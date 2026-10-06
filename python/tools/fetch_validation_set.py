"""Fetch the fixed eight-matrix NIST set in docs/08_plano_validacao_ampliada.md.

The six additions were selected by metadata before numerical results. The two
pilot problems were already observed. No failed item is silently substituted.
Official primary source: https://math.nist.gov/MatrixMarket/ .
"""
import argparse
from datetime import date
import gzip
import hashlib
import json
from pathlib import Path
import sys
from urllib.request import urlopen

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from takum_rvv.sparse import parse_matrix_market

SET = [
    ('bcsstk01', 'bcsstruc1', 'John Lewis, Boeing Computer Services', 'structural engineering', True),
    ('west0067', 'chemwest', 'Art Westerberg, University of Pittsburgh', 'chemical engineering', True),
    ('bcsstk02', 'bcsstruc1', 'John Lewis, Boeing Computer Services', 'structural engineering', False),
    ('west0132', 'chemwest', 'Art Westerberg, University of Pittsburgh', 'chemical engineering', False),
    ('jpwh_991', 'cirphys', 'J. P. Whelan, Philips Research Laboratories', 'circuit physics', False),
    ('sherman1', 'sherman', 'Andy Sherman, Nolan and Associates', 'oil reservoir modelling', False),
    ('pores_1', 'pores', 'John Appleyard, Harwell Laboratory', 'reservoir modelling', False),
    ('well1033', 'lsq', 'Michael Saunders, Stanford University', 'surveying least squares', False),
]


def sha(blob):
    return hashlib.sha256(blob).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--download', action='store_true', help='Allow HTTPS downloads when absent from cache')
    args = parser.parse_args()
    cache, output = ROOT / 'tmp/matrices', ROOT / 'data/harwell_boeing'
    cache.mkdir(parents=True, exist_ok=True)
    output.mkdir(parents=True, exist_ok=True)
    report = {'protocol': 'docs/08_plano_validacao_ampliada.md',
              'protocol_sha256': sha((ROOT / 'docs/08_plano_validacao_ampliada.md').read_bytes()),
              'selection': 'purposeful convenience sample, 2 observed pilots + 6 new metadata-selected problems',
              'requested': [entry[0] for entry in SET], 'matrices': [], 'failures': []}
    for name, group, author, domain, pilot in SET:
        url = f'https://math.nist.gov/pub/MatrixMarket2/Harwell-Boeing/{group}/{name}.mtx.gz'
        archive = cache / f'{name}.mtx.gz'
        try:
            if not archive.exists():
                if not args.download:
                    raise FileNotFoundError('No cached archive; use --download to permit the network')
                with urlopen(url, timeout=30) as response:
                    compressed = response.read()
                # Check the archive before caching it, so a failed HTTP response
                # cannot masquerade as an input on a subsequent offline run.
                gzip.decompress(compressed)
                archive.write_bytes(compressed)
            compressed = archive.read_bytes()
            data = gzip.decompress(compressed)
            matrix = parse_matrix_market(data.decode('utf-8-sig'))
            if len(matrix.data) > 50000:
                raise ValueError('Expanded nnz exceeds the predeclared limit')
            provenance = {'collection': 'NIST Matrix Market / Harwell-Boeing',
                          'name': name, 'source_author': author, 'domain': domain,
                          'retrieved': str(date(2026, 10, 6)), 'pilot_already_observed': pilot,
                          'page': f'https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/{group}/{name}.html',
                          'download': url, 'sha256': sha(data), 'archive_sha256': sha(compressed),
                          'selection': report['selection']}
            (output / f'{name}.mtx').write_bytes(data)
            (output / f'{name}.source.json').write_text(json.dumps(provenance, indent=2) + '\n', encoding='utf-8')
            report['matrices'].append({'name': name, 'path': f'data/harwell_boeing/{name}.mtx',
                                      'rows': matrix.rows, 'cols': matrix.cols, 'nnz': len(matrix.data),
                                      'sha256': sha(data), 'source': provenance})
            print(f'{name}: {matrix.rows}x{matrix.cols}, nnz={len(matrix.data)}', flush=True)
        except Exception as error:
            report['failures'].append({'name': name, 'download': url,
                                       'error': type(error).__name__ + ': ' + str(error)})
            print(f'{name}: FAILED {error}', flush=True)
    (ROOT / 'data/validation_set.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    return int(bool(report['failures']))


if __name__ == '__main__':
    raise SystemExit(main())
