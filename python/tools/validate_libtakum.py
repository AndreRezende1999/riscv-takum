"""Compare all T8 codes and operand pairs with pinned upstream reference data."""

import argparse
import gzip
import hashlib
import json
import math
import struct
import sys
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from takum_rvv.codec import Takum


def validate(path):
    blob = path.read_bytes()
    data = gzip.decompress(blob) if path.suffix == '.gz' else blob
    if len(data) != 8 + 256 * 8 + 3 * 65536 or data[:8] != b'TK8REF1\n':
        raise ValueError('Invalid reference file (header or size)')
    t = Takum(8)
    report = {'upstream_commit': '776ac0ca7855f640100731ed8bbb0c7cf83b2d94',
              'reference_sha256': hashlib.sha256(data).hexdigest(),
              'variant': 'linear', 'checks': {}}
    mismatches = []
    for a in range(256):
        d = struct.unpack_from('<d', data, 8 + 8 * a)[0]
        want = None if math.isnan(d) else Fraction(d)
        if t.decode(a) != want:
            mismatches.append({'a': a, 'actual': str(t.decode(a)), 'expected': str(want)})
    report['checks']['decode'] = {'cases': 256, 'mismatches': len(mismatches),
                                  'first_mismatches': mismatches[:10]}
    offset = 8 + 256 * 8
    for op in ('add', 'sub', 'mul'):
        mismatches = []
        fn = getattr(t, op)
        for a in range(256):
            for b in range(256):
                want = data[offset + a * 256 + b]
                got = fn(a, b)
                if got != want:
                    mismatches.append({'a': a, 'b': b, 'actual': got, 'expected': want})
        report['checks'][op] = {'cases': 65536, 'mismatches': len(mismatches),
                                'first_mismatches': mismatches[:10]}
        offset += 65536
    report['matches_all'] = all(v['mismatches'] == 0 for v in report['checks'].values())
    return report


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('reference', type=Path)
    p.add_argument('--report', type=Path)
    args = p.parse_args()
    result = validate(args.reference)
    text = json.dumps(result, indent=2)
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(text + '\n', encoding='utf-8')
    print(text)
    raise SystemExit(0 if result['matches_all'] else 1)
