"""Exact finite reference arithmetic for binary16/32/64/128 and OCP FP8.

The IEEE interchange layouts and roundTiesToEven follow IEEE Std 754-2019
(sections 3.4 and 4.3.1): https://doi.org/10.1109/IEEESTD.2019.8766229 .
FP8 layouts and overflow-after-rounding follow OCP OFP8 revision 1.0,
sections 5.1 and 5.2:
https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1

All finite values and intermediate results are exact ``Fraction`` objects;
each operation then rounds once to its destination format. In particular,
binary128 has 112 stored fraction bits and 113 significant bits. It does not
use the host's binary64 arithmetic as a substitute for binary128.

This is a finite numerical reference, not a full IEEE exception-state model:
NaNs and infinities both decode to None and any operation on None produces a
canonical NaN. There are no flags, traps, NaN payload propagation, directed
rounding modes, fused operations, or infinity arithmetic. Saturation clamps
only finite overflows; None remains NaN even in saturation mode. This differs
from the OCP conversion of a *known infinity* under saturation, because None
intentionally carries no infinity/NaN distinction.

Zero policy: decoding either signed zero returns Fraction(0). Encoding a
negative zero string preserves its sign, as does underflow of a negative
nonzero input. Fraction/integer zero and exact zero arithmetic results use
positive zero; negative-zero operands lose their sign when decoded.
"""

from dataclasses import dataclass
from fractions import Fraction


def _pow2(exponent: int) -> Fraction:
    return Fraction(1 << exponent) if exponent >= 0 else Fraction(1, 1 << -exponent)


def _floor_log2(value: Fraction) -> int:
    """Find a positive rational's binade without logarithms or host floats."""
    exponent = value.numerator.bit_length() - value.denominator.bit_length()
    if value < _pow2(exponent):
        exponent -= 1
    return exponent


def _round_even(value: Fraction) -> int:
    """Round a nonnegative rational to its nearest even integer on ties."""
    quotient, remainder = divmod(value.numerator, value.denominator)
    twice = 2 * remainder
    return quotient + (twice > value.denominator or
                       (twice == value.denominator and quotient % 2 == 1))


@dataclass(frozen=True)
class BinaryFormat:
    """A sign/exponent/fraction format with exact finite arithmetic.

    ``finite_only=True`` uses the OCP E4M3 convention: the all-ones exponent
    still holds finite values, with only its all-ones fraction reserved for
    NaN. Otherwise an all-ones exponent contains infinities and NaNs, as in
    IEEE formats and E5M2. ``saturate`` clamps finite overflow to max finite.
    """

    bits: int
    exponent_bits: int
    fraction_bits: int
    name: str
    finite_only: bool = False
    saturate: bool = False

    def __post_init__(self) -> None:
        if (not all(isinstance(n, int) for n in
                    (self.bits, self.exponent_bits, self.fraction_bits)) or
                self.exponent_bits < 2 or self.fraction_bits < 1 or
                self.bits != 1 + self.exponent_bits + self.fraction_bits):
            raise ValueError("bits must equal sign + exponent + fraction; exponent >= 2, fraction >= 1")

    @property
    def _bias(self) -> int:
        return (1 << (self.exponent_bits - 1)) - 1

    @property
    def _exponent_mask(self) -> int:
        return (1 << self.exponent_bits) - 1

    @property
    def _fraction_mask(self) -> int:
        return (1 << self.fraction_bits) - 1

    @property
    def _nan(self) -> int:
        payload = self._fraction_mask if self.finite_only else 1 << (self.fraction_bits - 1)
        return (self._exponent_mask << self.fraction_bits) | payload

    @property
    def _maximum_raw(self) -> int:
        if self.finite_only:
            return (1 << (self.bits - 1)) - 2
        return (self._exponent_mask << self.fraction_bits) - 1

    def decode(self, raw: int) -> Fraction | None:
        """Decode an unsigned raw word exactly; all nonfinite words give None."""
        if not isinstance(raw, int):
            raise TypeError("raw encoding must be an integer")
        if not 0 <= raw < (1 << self.bits):
            raise ValueError(f"raw encoding must fit {self.bits} bits")
        fraction = raw & self._fraction_mask
        exponent = (raw >> self.fraction_bits) & self._exponent_mask
        if exponent == self._exponent_mask:
            if not self.finite_only or fraction == self._fraction_mask:
                return None
        if exponent == 0:
            value = fraction * _pow2(1 - self._bias - self.fraction_bits)
        else:
            significand = (1 << self.fraction_bits) + fraction
            value = significand * _pow2(exponent - self._bias - self.fraction_bits)
        return -value if raw >> (self.bits - 1) else value

    def encode(self, value: Fraction | int | str | None) -> int:
        """Round an exact input to a raw word, nearest with ties to even.

        Decimal or rational strings are parsed exactly by Fraction. Host
        float inputs are rejected; callers can opt in explicitly by using
        Fraction.from_float. None encodes a canonical quiet NaN.
        """
        if value is None:
            return self._nan
        if not isinstance(value, (Fraction, int, str)):
            raise TypeError("encode expects Fraction, int, str, or None")
        negative_zero = isinstance(value, str) and value.lstrip().startswith("-")
        number = Fraction(value)
        negative = number < 0 or (number == 0 and negative_zero)
        sign = int(negative) << (self.bits - 1)
        if number == 0:
            return sign
        magnitude = abs(number)
        minimum_exponent = 1 - self._bias
        exponent = max(minimum_exponent, _floor_log2(magnitude))
        # Fix the spacing at the minimum normal binade for subnormals.
        significand = _round_even(magnitude * _pow2(self.fraction_bits - exponent))
        if significand == 1 << (self.fraction_bits + 1):
            significand >>= 1
            exponent += 1
        if significand < (1 << self.fraction_bits):
            return sign | significand
        raw = ((exponent + self._bias) << self.fraction_bits) + significand - (1 << self.fraction_bits)
        # Compare only after rounding: E4M3 values up to and including 464
        # round to 448. Clamping/checking the exact input first is incorrect.
        if raw > self._maximum_raw:
            if self.saturate:
                raw = self._maximum_raw
            elif self.finite_only:
                raw = self._nan
            else:
                raw = self._exponent_mask << self.fraction_bits
        return sign | raw

    def add(self, left: int, right: int) -> int:
        """Add decoded operands exactly, then round once."""
        a, b = self.decode(left), self.decode(right)
        return self.encode(None if a is None or b is None else a + b)

    def sub(self, left: int, right: int) -> int:
        """Subtract decoded operands exactly, then round once."""
        a, b = self.decode(left), self.decode(right)
        return self.encode(None if a is None or b is None else a - b)

    def mul(self, left: int, right: int) -> int:
        """Multiply decoded operands exactly, then round once."""
        a, b = self.decode(left), self.decode(right)
        return self.encode(None if a is None or b is None else a * b)


E4M3 = BinaryFormat(8, 4, 3, "E4M3", finite_only=True)
E5M2 = BinaryFormat(8, 5, 2, "E5M2")
BINARY16 = BinaryFormat(16, 5, 10, "binary16")
BINARY32 = BinaryFormat(32, 8, 23, "binary32")
BINARY64 = BinaryFormat(64, 11, 52, "binary64")
BINARY128 = BinaryFormat(128, 15, 112, "binary128")
