import unittest
from fractions import Fraction as F

from takum_rvv.codec import Takum
try:
    from takum_rvv.vector import VectorMachine, encode_instruction, decode_instruction
except ImportError:
    VectorMachine = None


class VectorTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(VectorMachine, 'Falta o executor vetorial')
        self.v = VectorMachine(vlen=128)
        self.v.set_vl(3, 8)

    def put(self, reg, values, bits=8, group=1):
        for i, x in enumerate(values):
            self.v.write(reg, i, Takum(bits).encode(x), bits=bits, group=group)

    def values(self, reg, n, bits=8, group=1):
        return [Takum(bits).decode(self.v.read(reg, i, bits=bits, group=group)) for i in range(n)]

    def test_mask_tail_and_restart_keep_undisturbed_elements(self):
        self.put(1, [1, 2, 3, 4]); self.put(2, [1, 1, 1, 1])
        self.put(3, [8, 8, 8, 8])
        self.v.set_mask([True, False, True])
        self.v.vstart = 1
        self.v.execute('vtadd.vv', 3, 1, 2, masked=True)
        self.assertEqual(self.values(3, 4), [8, 8, 4, 8])
        self.assertEqual(self.v.vstart, 0)

    def test_zero_vl_never_writes_including_reduction(self):
        self.put(3, [8, 8, 8])
        before = bytes(self.v.registers[3])
        self.v.set_vl(0, 8)
        self.v.execute('vtadd.vv', 3, 1, 2)
        self.v.execute('vtdot.vv', 3, 1, 2)
        self.assertEqual(bytes(self.v.registers[3]), before)

    def test_dot_seed_widening_and_mask_zero_does_not_disable_result(self):
        self.put(1, [2, 3, 4]); self.put(2, [1, 2, 3])
        self.put(3, [5], bits=16)
        self.v.set_mask([False, True, True])
        self.v.execute('vtdot.vv', 3, 1, 2, masked=True)
        self.assertEqual(self.values(3, 1, 16), [23])
        self.assertEqual(self.v.counts['active_products'], 2)

    def test_wide_accumulator_preserves_small_contribution(self):
        self.put(1, [1, F(1, 8), -1]); self.put(2, [1, F(1, 8), 1])
        self.v.execute('vtdot.vv', 4, 1, 2)
        self.assertEqual(self.values(4, 1, 16), [F(1, 64)])
        # A T8 accumulator loses the product when added to one.
        t = Takum(8)
        narrow = t.add(t.add(t.encode(1), t.encode(F(1, 64))), t.encode(-1))
        self.assertEqual(t.decode(narrow), 0)

    def test_narrow_reads_aligned_group_and_handles_second_register(self):
        self.v.set_vl(12, 8)
        self.put(2, [1] * 12, bits=16, group=2)
        self.v.execute('vncvt.t.t', 5, 0, 2)
        self.assertEqual(self.values(5, 12), [1] * 12)
        for source in (3, 31):
            with self.assertRaises(ValueError): self.v.execute('vncvt.t.t', 5, 0, source)
        with self.assertRaises(ValueError): self.v.execute('vncvt.t.t', 2, 0, 2)

    def test_vsetvli_x0_cases_and_unsupported_configurations(self):
        self.assertEqual(self.v.set_vl(0, 8, rs1_x0=True, rd_x0=True), 3)
        self.assertEqual(self.v.set_vl(0, 8, rs1_x0=True), 16)
        with self.assertRaises(ValueError): self.v.set_vl(3, 8, lmul=2)
        with self.assertRaises(ValueError): self.v.set_vl(3, 64)
        with self.assertRaises(ValueError): self.v.set_vl(0, 16, rs1_x0=True, rd_x0=True)

    def test_illegal_reduction_restart_and_mask_destination_do_not_write(self):
        self.v.vstart = 1
        before = bytes(self.v.registers[3])
        with self.assertRaises(ValueError): self.v.execute('vtdot.vv', 3, 1, 2)
        self.assertEqual(bytes(self.v.registers[3]), before)
        self.v.vstart = 0
        with self.assertRaises(ValueError): self.v.execute('vtadd.vv', 0, 1, 2, masked=True)
        with self.assertRaises(ValueError): self.v.execute('vtdot.vv', 1, 1, 2)

    def test_custom_opcode_execute_and_reject_unknown_word(self):
        self.put(1, [1, 1, 1]); self.put(2, [2, 2, 2])
        word = encode_instruction('vtmul.vv', 3, 1, 2)
        self.assertEqual(word & 0x7f, 0x0b)
        self.assertEqual(decode_instruction(word), ('vtmul.vv', 3, 1, 2, False))
        self.v.execute_word(word)
        self.assertEqual(self.values(3, 3), [2, 2, 2])
        with self.assertRaises(ValueError): self.v.execute_word(word | 0x7000)

    def test_elementwise_in_place_and_instruction_counts(self):
        self.put(1, [1, 2, 3]); self.put(2, [1, 1, 1])
        self.v.execute('vtsub.vv', 1, 1, 2)
        self.assertEqual(self.values(1, 3), [0, 1, 2])
        self.assertEqual(self.v.counts['vsetvli'], 1)
        self.assertEqual(self.v.counts['vtsub.vv'], 1)

    def test_empty_store_still_checks_register_and_memory_helpers_check_restart(self):
        self.v.set_vl(0, 8)
        before = dict(self.v.counts)
        with self.assertRaises(ValueError): self.v.store(32)
        self.assertEqual(dict(self.v.counts), before)
        self.v.vstart = -1
        with self.assertRaises(ValueError): self.v.load(1, [0])
        with self.assertRaises(ValueError): self.v.store(1)

    def test_indexed_load_is_atomic_on_invalid_address(self):
        self.put(1, [1, 2, 3])
        before = bytes(self.v.registers[1])
        with self.assertRaises(ValueError): self.v.load(1, [0, 0], indices=[0, 1, 2])
        self.assertEqual(bytes(self.v.registers[1]), before)
        self.v.load(1, [0x40, 0x48, 0x4a], indices=[2, 0, 1])
        self.assertEqual(self.values(1, 3), [3, 1, 2])


if __name__ == '__main__': unittest.main()
