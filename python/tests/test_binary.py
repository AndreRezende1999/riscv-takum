"""Independent fixtures and stdlib oracles for finite binary arithmetic."""

from dataclasses import FrozenInstanceError, replace
from fractions import Fraction as F
import math
import random
import struct
import unittest

try:
    from takum_rvv.binary import (
        BinaryFormat, E4M3, E5M2, BINARY16, BINARY32, BINARY64, BINARY128,
    )
except ImportError:
    BinaryFormat = None


class BinaryTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(BinaryFormat, "The binary reference is not implemented")

    def test_known_fp8_encodings(self):
        fixtures = (
            (E4M3, {0: F(0), 1: F(1, 512), 7: F(7, 512), 8: F(1, 64),
                    0x38: F(1), 0x3c: F(3, 2), 0x40: F(2), 0x7e: F(448),
                    0xb8: F(-1), 0xfe: F(-448)}),
            (E5M2, {0: F(0), 1: F(1, 65536), 3: F(3, 65536), 4: F(1, 16384),
                    0x3c: F(1), 0x3e: F(3, 2), 0x40: F(2), 0x7b: F(57344),
                    0xbc: F(-1), 0xfb: F(-57344)}),
        )
        for fmt, values in fixtures:
            for raw, value in values.items():
                with self.subTest(format=fmt.name, raw=hex(raw)):
                    self.assertEqual(fmt.decode(raw), value)
                    self.assertEqual(fmt.encode(value), raw)

    def test_known_ieee_encodings(self):
        for fmt, one, half, negative_one, smallest, largest in (
            (BINARY16, 0x3c00, 0x3800, 0xbc00, F(1, 2**24), F(65504)),
            (BINARY32, 0x3f800000, 0x3f000000, 0xbf800000,
             F(1, 2**149), F((2**24 - 1) * 2**104)),
            (BINARY64, 0x3ff0000000000000, 0x3fe0000000000000,
             0xbff0000000000000, F(1, 2**1074), F((2**53 - 1) * 2**971)),
            (BINARY128, 0x3fff << 112, 0x3ffe << 112, 0xbfff << 112,
             F(1, 2**16494), F((2**113 - 1) * 2**16271)),
        ):
            with self.subTest(format=fmt.name):
                self.assertEqual(fmt.encode(1), one)
                self.assertEqual(fmt.decode(one), 1)
                self.assertEqual(fmt.encode(F(1, 2)), half)
                self.assertEqual(fmt.encode(-1), negative_one)
                self.assertEqual(fmt.decode(1), smallest)
                self.assertEqual(fmt.encode(smallest), 1)
                self.assertEqual(fmt.decode(fmt.encode(largest)), largest)

    def test_fp8_exhaustive_finite_roundtrip(self):
        for fmt, nonfinite in (
            (E4M3, {0x7f, 0xff}),
            (E5M2, {0x7c, 0x7d, 0x7e, 0x7f, 0xfc, 0xfd, 0xfe, 0xff}),
        ):
            for raw in range(256):
                with self.subTest(format=fmt.name, raw=raw):
                    decoded = fmt.decode(raw)
                    if raw in nonfinite:
                        self.assertIsNone(decoded)
                    else:
                        self.assertIsInstance(decoded, F)
                        self.assertEqual(fmt.encode(decoded), 0 if raw == 128 else raw)

    def test_fp8_ties_to_even_and_subnormal_transitions(self):
        for value, expected in (
            (F(17, 16), 0x38), (F(19, 16), 0x3a),
            (F(-19, 16), 0xba), (F(1, 1024), 0),
            (F(3, 1024), 2), (F(15, 1024), 8),
            (F(31, 16), 0x40), (F(-1, 2048), 0x80),
        ):
            self.assertEqual(E4M3.encode(value), expected)
        self.assertEqual(E5M2.encode(F(7, 2**17)), 4)

    def test_e4m3_overflow_is_decided_after_rounding(self):
        for value in (448, 449, 463, 464):
            self.assertEqual(E4M3.encode(value), 0x7e)
            self.assertEqual(E4M3.encode(-value), 0xfe)
        for value in (F(1857, 4), 480, 512, 10**20):
            self.assertEqual(E4M3.encode(value), 0x7f)
            self.assertIsNone(E4M3.decode(E4M3.encode(-value)))

    def test_e5m2_and_ieee_overflow_boundaries(self):
        self.assertEqual(E5M2.encode(57345), 0x7b)
        self.assertEqual(E5M2.encode(61439), 0x7b)
        self.assertEqual(E5M2.encode(61440), 0x7c)
        self.assertEqual(E5M2.encode(-61440), 0xfc)
        self.assertEqual(BINARY16.encode(65519), 0x7bff)
        self.assertEqual(BINARY16.encode(65520), 0x7c00)
        self.assertEqual(BINARY16.encode(-65520), 0xfc00)

    def test_saturation_only_clamps_finite_overflow(self):
        for fmt, maximum in ((E4M3, 0x7e), (E5M2, 0x7b), (BINARY16, 0x7bff)):
            sat = replace(fmt, saturate=True)
            self.assertEqual(sat.encode(10**20), maximum)
            self.assertEqual(sat.encode(-10**20), maximum | (1 << (fmt.bits - 1)))
            self.assertIsNone(sat.decode(sat.encode(None)))
            self.assertIsNone(sat.decode(sat.mul(sat.encode(None), sat.encode(0))))

    def test_binary128_has_113_significant_bits(self):
        one = 0x3fff << 112
        self.assertEqual(BINARY128.encode(1 + F(1, 2**113)), one)
        self.assertEqual(BINARY128.encode(1 + F(3, 2**113)), one + 2)
        self.assertEqual(BINARY128.encode(1 + F(1, 2**112)), one + 1)
        self.assertEqual(BINARY128.decode(one + 1), 1 + F(1, 2**112))
        self.assertEqual(BINARY128.encode(F(1, 2**16495)), 0)
        self.assertEqual(BINARY128.encode(F(3, 2**16495)), 2)

    def test_exact_rational_operations_round_after_each_operation(self):
        self.assertEqual(E4M3.add(0x38, 0x38), 0x40)
        self.assertEqual(E4M3.sub(0x40, 0x38), 0x38)
        self.assertEqual(E4M3.mul(0x3c, 0x40), 0x44)
        # (1 + 1/16) rounds to 1 before subtracting 1.
        self.assertEqual(E4M3.sub(E4M3.add(0x38, 0x18), 0x38), 0)
        self.assertEqual(E4M3.mul(0x7e, 0x40), 0x7f)
        one = 0x3fff << 112
        self.assertEqual(BINARY128.sub(one + 1, one), (16383 - 112) << 112)
        self.assertEqual(BINARY128.mul(one + 1, one + 1), one + 2)

    def test_nonfinite_inputs_propagate_as_canonical_nan(self):
        for fmt in (E4M3, E5M2, BINARY16, BINARY32, BINARY64, BINARY128):
            nan = fmt.encode(None)
            self.assertIsNone(fmt.decode(nan))
            for op in (fmt.add, fmt.sub, fmt.mul):
                self.assertEqual(op(nan, fmt.encode(0)), nan)
                self.assertEqual(op(fmt.encode(1), nan), nan)
        self.assertEqual(BINARY16.encode(None), 0x7e00)
        self.assertIsNone(BINARY16.decode(0x7c00))
        self.assertIsNone(BINARY16.decode(0xfc00))

    def test_string_input_and_documented_zero_policy(self):
        self.assertEqual(BINARY32.encode("0.1"), 0x3dcccccd)
        for text in ("-0", " -0.000 ", "-0e10", "-0/7"):
            self.assertEqual(BINARY16.encode(text), 0x8000)
        self.assertEqual(BINARY16.decode(0x8000), F(0))
        self.assertEqual(BINARY16.add(0x8000, 0x8000), 0)
        self.assertEqual(BINARY16.mul(0x8000, 0x3c00), 0)
        self.assertEqual(BINARY16.encode(F(-1, 2**26)), 0x8000)

    def test_random_finite_encodings_and_rounding_match_struct(self):
        rng = random.Random(20261005)
        for fmt, code, width in ((BINARY16, "e", 2), (BINARY32, "f", 4), (BINARY64, "d", 8)):
            for _ in range(400):
                raw = rng.getrandbits(fmt.bits)
                value = struct.unpack(">" + code, raw.to_bytes(width, "big"))[0]
                if not math.isfinite(value) or value == 0:
                    continue
                exact = F.from_float(value)
                self.assertEqual(fmt.decode(raw), exact)
                self.assertEqual(fmt.encode(exact), raw)
            # Every source is a binary64 value; the rational model never passes
            # through float internally. struct independently rounds to 16/32/64.
            for _ in range(600):
                value = math.ldexp(rng.uniform(-2, 2), rng.randint(-25, 15))
                expected = int.from_bytes(struct.pack(">" + code, value), "big")
                self.assertEqual(fmt.encode(F.from_float(value)), expected)

    def test_invalid_inputs_and_configuration_are_rejected(self):
        for raw in (-1, 256):
            with self.assertRaises(ValueError):
                E4M3.decode(raw)
        with self.assertRaises(TypeError):
            E4M3.decode(F(1, 2))
        with self.assertRaises(TypeError):
            E4M3.encode(0.1)
        with self.assertRaises(ValueError):
            BinaryFormat(8, 4, 4, "bad")
        with self.assertRaises(ValueError):
            BinaryFormat(3, 1, 1, "bad")
        with self.assertRaises(FrozenInstanceError):
            E4M3.bits = 16


if __name__ == "__main__":
    unittest.main()
