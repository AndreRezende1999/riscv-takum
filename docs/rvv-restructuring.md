# Reestruturação do ISA RVV com Takum (réplica da metodologia do artigo AVX10.2)

Este documento aplica à RISC-V Vector Extension (RVV) a metodologia de
*Streamlining SIMD ISA Extensions with Takum Arithmetic: A Case Study on
Intel AVX10.2* (arXiv:2503.14067, Seção III). O objetivo é mostrar como o
-formato takum (T8/T16/T32) pode consolidar o conjunto de formatos de ponto
flutuante da RVV e simplificar o ISA, no espírito das Tabelas I-V do artigo.

Fontes do inventário (verificadas em 2026-09-15):

- `riscv-opcodes`, branch `master`, diretório `extensions/`:
  `rv_v` (375 instruções), `rv_zvfbfmin` (2), `rv_zvfbfwma` (2),
  `rv_zvbb` (16), `rv_zvbc` (4), `rv_zvkg` (2), `rv_zvkned` (11),
  `rv_zvknha` (3), `rv_zvksed` (3), `rv_zvksh` (2).
- `riscv-isa-manual` (capítulos `vector-common.adoc`, `zvfh.adoc`,
  `zvfbfmin.adoc`, `zvfbfwma.adoc`).

## 1. Metodologia (adaptada do artigo)

1. **Agrupamento de instruções**: categorias bitwise, máscara, inteiro,
   ponto flutuante (incluindo conversões), permutação e criptografia.
2. **Nomenclatura de quantidades em bits**: B8/B16/B32/B64 (bitwise),
   U8.. (inteiro sem sinal), S8.. (inteiro com sinal); substitui as
   abreviações B/W/D/Q, ambíguas entre "byte/word" e "bits".
3. **Nomenclatura de ponto flutuante**: T8/T16/T32/T64 para takum,
   substituindo H/S/D (half/single/double) e as siglas de formatos
   não-IEEE (BF16 da Zvfbfmin/Zvfbfwma; não há FP8 em RVV hoje).
4. **Generalização**: toda instrução de takum cobre T8, T16 e T32
   (no lugar de precisões fixas por instrução), pois todas compartilham o
   mesmo decodificador de 12 bits.

## 2. Inventário RVV (antes)

| Categoria | Quantidade | Fonte |
|---|---:|---|
| `vset` (configuração de tipo) | 3 | `rv_v` |
| Memória (unit/strided/indexed/segmentada/whole-register) | 63 | `rv_v` |
| Inteiro (aritmética, shifts, mul/div, saturação, widening, carry) | 187 | `rv_v` |
| Máscara e comparações (`vm*`) | 71 | `rv_v` |
| Permutação/deslocamento/merge/move | 38 | `rv_v` |
| Reduções inteiras (`vred*`, `vwred*`) | 10 | `rv_v` |
| Ponto flutuante (`vf*`, inclui 21 conversões e 6 reduções) | 92 | `rv_v` |
| Conversões bf16 vetoriais | 4 | `rv_zvfbfmin`, `rv_zvfbfwma` |
| Criptografia vetorial (8 arquivos Zvk*) | 41 | `rv_zv*` |
| **Total (V 1.0 + bf16 + Zvk*)** | **~510** | |

Observações relevantes para o argumento do artigo:

- A RVV **não tem FP8/OFP8**: o problema de proliferação de formatos se
  manifesta como bf16 (4 instruções) + float16 (via `Zvfh`, sem instruções
  próprias: redefine SEW=16) + f32/f64 (SEW=32/64).
- Já existem 21 instruções de conversão FP e 4 de bf16: qualquer formato
  novo adiciona mais um bloco de conversões cruzadas (N formatos →
  O(N²) pares). É exatamente o argumento da Seção III.3 (nomenclatura) e
  IV.D (conversões) do artigo.

## 3. Tabelas "original → proposta"

As tabelas usam notação de expressão regular sobre os mnemônicos, como no
artigo. As propostas de nomenclatura são provisórias deste projeto.

### 3.1 Bitwise e máscara

| ID | RVV (original) | Proposta |
|---|---|---|
| B01 | `v(and\|or\|xor)(\.vv\|\.vx\|\.vi)` | `v(and\|or\|xor)B(8\|16\|32\|64)` (sufixo `.{vv,vx,vi}` inalterado) |
| B02 | `vmand\|vmnand\|vmor\|vmnor\|vmxor\|vmxnor\|vmandn\|vmorn` | `vm(and\|nand\|or\|nor\|xor\|xnor\|andn\|orn).mm` |
| B03 | `vmsbf\|vmsif\|vmsof\|viota\|vid` | inalterado |
| B04 | `vmseq\|vmsne\|vmsltu?\|vmsleu?\|vmsgtu?` | `vms(eq\|ne\|lt\|le\|gt)(S\|U)(8\|16\|32\|64)` (signedness explícita) |

### 3.2 Inteiro

| ID | RVV (original) | Proposta |
|---|---|---|
| I01 | `v(add\|sub\|rsub\|minu?\|maxu?)` | `v(add\|sub)(S\|U)(8\|16\|32\|64)`, `v(min\|max)(S\|U)B(8\|16\|32\|64)` |
| I02 | `vmul(h\|hsu\|hu)?`, `vdivu?`, `vremu?` | `v(mul\|div\|rem)(S\|U)(8\|16\|32\|64)` com sufixos `h`/`hsu` explícitos |
| I03 | `vw(mul\|add\|sub\|macc)a?u?s?` | `vw(mul\|add\|sub\|macc)(S\|U)(8\|16\|32\|64)` |
| I04 | `vnsrl\|vnsra\|vnclipu?` | `vn(sh\|clip)(S\|U)` + larguras explícitas |
| I05 | `vsadd\|vsaddu\|vssub\|vssubu` | `v(add\|sub)SAT(S\|U)B(8\|16\|32\|64)` |
| I06 | `vzext\|vsext` (`.vf2/.vf4/.vf8`) | `v(zext\|sext)B(8\|16\|32\|64)` + fator |

### 3.3 Ponto flutuante e conversões

| ID | RVV (original) | Proposta |
|---|---|---|
| F01 | `vf(add\|sub\|mul\|div\|min\|max\|madd\|msub\|nmadd\|nmsub\|macc\|msac\|nmacc\|nmsac\|sqrt\|sgnj\|sgnjn\|sgnjx)` | `vt(add\|sub\|mul\|div\|min\|max\|madd\|msub\|nmadd\|nmsub\|macc\|msac\|nmacc\|nmsac\|sqrt\|sgnj\|sgnjn\|sgnjx)` em T(8\|16\|32) |
| F02 | `vmf(eq\|le\|lt\|ne\|gt\|ge)` | `vtcmp(\.eq\|\.le\|\.lt\|\.ne\|\.gt\|\.ge)` |
| F03 | `vfred(u\|o)sum\|vfredmin\|vfredmax` | `vtredu(sum\|min\|max)(T8\|T16\|T32)` |
| F04 | `vfcvt`, `vfwcvt`, `vfncvt` (21 instruções) | `vncvt.t.t` (estreitamento) e `vtcvt.t.iu`/`vtcvt.iu.t` (inteiro), com SEW/EEW selecionando T(8\|16\|32) |
| F05 | `vfwmaccbf16`, `vfwcvtbf16`, `vfncvtbf16` (Zvfbfmin/Zvfbfwma) + `Zvfh` (SEW=16) | removidos: T16/T8 unificam os casos de uso de bf16/f16 |
| F06 | (não existe) | `vtdot.vv`: produto escalar com acúmulo alargado (T8→T16, T16→T32, T32→T64) |

### 3.4 Criptografia

| ID | RVV (original) | Proposta |
|---|---|---|
| C01 | `vaes*`, `vsm4*`, `vsm3*` | inalterado |
| C02 | `vghsh.vv`, `vgmul.vv` | inalterado |
| C03 | `vsha2*` | inalterado |
| C04 | `vclmul(h)?`, `vbrev8` etc. (Zvbb/Zvbc) | `vclmulU64U8`/quantidades B/U explícitas |

## 4. Consolidação de formatos e conversões

Hoje, cada formato FP (f16 via Zvfh, bf16, f32, f64) tem custo de conversão
cruzada e regras próprias (bf16 usa instruções de exceção `vfncvtbf16`,
OFP8 não existe ainda em RVV mas é candidato). Com takum:

- os elementos passam a ser T8/T16/T32 (com T64 como acumulador interno do
  `vtdot` para SEW=32);
- conversões: 1 instrução de estreitamento (`vncvt.t.t`) substitui as
  famílias `vfncvt` (8 instruções) para redução de precisão; conversão para
  IEEE permanece necessária apenas na fronteira do sistema (I/O), não no
  laço de computação;
- bf16 (4 instruções) e as variantes SEW=16 da `Zvfh` deixam de ter função
  dedicada: T16 as cobre com faixa dinâmica muito maior (ver
  `docs/spec/zvtakum.adoc`).

Estimativa de redução (contagem de instruções de FP/conversão no `rv_v` +
bf16): **92 + 4 = 96 → ~8 instruções Zvtakum** (vtadd, vtsub, vtmul, vtdiv,
vtsqrt, vtdot, vncvt.t.t, vtcvt int↔takum), mantendo as sgnj/min/max como
operações de bits (comparação de takum é comparação inteira, Seção 5.2 do
artigo).

## 5. CSRs e tratamento de exceções

| Aspecto | RVV atual | Zvtakum |
|---|---|---|
| Tipo de elemento | `vtype.SEW` (8-64) | `vtype.SEW` = 8/16/32 para T8/T16/T32 |
| Arredondamento | `frm`/`vxrm` (por instrução, múltiplos modos) | RNE fixo (sem novo CSR); Algoritmo 1 disponível no modelo de referência |
| Overflow/underflow | exceções FP / saturação por instrução | sempre saturante; sem flags de exceção FP |
| Não-real | NaN(s) | NaR único (0x80/0x8000/0x80000000), ordem total |
| Máscara/tail | `vta`/`vma` do `vtype` | idêntico (reuso de `vtype`, `vl`, `vstart`) |
| Comparação | instruções `vmfeq` etc. + CSR | comparação inteira em complemento de dois (sem CSR extra) |

## 6. Limitações desta análise

- O espaço de encodings foi atribuído dentro do único `funct6` livre do
  OP-V (`0b111001`), usando `funct3` como sub-opcode (ver
  `docs/opcodes/zvtakum.opcodes`); uma proposta formal precisaria negociar
  espaço de opcode no Comitê Técnico.
- A contagem "antes" usa o inventário do `riscv-opcodes` (V 1.0 + bf16 +
  Zvk*); extensões futuras (ex.: FP8 vetorial) não estão incluídas.
- A remoção de bf16/f16 é uma avaliação do estudo; a retrocompatibilidade
  exigiria mantê-los como legado, como o artigo faz com os formatos AVX10.2.

## 7. Referências

- arXiv:2503.14067v2 (metodologia e Tabelas I-V).
- arXiv:2404.18603v2 (formato takum; Propriedades 3, 4, 6, 7, 11).
- `riscv-opcodes` (inventário) e `riscv-isa-manual` (semântica RVV).
