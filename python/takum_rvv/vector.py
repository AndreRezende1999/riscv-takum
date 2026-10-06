"""Functional subset of RVV state with five experimental Takum operations.

State/mask/vl conventions: RISC-V V 1.0, manual release 20260120:
https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html
Custom-0 space: same manual, rv-32-64g.html. Operation semantics and encodings
are THIS project's proposal, not ratified RISC-V instructions. No cycles/ELF.
"""

from collections import Counter
from .codec import Takum


OPERATIONS = {'vtadd.vv': 0, 'vtsub.vv': 1, 'vtmul.vv': 2,
              'vtdot.vv': 3, 'vncvt.t.t': 4}


def _register(reg):
    if not isinstance(reg, int) or not 0 <= reg < 32:
        raise ValueError('Vector register must be in v0..v31')


def encode_instruction(op, vd, vs1, vs2, masked=False):
    if op not in OPERATIONS:
        raise ValueError('Unknown experimental instruction')
    for reg in (vd, vs1, vs2): _register(reg)
    if op == 'vncvt.t.t' and vs1 != 0:
        raise ValueError('Narrowing requires reserved vs1=0')
    return (OPERATIONS[op] << 26 | int(not masked) << 25 |
            vs2 << 20 | vs1 << 15 | vd << 7 | 0x0b)


def decode_instruction(word):
    if not isinstance(word, int) or not 0 <= word < 2**32:
        raise ValueError('Instruction must be an unsigned 32-bit word')
    op = {v: k for k, v in OPERATIONS.items()}.get(word >> 26)
    if word & 0x707f != 0x0b or op is None:
        raise ValueError('Illegal custom-0 instruction')
    vd, vs1, vs2 = (word >> 7) & 31, (word >> 15) & 31, (word >> 20) & 31
    if op == 'vncvt.t.t' and vs1 != 0:
        raise ValueError('Reserved narrowing field must be zero')
    return op, vd, vs1, vs2, not bool((word >> 25) & 1)


class VectorMachine:
    """LMUL=1, SEW=8/16/32, ELEN=64 for widening; undisturbed tail/mask.

    Counters describe executed operations in this subset. Register fixture
    read/write calls are host operations, not simulated instructions.
    """

    def __init__(self, vlen=256):
        if not isinstance(vlen, int) or not 128 <= vlen <= 65536 or vlen & (vlen - 1):
            raise ValueError('VLEN must be a power of two in [128,65536] bits')
        self.vlen = vlen
        self.registers = [bytearray(vlen // 8) for _ in range(32)]
        self.sew, self.vl, self.vstart = 8, 0, 0
        self.counts = Counter()

    @property
    def vlmax(self):
        return self.vlen // self.sew

    def set_vl(self, avl, sew, lmul=1, rs1_x0=False, rd_x0=False):
        if sew not in (8, 16, 32) or lmul != 1:
            raise ValueError('Supported subset requires SEW=8/16/32 and LMUL=1')
        if not isinstance(avl, int) or avl < 0:
            raise ValueError('AVL must be nonnegative')
        new_max = self.vlen // sew
        if rs1_x0 and rd_x0:
            if new_max != self.vlmax:
                raise ValueError('Reserved vsetvli x0,x0 when VLMAX changes')
            length = self.vl
        else:
            length = new_max if rs1_x0 else min(avl, new_max)
        self.sew, self.vl, self.vstart = sew, length, 0
        self.counts['vsetvli'] += 1
        return length

    def _address(self, reg, lane, bits, group):
        _register(reg)
        if bits not in (8, 16, 32, 64) or group not in (1, 2):
            raise ValueError('Unsupported element width or group')
        if reg + group > 32 or (group == 2 and reg % 2):
            raise ValueError('Register group must be aligned and fit the register file')
        if not isinstance(lane, int) or not 0 <= lane < group * self.vlen // bits:
            raise ValueError('Lane outside register group')
        offset = lane * (bits // 8)
        return reg + offset // (self.vlen // 8), offset % (self.vlen // 8)

    def read(self, reg, lane, bits=None, group=1):
        bits = self.sew if bits is None else bits
        physical, offset = self._address(reg, lane, bits, group)
        return int.from_bytes(self.registers[physical][offset:offset + bits // 8], 'little')

    def write(self, reg, lane, raw, bits=None, group=1):
        bits = self.sew if bits is None else bits
        physical, offset = self._address(reg, lane, bits, group)
        if not isinstance(raw, int) or not 0 <= raw < 1 << bits:
            raise ValueError('Raw value outside element width')
        self.registers[physical][offset:offset + bits // 8] = raw.to_bytes(bits // 8, 'little')

    def set_mask(self, values):
        """Host test/setup helper; v0 bit i controls lane i at every SEW."""
        if len(values) > self.vlen:
            raise ValueError('Mask does not fit v0')
        raw = sum(int(bool(active)) << i for i, active in enumerate(values))
        self.registers[0][:] = raw.to_bytes(self.vlen // 8, 'little')

    def _active(self, lane, masked):
        return not masked or bool(self.registers[0][lane // 8] & (1 << (lane % 8)))

    def _check_restart(self):
        if not isinstance(self.vstart, int) or self.vstart < 0:
            raise ValueError('Invalid vstart')

    def execute_word(self, word):
        return self.execute(*decode_instruction(word))

    def execute(self, op, vd, vs1, vs2, masked=False):
        # Validate even when vl=0, before changing state.
        encode_instruction(op, vd, vs1, vs2, masked)
        self._check_restart()
        if masked and vd == 0:
            raise ValueError('Masked destination may not overwrite v0')
        if op == 'vtdot.vv':
            if self.vstart != 0:
                raise ValueError('Reduction does not support nonzero vstart')
            if vd in (vs1, vs2):
                raise ValueError('Wide scalar destination may not alias narrow sources')
        if op == 'vncvt.t.t':
            self._address(vs2, 0, self.sew * 2, 2)
            if vd in (vs2, vs2 + 1):
                raise ValueError('Narrowing overlap is not supported')
        self.counts[op] += 1
        if self.vstart >= self.vl:
            self.vstart = 0
            return
        narrow, wide = Takum(self.sew), Takum(2 * self.sew)
        lanes = [i for i in range(self.vstart, self.vl) if self._active(i, masked)]
        if op == 'vtdot.vv':
            acc = self.read(vd, 0, bits=2 * self.sew)
            for i in lanes:
                a = narrow.convert(self.read(vs1, i), wide)
                b = narrow.convert(self.read(vs2, i), wide)
                acc = wide.add(acc, wide.mul(a, b))
            # Mask controls the input elements, not the destination scalar.
            self.write(vd, 0, acc, bits=2 * self.sew)
            self.counts['active_products'] += len(lanes)
            self.counts['active_sums'] += len(lanes)
        elif op == 'vncvt.t.t':
            for i in lanes:
                self.write(vd, i, wide.convert(self.read(vs2, i, bits=2 * self.sew, group=2), narrow))
        else:
            operation = {'vtadd.vv': narrow.add, 'vtsub.vv': narrow.sub,
                         'vtmul.vv': narrow.mul}[op]
            for i in lanes:
                self.write(vd, i, operation(self.read(vs1, i), self.read(vs2, i)))
        self.counts['active_lanes'] += len(lanes)
        self.vstart = 0

    def load(self, vd, memory, indices=None):
        """Unmasked abstract unit/indexed load; checks all addresses first.

        Indexed loads use 32-bit indices and are not limited by x fitting a
        register. This models transferred bytes, not a cache or real memory.
        """
        _register(vd)
        self._check_restart()
        lanes = range(self.vstart, self.vl)
        if indices is not None and len(indices) < self.vl:
            raise ValueError('Too few indices')
        addresses = [i if indices is None else indices[i] for i in lanes]
        if any(not isinstance(j, int) or not 0 <= j < len(memory) for j in addresses):
            raise ValueError('Load address outside memory')
        words = [memory[j] for j in addresses]
        if any(not isinstance(x, int) or not 0 <= x < (1 << self.sew) for x in words):
            raise ValueError('Invalid memory element')
        for i, raw in zip(lanes, words): self.write(vd, i, raw)
        self.counts['indexed_load' if indices is not None else 'unit_load'] += 1
        self.counts['bytes_read'] += len(words) * (self.sew // 8)
        if indices is not None:
            self.counts['index_bytes_read'] += len(words) * 4
        self.vstart = 0

    def store(self, vs):
        """Unmasked abstract store of active elements, with undisturbed memory."""
        _register(vs)
        self._check_restart()
        result = [self.read(vs, i) for i in range(self.vstart, self.vl)]
        self.counts['unit_store'] += 1
        self.counts['bytes_written'] += len(result) * (self.sew // 8)
        self.vstart = 0
        return result
