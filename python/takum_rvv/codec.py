"""Independent exact-rational linear Takum codec and scalar ALU.

Representation: Hunhold, arXiv:2404.18603v2, Definition 8.
Tie-to-even bit rounding: arXiv:2408.10594v4, section 5.5.
No upstream implementation code is copied. None denotes NaR, never zero.
"""

from dataclasses import dataclass
from fractions import Fraction
from functools import lru_cache


def power2(exponent: int) -> Fraction:
    return Fraction(1 << exponent) if exponent >= 0 else Fraction(1, 1 << -exponent)


@dataclass(frozen=True)
class Fields:
    sign: int
    direction: int
    regime: int
    characteristic_bits: int
    characteristic: int
    fraction: Fraction
    fraction_width: int


def _fields(raw: int, bits: int) -> Fields:
    # Ghost bits to the right are zero when the characteristic is truncated.
    width = max(bits, 12)
    raw <<= width - bits
    sign = raw >> (width - 1)
    direction = (raw >> (width - 2)) & 1
    regime_code = (raw >> (width - 5)) & 7
    regime = regime_code if direction else 7 - regime_code
    p = width - 5 - regime
    characteristic_bits = (raw >> p) & ((1 << regime) - 1)
    c = ((1 << regime) - 1 if direction else 1 - (1 << (regime + 1)))
    return Fields(sign, direction, regime, characteristic_bits,
                  c + characteristic_bits,
                  Fraction(raw & ((1 << p) - 1), 1 << p), p)


@lru_cache(maxsize=32768)
def _decode(raw: int, bits: int) -> Fraction | None:
    if raw == 0:
        return Fraction(0)
    if raw == 1 << (bits - 1):
        return None
    f = _fields(raw, bits)
    exponent = (-1 if f.sign else 1) * (f.characteristic + f.sign)
    return (1 - 3 * f.sign + f.fraction) * power2(exponent)


@dataclass(frozen=True)
class Takum:
    bits: int

    def __post_init__(self):
        if self.bits not in (8, 16, 32, 64):
            raise ValueError("Takum supports 8, 16, 32 or 64 bits")

    @property
    def name(self):
        return f"takum_linear{self.bits}"

    @property
    def nar(self):
        return 1 << (self.bits - 1)

    def _check(self, raw):
        if not isinstance(raw, int) or not 0 <= raw < (1 << self.bits):
            raise ValueError("raw bit pattern outside the format width")

    def fields(self, raw: int) -> Fields:
        self._check(raw)
        return _fields(raw, self.bits)

    def decode(self, raw: int) -> Fraction | None:
        self._check(raw)
        return _decode(raw, self.bits)

    def encode(self, value) -> int:
        if value is None:
            return self.nar
        if not isinstance(value, (Fraction, int, str)):
            raise TypeError('encode expects Fraction, int, str or None; convert host floats explicitly')
        x = Fraction(value)
        if not x:
            return 0
        negative = x < 0
        x = abs(x)
        lo, hi = 1, self.nar - 1
        # Positive bit strings are strictly ordered. Find the lower neighbour.
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if _decode(mid, self.bits) <= x:
                lo = mid
            else:
                hi = mid - 1
        result = lo
        if lo < self.nar - 1:
            # A guard-bit boundary, including characteristic bits for T8.
            threshold = _decode(2 * lo + 1, self.bits + 1)
            if x > threshold or (x == threshold and lo & 1):
                result += 1
        return (-result) & ((1 << self.bits) - 1) if negative else result

    def convert(self, raw: int, target: "Takum") -> int:
        return target.encode(self.decode(raw))

    def add(self, a: int, b: int) -> int:
        x, y = self.decode(a), self.decode(b)
        return self.encode(None if x is None or y is None else x + y)

    def sub(self, a: int, b: int) -> int:
        x, y = self.decode(a), self.decode(b)
        return self.encode(None if x is None or y is None else x - y)

    def mul(self, a: int, b: int) -> int:
        x, y = self.decode(a), self.decode(b)
        return self.encode(None if x is None or y is None else x * y)
