"""Gera o teste das instruções Zvtakum (sim/tests/asm/zvtakum_isa.S) e a saída esperada.

O QEMU não conhece as codificações custom-0, então o oráculo é o modelo Python:
as operações Takum vêm de python/takum_rvv/codec.py (racionais exatos, sem libtakum),
e a estrutura vetorial (vl, máscara v0, políticas tu/mu, grupos LMUL) segue a mesma
convenção validada contra o QEMU no teste de RVV padrão.

    python3 sim/tests/gen_zvt.py
"""

from __future__ import annotations

import pathlib
import random
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "python"))

from takum_rvv.codec import Takum  # noqa: E402

OUT = pathlib.Path(__file__).resolve().parent / "asm"
VLENS = (128, 256, 512)
AVL = 3
HUGE = 10**9

# Codificação custom-0: opcode 0x0b, funct3 0, funct6 = operação, vm no bit 25.
FUNCT6 = {"vtadd.vv": 0, "vtsub.vv": 1, "vtmul.vv": 2, "vtdot.vv": 3, "vncvt.t.t": 4}
SHIFT = {8: 0, 16: 1, 32: 2, 64: 3}


def custom_word(op: str, vd: int, vs2: int, vs1: int, masked: bool) -> int:
    vm = 0 if masked else 1
    return (FUNCT6[op] << 26) | (vm << 25) | (vs2 << 20) | (vs1 << 15) | (vd << 7) | 0x0B


class Model:
    """Banco vetorial com as políticas tu/mu usadas no teste."""

    def __init__(self, vlenb: int, memory: dict[str, bytes]) -> None:
        self.vlenb = vlenb
        self.regs = [bytearray(vlenb) for _ in range(32)]
        self.memory = memory
        self.vl = 0
        self.sew = 8
        self.lmul = 1
        self.output = bytearray()

    def vlmax(self) -> int:
        return self.vlenb * 8 * self.lmul // self.sew

    def vsetvli(self, avl: int, sew: int, lmul: int) -> None:
        self.sew, self.lmul = sew, lmul
        self.vl = min(avl, self.vlmax())

    def get(self, base: int, index: int, eb: int) -> int:
        off = index * eb
        reg = base + off // self.vlenb
        pos = off % self.vlenb
        return int.from_bytes(self.regs[reg][pos:pos + eb], "little")

    def set(self, base: int, index: int, eb: int, value: int) -> None:
        off = index * eb
        reg = base + off // self.vlenb
        pos = off % self.vlenb
        self.regs[reg][pos:pos + eb] = (value & ((1 << (8 * eb)) - 1)).to_bytes(eb, "little")

    def mask(self, index: int) -> bool:
        return bool((self.regs[0][index // 8] >> (index % 8)) & 1)

    def load(self, vd: int, label: str, eb: int) -> None:
        data = self.memory[label]
        for i in range(self.vl):
            self.set(vd, i, eb, int.from_bytes(data[i * eb:(i + 1) * eb], "little"))

    def binop(self, op: str, vd: int, vs2: int, vs1: int, masked: bool) -> None:
        eb = self.sew // 8
        t = Takum(self.sew)
        fn = {"vtadd.vv": t.add, "vtsub.vv": t.sub, "vtmul.vv": t.mul}[op]
        for i in range(self.vl):
            if masked and not self.mask(i):
                continue
            self.set(vd, i, eb, fn(self.get(vs2, i, eb), self.get(vs1, i, eb)))

    def dot(self, vd: int, vs2: int, vs1: int, masked: bool) -> None:
        n = self.sew
        narrow, wide = Takum(n), Takum(2 * n)
        acc = self.get(vd, 0, 2 * n // 8)
        for i in range(self.vl):
            if masked and not self.mask(i):
                continue
            a = narrow.convert(self.get(vs2, i, n // 8), wide)
            b = narrow.convert(self.get(vs1, i, n // 8), wide)
            acc = wide.add(acc, wide.mul(a, b))
        if self.vl > 0:
            self.set(vd, 0, 2 * n // 8, acc)

    def ncvt(self, vd: int, vs2: int) -> None:
        n = self.sew
        wide, narrow = Takum(2 * n), Takum(n)
        for i in range(self.vl):
            self.set(vd, i, n // 8, wide.convert(self.get(vs2, i, 2 * n // 8), narrow))

    def store(self, vd: int, count: int) -> None:
        for reg in range(vd, vd + count):
            self.output += self.regs[reg]


def memory_image(seed: int = 2026) -> dict[str, bytes]:
    rng = random.Random(seed)

    def words(count: int) -> bytes:
        return b"".join(rng.getrandbits(32).to_bytes(4, "little") for _ in range(count))

    def bytes_(count: int) -> bytes:
        return bytes(rng.getrandbits(8) for _ in range(count))

    return {
        "vmask": bytes_(64),
        "vdata_a": words(64),
        "vdata_b": words(64),
        "vdata_c": bytes_(64),
        "vdata_d": bytes_(64),
        "vdata_e": bytes_(128),
        "vdata_f": bytes_(128),
    }


def program(memory: dict[str, bytes]) -> list[str]:
    asm: list[str] = []

    def emit(text: str) -> None:
        asm.append("    " + text)

    def custom(op: str, vd: int, vs2: int, vs1: int, masked: bool) -> None:
        word = custom_word(op, vd, vs2, vs1, masked)
        suffix = ", v0.t" if masked else ""
        asm.append(f"    .4byte 0x{word:08x}  # {op} v{vd}, v{vs2}, v{vs1}{suffix}")

    def store_full(reg: str, sew: int, lmul: int) -> None:
        # vl = VLMAX com rd != x0; grava o grupo inteiro e avança o ponteiro.
        emit(f"vsetvli t1, x0, e{sew}, m{lmul}, tu, mu")
        emit(f"vse{sew}.v {reg}, (s0)")
        emit("csrr t3, vl")
        emit(f"slli t3, t3, {SHIFT[sew]}")
        emit("add s0, s0, t3")

    asm += [
        "    .option norvc",
        "    .section .text",
        "    .globl _start",
        "_start:",
        "    la s0, out",
        "    mv s6, s0",
        "    la s1, vmask",
        "    la s2, vdata_a",
        "    la s3, vdata_b",
        "    la s4, vdata_c",
        "    la s5, vdata_d",
        "    la s7, vdata_e",
        "    la s8, vdata_f",
    ]
    emit("vsetvli t1, x0, e8, m1, tu, mu")
    emit("vle8.v v0, (s1)")
    emit(f"li t0, {AVL}")
    emit("vsetvli t1, t0, e32, m1, tu, mu")
    emit("vle32.v v2, (s2)")
    emit("vle32.v v3, (s3)")
    custom("vtadd.vv", 4, 2, 3, False)
    store_full("v4", 32, 1)
    custom("vtsub.vv", 5, 2, 3, True)
    store_full("v5", 32, 1)
    custom("vtmul.vv", 6, 2, 3, False)
    store_full("v6", 32, 1)
    emit("vsetivli t1, 1, e64, m1, tu, mu")
    emit("vmv.v.i v8, 0")
    emit(f"li t0, {AVL}")
    emit("vsetvli t1, t0, e32, m1, tu, mu")
    custom("vtdot.vv", 8, 2, 3, False)
    custom("vtdot.vv", 8, 2, 3, True)
    store_full("v8", 32, 1)
    emit("vsetvli t1, t0, e32, m1, tu, mu")
    emit("vle32.v v10, (s2)")
    emit("vsetvli t1, t0, e16, m1, tu, mu")
    custom("vncvt.t.t", 12, 10, 0, False)
    store_full("v12", 16, 1)
    emit("vsetvli t1, t0, e8, m1, tu, mu")
    emit("vle8.v v14, (s4)")
    emit("vle8.v v15, (s5)")
    custom("vtadd.vv", 16, 14, 15, True)
    store_full("v16", 8, 1)
    emit("vsetvli t1, t0, e16, m2, tu, mu")
    emit("vle16.v v18, (s7)")
    emit("vle16.v v20, (s8)")
    custom("vtmul.vv", 22, 18, 20, False)
    store_full("v22", 16, 2)
    # vl = 0: vtadd e vtdot não alteram o destino (política de cauda tu).
    emit("li t0, 0")
    emit("vsetvli t1, t0, e32, m1, tu, mu")
    custom("vtadd.vv", 24, 2, 3, False)
    custom("vtdot.vv", 8, 2, 3, False)
    store_full("v8", 32, 1)
    store_full("v24", 32, 1)
    asm += [
        "    # write(1, out, s0 - s6); exit(0)",
        "    sub a2, s0, s6",
        "    mv a1, s6",
        "    li a0, 1",
        "    li a7, 64",
        "    ecall",
        "    li a0, 0",
        "    li a7, 93",
        "    ecall",
        "    .section .bss",
        "    .balign 16",
        "out:",
        "    .space 65536",
        "    .section .data",
        "    .balign 16",
    ]
    for label, blob in memory.items():
        asm.append(f"{label}:")
        for k in range(0, len(blob), 16):
            chunk = ", ".join(str(b) for b in blob[k:k + 16])
            asm.append(f"    .byte {chunk}")
        asm.append("    .balign 16")
    return asm


def expected(vlen: int, memory: dict[str, bytes]) -> bytes:
    m = Model(vlen // 8, memory)
    m.vsetvli(HUGE, 8, 1)
    m.load(0, "vmask", 1)
    m.vsetvli(AVL, 32, 1)
    m.load(2, "vdata_a", 4)
    m.load(3, "vdata_b", 4)
    m.binop("vtadd.vv", 4, 2, 3, False)
    m.vsetvli(HUGE, 32, 1)
    m.store(4, 1)
    m.vsetvli(AVL, 32, 1)
    m.binop("vtsub.vv", 5, 2, 3, True)
    m.vsetvli(HUGE, 32, 1)
    m.store(5, 1)
    m.vsetvli(AVL, 32, 1)
    m.binop("vtmul.vv", 6, 2, 3, False)
    m.vsetvli(HUGE, 32, 1)
    m.store(6, 1)
    m.vsetvli(1, 64, 1)
    m.set(8, 0, 8, 0)
    m.vsetvli(AVL, 32, 1)
    m.dot(8, 2, 3, False)
    m.dot(8, 2, 3, True)
    m.vsetvli(HUGE, 32, 1)
    m.store(8, 1)
    m.vsetvli(AVL, 32, 1)
    m.load(10, "vdata_a", 4)
    m.vsetvli(AVL, 16, 1)
    m.ncvt(12, 10)
    m.vsetvli(HUGE, 16, 1)
    m.store(12, 1)
    m.vsetvli(AVL, 8, 1)
    m.load(14, "vdata_c", 1)
    m.load(15, "vdata_d", 1)
    m.binop("vtadd.vv", 16, 14, 15, True)
    m.vsetvli(HUGE, 8, 1)
    m.store(16, 1)
    m.vsetvli(AVL, 16, 2)
    m.load(18, "vdata_e", 2)
    m.load(20, "vdata_f", 2)
    m.binop("vtmul.vv", 22, 18, 20, False)
    m.vsetvli(HUGE, 16, 2)
    m.store(22, 2)
    m.vsetvli(0, 32, 1)
    m.binop("vtadd.vv", 24, 2, 3, False)
    m.dot(8, 2, 3, False)
    m.vsetvli(HUGE, 32, 1)
    m.store(8, 1)
    m.store(24, 1)
    return bytes(m.output)


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    memory = memory_image()
    (OUT / "zvtakum_isa.S").write_text("\n".join(program(memory)) + "\n")
    for vlen in VLENS:
        (OUT / f"zvtakum_isa.v{vlen}.expected").write_bytes(expected(vlen, memory))
    print(f"teste Zvtakum gravado em {OUT}")


if __name__ == "__main__":
    main()
