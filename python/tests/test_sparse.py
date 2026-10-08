"""Matrix Market validation and independently computed SpMV fixtures."""

from dataclasses import FrozenInstanceError
from decimal import Decimal, localcontext
from fractions import Fraction as F
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from takum_rvv.binary import E4M3, BINARY16, BINARY128
from takum_rvv.codec import Takum

try:
    from takum_rvv.sparse import (
        CSR, parse_matrix_market, read_matrix_market, reference_spmv,
        scalar_spmv, exact_quantized_spmv, error_metrics,
    )
except ImportError:
    CSR = None


class SparseTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(CSR, "The sparse numerical reference is not implemented")

    def test_general_real_is_exact_sorted_and_zero_filtered(self):
        matrix = parse_matrix_market("""%%MatrixMarket matrix coordinate real general
% unsorted input, decimal cancellation
3 4 7
2 4 0.1
1 3 2.50e-1
2 4 0.2
2 4 -0.3
1 1 1.2345678901234567890123456789
3 1 -0
1 3 2.5D-1
""")
        self.assertEqual((matrix.rows, matrix.cols), (3, 4))
        self.assertEqual(matrix.rowptr, (0, 2, 2, 2))
        self.assertEqual(matrix.colidx, (0, 2))
        self.assertEqual(matrix.data, (F("1.2345678901234567890123456789"), F(1, 2)))
        expected = {"field": "real", "symmetry": "general", "declared_entries": 7,
                    "expanded_entries": 7, "duplicate_entries_merged": 3,
                    "explicit_zero_entries": 1, "zero_entries_removed": 2,
                    "zero_sum_entries_removed": 1, "nnz": 2}
        for key, value in expected.items():
            self.assertEqual(matrix.metadata[key], value, key)

    def test_symmetric_duplicates_are_mirrored_and_merged(self):
        matrix = parse_matrix_market("""%%MatrixMarket matrix coordinate integer symmetric
3 3 5
3 1 2
1 1 4
3 1 3
2 2 0
3 3 -1
""")
        self.assertEqual(matrix.rowptr, (0, 2, 2, 4))
        self.assertEqual(matrix.colidx, (0, 2, 0, 2))
        self.assertEqual(matrix.data, (F(4), F(5), F(5), F(-1)))
        self.assertEqual(matrix.metadata["expanded_entries"], 7)
        self.assertEqual(matrix.metadata["duplicate_entries_merged"], 2)
        self.assertEqual(matrix.metadata["explicit_zero_entries"], 1)

    def test_pattern_entries_are_ones_and_empty_rows_survive(self):
        matrix = parse_matrix_market("""%%MatrixMarket matrix coordinate pattern general
4 3 3
4 3
1 1
1 1
""")
        self.assertEqual(matrix.rowptr, (0, 1, 1, 1, 2))
        self.assertEqual(matrix.colidx, (0, 2))
        self.assertEqual(matrix.data, (F(2), F(1)))
        empty = parse_matrix_market("%%MatrixMarket matrix coordinate real general\n0 0 0\n")
        self.assertEqual(empty.rowptr, (0,))
        self.assertEqual(reference_spmv(empty, []), [])

    def test_read_matrix_market_uses_exact_parser(self):
        with TemporaryDirectory() as directory:
            path = Path(directory) / "matrix.mtx"
            path.write_text("%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 .1\n", encoding="utf-8")
            matrix = read_matrix_market(path)
            self.assertEqual(matrix.data, (F(1, 10),))
            self.assertEqual(matrix.metadata["source"], str(path))

    def test_unsupported_headers_are_explicitly_rejected(self):
        for header in (
            "%%MatrixMarket matrix array real general",
            "%%MatrixMarket matrix coordinate complex general",
            "%%MatrixMarket matrix coordinate real hermitian",
            "%%MatrixMarket matrix coordinate real skew-symmetric",
            "%%MatrixMarket vector coordinate real general",
            "%%MatrixMarket matrix coordinate float general",
            "matrix coordinate real general",
            "%%MatrixMarket matrix coordinate real general extra",
        ):
            with self.subTest(header=header), self.assertRaises(ValueError):
                parse_matrix_market(header + "\n1 1 0\n")

    def test_malformed_dimensions_indices_counts_and_values_are_rejected(self):
        prefix = "%%MatrixMarket matrix coordinate real general\n"
        for body in (
            "", "1 1", "1 1 0 0", "-1 2 0", "1 -2 0", "1 1 -1",
            "1.0 1 0", "1 1 1", "1 1 0\n1 1 2", "1 1 1\n0 1 2",
            "1 1 1\n1 0 2", "1 1 1\n2 1 2", "1 1 1\n1 2 2",
            "1 1 1\n1 1", "1 1 1\n1 1 2 3", "1 1 1\n1 1 nan",
            "1 1 1\n1 1 inf", "1 1 1\n1 1 1/2", "1 1 1\n1 1 1_000",
        ):
            with self.subTest(body=body), self.assertRaises(ValueError):
                parse_matrix_market(prefix + body)
        for body in ("2 3 0", "2 2 1\n1 2 1"):
            with self.assertRaises(ValueError):
                parse_matrix_market("%%MatrixMarket matrix coordinate real symmetric\n" + body)
        with self.assertRaises(ValueError):
            parse_matrix_market("%%MatrixMarket matrix coordinate integer general\n1 1 1\n1 1 1.5")
        with self.assertRaises(ValueError):
            parse_matrix_market("%%MatrixMarket matrix coordinate pattern general\n1 1 1\n1 1 1")

    def test_csr_validates_structure_and_is_frozen(self):
        for args in (
            (-1, 1, (0,), (), ()),
            (2, 1, (0, 0), (), ()),
            (1, 1, (1, 1), (), ()),
            (2, 1, (0, 2, 1), (0,), (F(1),)),
            (1, 1, (0, 2), (0,), (F(1),)),
            (1, 1, (0, 1), (1,), (F(1),)),
            (1, 2, (0, 2), (1, 0), (F(1), F(1))),
            (1, 2, (0, 2), (0, 0), (F(1), F(1))),
            (1, 1, (0, 1), (0,), (F(0),)),
        ):
            with self.subTest(args=args), self.assertRaises(ValueError):
                CSR(*args, {})
        matrix = CSR(1, 1, (0, 1), (0,), (F(1),), {})
        with self.assertRaises(FrozenInstanceError):
            matrix.rows = 2

    def test_hand_matrix_spmv_and_empty_row(self):
        matrix = CSR(3, 3, (0, 2, 4, 4), (0, 2, 0, 1),
                     (F(3, 2), F(2), F(-2), F(4)), {})
        x = [F(2), F(-1), F(-3)]
        expected = [F(-3), F(-8), F(0)]
        self.assertEqual(reference_spmv(matrix, x), expected)
        self.assertEqual(exact_quantized_spmv(matrix, x, E4M3), expected)
        for storage in (E4M3, BINARY16, Takum(8)):
            raw = scalar_spmv(matrix, x, storage, storage)
            self.assertEqual([storage.decode(value) for value in raw], expected)

    def test_scalar_spmv_quantizes_both_inputs_before_widening(self):
        matrix = CSR(1, 1, (0, 1), (0,), (F(17, 16),), {})
        x = [F(17, 16)]
        self.assertEqual(scalar_spmv(matrix, x, E4M3, BINARY128), [0x38])
        self.assertEqual(exact_quantized_spmv(matrix, x, E4M3), [F(1)])
        self.assertEqual(reference_spmv(matrix, x), [F(289, 256)])

    def test_scalar_spmv_uses_separate_rounding_and_final_storage_conversion(self):
        matrix = CSR(1, 3, (0, 3), (0, 1, 2), (F(1), F(1, 16), F(-1)), {})
        x = [F(1), F(1), F(1)]
        self.assertEqual(scalar_spmv(matrix, x, E4M3, E4M3), [0])
        self.assertEqual(scalar_spmv(matrix, x, E4M3, BINARY16), [0x18])
        self.assertEqual(exact_quantized_spmv(matrix, x, E4M3), [F(1, 16)])
        matrix = CSR(1, 2, (0, 2), (0, 1), (F(1), F(1, 16)), {})
        self.assertEqual(scalar_spmv(matrix, x[:2], E4M3, BINARY128), [0x38])

    def test_binary128_reference_rounds_each_product_and_ordered_addition(self):
        # The rounded product loses 2^-224; a fused dot product would retain it.
        a = 1 + F(1, 2**112)
        matrix = CSR(1, 2, (0, 2), (0, 1), (a, -(1 + F(1, 2**111))), {})
        self.assertEqual(reference_spmv(matrix, [a, F(1)]), [F(0)])
        self.assertEqual(exact_quantized_spmv(matrix, [a, F(1)], BINARY128), [F(1, 2**224)])
        # Rounding the addition at the first prefix loses the half-ulp.
        matrix = CSR(1, 3, (0, 3), (0, 1, 2), (F(1), F(1, 2**113), F(-1)), {})
        self.assertEqual(reference_spmv(matrix, [F(1)] * 3), [F(0)])

    def test_nonfinite_values_are_propagated_per_touched_row(self):
        matrix = CSR(2, 1, (0, 1, 1), (0,), (F(10**20),), {})
        self.assertEqual(exact_quantized_spmv(matrix, [F(0)], E4M3), [None, F(0)])
        self.assertEqual(scalar_spmv(matrix, [F(0)], E4M3, BINARY128), [0x7f, 0])
        self.assertEqual(reference_spmv(matrix, [None]), [None, F(0)])
        extreme = CSR(1, 1, (0, 1), (0,), (F(1 << 16384),), {})
        self.assertEqual(reference_spmv(extreme, [F(0)]), [None])

    def test_spmv_rejects_wrong_vector_length(self):
        matrix = CSR(1, 2, (0, 0), (), (), {})
        for x in ([], [F(1)], [F(1)] * 3):
            with self.assertRaises(ValueError):
                reference_spmv(matrix, x)
            with self.assertRaises(ValueError):
                scalar_spmv(matrix, x, E4M3, BINARY16)
            with self.assertRaises(ValueError):
                exact_quantized_spmv(matrix, x, E4M3)

    def test_error_metrics_use_norms_and_no_zero_reference_epsilon(self):
        result = error_metrics([F(6), F(8)], [F(3), F(4)])
        self.assertEqual(Decimal(result["absolute_l2"]), 5)
        self.assertEqual(Decimal(result["relative_l2"]), 1)
        self.assertEqual(result["nonfinite_count"], 0)
        self.assertEqual(result["reference_nonfinite_count"], 0)
        self.assertFalse(result["zero_reference"])
        result = error_metrics([F(3), F(4)], [F(0), F(0)])
        self.assertEqual(Decimal(result["absolute_l2"]), 5)
        self.assertIsNone(result["relative_l2"])
        self.assertTrue(result["zero_reference"])
        empty = error_metrics([], [])
        self.assertEqual(Decimal(empty["absolute_l2"]), 0)
        self.assertIsNone(empty["relative_l2"])
        self.assertTrue(empty["zero_reference"])

    def test_error_metrics_invalidate_global_result_on_any_nonfinite(self):
        result = error_metrics([None, F(1), None], [F(0), None, F(0)])
        self.assertEqual(result["nonfinite_count"], 2)
        self.assertEqual(result["reference_nonfinite_count"], 1)
        self.assertIsNone(result["relative_l2"])
        self.assertIsNone(result["absolute_l2"])
        self.assertFalse(result["zero_reference"])
        result = error_metrics([None], [F(0)])
        self.assertTrue(result["zero_reference"])
        with self.assertRaises(ValueError):
            error_metrics([F(1)], [])

    def test_error_metrics_preserve_tiny_exact_error_and_decimal_precision(self):
        tiny = F(1, 2**10000)
        result = error_metrics([1 + tiny], [F(1)])
        with localcontext() as context:
            context.prec = 50
            expected = Decimal(1) / Decimal(2**10000)
            self.assertEqual(Decimal(result["absolute_l2"]), expected)
            self.assertEqual(Decimal(result["relative_l2"]), expected)
        result = error_metrics([F(0), F(0)], [F(1), F(1)])
        self.assertEqual(result["absolute_l2"], "1.4142135623730950488016887242096980785696718753769")


if __name__ == "__main__":
    unittest.main()
