"""Modelo de contagem de instruções dos kernels SpMV (sim/kernels/spmv.py).

Para um formato f, o kernel executa

    N_f = r_f * R + c_f * S + K

instruções, onde R é o número de linhas da matriz, S é o número de faixas (strip-mining)
somado sobre as linhas não vazias e K é a preparação e o encerramento do programa.

Os parâmetros (r_f, c_f, K) são medidos com matrizes sintéticas de uma e duas linhas,
vazias ou com 1, 2 e mais faixas. Depois o modelo é conferido contra as execuções de
sim/results/spmv_hb.csv, que usam matrizes reais e outros VLENs.

    python3 sim/kernels/modelo_contagem.py
"""

from __future__ import annotations

import csv
import math
import pathlib
import sys
from fractions import Fraction

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "sim" / "kernels"))
sys.path.insert(0, str(ROOT / "python"))

import spmv  # noqa: E402

FIT_VLEN = 256
RESULTS = ROOT / "sim" / "results" / "spmv_hb.csv"
OUT = ROOT / "sim" / "results" / "modelo_contagem.csv"


def count(fmt, row_lengths: list[int]) -> int:
    rowptr = [0]
    for n in row_lengths:
        rowptr.append(rowptr[-1] + n)
    nnz = rowptr[-1]
    one = fmt.encode(Fraction(1))
    source = spmv.program(fmt, rowptr, [0] * nnz, [one] * nnz, [one], len(row_lengths), nnz)
    _, counters = spmv.simulate("modelo", fmt, FIT_VLEN, source)
    return counters["insn_total"]


def fit(fmt):
    vlmax = FIT_VLEN // fmt.bits
    empty_one = count(fmt, [0])
    empty_two = count(fmt, [0, 0])
    r = empty_two - empty_one
    k = empty_one - r
    one_strip = count(fmt, [vlmax])
    c = one_strip - empty_one
    checks = [
        count(fmt, [vlmax + 1]) == empty_one + 2 * c,
        count(fmt, [vlmax, vlmax]) == 2 * r + 2 * c + k,
        count(fmt, [3, 0, vlmax + 2, 1]) == 4 * r + 4 * c + k,
    ]
    return r, c, k, checks


def check_real(params: dict) -> dict:
    stats = {name: {"exatas": 0, "total": 0, "residuo_max": 0} for name in params}
    matrices = {}
    for row in csv.DictReader(RESULTS.open()):
        name = row["format"]
        if name not in params:
            continue
        matrix_name = row["matrix"]
        if matrix_name not in matrices:
            matrices[matrix_name] = spmv.read_matrix_market(spmv.MATRIX_DIR / f"{matrix_name}.mtx")
        matrix = matrices[matrix_name]
        vlen = int(row["vlen"])
        bits = 32 if name == "fp32" else int(name.removeprefix("takum"))
        vlmax = vlen // bits
        strips = sum(
            math.ceil((matrix.rowptr[i + 1] - matrix.rowptr[i]) / vlmax)
            for i in range(matrix.rows)
            if matrix.rowptr[i + 1] > matrix.rowptr[i]
        )
        r, c, k = params[name]
        residual = int(row["insn_total"]) - (r * matrix.rows + c * strips + k)
        stats[name]["total"] += 1
        stats[name]["exatas"] += residual == 0
        stats[name]["residuo_max"] = max(stats[name]["residuo_max"], abs(residual))
    return stats


def main() -> None:
    formats = {fmt.name: fmt for fmt in spmv.formats()}
    params, synthetic = {}, {}
    for name, fmt in formats.items():
        r, c, k, checks = fit(fmt)
        params[name] = (r, c, k)
        synthetic[name] = (sum(checks), len(checks))
    real = check_real(params)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["formato", "r", "c", "k", "sinteticos_ok", "sinteticos_total",
                         "execucoes", "exatas", "residuo_max"])
        for name, (r, c, k) in params.items():
            ok, total = synthetic[name]
            s = real[name]
            writer.writerow([name, r, c, k, ok, total, s["total"], s["exatas"], s["residuo_max"]])

    print(f"{'formato':<9} {'r':>3} {'c':>3} {'K':>3}  sintéticos  execuções exatas  resíduo máx.")
    for name, (r, c, k) in params.items():
        ok, total = synthetic[name]
        s = real[name]
        print(f"{name:<9} {r:>3} {c:>3} {k:>3}  {ok}/{total}        "
              f"{s['exatas']}/{s['total']}          {s['residuo_max']}")
    print(f"\nresultados em {OUT}")


if __name__ == "__main__":
    main()
