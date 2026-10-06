"""Unpack the two previously downloaded NIST files and record provenance.

No network operations. Source: NIST Matrix Market, Harwell-Boeing collection.
Run from the repository root after downloading the URLs below to tmp/matrices.
"""
import gzip
import hashlib
import json
from pathlib import Path


SOURCES = {
    'bcsstk01': ('bcsstruc1', 'John Lewis, Boeing Computer Services', 'structural engineering'),
    'west0067': ('chemwest', 'Art Westerberg, University of Pittsburgh', 'chemical engineering'),
}


def main():
    output = Path('data/harwell_boeing')
    output.mkdir(parents=True, exist_ok=True)
    for name, (group, author, domain) in SOURCES.items():
        archive = Path('tmp/matrices') / f'{name}.mtx.gz'
        data = gzip.decompress(archive.read_bytes())
        (output / f'{name}.mtx').write_bytes(data)
        provenance = {
            'collection': 'NIST Matrix Market / Harwell-Boeing', 'name': name,
            'source_author': author, 'domain': domain, 'retrieved': '2026-10-06',
            'page': f'https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/{group}/{name}.html',
            'download': f'https://math.nist.gov/pub/MatrixMarket2/Harwell-Boeing/{group}/{name}.mtx.gz',
            'also_catalogued_at': f'https://sparse.tamu.edu/HB/{name}',
            'archive_sha256': hashlib.sha256(archive.read_bytes()).hexdigest(),
            'sha256': hashlib.sha256(data).hexdigest(),
            'selection': 'two small real matrices to validate the pipeline; not a representative sample',
        }
        (output / f'{name}.source.json').write_text(json.dumps(provenance, indent=2) + '\n', encoding='utf-8')
        print(name, provenance['sha256'])


if __name__ == '__main__': main()
