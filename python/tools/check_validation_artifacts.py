"""Audit saved experiment hashes, pairing, CDF denominators and model counters.

Does not rerun arithmetic or measure a processor. Counter formulas are derived
from this project's CSR kernel; see docs/10_analise_isa_csrs.md.
"""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from takum_rvv.sparse import read_matrix_market


def digest(data):
    return hashlib.sha256(data).hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, default=ROOT / 'results/validation_v2')
    parser.add_argument('--report', type=Path, default=ROOT / 'docs/evidencias/auditoria_validacao_ampliada.json')
    args = parser.parse_args()
    root = args.input.resolve()
    comparison = json.loads((root / 'comparison.json').read_text())
    dataset_bytes = (ROOT / 'data/validation_set.json').read_bytes()
    require(digest(dataset_bytes) == comparison['dataset_sha256'], 'Dataset changed')
    paths_by_sha = {m['sha256']: ROOT / m['path'] for m in json.loads(dataset_bytes)['matrices']}
    require(digest((ROOT / 'docs/08_plano_validacao_ampliada.md').read_bytes()) == comparison['protocol_sha256'], 'Protocol changed')
    for path, expected in comparison['artifacts_sha256'].items():
        require(digest((root / path).read_bytes()) == expected, 'Artifact changed: ' + path)
    require((root / 'none/vectors.json').read_bytes() == (root / 'pow2-bound/vectors.json').read_bytes(), 'Vectors differ')
    counts_rows, counter_checks, rows_checked = [], 0, 0
    matrices_by_policy = []
    for policy in ('none', 'pow2-bound'):
        arm = root / policy
        manifest = json.loads((arm / 'manifest.json').read_text())
        require(manifest['scaling'] == policy, 'Incorrect scaling label')
        require(manifest['seed'] == 2026 and manifest['vlen'] == 256, 'Unexpected configuration')
        snapshot = arm / manifest['source_snapshot']['path']
        require(digest(snapshot.read_bytes()) == manifest['source_snapshot']['sha256'], 'Source snapshot changed')
        with zipfile.ZipFile(snapshot) as archive:
            for name, expected in manifest['code_sha256'].items():
                require(digest(archive.read('takum_rvv/' + name)) == expected, 'Archived source hash differs: ' + name)
                require(digest((ROOT / 'takum_rvv' / name).read_bytes()) == expected, 'Current model differs: ' + name)
        matrices = {}
        for entry in manifest['inputs']:
            path = paths_by_sha[entry['sha256']]
            require(digest(path.read_bytes()) == entry['sha256'], 'Matrix changed')
            matrices[entry['matrix_id']] = read_matrix_market(path)
        matrices_by_policy.append(set(matrices))
        with (arm / 'results.csv').open(newline='') as stream:
            rows = list(csv.DictReader(stream))
        require(len(rows) == len(matrices) * 7 == 56, 'Missing or extra result rows')
        require(len({(r['matrix'], r['format']) for r in rows}) == len(rows), 'Duplicate results')
        summary = json.loads((arm / 'cdf_summary.json').read_text())
        for name, counts in summary.items():
            selected = [r for r in rows if r['format'] == name]
            require(counts['total'] == len(selected) == 8, 'CDF denominator differs')
            require(counts['defined'] == sum(bool(r['relative_l2']) for r in selected), 'CDF valid count differs')
            require(counts['nonfinite_results'] == sum(int(r['nonfinite_count']) > 0 for r in selected), 'CDF failures differ')
        for row in rows:
            rows_checked += 1
            require(row['matrix'] in matrices, 'Unknown matrix')
            require(row['scaling'] == policy, 'Row policy differs')
            if row['execution'] != 'vector_model':
                require(json.loads(row['counts']) == {}, 'Scalar model has vector counts')
                continue
            matrix = matrices[row['matrix']]
            bits = int(row['format'].removeprefix('takum_linear'))
            capacity = manifest['vlen'] // bits
            blocks = sum((matrix.rowptr[r+1] - matrix.rowptr[r] + capacity - 1) // capacity for r in range(matrix.rows))
            nnz, m = len(matrix.data), matrix.rows
            expected = {'vtdot.vv': blocks, 'unit_load': blocks, 'indexed_load': blocks,
                        'vsetvli': blocks + m, 'vncvt.t.t': m, 'unit_store': m,
                        'host_seed_writes': m, 'active_products': nnz, 'active_sums': nnz,
                        'active_lanes': nnz + m, 'bytes_read': 2 * nnz * (bits // 8),
                        'index_bytes_read': 4 * nnz, 'bytes_written': m * (bits // 8)}
            require(json.loads(row['counts']) == expected, 'Counter formula mismatch: ' + row['matrix'] + '/' + row['format'])
            counter_checks += 1
            if policy == 'none':
                counts_rows.append({'matrix': row['matrix'], 'bits': bits, 'rows': m, 'nnz': nnz,
                                    'blocks': blocks, 'model_actions': 4 * blocks + 3 * m,
                                    'custom_arithmetic_actions': blocks + m,
                                    'data_bytes_read': expected['bytes_read'],
                                    'index_bytes_read': 4 * nnz,
                                    'data_bytes_written': expected['bytes_written']})
    require(matrices_by_policy[0] == matrices_by_policy[1], 'Arms have different matrices')
    counts_path = root / 'counts.csv'
    with counts_path.open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(counts_rows[0]))
        writer.writeheader(); writer.writerows(counts_rows)
    report = {'passed': True, 'result_rows_checked': rows_checked,
              'vector_counter_sets_checked': counter_checks, 'same_vectors': True,
              'matrix_source_and_artifact_hashes_verified': True,
              'counts_sha256': digest(counts_path.read_bytes()),
              'limits': 'Integrity and accounting audit, not a repeat or independent proof of arithmetic.'}
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
