# Decisoes de projeto (log)

Este documento registra as decisoes do projeto, em ordem. Atualizar a cada
decisao relevante (mantendo data e motivo).

## Objetivo

Replicar, na arquitetura RISC-V (extensao vetorial RVV), o estudo
"Streamlining SIMD ISA Extensions with Takum Arithmetic: A Case Study on
Intel AVX10.2" (arXiv:2503.14067), incluindo:

1. Reestruturacao do conjunto de instrucoes (agrupamento, nomenclatura
   B/U/S/T, consolidacao de formatos em T8/T16/T32, simplificacao de
   conversoes) - equivalente das Tabelas I-V do artigo, aplicado a RVV.
2. Benchmark de viabilidade (conversao de matrizes esparsas em cada formato,
   erro relativo 2-norma vs float128, CDF) - replica da Figura 3.
3. Simulador funcional de um subconjunto RVV + extensao proposta `Zvtakum`
   com `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv` e `vncvt.t.t`
   (Fases 1-2 do enunciado da disciplina).
4. Avaliacao: SpMV `y = A*x`, erro acumulado vs IEEE (FP8/FP16/FP32),
   contagem de instrucoes e acessos a CSR.

Fontes de verdade: os PDFs dos dois artigos (arXiv:2503.14067v2 e
arXiv:2404.18603v2) e o texto extraido em `artigos.md` (transcricao com
artefatos: tabelas 4/5/6 e regex das Tabelas I-V precisam ser reconferidas
no PDF antes de virarem vetores golden).

## Decisoes

### D1 - Formatos e variantes (2026-09-15)

- Larguras: **T8, T16, T32** (escopo do enunciado). T64 existe no libtakum e
  pode ser usado internamente (acumulacao do `vtdot`), mas nao e exposto na ISA.
- Variantes: **ambas** implementadas atras de `--variant=linear|log`.
  - **Linear** (Def. 8, base 2): usada no benchmark de viabilidade do artigo
    (MuFoLAB v1.2.0 usava `LinearTakum8/16/32`) e default do libtakum v2.
  - **Logaritmica** (Def. 2, base sqrt(e)): variante "padrao" do formato
    no artigo original; usada nos analises de fechamento (Secao 5.6).
- NaR: bit string com S=1 e restante 0 (TAKUM*_NAR = INT*_MIN); ordem total
  two's complement (NaR = NaR e NaR <= x); sem infinito.

### D2 - Arredondamento (2026-09-15)

- libtakum implementa **round-to-nearest, ties-to-even (RNE)** com saturacao.
- O artigo define o **Algoritmo 1** (truncamento em n+1 bits + bit de guarda).
- Decisao: RNE (libtakum) e o comportamento normativo do ISA proposto;
  o modo Algoritmo 1 tambem e implementado na camada `zt_round` por fidelidade
  ao paper, com teste de divergencia quantificada entre os dois modos.
- Consequencia: as porcentagens de fechamento da Secao 5.6 do paper sao
  tratadas como ancoras aproximadas (tolerancia), nao bit-exatas.

### D3 - Conjunto de instrucoes Zvtakum (2026-09-15)

- `vtadd.vv`, `vtsub.vv`, `vtmul.vv`: SEW=8/16/32 seleciona T8/T16/T32.
- `vtdot.vv`: acumulacao com alargamento gradual, seguindo a proposta F08 do
  artigo (`VDPPT8PT16 | VDPPT16PT32 | VDPPT32PT64`): T8 -> acumula em T16,
  T16 -> T32, T32 -> T64 (interno), com saturacao.
- `vncvt.t.t`: conversao com reducao de largura (T32 -> T16 -> T8).
- Conversoes IEEE <-> takum ficam em software (biblioteca), nao no ISA, para
  inicializacao/analise dos benchmarks.
- Encodings em espaco reservado do OP-V (funct6), documentados em
  `docs/opcodes/zvtakum.opcodes` (formato riscv-opcodes).

### D4 - Implementacao de referencia (2026-09-15)

- Simulador funcional em C11, sem dependencia de simuladores externos.
- Operacoes numericas delegadas ao **libtakum v2.0.0** (ISC), submodule em
  `third_party/libtakum`; pinar no tag v2.0.0.
- Mapeamento direto: `<tipo>_from_float64/32`, `_to_float64/32`, `_addition`,
  `_subtraction`, `_multiplication`, `_division`, `_square_root`,
  `_absolute`, `_sign`, `_precision`; negacao via unario `-`; NaR via macros
  `TAKUM*_NAR`; comparacoes via operadores C (tipos sao intN_t, ordem
  two's complement). Nao existem FMA nem classificacao no libtakum.
- T8/T16 (< 12 bits) seguem o modelo "ghost bits" (extensao a 12 bits com
  zeros); como o libtakum nao expoe esse detalhe, o codec proprio faz o
  expand/trim e e validado valor-a-valor contra o libtakum (256 valores T8).
- Sem ghost bits no libtakum, usar apenas conversoes via float32/float64
  (evitar `_extended_float`, dependente de plataforma).

### D5 - Tools de avaliacao (2026-09-15)

- Stack: C + libtakum + libquadmath (`__float128`); Python/numpy para
  estatistica e figuras (matplotlib instalado via pip --user quando necessario).
- Metrica do benchmark de viabilidade (replica MuFoLAB):
  `||F128(A) - F128(T(A))||_2 / ||F128(A)||_2` sobre as entradas, com
  referencia binaria128 aplicada aos valores float64 da matriz, mais a
  coluna de erro log-relativo (convencao 0/0 -> 0).
- Formatos: Float8 E4M3/E5M2 (codec proprio conforme OCP), bfloat16, float16,
  float32, float64, takum linear 8/16/32, takum log 8/16/32 e, se viavel,
  posit 8/16/32 via libposit (ISC, mesma org).
- Matrizes: SuiteSparse com `nnz <= 50.000`; o cache JLD2 do MuFoLAB nao e
  legivel fora de Julia, entao baixar `.mtx` e filtrar; comecar com um
  subconjunto representativo (~100) e permitir escalar para as 1.401.
- Saida: CSV por metrica + CSV ordenado com coluna `percent` (CDF),
  espelhando o pipeline do MuFoLAB (`out/convert/relative_error.sorted.csv`).

### D6 - Repositorio (2026-09-15)

- Repo privado no GitHub: `riscv-takum` (conta AndreRezende1999).
- Estrutura: `include/zvtakum`, `src`, `tools`, `tests`, `bench`, `scripts`,
  `docs`, `paper`.
- Licenca do projeto: ISC (compativel com libtakum/libposit).

### D7 - Dominio de arredondamento do takum linear (2026-09-15)

- Achado do F1: o libtakum arredonda takum **linear** no dominio
  logaritmico (Algoritmo 1 adaptado a base 2), com empates para cima na
  ordem de bit string. Ex.: `2^-239 * 2^8 = 2^-231`, ponto medio geometrico
  entre `2^-239` e `2^-223`, arredonda para `2^-223` (empate para cima),
  nao para o vizinho mais proximo em valor.
- Decisao: adotar o comportamento do libtakum como referencia normativa do
  ISA (documentado em `docs/spec/zvtakum.adoc`). O limite de erro dos testes
  usa a distancia aos vizinhos representaveis (`neighbor_bound`), valido
  para qualquer regra monotona, em vez de `epsilon(p)` no dominio linear.
- Consequencia para o artigo: o erro relativo do takum linear em regioes de
  p <= 0 (expoentes extremos de T8) pode chegar a ~100% (ex.: fator 256 de
  espacamento entre representaveis), o que deve ser discutido nos resultados.

### D8 - RNE vs Algoritmo 1 (2026-09-15)

- RNE (libtakum) permanece normativo; `zt_round_algo1` implementa o
  Algoritmo 1 do artigo para fidelidade. Medicao: 0 divergencias em 200.000
  amostras aleatorias por variante/tamanho (empates exatos nao amostrados).
- As porcentagens de fechamento da Secao 5.6 do paper continuam tratadas
  como ancoras aproximadas.

### D9 - Encodings e escopo das instrucoes (2026-09-15)

- Instrucoes da Fase 2: `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv`,
  `vncvt.t.t` (escopo do enunciado), com `vtdiv.vv`/`vtsqrt.v` reservados.
- `vtdot.vv`: acumulacao com alargamento gradual (F08 do artigo):
  T8->T16, T16->T32, T32->T64; destino com EEW=2*SEW (grupo de 2
  registradores), como `vwredsum.vs`. T64 existe apenas como acumulador.
- `vncvt.t.t`: estreitamento como `vfncvt` (EEW=2*SEW -> SEW), RNE e
  saturacao.
- Encodings provisorios no unico funct6 livre do OP-V (0b111001), com
  funct3 como sub-opcode e bit 25 = 0; arquivo
  `docs/opcodes/zvtakum.opcodes`. Desvio da convencao de funct3
  documentado em `docs/rvv-restructuring.md`.
- Inventario RVV (riscv-opcodes): rv_v = 375 instrucoes (FP = 92,
  conversoes = 21), bf16 = 4 (Zvfbfmin/Zvfbfwma), crypto = 41; nao ha
  FP8 em RVV. Tabelas de reestruturacao em `docs/rvv-restructuring.md`.

### D10 - Simulador funcional (2026-09-15)

- Simulador em C11 proprio (sem Spike/QEMU): VLEN configuravel (padrao 256
  bits), LMUL 1/2/4/8, SEW 8/16/32, `vta`/`vma` 0 = undisturbed e 1 =
  agnostico preenchido com 1s (escolha per; RVV permite qualquer valor).
- Subconjunto RVV suficiente para os kernels: vsetvl*, vle/vse (8/16/32,
  unit-stride), vfadd/vfmul (vv/vf, f32), vfredusum (f32), vrgather.vv,
  vmv.v.v, vmv.v.i, vfmv.v.f.
- `vtdot.vv` acumula em `vd[0]` (EEW = 2*SEW): le o acumulador inicial de
  vd[0], soma os produtos alargados (T8->T16, T16->T32, T32->T64) e escreve
  de volta. Isso permite usar a instrucao em laco de segmentos de linha
  (SpMV) sem instrucoes extras de reduction.
- Contadores: instrucoes (total/RVV/Zvtakum), escritas de CSR (vtype/vl) e
  elementos ativos; trace opcional de palavras executadas.
- Ferramentas: `zt-disa` (encode/decode) e `zt-run` (.zt), assembler proprio
  aceita nomes ABI de registradores (a0..a7/t0..t6), tokens de vtype
  (e8/e16/e32, m1/m2/m4/m8, ta/ma) e sufixo `v0.t` para mascaramento.

## Riscos e pontos abertos

- **Arredondamento**: ver D2; quantificar divergencia e documentar no artigo.
- **Ghost bits**: validar codec T8/T16 contra libtakum exaustivamente.
- **Acumulacao do vtdot**: semantica exata do produto (largura do produto e
  momento do arredondamento) a fixar em `docs/spec/zvtakum.adoc`; validar
  contra calculo em float128.
- **Fechamento (Sec. 5.6)**: replicar com RNE pode deslocar porcentagens.
- **Transcricao `artigos.md`**: reconferir tabelas 4/5/6 no PDF antes de
  usar como vetores de teste.
- **Matplotlib ausente**: instalar com `pip3 install --user matplotlib` na
  fase de analise.

## Referencias

- arXiv:2503.14067v2 - Streamlining SIMD ISA Extensions with Takum Arithmetic
- arXiv:2404.18603v2 - Beating Posits at Their Own Game: Takum Arithmetic
- libtakum v2.0.0 - https://github.com/takum-arithmetic/libtakum (ISC)
- MuFoLAB v1.2.0 - https://github.com/takum-arithmetic/MuFoLAB (ISC)
- riscv-opcodes (inventario RVV) - https://github.com/riscv/riscv-opcodes
- riscv-isa-manual (convencoes de spec) - https://github.com/riscv/riscv-isa-manual
