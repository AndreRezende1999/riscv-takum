"""Exact Matrix Market ingestion and ordered scalar SpMV references.

Matrix Market coordinate syntax and symmetry conventions are described by
NIST: https://math.nist.gov/MatrixMarket/formats.html . Supported fields are
real, integer and pattern; supported symmetry is general or lower-triangular
symmetric. Pattern entries become one. Decimal values are parsed directly to
Fraction (including scientific notation); D/d exponents are also accepted.
Array, complex, Hermitian and skew-symmetric inputs are explicitly rejected.

Duplicates are summed exactly before numeric quantization. Explicit zeros
and coordinates whose merged sum is zero are omitted. CSR columns are sorted
within each row, defining the accumulation order in every reference below.
"""

from dataclasses import dataclass
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path
import re
from typing import Protocol, Sequence

from .binary import BINARY128


class NumericFormat(Protocol):
    """The finite-value codec/ALU interface shared by BinaryFormat and Takum."""

    def encode(self, value: Fraction | int | str | None) -> int: ...
    def decode(self, raw: int) -> Fraction | None: ...
    def add(self, left: int, right: int) -> int: ...
    def mul(self, left: int, right: int) -> int: ...


@dataclass(frozen=True)
class CSR:
    """Canonical CSR with exact, nonzero data and strictly ordered columns.

    The numeric structure is immutable. ``metadata`` is a caller-visible
    dictionary of provenance and normalization counts, not numerical state.
    """

    rows: int
    cols: int
    rowptr: tuple[int, ...]
    colidx: tuple[int, ...]
    data: tuple[Fraction, ...]
    metadata: dict

    def __post_init__(self) -> None:
        if (not isinstance(self.rows, int) or not isinstance(self.cols, int) or
                self.rows < 0 or self.cols < 0):
            raise ValueError("CSR dimensions must be nonnegative integers")
        if not all(isinstance(v, tuple) for v in (self.rowptr, self.colidx, self.data)):
            raise ValueError("CSR arrays must be tuples")
        if (len(self.rowptr) != self.rows + 1 or self.rowptr[0] != 0 or
                self.rowptr[-1] != len(self.data) or len(self.colidx) != len(self.data)):
            raise ValueError("CSR pointers and array lengths are inconsistent")
        if (any(not isinstance(v, int) for v in self.rowptr) or
                any(a > b for a, b in zip(self.rowptr, self.rowptr[1:]))):
            raise ValueError("CSR row pointers must be nondecreasing integers")
        if any(not isinstance(v, int) or not 0 <= v < self.cols for v in self.colidx):
            raise ValueError("CSR column index outside matrix dimensions")
        if any(not isinstance(v, Fraction) or v == 0 for v in self.data):
            raise ValueError("CSR data must contain nonzero Fractions")
        for row in range(self.rows):
            start, stop = self.rowptr[row:row + 2]
            if any(self.colidx[i - 1] >= self.colidx[i] for i in range(start + 1, stop)):
                raise ValueError("CSR columns must be strictly increasing within each row")
        if not isinstance(self.metadata, dict):
            raise ValueError("CSR metadata must be a dictionary")


_INTEGER = re.compile(r"[+-]?[0-9]+")
_DECIMAL = re.compile(r"[+-]?(?:[0-9]+(?:\.[0-9]*)?|\.[0-9]+)(?:[eEdD][+-]?[0-9]+)?")


def _integer(token: str, description: str) -> int:
    if not _INTEGER.fullmatch(token):
        raise ValueError(f"{description} must be an integer: {token!r}")
    return int(token)


def parse_matrix_market(text: str) -> CSR:
    """Parse supported coordinate Matrix Market text without host floats.

    Metadata counts: declared_entries is the number of input lines;
    expanded_entries includes symmetric mirrors; duplicate_entries_merged
    counts repeated expanded coordinates. explicit_zero_entries counts input
    zero lines. zero_entries_removed counts unique merged zero coordinates;
    zero_sum_entries_removed is the subset with nonzero contributions that
    cancelled. nnz is the resulting number of stored CSR entries.
    """
    lines = iter((number, line.strip()) for number, line in
                 enumerate(text.lstrip("\ufeff").splitlines(), 1) if line.strip())
    first = next(lines, None)
    if first is None:
        raise ValueError("Missing Matrix Market header")
    header = first[1].lower().split()
    if len(header) != 5 or header[:3] != ["%%matrixmarket", "matrix", "coordinate"]:
        raise ValueError("Only Matrix Market matrix coordinate input is supported")
    field, symmetry = header[3:]
    if field not in ("real", "integer", "pattern"):
        raise ValueError(f"Unsupported Matrix Market field: {field}")
    if symmetry not in ("general", "symmetric"):
        raise ValueError(f"Unsupported Matrix Market symmetry: {symmetry}")
    content = ((number, line) for number, line in lines if not line.startswith("%"))
    dimension_line = next(content, None)
    if dimension_line is None or len(dimension_line[1].split()) != 3:
        raise ValueError("Expected rows, columns and declared entry count")
    rows, cols, declared = (_integer(token, "Dimension/count")
                            for token in dimension_line[1].split())
    if min(rows, cols, declared) < 0:
        raise ValueError("Dimensions and declared entry count must be nonnegative")
    if symmetry == "symmetric" and rows != cols:
        raise ValueError("Symmetric Matrix Market input must be square")

    entries: dict[tuple[int, int], Fraction] = {}
    nonzero_coordinates: set[tuple[int, int]] = set()
    count = expanded = explicit_zeros = 0
    for number, line in content:
        tokens = line.split()
        if len(tokens) != (2 if field == "pattern" else 3):
            raise ValueError(f"Wrong number of entry fields on line {number}")
        row = _integer(tokens[0], f"Row on line {number}")
        col = _integer(tokens[1], f"Column on line {number}")
        if not 1 <= row <= rows or not 1 <= col <= cols:
            raise ValueError(f"Matrix index out of bounds on line {number}")
        if symmetry == "symmetric" and row < col:
            raise ValueError(f"Symmetric input must store the lower triangle (line {number})")
        if field == "pattern":
            value = Fraction(1)
        elif field == "integer":
            value = Fraction(_integer(tokens[2], f"Value on line {number}"))
        else:
            token = tokens[2]
            if not _DECIMAL.fullmatch(token):
                raise ValueError(f"Expected finite decimal value on line {number}: {token!r}")
            value = Fraction(token.replace("D", "e").replace("d", "e"))
        count += 1
        explicit_zeros += value == 0
        coordinates = [(row - 1, col - 1)]
        if symmetry == "symmetric" and row != col:
            coordinates.append((col - 1, row - 1))
        for coordinate in coordinates:
            expanded += 1
            entries[coordinate] = entries.get(coordinate, Fraction(0)) + value
            if value:
                nonzero_coordinates.add(coordinate)
    if count != declared:
        raise ValueError(f"Declared {declared} entries but found {count}")

    zero_coordinates = {coordinate for coordinate, value in entries.items() if not value}
    metadata = {
        "field": field,
        "symmetry": symmetry,
        "declared_entries": declared,
        "expanded_entries": expanded,
        "duplicate_entries_merged": expanded - len(entries),
        "explicit_zero_entries": explicit_zeros,
        "zero_entries_removed": len(zero_coordinates),
        "zero_sum_entries_removed": len(zero_coordinates & nonzero_coordinates),
        "nnz": len(entries) - len(zero_coordinates),
    }
    rowptr = [0] * (rows + 1)
    colidx: list[int] = []
    data: list[Fraction] = []
    for (row, col), value in sorted(entries.items()):
        if value:
            rowptr[row + 1] += 1
            colidx.append(col)
            data.append(value)
    for row in range(rows):
        rowptr[row + 1] += rowptr[row]
    return CSR(rows, cols, tuple(rowptr), tuple(colidx), tuple(data), metadata)


def read_matrix_market(path: Path) -> CSR:
    """Read a UTF-8/ASCII Matrix Market file, recording its path in metadata."""
    path = Path(path)
    matrix = parse_matrix_market(path.read_text(encoding="utf-8-sig"))
    matrix.metadata["source"] = str(path)
    return matrix


def _check_x(matrix: CSR, x: Sequence[Fraction | None]) -> None:
    if len(x) != matrix.cols:
        raise ValueError(f"Vector length {len(x)} does not match {matrix.cols} columns")


def reference_spmv(matrix: CSR, x: Sequence[Fraction | None]) -> list[Fraction | None]:
    """Common binary128 reference from original inputs, in CSR column order.

    Quantize both original A and x directly to binary128, then round each
    multiply and each add separately. This is not an exact or fused dot
    product. Nonfinite operands/results propagate as None only to rows that
    touch them; empty rows return zero. See binary.py for finite-model limits.
    """
    raw = scalar_spmv(matrix, x, BINARY128, BINARY128)
    return [BINARY128.decode(value) for value in raw]


def scalar_spmv(matrix: CSR, x: Sequence[Fraction | None],
                storage_format: NumericFormat,
                accumulator_format: NumericFormat) -> list[int]:
    """Quantize inputs to storage, convert to accumulator, multiply/add, store.

    Every multiply and add rounds separately in accumulator_format. A and x
    are both quantized in storage_format *before* conversion. Each final
    accumulator is converted back to storage_format; outputs are raw words.
    """
    _check_x(matrix, x)
    a = [accumulator_format.encode(storage_format.decode(storage_format.encode(value)))
         for value in matrix.data]
    v = [accumulator_format.encode(storage_format.decode(storage_format.encode(value)))
         for value in x]
    result = []
    for row in range(matrix.rows):
        total = accumulator_format.encode(0)
        for index in range(matrix.rowptr[row], matrix.rowptr[row + 1]):
            product = accumulator_format.mul(a[index], v[matrix.colidx[index]])
            total = accumulator_format.add(total, product)
        result.append(storage_format.encode(accumulator_format.decode(total)))
    return result


def exact_quantized_spmv(matrix: CSR, x: Sequence[Fraction | None],
                         storage_format: NumericFormat) -> list[Fraction | None]:
    """Diagnostic exact rational dot product of the storage-quantized inputs.

    There is no product, accumulation or final-storage rounding. Therefore it
    isolates input quantization; it is not the common binary128 reference.
    Any touched nonfinite input invalidates that row, even when multiplied by
    zero. Rows with no stored entries remain zero.
    """
    _check_x(matrix, x)
    a = [storage_format.decode(storage_format.encode(value)) for value in matrix.data]
    v = [storage_format.decode(storage_format.encode(value)) for value in x]
    result: list[Fraction | None] = []
    for row in range(matrix.rows):
        total: Fraction | None = Fraction(0)
        for index in range(matrix.rowptr[row], matrix.rowptr[row + 1]):
            left, right = a[index], v[matrix.colidx[index]]
            if left is None or right is None:
                total = None
                break
            total += left * right
        result.append(total)
    return result


def _decimal_sqrt(value: Fraction) -> str:
    with localcontext() as context:
        context.prec = 50
        decimal_value = Decimal(value.numerator) / Decimal(value.denominator)
        return str(decimal_value.sqrt())


def error_metrics(actual: Sequence[Fraction | None],
                  reference: Sequence[Fraction | None]) -> dict:
    """Return exact-sum L2 errors as 50-digit Decimal square-root strings.

    Any nonfinite value invalidates both global norms; counts are retained.
    Relative error is undefined for zero reference norm, without an epsilon.
    zero_reference is true only if every reference entry is finite and zero
    (also true for empty vectors). Absolute error remains defined in that
    case if all actual entries are finite. Decimal strings avoid host-float
    overflow/underflow when exporting very large or small errors.
    """
    if len(actual) != len(reference):
        raise ValueError("Actual and reference vectors must have equal lengths")
    nonfinite_count = sum(value is None for value in actual)
    reference_nonfinite_count = sum(value is None for value in reference)
    zero_reference = reference_nonfinite_count == 0 and all(value == 0 for value in reference)
    result = {
        "relative_l2": None,
        "absolute_l2": None,
        "nonfinite_count": nonfinite_count,
        "zero_reference": zero_reference,
        "reference_nonfinite_count": reference_nonfinite_count,
    }
    if nonfinite_count or reference_nonfinite_count:
        return result
    error_squared = sum(((a - b) ** 2 for a, b in zip(actual, reference)), Fraction(0))
    reference_squared = sum((value ** 2 for value in reference), Fraction(0))
    result["absolute_l2"] = _decimal_sqrt(error_squared)
    if reference_squared:
        result["relative_l2"] = _decimal_sqrt(error_squared / reference_squared)
    return result
