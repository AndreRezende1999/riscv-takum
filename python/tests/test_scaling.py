import json
import tempfile
import unittest
from decimal import Decimal
from fractions import Fraction as F
from pathlib import Path

from takum_rvv.sparse import parse_matrix_market
from takum_rvv.benchmark import run_experiment
try:
    from takum_rvv.scaling import prepare_scaled_inputs
except ImportError:
    prepare_scaled_inputs = None


class ScalingTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(prepare_scaled_inputs, 'Scaling is not implemented yet')

    def test_power_of_two_bound_preserves_exact_physical_problem(self):
        a = parse_matrix_market('%%MatrixMarket matrix coordinate real general\n2 2 3\n1 1 3\n1 2 -2\n2 2 0.25\n')
        x = [F(3, 2), F(-1, 2)]
        scaled, xs, sa, sx = prepare_scaled_inputs(a, x, 'pow2-bound')
        self.assertEqual((sa, sx), (8, 2))
        self.assertEqual(scaled.data, (F(3, 8), F(-1, 4), F(1, 32)))
        self.assertEqual(xs, [F(3, 4), F(-1, 4)])
        self.assertEqual(scaled.data[0] * xs[0] * sa * sx, F(9, 2))
        self.assertLessEqual(max(sum(abs(v) for v in scaled.data[scaled.rowptr[r]:scaled.rowptr[r+1]]) for r in range(2)), 1)

    def test_no_scale_zero_and_fractional_power_bound(self):
        a = parse_matrix_market('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 0.125\n')
        _, _, sa, sx = prepare_scaled_inputs(a, [F(1, 16)], 'pow2-bound')
        self.assertEqual((sa, sx), (F(1, 8), F(1, 16)))
        same, x, sa, sx = prepare_scaled_inputs(a, [F(1)], 'none')
        self.assertIs(same, a)
        self.assertEqual((sa, sx), (1, 1))
        zero = parse_matrix_market('%%MatrixMarket matrix coordinate real general\n1 1 0\n')
        _, _, sa, sx = prepare_scaled_inputs(zero, [F(0)], 'pow2-bound')
        self.assertEqual((sa, sx), (1, 1))
        with self.assertRaises(ValueError): prepare_scaled_inputs(a, [F(1)], 'unknown')

    def test_scale_does_not_change_reference_or_hide_output_units(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'big.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 1024\n')
            original = run_experiment([path], root / 'none', vector='ones')
            scaled = run_experiment([path], root / 'scaled', vector='ones', scaling='pow2-bound')
            before = next(r for r in original['results'] if r['format'] == 'E4M3')
            after = next(r for r in scaled['results'] if r['format'] == 'E4M3')
            self.assertEqual(before['nonfinite_count'], 1)
            self.assertEqual(after['nonfinite_count'], 0)
            self.assertEqual(Decimal(after['relative_l2']), 0)
            self.assertEqual(after['matrix_scale'], '1024')
            self.assertEqual(json.loads(after['output_raw_hex']), ['38'])  # scaled value = 1
            self.assertEqual(scaled['manifest']['scaling'], 'pow2-bound')
            self.assertEqual(original['manifest']['reference'], scaled['manifest']['reference'])
            self.assertEqual(json.loads((root / 'none/vectors.json').read_text()), json.loads((root / 'scaled/vectors.json').read_text()))

    def test_scaled_quantization_error_is_measured_after_rescaling(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'nonexact.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 1000\n')
            report = run_experiment([path], root / 'out', vector='ones', scaling='pow2-bound')
            row = next(r for r in report['results'] if r['format'] == 'E4M3')
            # 1000/1024 rounds to 1; reconstruct to1024, absolute error24.
            self.assertEqual(Decimal(row['absolute_l2']), 24)
            self.assertEqual(Decimal(row['matrix_representation_relative_l2']), Decimal('0.024'))
            self.assertEqual(Decimal(row['input_effect_relative_l2']), Decimal('0.024'))


if __name__ == '__main__': unittest.main()
