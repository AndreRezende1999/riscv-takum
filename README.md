# riscv-takum (Zvtakum)

Projeto Integrador (AOC/UFMG): implementacao e avaliacao do formato aritmetico
**Takum** na extensao vetorial **RISC-V (RVV)**.

Replica a metodologia de:

- L. Hunhold, *Streamlining SIMD ISA Extensions with Takum Arithmetic: A Case
  Study on Intel AVX10.2* (MOCAST 2025), arXiv:2503.14067
- L. Hunhold, *Beating Posits at Their Own Game: Takum Arithmetic*
  (CoNGA 2024), arXiv:2404.18603

## Conteudo

- `include/`, `src/` - codec/ALU Takum (T8/T16/T32), variantes linear (Def. 8)
  e logaritmica (Def. 2); simulador funcional RVV + Zvtakum
  (`vtadd`, `vtsub`, `vtmul`, `vtdot`, `vncvt`)
- `tools/` - `zt-disa` (encode/decode de instrucoes), `zt-run` (executa `.zt`)
- `examples/` - programas de exemplo (`axpy.zt`, `takum_dot.zt`)
- `tests/` - testes unitarios, testes de propriedades e vetores golden
- `bench/` - benchmark de viabilidade (matrizes esparsas) e SpMV
- `docs/` - decisoes de projeto, especificacao, tabelas de reestruturacao
  do ISA e devlog
- `paper/` - artigo em formato IEEE (LaTeX)

## Build

Dependencias: C11 (`cc`), GNU make e o submodule `third_party/libtakum` (ISC).

```sh
git submodule update --init --recursive
make third_party   # compila libtakum (pinada em v2.0.0)
make test          # testes
make demo          # exemplos com zt-disa/zt-run
```

## Estado

F3 concluido - codec/ALU, especificacao Zvtakum, encodings, reestruturacao
RVV e simulador funcional (RVV subconjunto + Zvtakum) com contadores de
instrucao/CSR. Ver `docs/spec/zvtakum.adoc`, `docs/rvv-restructuring.md` e
`docs/devlog.md`.

## Licenca

Codigo deste repositorio: ISC (ver `LICENSE`).
`third_party/libtakum` e ISC, (c) Laslo Hunhold.
