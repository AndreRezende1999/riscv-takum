"""Teste de conformidade do simulador (sim/build/zt-sim).

Para cada programa em sim/tests/asm/*.S:
  * monta com llvm-mc e liga com ld (elf64lriscv);
  * executa no zt-sim para cada VLEN;
  * compara a saída (bytes) e o código de saída com a referência:
      - QEMU user-mode, para programas de instruções padrão;
      - o arquivo NOME.vVLEN.expected, quando existe (Zvtakum, que o QEMU não executa).

    python3 sim/tests/difftest.py [--vlen 128 256 512] [--only NOME]
"""

from __future__ import annotations

import argparse
import json
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
ASM = ROOT / "sim" / "tests" / "asm"
BUILD = ROOT / "sim" / "build" / "asm"
SIM = ROOT / "sim" / "build" / "zt-sim"
QEMU = "qemu-riscv64"


def run(cmd: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, check=False)


def assemble(src: pathlib.Path) -> pathlib.Path:
    BUILD.mkdir(parents=True, exist_ok=True)
    obj = BUILD / f"{src.stem}.o"
    elf = BUILD / f"{src.stem}.elf"
    proc = run(["llvm-mc", "-triple=riscv64", "-mattr=+m,+zicsr,+v,+zvfh",
                "-filetype=obj", "-o", str(obj), str(src)])
    if proc.returncode != 0:
        raise SystemExit(f"llvm-mc falhou em {src.name}:\n{proc.stderr.decode()}")
    proc = run(["ld", "-m", "elf64lriscv", "--no-relax", "-Ttext=0x10000", "-o", str(elf), str(obj)])
    if proc.returncode != 0:
        raise SystemExit(f"ld falhou em {src.name}:\n{proc.stderr.decode()}")
    return elf


def run_sim(elf: pathlib.Path, vlen: int) -> tuple[bytes, int, dict]:
    out = BUILD / f"{elf.stem}.v{vlen}.sim.bin"
    cnt = BUILD / f"{elf.stem}.v{vlen}.sim.json"
    proc = run([str(SIM), str(elf), "--vlen", str(vlen), "--stdout", str(out), "--counters", str(cnt)])
    if proc.returncode not in (0, 1):
        raise SystemExit(f"zt-sim falhou em {elf.name} (VLEN {vlen}):\n{proc.stderr.decode()}")
    counters = json.loads(cnt.read_text())
    return out.read_bytes(), counters["exit_code"], counters


def run_qemu(elf: pathlib.Path, vlen: int) -> tuple[bytes, int]:
    # Elementos agnósticos (ta, ma) recebem 1s, como no zt-sim; sem essas opções o QEMU
    # os deixa inalterados. A RVV 1.0 permite as duas escolhas.
    cpu = (f"rv64,v=true,vlen={vlen},elen=64,vext_spec=v1.0,"
           "rvv_ta_all_1s=true,rvv_ma_all_1s=true")
    proc = run([QEMU, "-cpu", cpu, str(elf)])
    return proc.stdout, proc.returncode


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vlen", type=int, nargs="+", default=[128, 256, 512])
    parser.add_argument("--only", default=None, help="nome do programa, sem extensão")
    args = parser.parse_args()

    sources = sorted(ASM.glob("*.S"))
    if args.only:
        sources = [s for s in sources if s.stem == args.only]
    failures = 0
    checks = 0
    for src in sources:
        elf = assemble(src)
        for vlen in args.vlen:
            sim_out, sim_code, counters = run_sim(elf, vlen)
            expected = ASM / f"{src.stem}.v{vlen}.expected"
            if expected.exists():
                ref_out, ref_code, ref = expected.read_bytes(), 0, "modelo"
            else:
                ref_out, ref_code = run_qemu(elf, vlen)
                ref = "qemu"
            checks += 1
            same = sim_out == ref_out and sim_code == ref_code
            status = "ok" if same else "DIVERGE"
            print(f"{src.stem:<14} VLEN={vlen:<4} ref={ref:<6} bytes={len(ref_out):<6} "
                  f"insn={counters['insn_total']:<8} zvt={counters['insn_zvtakum']:<5} {status}")
            if not same:
                failures += 1
                first = next((i for i, (a, b) in enumerate(zip(sim_out, ref_out)) if a != b),
                             min(len(sim_out), len(ref_out)))
                print(f"    tamanhos: sim={len(sim_out)} ref={len(ref_out)}; "
                      f"primeiro byte diferente: {first}; códigos: sim={sim_code} ref={ref_code}")
    print(f"\n{checks} execuções, {failures} divergências")
    return 0 if failures == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
