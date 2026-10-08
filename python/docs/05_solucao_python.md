# Solução funcional em Python

Direção atual, confirmada em 06/10/2026: desenvolver e validar a solução em Python antes de escrever o artigo. O enunciado admite Python. **Spike está fora do escopo, por decisão da usuária.** Esta nota substitui a recomendação de manter C como implementação principal em `03_proposta_tecnica.md`.

## Contrato numérico

Implementar **Takum linear** T8/T16/T32 e T64 como acumulador interno. Os valores finitos serão frações exatas (`fractions.Fraction`), sem passar por `float` de Python. A definição vem de Hunhold, [artigo fornecido, definição 8](https://arxiv.org/abs/2404.18603v2). Fixar arredondamento com empate para par no código, conforme o [codec, versão 4, seção 5.5](https://arxiv.org/html/2408.10594v4). Em regimes com bits de característica truncados, o limiar é o código intermediário com um bit adicional; não é necessariamente a média aritmética dos valores adjacentes. Saturar valores finitos não nulos nos extremos; representar zero e NaR separadamente. A variante logarítmica fica fora desta implementação inicial.

## Modelo de execução

A divisão codec/ALU/estado vetorial/SpMV e os nomes das cinco operações aproveitam a organização do [protótipo do grupo](../../docs/spec/zvtakum.adoc). O código Python é uma implementação nova; não utiliza a ALU C como backend. As decisões numéricas aproveitadas da literatura são atribuídas abaixo.

32 registradores vetoriais, VLEN configurável, SEW 8/16/32, LMUL=1, `vl`, `vstart` e máscara v0. Preservar elementos inativos e cauda (políticas undisturbed). Rejeitar configurações fora deste subconjunto. Referência: [RVV 1.0](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html).

Operações experimentais: `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv`, `vncvt.t.t`. O dot lê dois vetores estreitos e usa `vd[0]` com 2×SEW como semente e destino escalar. Produtos e somas são arredondados separadamente a 2×SEW, em ordem crescente de índice: não é operação fundida nem acumulador exato. `vstart != 0` é rejeitado no dot; `vl=0` não modifica destino. Narrowing lê grupo de dois registradores alinhado e escreve um registrador sem sobreposição. Essa é uma decisão **deste projeto**, inspirada nas operações de precisão ampliada do [estudo AVX10.2](https://arxiv.org/abs/2503.14067v2), não uma extensão ratificada.

Usar `custom-0` para palavras experimentais de 32 bits; não ocupar posições reservadas de OP-V. [Mapa oficial](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv-32-64g.html). O interpretador dessas palavras não executa ELF nem implementa o processador RISC-V completo.

## Experimentos e validação

1. Vetores manuais de codec, arredondamento, especiais e ALU; enumeração dos 256 códigos T8; casos dirigidos T16/T32/T64.
2. Comparação independente das 65.536 combinações T8 por operação com **libtakum**, fixando versão e preservando divergências. O precedente de cobertura exaustiva FP8 é [Marcelli et al., seção 4](https://doi.org/10.3390/electronics14193924); nosso teste não valida a integração deles nem a substitui.
3. Estado vetorial: máscaras, caudas, `vl=0`, reinício, alias e acumulador; comparar execução vetorial com resultado escalar.
4. SpMV CSR: Matrix Market, dados lidos como decimais exatos; referência comum em binary128 em software (113 bits, expoente de 15 bits), multiplicação/soma separadas. Comparadores E4M3/E5M2, binary16/32. FP8 segue estrutura/conversão [OCP OFP8](https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1); política aritmética/overflow declarada pelo experimento.
5. Exportar CSV e manifesto com hashes, parâmetros, falhas e contagens do subconjunto modelado. Não confundir contagem de instruções com ciclos, área ou energia. Exemplos sintéticos validam o programa; não são evidência sobre a população SuiteSparse.

## Execução

Ordem de implementação: testes → codec/ALU → estado e instruções → referência binária/SpMV → execução e revisão dos resultados. Biblioteca padrão de Python; ferramentas C usadas apenas no teste diferencial opcional. Preservar o ZIP extraído e atribuir as ideias reutilizadas no próprio código e nesta nota.
