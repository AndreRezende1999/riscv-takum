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
make bench         # benchmarks (matrizes -> CSV -> CDFs)
```

## Entregaveis

- **Codigo/ferramentas**: `src/`, `include/`, `tools/`, `tests/` (simulador
  RVV+Zvtakum, codec/ALU, zt-disa/zt-run, testes exaustivos).
- **Especificacao**: `docs/spec/zvtakum.adoc` (formato, instrucoes,
  encodings, excecoes), `docs/rvv-restructuring.md` (tabelas
  original->proposta), `docs/opcodes/zvtakum.opcodes`.
- **Benchmarks**: `bench/` + `bench/results/` (CSVs, summaries, figuras CDF,
  fechamento, SpMV).
- **Artigo IEEE** (ate 6 paginas, em ingles): `paper/main.tex` - compila com
  `make paper` (LaTeX) ou no Overleaf (template IEEE conference).
- **Slides + roteiro da demo**: `slides/slides.tex` e `slides/roteiro.md`
  (`make slides`).
- **Documentacao do processo**: `docs/devlog.md` (cronologico) e
  `docs/design.md` (decisoes).

## Estado

Projeto completo (F0-F5): codec/ALU, especificacao Zvtakum, encodings,
reestruturacao RVV, simulador funcional, benchmark de viabilidade (100
matrizes, 15 formatos), fechamento aritmetico (T8/T16) e SpMV; artigo e
slides prontos para preencher autores e apresentar.

## Licenca

Codigo deste repositorio: ISC (ver `LICENSE`).
`third_party/libtakum` e ISC, (c) Laslo Hunhold.
