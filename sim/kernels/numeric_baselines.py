"""Erro SpMV dos formatos sem suporte no RVV (FP8 e FP16), por modelo numérico.

O RVV 1.0 não define FP8, e a FP16 vetorial depende de Zvfh, que o simulador ainda
não implementa. Por isso estes formatos entram apenas como referência numérica:
mesma matriz, mesmo vetor x, mesma regra de arredondamento por operação e mesma
ordem de acumulação de scalar_spmv(). Não há contagem de instruções para eles.

    python3 sim/kernels/numeric_baselines.py
"""

from __future__ import annotations

import csv
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "sim" / "kernels"))
sys.path.insert(0, str(ROOT / "python"))

from spmv import MATRIX_DIR, x_vector  # noqa: E402
from takum_rvv.binary import BINARY16, BINARY32, BINARY64, E4M3, E5M2  # noqa: E402
from takum_rvv.codec import Takum  # noqa: E402
from takum_rvv.sparse import error_metrics, read_matrix_market, reference_spmv, scalar_spmv  # noqa: E402

OUT = ROOT / "sim" / "results" / "spmv_numerico_hb.csv"

FORMATS = [
    # Política de acumulação de cada kernel (2n para takum, largura do formato para FP).
    ("e4m3", E4M3, BINARY16),
    ("e5m2", E5M2, BINARY16),
    ("binary16", BINARY16, BINARY32),
    ("binary32", BINARY32, BINARY32),
    ("takum8", Takum(8), Takum(16)),
    ("takum16", Takum(16), Takum(32)),
    ("takum32", Takum(32), Takum(64)),
    # Controles: mesmo acumulador para isolar o efeito da largura de acumulação.
    ("binary16_acc16", BINARY16, BINARY16),
    ("binary32_acc64", BINARY32, BINARY64),
    ("takum8_acc8", Takum(8), Takum(8)),
    ("takum16_acc16", Takum(16), Takum(16)),
    ("takum32_acc32", Takum(32), Takum(32)),
]


def main() -> int:
    rows = []
    for path in sorted(MATRIX_DIR.glob("*.mtx")):
        matrix = read_matrix_market(path)
        xs = x_vector(matrix.cols)
        reference = reference_spmv(matrix, xs)
        for name, storage, accumulator in FORMATS:
            raw = scalar_spmv(matrix, xs, storage, accumulator)
            actual = [storage.decode(value) for value in raw]
            metrics = error_metrics(actual, reference)
            rows.append({
                "matrix": path.stem,
                "format": name,
                "accumulator": getattr(accumulator, "name", None) or accumulator.__class__.__name__,
                "relative_l2": metrics["relative_l2"],
                "nonfinite": metrics["nonfinite_count"],
            })
            print(f"{path.stem:<12} {name:<9} err={metrics['relative_l2']} "
                  f"nao_finitos={metrics['nonfinite_count']}")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)
    print(f"\n{len(rows)} avaliações; resultados em {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
