"""Independent T16/T32 reference fixtures; no compiler needed at test time."""
import json
import unittest
from fractions import Fraction
from pathlib import Path

try:
    from tools.validate_libtakum_wide import hex_fraction, validate, validate_bytes
except ImportError:
    hex_fraction = validate = validate_bytes = None


class WideReferenceTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(validate, 'The independent wide-reference validator is missing')

    def test_hexfloat_is_parsed_without_binary64_narrowing(self):
        self.assertEqual(hex_fraction('0x1.0000000000000001p+0'),
                         Fraction(1) + Fraction(1, 2**64))
        self.assertEqual(hex_fraction('-0x1.8p-239'), -Fraction(3, 2**240))
        self.assertEqual(hex_fraction('-0x0p+0'), 0)
        self.assertIsNone(hex_fraction('nan'))
        self.assertIsNone(hex_fraction('-nan'))
        for token in ('inf', '-inf', '1.25', '0x1p', '0x1.2p+3junk'):
            with self.assertRaises(ValueError, msg=token):
                hex_fraction(token)

    def test_malformed_or_truncated_reference_is_rejected(self):
        for data in (b'', b'TKWREF0\n',
                     b'TKWREF1\t776ac0ca7855f640100731ed8bbb0c7cf83b2d94\n'):
            with self.assertRaises(ValueError):
                validate_bytes(data)

    def test_double_rounding_analysis_checks_exact_distance(self):
        from tools import validate_libtakum_wide as validator
        self.assertTrue(hasattr(validator, 'analyze_t32_product'),
                        'Wide discrepancies require an independent exact analysis')
        analyze = validator.analyze_t32_product
        result = analyze('0x1.0000002p+0', '0x1.8000002p+0',
                         0x44000003, 0x44000002)
        self.assertEqual(result['classification'], 'upstream_binary64_double_rounding')
        self.assertEqual(Fraction(result['distance_to_midpoint']), Fraction(1, 2**54))
        # Swapping the alleged correct/wrong outputs must fail the proof.
        self.assertEqual(analyze('0x1.0000002p+0', '0x1.8000002p+0',
                                 0x44000002, 0x44000003)['classification'], 'unclassified')
        # An exact tie is not this double-rounding counterexample.
        self.assertEqual(analyze('0x1p+0', '0x1.8p+0',
                                 0x44000003, 0x44000002)['classification'], 'unclassified')

    def test_exhaustive_t16_decode_and_sampled_wide_operations(self):
        root = Path(__file__).parent / 'data'
        fixture = root / 'libtakum_wide.tsv.gz'
        provenance = root / 'libtakum_wide.json'
        self.assertTrue(fixture.is_file(), 'Generate the external C fixture before validation')
        self.assertTrue(provenance.is_file(), 'The external fixture needs pinned provenance')
        report = validate(fixture)
        metadata = json.loads(provenance.read_text(encoding='utf-8'))
        self.assertEqual(report['reference_sha256'], metadata['reference_sha256'])
        self.assertEqual(report['upstream_commit'], metadata['upstream_commit'])
        self.assertEqual(report['checks']['t16_decode']['cases'], 65536)
        for bits in (16, 32):
            self.assertEqual(report['checks'][f't{bits}_operand_decode']['mismatches'], 0)
            for op in ('add', 'sub', 'mul'):
                self.assertEqual(report['checks'][f't{bits}_{op}']['cases'], 10000)
        self.assertEqual(report['checks']['t16_decode']['mismatches'], 0)
        # An upstream discrepancy is accepted only after a saved exact analysis.
        # Changes on either side must produce a reviewable test failure.
        self.assertEqual(report['mismatches'], metadata['reviewed_mismatches'])
        self.assertEqual(report['classification_counts'], metadata['classification_counts'])
        self.assertNotIn('unclassified', report['classification_counts'])


if __name__ == '__main__':
    unittest.main()
