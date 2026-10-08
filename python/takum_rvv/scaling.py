"""A project-specific power-of-two normalization for controlled SpMV trials.

Motivation for explicit scaling controls: Micikevicius et al., FP8 Formats
for Deep Learning, arXiv:2209.05433v2, section4.3. This infinity-norm bound
policy is our experimental choice, not that paper's calibration algorithm.
The two global scale exponents and exact external rescaling must be reported.
"""
from dataclasses import replace
from fractions import Fraction
from .codec import power2


def _ceil_power2(value):
    if value == 0:
        return Fraction(1)
    if value < 0:
        raise ValueError('A scale bound must be nonnegative')
    exponent = value.numerator.bit_length() - value.denominator.bit_length()
    result = power2(exponent)
    return result * 2 if result < value else result


def prepare_scaled_inputs(matrix, x, policy='none'):
    if len(x) != matrix.cols:
        raise ValueError('Vector length differs from matrix columns')
    if policy == 'none':
        return matrix, x, Fraction(1), Fraction(1)
    if policy != 'pow2-bound':
        raise ValueError('Scaling must be none or pow2-bound')
    row_bound = max((sum((abs(a) for a in matrix.data[matrix.rowptr[r]:matrix.rowptr[r+1]]),
                         Fraction(0)) for r in range(matrix.rows)), default=Fraction(0))
    sa = _ceil_power2(row_bound)
    sx = _ceil_power2(max((abs(Fraction(v)) for v in x), default=Fraction(0)))
    scaled = replace(matrix, data=tuple(v / sa for v in matrix.data), metadata=dict(matrix.metadata))
    return scaled, [Fraction(v) / sx for v in x], sa, sx


def rescale_values(values, scale):
    """No finite rounding here: an external block scale, not a vector opcode."""
    return [None if v is None else v * scale for v in values]
