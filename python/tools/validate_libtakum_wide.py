"""Audit independent libtakum T16/T32 data, preserving every disagreement.

Fixture generator: libtakum_wide_reference.c; upstream provenance is recorded
in tests/data/libtakum_wide.md. Hexadecimal values are parsed as Fractions,
never through Python float. The upstream binary64 ALU is not assumed exact.
"""
import argparse
import gzip
import hashlib
import json
import re
import sys
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from takum_rvv.codec import Takum

COMMIT = '776ac0ca7855f640100731ed8bbb0c7cf83b2d94'
HEX_FLOAT = re.compile(r'([+-]?)0x([0-9a-f]+)(?:\.([0-9a-f]*))?p([+-]?\d+)', re.I)


def hex_fraction(token):
    """Decode the exact value of a C %a token; NaN denotes Takum NaR."""
    if token.lower() in ('nan', '-nan', '+nan'):
        return None
    match = HEX_FLOAT.fullmatch(token)
    if match is None:
        raise ValueError(f'Invalid finite hexadecimal value: {token}')
    sign, integral, fractional, exponent = match.groups()
    fractional = fractional or ''
    numerator = int(integral + fractional, 16)
    value = Fraction(numerator, 16 ** len(fractional))
    exp = int(exponent)
    value = value * (1 << exp) if exp >= 0 else value / (1 << -exp)
    return -value if sign == '-' else value


def analyze_t32_product(a_token, b_token, python_raw, upstream_raw):
    """Prove a particular near-one double-rounding discrepancy, or decline.

    This does not call the Python Takum encoder or decoder. Input values come
    from the C %a records. Within this one regime, a positive output pattern
    0x40000000+k represents 1+k/2**27; negation is two's complement. Adjacent
    output candidates therefore have an exact rational midpoint. In [1,2),
    binary64 spacing is 2**-52, so distance strictly below 2**-53 proves that
    binary64 first rounds to that midpoint. A subsequent Takum tie chooses
    the even raw pattern, even when the original exact value was nearer the
    odd candidate. Other regions or discrepancies are left unclassified.
    """
    def candidate(raw):
        if not isinstance(raw, int) or not 0 <= raw < 2**32:
            return None
        negative = bool(raw & 0x80000000)
        magnitude = (-raw) & 0xffffffff if negative else raw
        if not 0x40000000 <= magnitude < 0x48000000:
            return None
        value = 1 + Fraction(magnitude - 0x40000000, 2**27)
        return -value if negative else value

    a, b = hex_fraction(a_token), hex_fraction(b_token)
    py, upstream = candidate(python_raw), candidate(upstream_raw)
    if any(value is None for value in (a, b, py, upstream)):
        return {'classification': 'unclassified'}
    exact = a * b
    midpoint = (py + upstream) / 2
    distance = abs(exact - midpoint)
    proved = (abs(python_raw - upstream_raw) == 1 and upstream_raw % 2 == 0
              and 1 < abs(midpoint) < 2 and (midpoint * 2**52).denominator == 1
              and 0 < distance < Fraction(1, 2**53)
              and abs(exact - py) < abs(exact - upstream))
    return {'classification': 'upstream_binary64_double_rounding' if proved else 'unclassified',
            'exact_product': str(exact), 'candidate_midpoint': str(midpoint),
            'distance_to_midpoint': str(distance), 'binary64_spacing': str(Fraction(1, 2**52)),
            'python_value': str(py), 'upstream_value': str(upstream)}


def validate_bytes(data):
    lines = data.decode('ascii').splitlines()
    if len(lines) != 4 + 65536 + 2 * 10000 or lines[0] != f'TKWREF1\t{COMMIT}':
        raise ValueError('Invalid or truncated wide reference (header or record count)')
    metadata = {}
    for line, name in zip(lines[1:4], ('DBL_MANT_DIG', 'LDBL_MANT_DIG', 'PAIRS_PER_WIDTH')):
        fields = line.split('\t')
        if len(fields) != 3 or fields[:2] != ['M', name]:
            raise ValueError('Invalid platform metadata')
        metadata[name] = int(fields[2])
    if metadata['DBL_MANT_DIG'] < 53 or metadata['PAIRS_PER_WIDTH'] != 10000:
        raise ValueError('Unsupported reference platform or sample size')
    report = {'upstream_commit': COMMIT, 'variant': 'linear',
              'reference_sha256': hashlib.sha256(data).hexdigest(),
              'platform': metadata,
              'result_labels': {'actual': 'Python exact-rational ALU',
                                'expected': 'Pinned upstream result, not assumed mathematically exact'},
              'checks': {}, 'sampling': {}, 'mismatches': []}

    def check(name, actual, expected, context):
        group = report['checks'].setdefault(name, {'cases': 0, 'mismatches': 0})
        group['cases'] += 1
        if actual != expected:
            group['mismatches'] += 1
            report['mismatches'].append(dict(check=name, **context,
                                             actual=actual, expected=expected))

    def raw_value(token, bits):
        if not re.fullmatch(r'[0-9a-f]+', token):
            raise ValueError('Invalid raw hexadecimal pattern')
        raw = int(token, 16)
        if raw >= 1 << bits:
            raise ValueError('Raw pattern outside width')
        return raw

    t16 = Takum(16)
    for expected_raw, line in enumerate(lines[4:4 + 65536]):
        fields = line.split('\t')
        if len(fields) != 4 or fields[:2] != ['D', '16']:
            raise ValueError('Invalid T16 decode record')
        raw = raw_value(fields[2], 16)
        if raw != expected_raw:
            raise ValueError('T16 decode records must enumerate every code in order')
        check('t16_decode', str(t16.decode(raw)), str(hex_fraction(fields[3])), {'a': raw})

    offset = 4 + 65536
    for bits in (16, 32):
        t = Takum(bits)
        counts = {'boundary': 0, 'tie_probe': 0, 'stratified': 0}
        for index, line in enumerate(lines[offset:offset + 10000]):
            fields = line.split('\t')
            if len(fields) != 11 or fields[:3] != ['P', str(bits), str(index)]:
                raise ValueError('Invalid or out-of-order operation record')
            kind = fields[3]
            expected_kind = 'boundary' if index < 768 else 'tie_probe' if index < 1152 else 'stratified'
            if kind != expected_kind:
                raise ValueError('Invalid sample stratum')
            counts[kind] += 1
            a, b = (raw_value(token, bits) for token in fields[4:6])
            for raw, token in zip((a, b), fields[6:8]):
                check(f't{bits}_operand_decode', str(t.decode(raw)), str(hex_fraction(token)),
                      {'case': index, 'a': raw})
            for op, token in zip(('add', 'sub', 'mul'), fields[8:]):
                check(f't{bits}_{op}', getattr(t, op)(a, b), raw_value(token, bits),
                      {'case': index, 'kind': kind, 'a': a, 'b': b})
        report['sampling'][f't{bits}'] = counts
        offset += 10000
    report['classification_counts'] = {}
    report['analyses'] = []
    for mismatch in report['mismatches']:
        analysis = {'classification': 'unclassified'}
        if mismatch['check'] == 't32_mul':
            fields = lines[4 + 65536 + 10000 + mismatch['case']].split('\t')
            analysis = analyze_t32_product(fields[6], fields[7],
                                           mismatch['actual'], mismatch['expected'])
        classification = analysis['classification']
        report['classification_counts'][classification] = report['classification_counts'].get(classification, 0) + 1
        report['analyses'].append(dict(check=mismatch['check'], case=mismatch.get('case'), **analysis))
    report['matches_all'] = not report['mismatches']
    return report


def validate(path):
    path = Path(path)
    blob = path.read_bytes()
    data = gzip.decompress(blob) if path.suffix == '.gz' else blob
    return validate_bytes(data)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reference', type=Path)
    parser.add_argument('--report', type=Path)
    parser.add_argument('--compress', type=Path, help='Save deterministic gzip of the original C data')
    args = parser.parse_args()
    blob = args.reference.read_bytes()
    data = gzip.decompress(blob) if args.reference.suffix == '.gz' else blob
    result = validate_bytes(data)
    if args.compress:
        args.compress.write_bytes(gzip.compress(data, mtime=0))
    text = json.dumps(result, indent=2) + '\n'
    if args.report:
        args.report.write_text(text, encoding='utf-8')
    print(text, end='')
    raise SystemExit(0 if result['matches_all'] else 1)
