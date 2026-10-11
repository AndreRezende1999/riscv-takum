"""SpMV (y = A x, CSR) em RISC-V, executado no zt-sim, para FP32 e Takum linear.

Para cada matriz (Matrix Market), VLEN e formato, gera um programa RISC-V que:
  * percorre as linhas e as faixas (strip-mining) com scalar + RVV;
  * carrega valores, índices (offsets em bytes de x) e faz gather de x com vluxei32;
  * FP32: vfmul.vv + vfredusum.vs;  Takum: vtdot.vv (acumulador 2n) + vncvt.t.t.

Verificação em dois níveis:
  1. bit a bit: a saída do simulador é igual à de python/takum_rvv/sparse.py
     scalar_spmv(), que arredonda cada produto e cada soma no formato de acumulação;
  2. precisão: erro relativo L2 frente à referência binary128 (reference_spmv).

    python3 sim/kernels/spmv.py [--vlen 128 256 512] [--only NOME] [--out CSV]
"""

from __future__ import annotations

import argparse
import csv
import json
import pathlib
import random
import subprocess
import sys
from fractions import Fraction

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "python"))

from takum_rvv.binary import BINARY32, BINARY128  # noqa: E402
from takum_rvv.codec import Takum  # noqa: E402
from takum_rvv.sparse import (  # noqa: E402
    error_metrics,
    read_matrix_market,
    reference_spmv,
    scalar_spmv,
)

MATRIX_DIR = ROOT / "python" / "data" / "harwell_boeing"
SIM = ROOT / "sim" / "build" / "zt-sim"
BUILD = ROOT / "sim" / "build" / "spmv"
DEFAULT_OUT = ROOT / "sim" / "results" / "spmv_hb.csv"
X_SEED = 2026
X_DENOM = 1 << 52  # x_i = k / 2^52, com |k| <= 2^52: força arredondamento em FP32 e takum32

# Codificação custom-0 das instruções Zvtakum (ver docs/opcodes/zvtakum.opcodes).
VTDOT = 3
VNCVT = 4


def custom(funct6: int, vd: int, vs2: int, vs1: int, vm: int = 1) -> str:
    word = (funct6 << 26) | (vm << 25) | (vs2 << 20) | (vs1 << 15) | (vd << 7) | 0x0B
    return f".4byte 0x{word:08x}"


class Format:
    """Formato de armazenamento e de acumulação de um kernel."""

    def __init__(self, name: str, bits: int, storage, accumulator) -> None:
        self.name = name
        self.bits = bits
        self.eb = bits // 8
        self.storage = storage
        self.accumulator = accumulator

    def encode(self, value: Fraction) -> int:
        return self.storage.encode(value)

    def pack(self, raw: int) -> bytes:
        return int(raw).to_bytes(self.eb, "little")

    def decode(self, raw: int):
        return self.storage.decode(raw)


def formats() -> list[Format]:
    return [
        Format("fp32", 32, BINARY32, BINARY32),
        Format("takum8", 8, Takum(8), Takum(16)),
        Format("takum16", 16, Takum(16), Takum(32)),
        Format("takum32", 32, Takum(32), Takum(64)),
    ]


def x_vector(cols: int) -> list[Fraction]:
    rng = random.Random(X_SEED)
    return [Fraction(rng.randint(-X_DENOM, X_DENOM), X_DENOM) for _ in range(cols)]


def directive(eb: int) -> str:
    return {1: ".byte", 2: ".hword", 4: ".word"}[eb]


def data_block(label: str, values: list[int], eb: int) -> list[str]:
    lines = [f"{label}:"]
    for start in range(0, len(values), 16):
        chunk = ", ".join(str(int(v)) for v in values[start:start + 16])
        lines.append(f"    {directive(eb)} {chunk}")
    lines.append("    .balign 16")
    return lines


def program(fmt: Format, rowptr, colbyte, vals, xvals, rows: int, nnz: int) -> str:
    eb = fmt.eb
    n = fmt.bits
    lines = [
        "    .option norvc",
        "    .section .text",
        "    .globl _start",
        "_start:",
        "    la s0, rowptr",
        "    la s1, colbyte",
        "    la s2, vals",
        "    la s3, xvec",
        "    la s4, yout",
        "    mv s7, s4",
        f"    li s5, {rows}",
        "row_loop:",
        "    beqz s5, done",
        "    lw t0, 0(s0)",
        "    lw t1, 4(s0)",
        "    sub t2, t1, t0",
        "    addi s0, s0, 4",
    ]
    if fmt.name == "fp32":
        lines += [
            "    vsetivli t3, 1, e32, m1, tu, mu",
            "    vmv.v.i v2, 0",
            "strip:",
            "    beqz t2, row_done",
            "    vsetvli t3, t2, e32, m1, tu, mu",
            "    vle32.v v4, (s1)",
            "    vle32.v v8, (s2)",
            "    vluxei32.v v12, (s3), v4",
            "    vfmul.vv v8, v8, v12",
            "    vfredusum.vs v2, v8, v2",
            "    slli t4, t3, 2",
            "    add s1, s1, t4",
            "    add s2, s2, t4",
            "    sub t2, t2, t3",
            "    j strip",
            "row_done:",
            "    vsetivli t3, 1, e32, m1, tu, mu",
            "    vse32.v v2, (s4)",
            "    addi s4, s4, 4",
            "    addi s5, s5, -1",
            "    j row_loop",
        ]
    else:
        idx_lmul = 32 // n
        shift = {1: 0, 2: 1, 4: 2}[eb]
        acc_sew = 2 * n
        # Deslocamento dos valores: reutiliza t4 (32 bits) ou o próprio t3 (8 bits).
        if shift == 2:
            values_offset = ["    add s2, s2, t4"]
        elif shift == 0:
            values_offset = ["    add s2, s2, t3"]
        else:
            values_offset = [f"    slli t4, t3, {shift}", "    add s2, s2, t4"]
        lines += [
            f"    vsetivli t3, 1, e{acc_sew}, m1, tu, mu",
            "    vmv.v.i v2, 0",
            "strip:",
            "    beqz t2, row_done",
            f"    vsetvli t3, t2, e32, m{idx_lmul}, tu, mu",
            "    vle32.v v4, (s1)",
        ] + ([] if idx_lmul == 1 else [
            # Com SEW=32, índice e dados usam a mesma configuração; não há troca.
            f"    vsetvli t3, t2, e{n}, m1, tu, mu",
        ]) + [
            f"    vle{n}.v v8, (s2)",
            "    vluxei32.v v12, (s3), v4",
            "    " + custom(VTDOT, 2, 8, 12),
            "    slli t4, t3, 2",
            "    add s1, s1, t4",
        ] + values_offset + [
            "    sub t2, t2, t3",
            "    j strip",
            "row_done:",
            f"    vsetivli t3, 1, e{n}, m1, tu, mu",
            "    " + custom(VNCVT, 6, 2, 0),
            f"    vse{n}.v v6, (s4)",
            f"    addi s4, s4, {eb}",
            "    addi s5, s5, -1",
            "    j row_loop",
        ]
    lines += [
        "done:",
        "    sub a2, s4, s7",
        "    mv a1, s7",
        "    li a0, 1",
        "    li a7, 64",
        "    ecall",
        "    li a0, 0",
        "    li a7, 93",
        "    ecall",
        "    .section .data",
        "    .balign 16",
    ]
    lines += data_block("rowptr", rowptr, 4)
    lines += data_block("colbyte", colbyte, 4)
    lines += data_block("vals", vals, eb)
    lines += data_block("xvec", xvals, eb)
    lines += [
        "    .section .bss",
        "    .balign 16",
        "yout:",
        f"    .space {max(rows * eb, 16) + 16}",
    ]
    return "\n".join(lines) + "\n"


def run(cmd: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, check=False)


def simulate(name: str, fmt: Format, vlen: int, source: str) -> tuple[bytes, dict]:
    BUILD.mkdir(parents=True, exist_ok=True)
    stem = f"{name}.{fmt.name}.v{vlen}"
    asm = BUILD / f"{stem}.S"
    obj = BUILD / f"{stem}.o"
    elf = BUILD / f"{stem}.elf"
    out = BUILD / f"{stem}.out"
    cnt = BUILD / f"{stem}.json"
    asm.write_text(source)
    proc = run(["llvm-mc", "-triple=riscv64", "-mattr=+m,+zicsr,+v,+zvfh",
                "-filetype=obj", "-o", str(obj), str(asm)])
    if proc.returncode != 0:
        raise SystemExit(f"llvm-mc falhou em {stem}:\n{proc.stderr.decode()}")
    proc = run(["ld", "-m", "elf64lriscv", "--no-relax", "-Ttext=0x10000", "-o", str(elf), str(obj)])
    if proc.returncode != 0:
        raise SystemExit(f"ld falhou em {stem}:\n{proc.stderr.decode()}")
    proc = run([str(SIM), str(elf), "--vlen", str(vlen), "--stdout", str(out),
                "--counters", str(cnt), "--mem", "64", "--max-insns", str(10**9)])
    if proc.returncode not in (0, 1):
        raise SystemExit(f"zt-sim falhou em {stem}:\n{proc.stderr.decode()}")
    counters = json.loads(cnt.read_text())
    if counters["exit_code"] != 0:
        raise SystemExit(f"programa {stem} terminou com código {counters['exit_code']}")
    return out.read_bytes(), counters


def evaluate(name: str, matrix, xs: list[Fraction], reference, fmt: Format,
             raw_expected: list[int], vlen: int) -> dict:
    rows, nnz = matrix.rows, len(matrix.data)
    rowptr = list(matrix.rowptr)
    colbyte = [c * fmt.eb for c in matrix.colidx]
    vals = [fmt.encode(v) for v in matrix.data]
    xraw = [fmt.encode(v) for v in xs]
    source = program(fmt, rowptr, colbyte, vals, xraw, rows, nnz)
    got, counters = simulate(name, fmt, vlen, source)

    expected = b"".join(fmt.pack(raw) for raw in raw_expected)
    bit_exact = got == expected
    if not bit_exact:
        mismatch = next(i for i in range(min(len(got), len(expected))) if got[i] != expected[i])
        raise SystemExit(f"{name} {fmt.name} VLEN={vlen}: saída difere do modelo no byte {mismatch}")

    actual = [fmt.decode(int.from_bytes(got[k * fmt.eb:(k + 1) * fmt.eb], "little"))
              for k in range(rows)]
    metrics = error_metrics(actual, reference)
    return {
        "matrix": name,
        "format": fmt.name,
        "vlen": vlen,
        "rows": rows,
        "cols": matrix.cols,
        "nnz": nnz,
        "bit_exact": bit_exact,
        "relative_l2": metrics["relative_l2"],
        "absolute_l2": metrics["absolute_l2"],
        "nonfinite": metrics["nonfinite_count"],
        "insn_total": counters["insn_total"],
        "insn_scalar": counters["insn_scalar"],
        "insn_vsetvl": counters["insn_vsetvl"],
        "insn_vector": counters["insn_vector"],
        "insn_zvtakum": counters["insn_zvtakum"],
        "csr_writes": counters["csr_writes"],
        "csr_reads": counters["csr_reads"],
        "elem_active": counters["elem_active"],
        "bytes_loaded": counters["bytes_loaded"],
        "bytes_stored": counters["bytes_stored"],
        "index_bytes_loaded": counters["index_bytes_loaded"],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vlen", type=int, nargs="+", default=[128, 256, 512])
    parser.add_argument("--only", default=None, help="nome da matriz, sem extensão")
    parser.add_argument("--out", type=pathlib.Path, default=DEFAULT_OUT)
    args = parser.parse_args()

    paths = sorted(MATRIX_DIR.glob("*.mtx"))
    if args.only:
        paths = [p for p in paths if p.stem == args.only]
    rows_out: list[dict] = []
    for path in paths:
        matrix = read_matrix_market(path)
        xs = x_vector(matrix.cols)
        reference = reference_spmv(matrix, xs)
        for fmt in formats():
            raw_expected = scalar_spmv(matrix, xs, fmt.storage, fmt.accumulator)
            for vlen in args.vlen:
                row = evaluate(path.stem, matrix, xs, reference, fmt, raw_expected, vlen)
                rows_out.append(row)
                print(f"{path.stem:<12} {fmt.name:<8} VLEN={vlen:<4} "
                      f"err={row['relative_l2'] or 'n/d':<22} insn={row['insn_total']:<8} "
                      f"zvt={row['insn_zvtakum']:<6} bit-exato={row['bit_exact']}")
    args.out.parent.mkdir(parents=True, exist_ok=True)
    with args.out.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows_out[0].keys()))
        writer.writeheader()
        writer.writerows(rows_out)
    print(f"\n{len(rows_out)} execuções; resultados em {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
