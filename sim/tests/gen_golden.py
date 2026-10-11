"""Gera os vetores dourados do núcleo Takum (C++) a partir do modelo Python.

O modelo Python (python/takum_rvv/codec.py) usa racionais exatos e não depende
da libtakum. Os vetores são comprometidos no repositório; este script só precisa
ser reexecutado se o modelo de referência mudar.

    python3 sim/tests/gen_golden.py
"""

from __future__ import annotations

import pathlib
import random
import sys
from fractions import Fraction

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "python"))

from takum_rvv.codec import Takum  # noqa: E402

OUT = pathlib.Path(__file__).resolve().parent / "golden"
SAMPLES = {16: 4000, 32: 4000, 64: 2000}
DOT_SAMPLES = {8: 4000, 16: 3000, 32: 2000}


def write_t8_tables(t8: Takum) -> None:
    for name, op in (("add", t8.add), ("sub", t8.sub), ("mul", t8.mul)):
        table = bytearray(256 * 256)
        for a in range(256):
            for b in range(256):
                table[a * 256 + b] = op(a, b)
        (OUT / f"t8_{name}.bin").write_bytes(bytes(table))


def write_narrow_table() -> None:
    t16, t8 = Takum(16), Takum(8)
    table = bytearray(1 << 16)
    for code in range(1 << 16):
        table[code] = t16.convert(code, t8)
    (OUT / "t16_to_t8.bin").write_bytes(bytes(table))


def random_code(rng: random.Random, takum: Takum) -> int:
    if rng.random() < 0.5:
        return rng.getrandbits(takum.bits)
    # Valores de magnitude moderada: exercitam fronteiras de regime comuns.
    value = Fraction(rng.randint(1, 1 << 20), rng.randint(1, 1 << 12))
    if rng.random() < 0.5:
        value = -value
    return takum.encode(value)


def write_sampled(rng: random.Random) -> None:
    lines: list[str] = []
    for bits, count in SAMPLES.items():
        takum = Takum(bits)
        for _ in range(count):
            a = random_code(rng, takum)
            b = random_code(rng, takum)
            lines.append(f"add {bits} {a:x} {b:x} {takum.add(a, b):x}")
            lines.append(f"sub {bits} {a:x} {b:x} {takum.sub(a, b):x}")
            lines.append(f"mul {bits} {a:x} {b:x} {takum.mul(a, b):x}")
    (OUT / "takum_ops_sampled.txt").write_text("\n".join(lines) + "\n")


def write_dot(rng: random.Random) -> None:
    lines: list[str] = []
    for bits, count in DOT_SAMPLES.items():
        narrow, wide = Takum(bits), Takum(2 * bits)
        for _ in range(count):
            acc = rng.getrandbits(2 * bits)
            if rng.random() < 0.3:
                acc = 0
            a = random_code(rng, narrow)
            b = random_code(rng, narrow)
            aw = narrow.convert(a, wide)
            bw = narrow.convert(b, wide)
            product = wide.mul(aw, bw)
            result = wide.add(acc, product)
            lines.append(f"dot {bits} {acc:x} {a:x} {b:x} {result:x}")
    (OUT / "takum_dot_sampled.txt").write_text("\n".join(lines) + "\n")


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    rng = random.Random(2026)
    write_t8_tables(Takum(8))
    write_narrow_table()
    write_sampled(rng)
    write_dot(rng)
    print(f"vetores gravados em {OUT}")


if __name__ == "__main__":
    main()
