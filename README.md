# Projeto Integrador AOC — Takum/RISC-V

Este é o repositório completo da Fase 2: simulador funcional Zvtakum, kernels
SpMV, resultados, artigo e slides. A entrega separada da Fase 1 está no repo
novo `aoc-takum-riscv`, cuja `main` contém somente o núcleo Takum; a branch
`fase2` desse repo reúne o projeto completo.

## Equipe e contribuições

| Nome | Matrícula | Contribuições principais |
|---|---|---|
| André Luís Alves Rezende | 2018104050 | `<CONTRIBUIÇÕES>` |
| Gabriel Ramos Fontes | 2022055939 | `<CONTRIBUIÇÕES>` |
| Isadora Maria Carvalho Lopes | 2022421544 | `<CONTRIBUIÇÕES>` |
| João Pedro Santos de Brito | 2023038302 | `<CONTRIBUIÇÕES>` |

## Como reproduzir

```sh
make sim-test
make sim-check       # requer llvm-mc, linker RISC-V e qemu-riscv64
make spmv
make paper-data && make paper
make slides
```

## Entregáveis

| Entregável | Local |
|---|---|
| Simulador RV64IM/RVV/Zvtakum | `sim/` |
| Kernels e resultados | `sim/kernels/`, `sim/results/` |
| Especificação e design | `docs/` |
| Artigo IEEE | `paper/` |
| Slides e roteiro da demo | `slides/` |
| Modelo Python e ferramentas | `python/` |

FP8 e FP16 são baselines numéricos; não há kernel FP16/Zvfh no simulador nesta
fase. A variante logarítmica e o estudo MuFoLAB de 1401 matrizes também estão
fora do escopo.
