#!/usr/bin/env python3
"""Baixa um subconjunto representativo do SuiteSparse Matrix Collection.

Metodologia (replica a selecao do artigo AVX10.2):
- matrizes com nnz <= 50000 (o artigo usa todas; aqui usamos um
  subconjunto representativo para manter o download leve);
- estratificacao por grupo e por faixas de nnz (quartis), com semente
  fixa para reprodutibilidade.

Uso:
  python3 scripts/fetch_matrices.py --count 100 --out bench/matrices
"""

import argparse
import csv
import io
import os
import random
import sys
import tarfile
import urllib.request

STATS_URL = "https://sparse.tamu.edu/files/ssstats.csv"
MM_BASE = "https://sparse.tamu.edu/MM/"


def fetch_stats():
    with urllib.request.urlopen(STATS_URL, timeout=60) as resp:
        data = resp.read().decode("utf-8", "replace")
    rows = []
    for line in data.splitlines():
        parts = line.split(",")
        if len(parts) < 5:
            continue
        group, name, nrows, ncols, nnz = parts[:5]
        try:
            nnz = int(nnz)
            nrows = int(nrows)
            ncols = int(ncols)
        except ValueError:
            continue
        rows.append(
            {
                "group": group,
                "name": name,
                "nrows": nrows,
                "ncols": ncols,
                "nnz": nnz,
            }
        )
    return rows


def select(rows, count, max_nnz, seed):
    cand = [r for r in rows if 0 < r["nnz"] <= max_nnz]
    if not cand:
        return []
    rng = random.Random(seed)
    # estratifica por grupo e por quartil de nnz
    by_group = {}
    for r in cand:
        by_group.setdefault(r["group"], []).append(r)
    selected = []
    groups = sorted(by_group)
    while len(selected) < count and groups:
        rng.shuffle(groups)
        for g in list(groups):
            bucket = by_group[g]
            if not bucket:
                groups.remove(g)
                continue
            bucket.sort(key=lambda r: r["nnz"])
            q = len(bucket) // 4
            idx = rng.choice(
                [
                    rng.randrange(0, max(1, q)),
                    rng.randrange(max(0, q), max(1, 2 * q)),
                    rng.randrange(max(0, 2 * q), max(1, 3 * q)),
                    rng.randrange(max(0, 3 * q), len(bucket)),
                ]
            )
            selected.append(bucket.pop(idx))
            if len(selected) >= count:
                break
    return selected


def download_matrix(group, name, outdir):
    dest = os.path.join(outdir, name + ".mtx")
    if os.path.exists(dest):
        return dest
    url = f"{MM_BASE}{group}/{name}.tar.gz"
    try:
        with urllib.request.urlopen(url, timeout=180) as resp:
            blob = resp.read()
    except Exception as exc:  # noqa: BLE001
        print(f"aviso: falha ao baixar {group}/{name}: {exc}", file=sys.stderr)
        return None
    tmp = dest + ".tar.gz"
    with open(tmp, "wb") as f:
        f.write(blob)
    try:
        with tarfile.open(tmp, "r:gz") as tar:
            members = [m for m in tar.getmembers() if m.name.endswith(".mtx")]
            if not members:
                print(f"aviso: {group}/{name} sem .mtx", file=sys.stderr)
                return None
            with tar.extractfile(members[0]) as src, open(dest, "wb") as out:
                out.write(src.read())
    finally:
        os.unlink(tmp)
    return dest


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--count", type=int, default=100)
    ap.add_argument("--max-nnz", type=int, default=50000)
    ap.add_argument("--out", default="bench/matrices")
    ap.add_argument("--seed", type=int, default=42)
    args = ap.parse_args()

    os.makedirs(args.out, exist_ok=True)
    rows = fetch_stats()
    chosen = select(rows, args.count, args.max_nnz, args.seed)
    print(f"selecionadas {len(chosen)} matrizes (nnz <= {args.max_nnz})")
    ok = 0
    for r in chosen:
        path = download_matrix(r["group"], r["name"], args.out)
        if path:
            ok += 1
            print(f"  {r['group']}/{r['name']}: nnz={r['nnz']} -> {path}")
    print(f"baixadas {ok}/{len(chosen)} em {args.out}")


if __name__ == "__main__":
    main()
