#!/usr/bin/env python3
"""Analisa o CSV de erro relativo: CDF (coluna percent) e figuras.

Replica o pipeline do MuFoLAB (sort_csv.jl) de forma simplificada:
- ordena cada coluna (somente valores finitos);
- escreve <prefix>.sorted.csv com a coluna `percent`;
- gera figuras PNG por grupo de bits se matplotlib estiver disponivel.
"""

import argparse
import csv
import math
import os
import sys

GROUPS = {
    "8 bits": ["f8_e4m3", "f8_e5m2", "takum8", "taklog8", "posit8"],
    "16 bits": ["f16", "bf16", "takum16", "taklog16", "posit16"],
    "32 bits": ["f32", "takum32", "taklog32", "posit32"],
}


def load(path):
    with open(path, newline="") as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)
    drop = [i for i, name in enumerate(header) if name == "nnz"]
    if drop:
        i = drop[0]
        header = header[:i] + header[i + 1:]
        rows = [row[:i] + row[i + 1:] for row in rows]
    return header, rows


def sorted_columns(header, rows):
    data = {name: [] for name in header[1:]}
    nonfinite = {name: 0 for name in header[1:]}
    for row in rows:
        for name, value in zip(header[1:], row[1:]):
            try:
                v = float(value)
            except ValueError:
                nonfinite[name] += 1
                continue
            if math.isfinite(v):
                data[name].append(v)
            else:
                nonfinite[name] += 1
    out = {}
    for name in header[1:]:
        out[name] = sorted(data[name])
    return out, nonfinite


def write_sorted(cols, header, path):
    names = header[1:]
    n = max((len(cols[name]) for name in names), default=0)
    with open(path, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["percent"] + names)
        for i in range(n):
            pct = i / (n - 1) if n > 1 else 0.0
            row = [f"{pct:.6f}"]
            for name in names:
                row.append(f"{cols[name][i]:.6e}" if i < len(cols[name]) else "")
            writer.writerow(row)


def plot(cols, path_prefix):
    try:
        import matplotlib

        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except Exception as exc:  # noqa: BLE001
        print(f"matplotlib indisponivel ({exc}); apenas CSV gerado",
              file=sys.stderr)
        return False

    for label, formats in GROUPS.items():
        present = [f for f in formats if f in cols and cols[f]]
        if not present:
            continue
        plt.figure(figsize=(6.0, 4.0))
        for name in present:
            vals = cols[name]
            pct = [i / (len(vals) - 1) for i in range(len(vals))] if len(
                vals) > 1 else [0.0]
            plt.plot(pct, vals, label=name)
        plt.yscale("log")
        plt.xlabel("matrizes (percentual acumulado)")
        plt.ylabel("erro relativo 2-norma")
        plt.title(f"Conversao de matrizes - {label}")
        plt.grid(True, which="both", alpha=0.3)
        plt.legend(fontsize=8)
        out = f"{path_prefix}_{label.split()[0]}.png"
        plt.tight_layout()
        plt.savefig(out, dpi=150)
        plt.close()
        print(f"figura: {out}")
    return True


def percentile(vals, p):
    if not vals:
        return float("nan")
    idx = min(len(vals) - 1, max(0, round(p * (len(vals) - 1))))
    return vals[idx]


def summary(cols, header, rows):
    total = len(rows)
    print(f"resumo ({total} matrizes; erro relativo 2-norma):")
    print(f"{'formato':10s} {'finitos':>7s} {'mediana':>12s} "
          f"{'p90':>12s} {'max':>12s} {'>100%':>7s}")
    for name in header[1:]:
        vals = cols[name]
        over = sum(1 for v in vals if v > 1.0)
        pct_over = 100.0 * over / total if total else 0.0
        med = percentile(vals, 0.5)
        p90 = percentile(vals, 0.9)
        mx = vals[-1] if vals else float("nan")
        print(f"{name:10s} {len(vals):7d} {med:12.3e} {p90:12.3e} "
              f"{mx:12.3e} {pct_over:6.1f}%")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("csv")
    ap.add_argument("--outdir", default=".")
    ap.add_argument("--prefix", default="cdf")
    ap.add_argument("--no-plot", action="store_true")
    args = ap.parse_args()

    header, rows = load(args.csv)
    cols, nonfinite = sorted_columns(header, rows)
    for name in header[1:]:
        nf = nonfinite[name]
        total = len(rows)
        if nf:
            print(f"  {name}: {len(cols[name])} finitos, {nf} nao finitos "
                  f"de {total}")
    summary(cols, header, rows)
    out_csv = os.path.join(args.outdir, args.prefix + ".sorted.csv")
    write_sorted(cols, header, out_csv)
    print(f"csv ordenado: {out_csv}")
    if not args.no_plot:
        plot(cols, os.path.join(args.outdir, args.prefix))


if __name__ == "__main__":
    main()
