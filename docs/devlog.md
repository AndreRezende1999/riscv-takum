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

## 2026-09-15 - F3: simulador funcional RVV + Zvtakum

Implementado:

- `include/zvtakum/rvv.h` + `src/rvv_state.c`: estado (32 vregs, vtype com
  SEW/LMUL/vta/vma, vl, vstart, x0-x31, memoria de 1 MiB), acesso a
  elementos (tambem em largura alargada para o vtdot), `vsetvli` com regras
  de x0/AVL e codificadores de instrucoes.
- `src/rvv_insns.c`: dispatch por opcode/funct6/funct3/bit25 e semantica de
  vsetvl*, vle/vse (8/16/32), vfadd/vfmul (vv/vf), vfredusum, vrgather.vv,
  vmv.v.v, vmv.v.i, vfmv.v.f e das Zvtakum (vtadd, vtsub, vtmul, vtdot,
  vncvt). Mascara/tail: vta/vma=1 preenche com 1s, 0 deixa undisturbed.
  Contadores: instrucoes (total/RVV/Zvtakum), CSR writes, elementos.
- `src/zt_asm.c` + `include/zvtakum/asm.h`: assembler e disassembler do
  subconjunto, incluindo vtype simbolico (e8/e16/e32, m1..m8, ta/tu, ma/mu),
  registradores ABI e sufixo v0.t.
- `tools/zt-disa.c`, `tools/zt-run.c` (opcoes --variant/--vlen/--x/--init8),
  `examples/axpy.zt`, `examples/takum_dot.zt`, alvo `make demo`.
- Testes:
  - `tests/test_rvv.c`: vsetvli/vsetivli, load/store, mascara/tail,
    vfadd/vfmul/vfredusum, vrgather, vmv/vfmv.
  - `tests/test_zvtakum_isa.c`: 200 trials x 32 elementos de vtadd/vtsub/
    vtmul comparados com a ALU escalar (bit-exato), vncvt T32->T16, vtdot
    T8->T16 com acumulador inicial, mascaramento.
  - `tests/test_sim.c`: round-trip assembler/disassembler (16 programas),
    programa axpy f32 completo e programa takum (load + vtadd + vtmul +
    vtdot + store) nas duas variantes, com contadores verificados.
- Achados: `vmv.v.v`/`vfmv.v.f`/`vmv.v.i` usam bit 25 fixo em 1 (funct6
  0x17), separando de `vmerge` (bit 25 = vm); o disassembler passou a
  imprimir vtype simbolico para permitir round-trip.

Comandos:

```sh
make -j4 all
make test
make demo
```

## 2026-09-15 - F4a: benchmark de viabilidade (matrizes)

- `scripts/fetch_matrices.py`: seleciona e baixa um subconjunto
  representativo do SuiteSparse (`ssstats.csv`, nnz <= 50000,
  estratificado por grupo/quartis, semente 42). Resultado: 100 matrizes em
  `bench/matrices` (nao versionadas).
- `bench/convert_formats.c`: le `.mtx` (coordinate real/pattern, general e
  symmetric; matrizes complexas ignoradas), converte cada entrada para 15
  formatos e acumula o erro relativo 2-norma contra long double (80 bits no
  x86-64; desvio do binary128 do artigo registrado em design.md):
  - codecs proprios: E4M3 (overflow -> NaN, sem Inf), E5M2 (Inf/NaN),
    bf16 (RNE);
  - `_Float16` do compilador para f16;
  - takum linear/log 8/16/32 via libtakum/zt_decode;
  - posit 8/16/32 via libposit (submodule adicionado; necessita
    `-Wl,--allow-multiple-definition` por colisao de simbolos internos
    `util_round_*` entre libtakum e libposit).
- `scripts/analyze.py`: CDF ordenada (`cdf.sorted.csv`, coluna `percent`),
  resumo (mediana/p90/max/% >100%) e figuras (`cdf_8/16/32.png`) via
  matplotlib em `.venv`.
- Resultados (100 matrizes; ver `bench/results/summary.txt`):
  mediana do erro relativo:
  - 8 bits: f8_e4m3 7.2e-3 (27 overflow), f8_e5m2 2.4e-2 (18 overflow),
    takum8 5.7e-2, taklog8 5.4e-2, posit8 2.5e-2;
  - 16 bits: f16 5.8e-6 (18 overflow), bf16 9.5e-4, takum16 1.5e-4,
    taklog16 2.2e-4, posit16 8.4e-5;
  - 32 bits: f32 1.0e-8, takum32 1.1e-9, taklog32 3.6e-9, posit32 1.0e-9.
  Takum32 supera f32 na mediana/p90; nos 8 bits, os formatos IEEE
  estouram (Inf/NaN) em ~20-27% das matrizes enquanto takum satura com
  erro moderado (2-3% acima de 100%).
- `make bench` executa coleta -> conversao -> analise; CSVs/figuras
  versionados em `bench/results`.

## 2026-09-15 - F4b: fechamento aritmetico + SpMV

- `bench/closure.c`: T8 exaustivo e T16 com 2M de pares amostrados na
  faixa da posit correspondente; exatidao com tolerancia 1e-15 e descarte
  de soma/subtracao nao verificavel (operando menor < 2e-15 do maior).
  Resultados em `bench/results/closure.csv`/`closure_summary.txt`:
  log T8 add 0.00%, sub 2.44%, mul 41.17%, div 41.17%, inv 100%,
  sqrt 60.49%; log T16 add 0.00%, mul 36.74%, div 36.75%, inv 100%,
  sqrt 84.20%, square 100%. Comparacao com o artigo (T8 mul 40.3%,
  inv 100%, sqrt 58.8%; T16 mul 36.6%, div 36.7%, sqrt 84.1%): aderente.
- `bench/spmv.c`: kernels vrgather + vtdot (Takum) e vrgather + vfmul +
  vfredusum (f32), referencias em long double com entradas arredondadas,
  contadores de instrucao/CSR/elementos; VLEN=1024, matrizes lap2d (n=25)
  e aleatoria (n=32, 6 nnz/linha). Resultados em
  `bench/results/spmv.csv`/`spmv_summary.txt`: erro relativo 2-norma de y:
  T32 ~1e-9 (linear e log), T16 ~1e-4, T8 ~3-6e-2, f32 ~5e-8 (caso
  aleatorio). Contagem de instrucoes: kernel Takum ~193 (129 RVV + 64
  Zvtakum) contra ~161 do f32 no mesmo caso.
- Bugs encontrados e corrigidos: (1) chamadas de vsetvli com avl_is_x0=1
  faziam vl=vlmax (lixo nos strips); (2) `zt_convert` sem conversoes com
  64 bits e dispatch da ALU sem largura 64 (acumulador do vtdot SEW=32
  retornava lixo); (3) `vrgather.vv` restrito a SEW=32, generalizado;
  (4) gather valida indice contra VLMAX, exigindo VLEN grande e matrizes
  pequenas no SpMV.

## 2026-09-15 - F5: artigo IEEE + slides

- `paper/main.tex` (IEEEtran, 3 paginas): introducao, relacionados,
  metodologia (codec, Zvtakum, reestruturacao RVV, simulador, benchmarks),
  resultados (viabilidade com Tabela 1, fechamento com comparacao ao artigo,
  SpMV, complexidade de ISA/CSR) e conclusao. `paper/refs.bib` com 10
  referencias. Compila com `make paper` (latexmk).
- Ferramentas LaTeX: TinyTeX desatualizado bloqueava o tlmgr; resolvido
  trocando o repositorio para `mirror.ctan.org` e instalando
  `ieeetran`, `beamer`, `cite`, `booktabs`, `courier` e dependencias.
- `slides/slides.tex` (13 slides) e `slides/roteiro.md` (estrutura de 15
  min + demo + perguntas provaveis).
- README reorganizado com entregaveis e alvos `make paper`/`make slides`.
- Pendencia manual da equipe: preencher autores/afiliacao nos dois fontes e
  (opcional) rodar as 1401 matrizes do artigo.

