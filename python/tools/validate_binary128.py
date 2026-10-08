"""Generate/read an independent GCC binary128 fixture and compare raw results.

The corpus generator only constructs IEEE raw words and decimal strings. It
never asks the Python format for expected values or for its input encodings.
The C executable supplies every saved expected result. A saved JSONL fixture
can subsequently be validated offline with Python's standard library alone.
"""

import argparse
from collections import Counter
from datetime import datetime, timezone
from decimal import Decimal, localcontext
import hashlib
import json
from pathlib import Path
import platform
import random
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from takum_rvv.binary import BINARY128


SIGN = 1 << 127
FRACTION_MASK = (1 << 112) - 1
EXPONENT_MASK = 0x7fff << 112
MAXIMUM_FINITE = (0x7ffe << 112) | FRACTION_MASK
ONE = 0x3fff << 112
CLASSIFICATIONS = (
    "exact", "signed_zero_difference", "nonfinite_kind_difference",
    "nan_payload_or_sign_difference", "infinity_sign_difference", "mismatch",
)
_HEX128 = re.compile(r"[0-9a-fA-F]{32}")


def _raw(value: str) -> int:
    if not isinstance(value, str) or not _HEX128.fullmatch(value):
        raise ValueError("Expected exactly 32 hexadecimal digits")
    return int(value, 16)


def _kind(raw: int) -> str:
    if not isinstance(raw, int) or not 0 <= raw < (1 << 128):
        raise ValueError("Expected an unsigned binary128 word")
    if raw & EXPONENT_MASK == EXPONENT_MASK:
        return "nan" if raw & FRACTION_MASK else "infinity"
    return "zero" if raw & (SIGN - 1) == 0 else "finite"


def compare_raw(actual: int, expected: int) -> str:
    """Classify exact matches and deliberately limited finite-model matches.

    Both zero signs decode to Fraction(0). Any NaN/infinity decodes to None.
    Such raw differences are accepted under that contract but counted in
    distinct categories, with examples retained in the validation report.
    A finite/nonfinite difference or unequal nonzero finite result is a bug.
    """
    actual_kind, expected_kind = _kind(actual), _kind(expected)
    if actual == expected:
        return "exact"
    if actual_kind == expected_kind == "zero":
        return "signed_zero_difference"
    if actual_kind in ("nan", "infinity") and expected_kind in ("nan", "infinity"):
        if actual_kind != expected_kind:
            return "nonfinite_kind_difference"
        return "nan_payload_or_sign_difference" if actual_kind == "nan" else "infinity_sign_difference"
    return "mismatch"


def generate_cases(pair_count: int = 2000, seed: int = 20261006) -> list[dict]:
    """Construct raw finite inputs spanning full range and sensitive boundaries."""
    if pair_count < 1:
        raise ValueError("Pair count must be positive")
    rng = random.Random(seed)
    minimum_normal = 1 << 112
    half_ulp_one = (0x3fff - 113) << 112
    two = 0x4000 << 112
    anchors = (
        (0, 0), (SIGN, SIGN), (0, SIGN), (SIGN, ONE),
        (ONE, ONE), (ONE, ONE | SIGN), (ONE + 1, ONE + 1),
        (ONE, half_ulp_one), (ONE + 1, half_ulp_one),
        (ONE - 1, half_ulp_one),
        (1, 1), (SIGN | 1, 1), (SIGN | 1, ONE),
        (minimum_normal, 1), (minimum_normal - 1, 1),
        (minimum_normal, minimum_normal | SIGN),
        (minimum_normal, (0x3fff - 1) << 112),
        (1, (0x3fff - 1) << 112), (3, (0x3fff - 1) << 112),
        (MAXIMUM_FINITE, MAXIMUM_FINITE),
        (MAXIMUM_FINITE, MAXIMUM_FINITE | SIGN),
        (MAXIMUM_FINITE, ONE), (MAXIMUM_FINITE, two),
        (MAXIMUM_FINITE | SIGN, two),
        (MAXIMUM_FINITE, (0x3fff + 16270) << 112),
        (MAXIMUM_FINITE, (0x3fff + 16271) << 112),
        (minimum_normal - 1, minimum_normal - 1),
    )
    cases = []

    def append_pair(category, a, b):
        cases.append({"type": "pair", "id": len(cases), "category": category,
                      "a": f"{a:032x}", "b": f"{b:032x}"})

    for a, b in anchors[:pair_count]:
        append_pair("anchors", a, b)

    def uniform():
        return rng.getrandbits(1) * SIGN | rng.randrange(0x7fff) << 112 | rng.getrandbits(112)

    categories = ("uniform", "near_one", "exponent_extremes", "subnormal", "cancellation", "rounding_boundary")
    while len(cases) < pair_count:
        category = categories[(len(cases) - len(anchors)) % len(categories)]
        if category == "uniform":
            a, b = uniform(), uniform()
        elif category == "near_one":
            a = ONE + rng.randint(-1024, 1024) | rng.getrandbits(1) * SIGN
            b = ONE + rng.randint(-1024, 1024) | rng.getrandbits(1) * SIGN
        elif category == "exponent_extremes":
            exponents = (0, 1, 2, 0x7ffd, 0x7ffe)
            a = rng.choice(exponents) << 112 | rng.getrandbits(112) | rng.getrandbits(1) * SIGN
            b = rng.choice(exponents) << 112 | rng.getrandbits(112) | rng.getrandbits(1) * SIGN
        elif category == "subnormal":
            a = rng.getrandbits(112) | rng.getrandbits(1) * SIGN
            b = rng.choice((rng.getrandbits(112), minimum_normal + rng.randint(-32, 32), ONE))
            b |= rng.getrandbits(1) * SIGN
        elif category == "cancellation":
            a = uniform()
            b = min(MAXIMUM_FINITE, max(0, (a & (SIGN - 1)) + rng.randint(-2, 2)))
            b |= (a & SIGN) ^ SIGN
        else:
            a = ONE + rng.randrange(16)
            b = half_ulp_one + rng.choice((-1, 0, 1))
            a |= rng.getrandbits(1) * SIGN
            b |= rng.getrandbits(1) * SIGN
        append_pair(category, a, b)

    # These anchors include decimal conversion, zeros, range overflow and
    # underflow, an irrational constant prefix, and exact ties around one.
    decimals = ["0", "-0", "1", "-1", "0.1", "-0.1", "1e-5000", "-1e-5000",
                "1e5000", "-1e5000", "1.0000000000000000000000000000000001",
                "3.14159265358979323846264338327950288419716939937510",
                "1e-4932", "1e4932"]
    with localcontext() as context:
        context.prec = 200
        decimals += [str(Decimal(1) + Decimal(n) / Decimal(2**113)) for n in (1, 2, 3)]
    for decimal in decimals:
        cases.append({"type": "decimal", "id": len(cases), "category": "decimal_anchor", "decimal": decimal})
    return cases


def request_text(cases: list[dict]) -> str:
    lines = []
    for case in cases:
        if case["type"] == "pair":
            lines.append(f"P {case['id']} {case['category']} {case['a']} {case['b']}")
        elif case["type"] == "decimal":
            lines.append(f"D {case['id']} {case['category']} {case['decimal']}")
        else:
            raise ValueError("Unknown corpus record type")
    return "\n".join(lines) + "\n"


def _read_records(text: str) -> tuple[dict, list[dict]]:
    records = [json.loads(line) for line in text.splitlines() if line.strip()]
    if not records or records[0].get("type") != "metadata":
        raise ValueError("Reference fixture must begin with oracle metadata")
    metadata = records[0]
    required = {"schema": 1, "mantissa_bits": 113, "max_exponent": 16384,
                "min_exponent": -16381, "float128_bytes": 16,
                "rounding": "FE_TONEAREST", "fast_math": False}
    if any(metadata.get(key) != value for key, value in required.items()):
        raise ValueError("Oracle does not declare the required IEEE binary128 environment")
    seen = set()
    for case in records[1:]:
        if case.get("type") not in ("pair", "decimal") or case.get("id") in seen:
            raise ValueError("Unexpected record type or duplicate reference id")
        if not isinstance(case.get("id"), int) or not isinstance(case.get("category"), str):
            raise ValueError("Reference cases require an integer id and category")
        seen.add(case["id"])
        if case["type"] == "pair":
            for key in ("a", "b", "add", "sub", "mul"):
                _raw(case[key])
            if any(_kind(_raw(case[key])) in ("nan", "infinity") for key in ("a", "b")):
                raise ValueError("Arithmetic corpus only supports finite operands")
        else:
            _raw(case["raw"])
            if not isinstance(case.get("decimal"), str):
                raise ValueError("Decimal fixture input must be a string")
    if not records[1:]:
        raise ValueError("Reference fixture has no cases")
    return metadata, records[1:]


def validate(path: Path) -> dict:
    """Validate a saved external fixture; retain classified raw differences."""
    path = Path(path)
    blob = path.read_bytes()
    metadata, cases = _read_records(blob.decode("utf-8"))
    operations = ("add", "sub", "mul", "encode_decimal")
    checks = {op: {"cases": 0, "mismatches": 0,
                   "classifications": dict.fromkeys(CLASSIFICATIONS, 0),
                   "first_mismatches": [], "first_contract_differences": [],
                   "oracle_nonfinite": 0} for op in operations}
    totals = dict.fromkeys(CLASSIFICATIONS, 0)
    for case in cases:
        if case["type"] == "pair":
            a, b = _raw(case["a"]), _raw(case["b"])
            comparisons = [(op, getattr(BINARY128, op)(a, b), _raw(case[op])) for op in operations[:3]]
        else:
            comparisons = [("encode_decimal", BINARY128.encode(case["decimal"]), _raw(case["raw"]))]
        for op, actual, expected in comparisons:
            classification = compare_raw(actual, expected)
            check = checks[op]
            check["cases"] += 1
            check["classifications"][classification] += 1
            totals[classification] += 1
            check["oracle_nonfinite"] += _kind(expected) in ("nan", "infinity")
            details = {"id": case["id"], "category": case["category"],
                       "actual": f"{actual:032x}", "expected": f"{expected:032x}",
                       "classification": classification}
            if classification == "mismatch":
                check["mismatches"] += 1
                if len(check["first_mismatches"]) < 10:
                    check["first_mismatches"].append(details)
            elif classification != "exact" and len(check["first_contract_differences"]) < 10:
                check["first_contract_differences"].append(details)
    return {
        "schema": 1,
        "oracle": metadata,
        "fixture_sha256": hashlib.sha256(blob).hexdigest(),
        "python": platform.python_version(),
        "python_binary_sha256": hashlib.sha256((ROOT / "takum_rvv" / "binary.py").read_bytes()).hexdigest(),
        "pair_count": sum(case["type"] == "pair" for case in cases),
        "category_counts": dict(Counter(case["category"] for case in cases)),
        "comparison_contract": "Raw finite values must match; signed zeros and nonfinite kinds/payloads are separately classified under Fraction/None semantics.",
        "checks": checks,
        "classification_totals": totals,
        "matches_all": totals["mismatch"] == 0,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fixture", type=Path, default=ROOT / "tests/data/binary128_cases.jsonl")
    parser.add_argument("--report", type=Path)
    parser.add_argument("--pairs", type=int, default=2000)
    parser.add_argument("--seed", type=int, default=20261006)
    parser.add_argument("--build-command", help="Exact build command used by the operator, recorded as declared provenance")
    parser.add_argument("--oracle", nargs=argparse.REMAINDER,
                        help="Run an external oracle argv (must be the final option); omit to validate an existing fixture")
    args = parser.parse_args()
    if args.oracle is not None:
        if not args.oracle:
            parser.error("--oracle needs an executable and optional arguments")
        cases = generate_cases(args.pairs, args.seed)
        request = request_text(cases)
        completed = subprocess.run(args.oracle, input=request, text=True, encoding="utf-8",
                                   capture_output=True, check=True, timeout=120)
        metadata, expected = _read_records(completed.stdout)
        if len(expected) != len(cases):
            raise ValueError("Oracle returned a different number of cases")
        for sent, received in zip(cases, expected):
            if any(received.get(key) != value for key, value in sent.items()):
                raise ValueError(f"Oracle response changed input case {sent['id']}")
        metadata["provenance"] = {
            "generated_utc": datetime.now(timezone.utc).isoformat(),
            "seed": args.seed, "requested_pairs": args.pairs,
            "oracle_argv": args.oracle,
            "operator_declared_build_command": args.build_command,
            "request_sha256": hashlib.sha256(request.encode("utf-8")).hexdigest(),
            "harness_sha256": hashlib.sha256((ROOT / "tools/binary128_reference.c").read_bytes()).hexdigest(),
            "generator_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "oracle_stderr": completed.stderr,
        }
        args.fixture.parent.mkdir(parents=True, exist_ok=True)
        args.fixture.write_text("\n".join(json.dumps(record, sort_keys=True)
                                          for record in [metadata, *expected]) + "\n", encoding="utf-8")
    report = validate(args.fixture)
    output = json.dumps(report, indent=2)
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(output + "\n", encoding="utf-8")
    print(output)
    return 0 if report["matches_all"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
