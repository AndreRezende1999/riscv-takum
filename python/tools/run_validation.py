"""Run the predeclared eight-matrix, two-scaling experiment entirely offline.

Protocol and source attribution: docs/08_plano_validacao_ampliada.md and
data/validation_set.json. Numerical models cite their sources in takum_rvv/.
"""

import argparse
import csv
import hashlib
import json
from decimal import Decimal, localcontext
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from takum_rvv.benchmark import run_experiment


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def summarize(arms):
    """Paired comparisons; undefined errors never become zeros or disappear."""
    lookup = {policy: {(r['matrix'], r['format']): r for r in arm['results']}
              for policy, arm in arms.items()}
    if set(lookup['none']) != set(lookup['pow2-bound']):
        raise ValueError('Experimental arms have different matrix/format pairs')
    paired = []
    for key, baseline in lookup['none'].items():
        scaled = lookup['pow2-bound'][key]
        a, b = baseline['relative_l2'], scaled['relative_l2']
        if a is None or b is None:
            effect = ('both_undefined' if a is None and b is None else
                      'became_defined' if a is None else 'became_undefined')
        else:
            da, db = Decimal(a), Decimal(b)
            effect = 'improved' if db < da else 'worsened' if db > da else 'unchanged'
        paired.append({'matrix': key[0], 'format': key[1], 'none': a,
                       'pow2-bound': b, 'effect': effect})
    aggregates = {}
    for policy, arm in arms.items():
        aggregates[policy] = {}
        for name in dict.fromkeys(r['format'] for r in arm['results']):
            rows = [r for r in arm['results'] if r['format'] == name]
            values = sorted(Decimal(r['relative_l2']) for r in rows if r['relative_l2'] is not None)
            with localcontext() as ctx:
                ctx.prec = 60
                n = len(values)
                median = (values[n // 2] if n % 2 else
                          (values[n // 2 - 1] + values[n // 2]) / 2) if n else None
            aggregates[policy][name] = {'total': len(rows), 'defined': n,
                                       'median_defined_only': str(median) if median is not None else None}
    return {'aggregates': aggregates, 'paired': paired}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'results' / 'validation_v2')
    args = parser.parse_args()
    output = args.output.resolve()
    if output.exists() and any(output.iterdir()):
        parser.error('Choose an empty/new output directory to preserve previous results')
    dataset_path = ROOT / 'data' / 'validation_set.json'
    dataset = json.loads(dataset_path.read_text(encoding='utf-8'))
    if dataset['failures'] or [m['name'] for m in dataset['matrices']] != dataset['requested']:
        raise ValueError('The predeclared dataset is incomplete or reordered')
    if digest(ROOT / dataset['protocol']) != dataset['protocol_sha256']:
        raise ValueError('The recorded pre-results protocol has changed')
    paths = [ROOT / m['path'] for m in dataset['matrices']]
    for path, entry in zip(paths, dataset['matrices']):
        if digest(path) != entry['sha256']:
            raise ValueError(f'Matrix hash differs from dataset manifest: {path}')
    arms = {}
    for policy in ('none', 'pow2-bound'):
        print(f'Running {policy}: {len(paths)} matrices, seven formats, seed=2026, VLEN=256', flush=True)
        arms[policy] = run_experiment(paths, output / policy, seed=2026, vlen=256, scaling=policy)
        print(f'Completed {policy}: {len(arms[policy]["results"])} results', flush=True)
    if (output / 'none' / 'vectors.json').read_bytes() != (output / 'pow2-bound' / 'vectors.json').read_bytes():
        raise AssertionError('Experimental arms used different vectors')
    if arms['none']['manifest']['code_sha256'] != arms['pow2-bound']['manifest']['code_sha256']:
        raise AssertionError('Model code changed between arms')
    summary = summarize(arms)
    summary.update({'dataset_sha256': digest(dataset_path),
                    'protocol_sha256': dataset['protocol_sha256'],
                    'runner_sha256': digest(Path(__file__)),
                    'same_vectors_verified': True, 'same_model_code_verified': True,
                    'interpretation': 'Eight convenience-selected problems; bcsstk02 is a dense control. One seed. No population inference.',
                    'artifacts_sha256': {str(p.relative_to(output)): digest(p)
                                          for p in sorted(output.glob('*/*')) if p.is_file()}})
    (output / 'comparison.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
    with (output / 'paired.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=['matrix', 'format', 'none', 'pow2-bound', 'effect'])
        writer.writeheader()
        writer.writerows(summary['paired'])
    print(json.dumps(summary['aggregates'], indent=2), flush=True)


if __name__ == '__main__':
    main()
