# riscv-takum (Zvtakum)

Projeto Integrador (AOC/UFMG): implementação e avaliação do formato aritmético **Takum**
em uma extensão vetorial experimental para RISC-V (Zvtakum), sobre a RVV 1.0.

A branch `refactor/zvtakum-cpp` reorganiza o trabalho em torno de um simulador de ISA em
C++17 (`sim/`), com gabarito em Python e testes diferenciais contra o QEMU. A versão C11
anterior foi removida; o histórico permanece no git (`main` anterior a este merge).

## Conteúdo

* `sim/`: simulador RV64IM + Zicsr, subconjunto RVV 1.0 e Zvtakum (`zt-sim`), núcleo Takum em inteiros, testes e experimentos SpMV.
* `docs/arquitetura.md`: arquitetura, componentes e níveis de verificação.
* `docs/decisoes.md`: registro das decisões (D1–D10), com status e pendências.
* `docs/spec/zvtakum.adoc`: especificação experimental (formato, encodings, semântica, restrições).
* `docs/opcodes/zvtakum.opcodes`: encodings no formato riscv-opcodes (custom-0).
* `python/`: modelo de referência em Python (racionais exatos, binary128 por software) e a implementação de comparação.
* `paper/`: artigo em português (IEEE).
* `slides/`: apresentação e roteiro da demonstração.


## Como reproduzir

Requisitos: `c++` (C++17), `llvm-mc`, `ld` com suporte a `elf64lriscv`, `qemu-riscv64` e Python 3.10+.

```sh
make sim-test                 # núcleo Takum contra vetores dourados
make sim-check                # RVV padrão contra QEMU; Zvtakum contra o modelo
make spmv                     # SpMV em 8 matrizes, 4 formatos, 3 VLENs, + modelo de contagem
make paper-data               # regenera tabelas e números do artigo a partir de sim/results/
make paper                    # compila paper/main.pdf (latexmk)
```

Resultados: `sim/results/spmv_hb.csv` (96 execuções, todas bit a bit iguais ao modelo) e
`sim/results/spmv_numerico_hb.csv` (FP8, FP16 e takum, somente numérico).

## Estado

* Núcleo Takum linear T8/T16/T32 (com T64 no acumulador): verificado contra o modelo Python.
* Escalar RV64IM + Zicsr e RVV padrão (subconjunto): verificados contra o QEMU, byte a byte.
* Zvtakum (5 instruções): verificado contra o modelo Python, byte a byte.
* Kernels SpMV em RISC-V (FP32 e takum): bit a bit iguais ao modelo; erros medidos contra binary128.
* Modelo de contagem `N = rR + cS + K`: parâmetros medidos em programas sintéticos e resíduo zero nas 96 execuções reais.
* Pendências: variante logarítmica, FP16 vetorial (Zvfh) no simulador, estudo de 1401 matrizes (MuFoLAB) e revisão do artigo com os novos resultados. Ver `docs/decisoes.md`.

## Licença

Código deste repositório: ISC (ver `LICENSE`). `third_party/libtakum` é ISC, (c) Laslo Hunhold.
