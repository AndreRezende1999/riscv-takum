# Registro de decisões de projeto

Cada decisão tem contexto, alternativas consideradas e resultado. O status indica o que
foi feito nesta branch (`refactor/zvtakum-cpp`).

## D1 — Espaço de codificação das instruções Takum

* **Status:** adotada. Migrada para custom-0.
* **Contexto:** a versão anterior usava OP-V com `funct6 = 0b111001` e `funct3` como subopcode, com a justificativa de que o valor seria o único livre.
* **Evidência:** o inventário do riscv-opcodes (`rv_v` e `rv_zv*`, lido em 2026-10-10) mostra que 0b111001 está livre, mas também estão livres de 11 a 33 outros valores por classe de operando. A premissa de unicidade é falsa.
* **Decisão:** custom-0 (opcode 0x0B), funct3 = 0, funct6 = operação (0–4), mesma ordem da Python. O OP-V fica sem alteração.
* **Alternativas:** manter OP-V com subopcode em funct3, que quebra a convenção da RVV; ou reservar um funct6 de OP-V, sem garantia de que não colida com extensões futuras.

## D2 — Linguagem do simulador

* **Status:** adotada para o simulador novo (C++17). O código C11 anterior (`src/`, `include/`, `tests/`, `tools/`, `bench/`) foi removido; sua história permanece no git.
* **Contexto:** o item 2 dos Objetivos aceita C++ ou Python. C++17 atende explicitamente ao enunciado.
* **Motivação:** o núcleo Takum e o interpretador ficam mais claros e mais rápidos em C++; a escala do experimento (matrizes × formatos × VLEN) exige código compilado.
* **Pendente:** nenhuma.

## D3 — Papéis dos modelos

* **Status:** adotada.
* **Decisão:** o simulador `sim/` é o executor de ISA. O modelo Python (`python/takum_rvv`, racionais exatos) é o gabarito bit a bit. A libtakum não é usada pelo simulador novo; a comparação direta com ela ficou no modelo Python e no legado.
* **Pendente:** a checagem T8 contra a libtakum não foi refeita dentro de `sim/`.

## D4 — Núcleo escalar

* **Status:** adotada.
* **Decisão:** RV64IM e Zicsr executados no simulador, com os laços do kernel SpMV também no simulador.
* **Motivação:** a auditoria anterior mostrou que o caminho FP32 e o takum tinham perímetros diferentes (laço no host para o FP32). Com o núcleo escalar, os dois kernels têm o mesmo perímetro de contagem.

## D5 — Variante logarítmica

* **Status:** não adotada nesta branch.
* **Contexto:** o artigo anterior apresentava as duas variantes. A variante logarítmica exige Δ± para soma e subtração, o que é um custo de complexidade a ser analisado (objetivo 1 do enunciado).
* **Decisão:** escopo linear. A variante log continua apenas no legado C (libtakum) e não é reproduzida aqui.
* **Pendente:** decidir se a variante log entra no ISA, com que método para Δ±, ou se fica como análise separada.

## D6 — Arredondamento normativo

* **Status:** adotada e validada.
* **Decisão:** RNE no código, com prefixo de n+1 bits e sticky, sem `double`. Definido em `docs/spec/zvtakum.adoc`.
* **Validação:** T8 completo (add, sub, mul e narrow T16→T8) e amostras de T16, T32 e T64 contra o modelo Python.
* **Alternativa:** arredondamento no valor (vizinho mais próximo), que não é o comportamento da libtakum nem do modelo de referência.

## D7 — Semântica do vtdot

* **Status:** adotada.
* **Decisão:** MAC: acumulador em `vd[0]` com EEW = 2·SEW e EMUL = 1, como o `vwmacc` na convenção de vd lido e escrito. Sem `vstart ≠ 0`.
* **Alternativa:** redução RVV com acumulador em `vs1[0]`. Não foi adotada porque o kernel precisaria de um registrador extra para o acumulador, e a versão anterior já usava o `vd[0]`.

## D8 — Formatos de referência

* **Status:** parcialmente adotada.
* **Decisão:** FP32 como kernel vetorial real (`vfmul` e `vfredusum`). Takum T8, T16 e T32 como kernels reais. FP8 (E4M3, E5M2) e FP16 apenas por modelo numérico (`kernels/numeric_baselines.py`), sem contagem de instruções.
* **Pendente:** não implementar Zvfh nesta fase. Se houver tempo, alterar `sim/src/machine.cpp` para executar FP16 e widening para FP32, adicionar as instruções e casos de teste correspondentes em `sim/kernels/` e atualizar os contadores; estimativa de esforço: uma mudança de semântica no simulador, um kernel e uma rodada de validação diferencial.

## D9 — Oráculo para instruções padrão

* **Status:** adotada.
* **Decisão:** QEMU 10.2.2 user-mode, com `-cpu rv64,v=true,vlen=V,elen=64,vext_spec=v1.0,rvv_ta_all_1s=true,rvv_ma_all_1s=true`, para escalar e RVV padrão. Não se usa Spike.
* **Motivação:** o QEMU está instalado e implementa a RVV 1.0. A branch Python havia excluído o Spike por decisão registrada; esta branch não depende dele. As opções `rvv_ta_all_1s` e `rvv_ma_all_1s` alinham o QEMU à política agnóstica do simulador (D11).

## D11 — Política de elementos agnósticos

* **Status:** adotada.
* **Decisão:** elementos agnósticos (`vta = 1` ou `vma = 1`) recebem 1s no simulador.
* **Motivação:** a RVV 1.0 permite as duas escolhas. Sem a opção correspondente, o QEMU mantém o valor anterior, e a divergência aparece apenas nesses elementos (verificado nos programas `rvv_std` e `zvtakum_isa`).
* **Consequência:** a verificação diferencial depende dessa escolha, e a especificação a declara.

## D12 — Modelo analítico de contagem de instruções

* **Status:** adotada e validada.
* **Decisão:** cada kernel SpMV segue `N = rR + cS + K`, com parâmetros medidos por `sim/kernels/modelo_contagem.py` a partir de programas sintéticos e conferidos nas 96 execuções reais (resíduo zero).
* **Consequência:** a diferença entre Takum32 e FP32 é `R − S`, e os empates ocorrem quando `S = R`. Essa identidade explica as contagens sem recorrer à interpretação do gerador.
* **Motivação:** a primeira comparação deu o sinal oposto por causa de uma instrução redundante no kernel de 8 bits, corrigida nesta etapa. Um modelo verificado evita repetir esse tipo de erro.

## D13 — Comparações pareadas de precisão

* **Status:** adotada.
* **Decisão:** comparações entre formatos são feitas por matriz (mesma matriz e mesmo x), reportando vitórias, derrotas, empates e resultados não finitos. Medianas resumem uma coluna, mas não comparam conjuntos de matrizes diferentes.
* **Motivação:** a primeira versão comparava a mediana de binary16 (cinco matrizes finitas) com a de Takum16 (oito), o que não é comparação válida. A análise pareada inverteu uma conclusão do artigo.

## D10 — Protocolo de representação (1401 matrizes)

* **Status:** não executada nesta branch.
* **Motivo:** o MuFoLAB exige Julia ≥ 1.11, que não está instalada na máquina. A rodada completa levaria horas e os desvios do protocolo (regra de falha do MuFoLAB, E4M3 IEEE e referência binary64, documentados na conversa anterior) precisam ser decididos antes.
* **Consequência:** os resultados de representação do artigo ainda são os da versão anterior (100 matrizes, referência long double). O artigo declara isso explicitamente.
