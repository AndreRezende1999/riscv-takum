"""Independent upstream fixtures; provenance in tests/data/README.md."""
import unittest
from pathlib import Path
from fractions import Fraction

from takum_rvv.codec import Takum
from tools.validate_libtakum import validate


class ReferenceTests(unittest.TestCase):
    def test_all_t8_pairs_match_pinned_libtakum(self):
        report = validate(Path(__file__).parent / 'data' / 'libtakum_t8.bin.gz')
        self.assertTrue(report['matches_all'], report)

    def test_integer_exactness_limits_from_published_table(self):
        # Hunhold, arXiv:2412.20273v2, section 5: largest consecutive integers.
        for bits, last in ((8, 8), (16, 512), (32, 2**24), (64, 2**55)):
            t = Takum(bits)
            for sign in (1, -1):
                for value in (last - 1, last):
                    self.assertEqual(t.decode(t.encode(sign * value)), sign * value)
                self.assertNotEqual(t.decode(t.encode(sign * (last + 1))), sign * (last + 1))


if __name__ == '__main__': unittest.main()
