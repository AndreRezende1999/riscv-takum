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
  e logaritmica (Def. 2)
- `src/` - simulador funcional RVV + extensao proposta `Zvtakum`
  (`vtadd`, `vtsub`, `vtmul`, `vtdot`, `vncvt`)
- `tests/` - testes unitarios, testes de propriedades e vetores golden
- `bench/` - benchmark de viabilidade (matrizes esparsas) e SpMV
- `docs/` - decisoes de projeto, especificacao e tabelas de reestruturacao do ISA
- `paper/` - artigo em formato IEEE (LaTeX)

## Build

Dependencias: C11 (`cc`), GNU make e o submodule `third_party/libtakum` (ISC).

```sh
git submodule update --init --recursive
make third_party   # compila libtakum (pinada em v2.0.0)
make test          # testes
```

## Estado

F1 concluido - codec T8/T16/T32 (variantes linear e logaritmica), ALU
(add/sub/mul/div/sqrt/abs/neg), dois modos de arredondamento (RNE normativo
e Algoritmo 1 do artigo), testes exaustivos T8 e propriedades formais.
Ver `docs/spec/zvtakum.adoc` e `docs/devlog.md`.

## Licenca

Codigo deste repositorio: ISC (ver `LICENSE`).
`third_party/libtakum` e ISC, (c) Laslo Hunhold.
