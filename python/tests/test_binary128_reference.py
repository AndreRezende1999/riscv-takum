"""Offline binary128 differential checks against an external GCC oracle."""

import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

try:
    from tools.validate_binary128 import (
        compare_raw, generate_cases, request_text, validate,
    )
except ImportError:
    compare_raw = generate_cases = request_text = validate = None


class Binary128ReferenceTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(validate, "The independent binary128 validator is missing")

    def test_saved_gcc_fixture_matches_all_operations_and_conversions(self):
        fixture = Path(__file__).parent / "data" / "binary128_cases.jsonl"
        self.assertTrue(fixture.is_file(), "Generate the external GCC reference fixture first")
        report = validate(fixture)
        self.assertTrue(report["matches_all"], report)
        self.assertEqual(report["oracle"]["mantissa_bits"], 113)
        self.assertEqual(report["oracle"]["max_exponent"], 16384)
        self.assertEqual(report["oracle"]["rounding"], "FE_TONEAREST")
        self.assertGreaterEqual(report["pair_count"], 2000)
        for operation in ("add", "sub", "mul"):
            self.assertEqual(report["checks"][operation]["cases"], report["pair_count"])
        self.assertGreaterEqual(report["checks"]["encode_decimal"]["cases"], 12)
        self.assertGreater(report["classification_totals"]["signed_zero_difference"], 0)
        self.assertIn("subnormal", report["category_counts"])
        self.assertIn("cancellation", report["category_counts"])
        self.assertIn("exponent_extremes", report["category_counts"])

    def test_corpus_uses_deterministic_finite_raw_words(self):
        cases = generate_cases(pair_count=2000, seed=20261006)
        self.assertEqual(cases, generate_cases(pair_count=2000, seed=20261006))
        pairs = [case for case in cases if case["type"] == "pair"]
        self.assertEqual(len(pairs), 2000)
        self.assertEqual(len({case["id"] for case in cases}), len(cases))
        for case in pairs:
            for key in ("a", "b"):
                raw = int(case[key], 16)
                self.assertEqual(len(case[key]), 32)
                self.assertNotEqual((raw >> 112) & 0x7fff, 0x7fff)
        text = request_text(cases)
        self.assertEqual(len(text.splitlines()), len(cases))
        self.assertTrue(text.startswith("P 0 "))
        with self.assertRaises(ValueError):
            generate_cases(pair_count=0)

    def test_raw_comparison_classifies_contract_differences(self):
        sign = 1 << 127
        infinity = 0x7fff << 112
        quiet_nan = infinity | (1 << 111)
        self.assertEqual(compare_raw(1, 1), "exact")
        self.assertEqual(compare_raw(0, sign), "signed_zero_difference")
        self.assertEqual(compare_raw(quiet_nan, infinity), "nonfinite_kind_difference")
        self.assertEqual(compare_raw(quiet_nan, quiet_nan | 17), "nan_payload_or_sign_difference")
        self.assertEqual(compare_raw(infinity, infinity | sign), "infinity_sign_difference")
        self.assertEqual(compare_raw(1, 2), "mismatch")
        self.assertEqual(compare_raw(quiet_nan, 0), "mismatch")

    def test_validator_detects_corrupted_oracle_result(self):
        metadata = {"type": "metadata", "schema": 1, "compiler": "fixture-test",
                    "mantissa_bits": 113, "max_exponent": 16384, "min_exponent": -16381,
                    "float128_bytes": 16, "rounding": "FE_TONEAREST", "fast_math": False}
        case = {"type": "pair", "id": 0, "category": "manual_test",
                "a": "3fff0000000000000000000000000000",
                "b": "3fff0000000000000000000000000000",
                "add": "40000000000000000000000000000001",
                "sub": "00000000000000000000000000000000",
                "mul": "3fff0000000000000000000000000000"}
        with TemporaryDirectory() as directory:
            path = Path(directory) / "fixture.jsonl"
            path.write_text(json.dumps(metadata) + "\n" + json.dumps(case) + "\n", encoding="utf-8")
            report = validate(path)
        self.assertFalse(report["matches_all"])
        self.assertEqual(report["checks"]["add"]["mismatches"], 1)
        self.assertEqual(report["checks"]["sub"]["mismatches"], 0)
        self.assertEqual(report["checks"]["mul"]["mismatches"], 0)


if __name__ == "__main__":
    unittest.main()
