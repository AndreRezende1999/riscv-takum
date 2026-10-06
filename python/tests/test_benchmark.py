import tempfile
import unittest
import json
import subprocess
import sys
import hashlib
import zipfile
from decimal import Decimal, localcontext
from pathlib import Path
from fractions import Fraction as F
from takum_rvv.codec import Takum
try:
    from takum_rvv.benchmark import run_experiment, spmv_vector, empirical_cdf
    from takum_rvv.sparse import parse_matrix_market, scalar_spmv
except ImportError:
    run_experiment = None


class BenchmarkTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(run_experiment, 'Falta o pipeline SpMV')

    def test_vector_spmv_strips_rows_and_uses_memory_beyond_register_capacity(self):
        lines = ['%%MatrixMarket matrix coordinate real general', '3 100 40']
        lines += [f'1 {i+1} 1' for i in range(39)]
        lines += ['3 100 2']
        a = parse_matrix_market('\n'.join(lines))
        x = [F(1)] * 100
        for bits in (8, 16, 32):
            output, counts = spmv_vector(a, x, bits, vlen=128)
            self.assertEqual(output, scalar_spmv(a, x, Takum(bits), Takum(2*bits)))
            self.assertEqual(Takum(bits).decode(output[1]), 0)
            self.assertEqual(Takum(bits).decode(output[2]), 2)
            self.assertEqual(counts['active_products'], 40)
            self.assertEqual(counts['index_bytes_read'], 160)

    def test_manifest_results_and_zero_reference_remain_explicit(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'small.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n2 2 2\n1 1 1\n2 2 2\n')
            result = run_experiment([path], root / 'out', seed=42, vlen=128)
            self.assertTrue((root / 'out' / 'results.csv').is_file())
            self.assertTrue((root / 'out' / 'manifest.json').is_file())
            self.assertEqual(len(result['results']), 7)
            self.assertTrue(all(r['reference_nonfinite_count'] == 0 for r in result['results']))
            self.assertEqual(result['manifest']['reference'], 'binary128; separate multiply/add; ties-even')
            self.assertEqual(len(result['manifest']['inputs'][0]['sha256']), 64)

    def test_cdf_keeps_failures_in_denominator(self):
        points = empirical_cdf(['0.1', None, '0.2', '0.1'])
        self.assertEqual(points, [('0.1', 2, 4), ('0.2', 3, 4)])

    def test_saved_source_snapshot_matches_manifest(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'small.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 1\n')
            result = run_experiment([path], root / 'out', vector='ones')
            manifest = result['manifest']
            self.assertIn('source_snapshot', manifest)
            snapshot = root / 'out' / manifest['source_snapshot']['path']
            self.assertEqual(hashlib.sha256(snapshot.read_bytes()).hexdigest(),
                             manifest['source_snapshot']['sha256'])
            with zipfile.ZipFile(snapshot) as archive:
                self.assertEqual(set(archive.namelist()),
                                 {'takum_rvv/' + name for name in manifest['code_sha256']})
                for name, digest in manifest['code_sha256'].items():
                    self.assertEqual(hashlib.sha256(archive.read('takum_rvv/' + name)).hexdigest(), digest)

    def test_all_invalid_format_still_appears_in_cdf_summary(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'overflow.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 1000\n')
            run_experiment([path], root / 'out', vector='ones')
            summary_path = root / 'out' / 'cdf_summary.json'
            self.assertTrue(summary_path.exists())
            summary = json.loads(summary_path.read_text())
            self.assertEqual(summary['E4M3']['total'], 1)
            self.assertEqual(summary['E4M3']['defined'], 0)
            self.assertEqual(summary['E4M3']['nonfinite_results'], 1)

    def test_input_quantization_metric_excludes_binary128_reference_rounding(self):
        with tempfile.TemporaryDirectory() as d, localcontext() as ctx:
            ctx.prec = 200
            root = Path(d)
            path = root / 'exact32.mtx'
            tiny = format(Decimal(2) ** -149, 'f')
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 2 2\n1 1 1\n1 2 ' + tiny + '\n')
            report = run_experiment([path], root / 'out', vector='ones')
            result = next(r for r in report['results'] if r['format'] == 'binary32')
            self.assertEqual(Decimal(result['input_effect_relative_l2']), 0)

    def test_cli_displays_huge_finite_metric_without_float_overflow(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            path = root / 'tiny.mtx'
            path.write_text('%%MatrixMarket matrix coordinate real general\n1 1 1\n1 1 1e-400\n')
            p = subprocess.run([sys.executable, '-m', 'takum_rvv', 'bench', str(path),
                                '--vector', 'ones', '--output', str(root / 'out')],
                               capture_output=True, text=True, encoding='utf-8', errors='replace')
            self.assertEqual(p.returncode, 0, p.stderr)
            self.assertIn('E+328', p.stdout.upper())


if __name__ == '__main__': unittest.main()
