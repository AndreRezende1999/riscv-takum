# Devlog

Registro cronologico do desenvolvimento (mais detalhado que o `design.md`,
que guarda apenas decisoes). Formato: data, fase, o que foi feito, achados e
comandos relevantes.

## 2026-09-15 - F0: setup

- Criado repo `~/Projects/riscv-takum` + repo privado no GitHub
  (`AndreRezende1999/riscv-takum`), branch `main`.
- Submodule `third_party/libtakum` pinado em **v2.0.0** (ISC). Build:
  `./configure && make libtakum.a`.
- Estrutura inicial: `include/zvtakum`, `src`, `tools`, `tests`, `bench`,
  `scripts`, `docs`, `paper`; `Makefile` com alvos `third_party`, `all`,
  `test`.
- Teste smoke: 4.5 + 6.5 = 11 exato (linear) e 100 x 10 ~ 1000 (log).
- Pesquisa previa (subagentes): API do libtakum (nomes exatos, RNE
  ties-to-even, sem FMA/classify), inventario RVV no `riscv-opcodes`
  (`extensions/`, rv_v = 375 linhas, FP = 92, bf16 = Zvfbfmin/Zvfbfwma,
  sem FP8), metodologia do MuFoLAB (metrica relativa 2-norma vs Float128,
  nnz <= 50.000, CSV ordenado com coluna `percent`).
- Fonte LaTeX do arXiv 2404.18603v2 baixada para `/tmp/opencode/arxiv-src`
  para conferir o Algoritmo 1 (a transcricao markdown tem artefatos).

## 2026-09-15 - F1: codec + ALU

Implementado:

- `include/zvtakum/takum_codec.h` + `src/takum_codec.c`:
  - `zt_decode`: campos (S, D, R, r, C, c, p, mant, m) via expansao de 12
    bits (ghost bits), valor para as variantes linear e log.
  - `zt_from_double`/`zt_to_double`/`zt_round_to`: delegam ao libtakum
    (RNE + saturacao).
  - `zt_round_algo1`: Algoritmo 1 do artigo implementado bit-a-bit
    (truncamento n+1, bit de guarda, correcoes de under/overflow).
- `include/zvtakum/takum_alu.h` + `src/takum_alu.c`: add, sub, mul, div,
  sqrt, abs, neg, cmp, conversao para inteiro (ordem two's complement).
- `tools/zt-format.c`: tabela de extremos representaveis e faixa dinamica.
- Testes:
  - `tests/test_codec.c`: campos, monotonicidade (ordem two's complement),
    negacao via complemento de dois, inversao (Prop. 7, variante log),
    round-trip RNE e Algo1 para todos os padroes T8/T16 e amostras T32,
    comparacao do valor decodificado com o libtakum, estatistica de
    divergencia RNE vs Algo1.
  - `tests/test_alu.c`: T8 exaustivo (todas as 256x256 combinacoes em
    add/sub/mul/div, ambas variantes), T16/T32 amostrados, saturacoes
    positivas/negativas, underflows, identidades (a+0, a*1, a*0, a-a),
    cancelamento exato, sqrt de negativos, propagacao de NaR.
  - Ambos passam: `make test` (0.5 s + 0.8 s + smoke).

Achados relevantes:

1. **Ghost bits**: a expansao de 12 bits e `E = bits << (12 - n)`. Para T8,
   os 3 ultimos bits do byte ocupam os bits mais altos de C (C_6..C_4);
   C_3..C_0 e todos os bits de mantissa sao fantasma. Isso faz p negativo
   para r > 3 e limita a faixa de T8: linear 2^+-239, log e^+-119.5
   (diferente do dominio do formato, 2^+-255 / e^+-127.5).
2. **Extremos de saturacao**: para T8/T16/T32, os extremos representaveis
   estao em `build/tools/zt-format`; em T8 a menor magnitude linear e
   2^-239 e a maior e 2^239 (assimetria de saturacao do Algoritmo 1
   preservada pelo libtakum).
3. **Arredondamento linear**: o libtakum arredonda takum *linear* no dominio
   logaritmico (Algoritmo 1 adaptado a base 2, empates para cima na ordem de
   bit string), NAO no dominio linear. Exemplo: 2^-239 * 2^8 = 2^-231 e
   exatamente o ponto medio geometrico entre 2^-239 e 2^-223; o resultado
   e 2^-223 (empate para cima), enquanto o mais proximo em valor seria
   2^-239. Consequencia: os testes usam um limite rigoroso baseado na
   distancia aos vizinhos representaveis (`neighbor_bound`), valido para
   qualquer regra de arredondamento monotona.
4. **RNE vs Algoritmo 1**: 0 divergencias em 200.000 amostras aleatorias
   por variante/tamanho (empates exatos nao amostrados). RNE e o modo
   normativo adotado; Algoritmo 1 fica disponivel para fidelidade ao paper.
5. A faixa dinamica de T16/T32 ja realiza o maximo do formato; T8 tem faixa
   reduzida (ver tabela no `docs/spec/zvtakum.adoc`).

Comandos:

```sh
make third_party
make -j4 all
make test
./build/tools/zt-format
```

## 2026-09-15 - F2: reestruturacao RVV e encodings

- Inventario verificado no `riscv-opcodes` (`extensions/`): `rv_v` = 375
  instrucoes (FP = 92, conversoes vfcvt/vfwcvt/vfncvt = 21, reducoes FP =
  6), bf16 = 4 (`rv_zvfbfmin`, `rv_zvfbfwma`), crypto = 41 em 8 arquivos
  Zvk*. RVV nao tem FP8.
- `docs/rvv-restructuring.md`: metodologia (4 diretrizes do artigo),
  inventario por categoria, tabelas "original -> proposta" (bitwise,
  inteiro, FP/conversoes, crypto), consolidacao de formatos, analise de
  CSRs e limitacoes. Estimativa: 96 instrucoes de FP/conversao atuais ->
  ~8 Zvtakum.
- Analise de encodings: parser proprio do `rv_v` mostra que o unico
  `funct6` livre no half de FP do OP-V e `0b111001`. Zvtakum usa esse
  espaco com `funct3` como sub-opcode (provisorio, documentado).
- `docs/opcodes/zvtakum.opcodes` (formato riscv-opcodes) com `vncvt.t.t`,
  `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv` e reservas.
- `docs/spec/zvtakum.adoc` atualizado com semantica das instrucoes,
  acumulacao alargada do `vtdot` (T8->T16, T16->T32, T32->T64), estreitamento
  do `vncvt` e secao de excecoes/CSRs.

