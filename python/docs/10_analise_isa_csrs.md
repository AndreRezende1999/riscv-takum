# Análise delimitada de instruções e CSRs

Esta nota trata a análise pedida pelo enunciado como investigação, sem presumir que deva demonstrar uma redução. Base empírica: o kernel Python e os [contadores auditados](../results/validation_v2/counts.csv), não um processador completo.

## O que o kernel efetivamente conta

Sejam `m` o número de linhas, `N` os não zeros efetivos, `w` a largura em bits, `L=VLEN/w` e `nᵣ` o tamanho da linha r. Para a escolha determinística de `vl=min(AVL,L)` deste modelo, o número de blocos é `K=Σᵣ ceil(nᵣ/L)`, com contribuição zero de linhas vazias.

| Ação contada no modelo | Quantidade |
|---|---:|
| Configurar comprimento/largura (`vsetvli`) | K + m |
| Carregar os valores de A | K |
| Carregar x por índices | K |
| Executar `vtdot.vv` | K |
| Executar `vncvt.t.t` | m |
| Armazenar o resultado | m |
| Total dessas ações | 4K + 3m |
| Escritas da semente pelo hospedeiro, separadas | m |

São ainda N multiplicações e N somas elementares. Não somar `active_products`, `active_sums` ou `active_lanes` à contagem de instruções. Apenas dot e narrowing passam por palavras customizadas no SpMV; as configurações e transferências são chamadas funcionais. Em particular, o carregamento dos próprios índices para registradores RVV, o percurso do CSR, ponteiros, desvios e inicialização arquitetural da semente ainda não são executados como instruções reais.

Transferências abstratas: `2N(w/8)` bytes de valores lidos, `4N` bytes de índices de 32 bits e `m(w/8)` bytes de saída. Não incluem rowptr, cache, reutilização de x ou sobrecarga da representação Python. São fórmulas do kernel do projeto, verificadas nos 48 resultados Takum dos dois braços. A escala não muda essas contagens, pois ocorre no hospedeiro.

Exemplo: `bcsstk01`, VLEN=256, tem m=48 e N=400. T8/T16 usam K=48 e 336 ações; T32 usa K=60 e 384 ações. Em `sherman1`, as linhas são curtas e K=1.000 nas três larguras, dando 7.000 ações em todas elas. Assim, reduzir a largura não garante reduzir a quantidade de instruções: é preciso observar os comprimentos das linhas.

## Comparação arquitetural que faz sentido

A RVV 1.0 já reutiliza instruções em diferentes SEW e oferece multiplicação ampliada e redução ordenada `vfredosum`; `vfwredosum` amplia a soma de operandos estreitos. O suporte binary16 vem de Zvfh; não se deve pressupor FP8 vetorial só porque SEW=8 existe. [Especificação V, §§13–14 e 18](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html).

**Inferência para nosso baseline futuro:** em binary32→binary64, uma multiplicação ampliada seguida de redução ordenada na largura ampliada é um candidato a reproduzir os pontos de arredondamento do dot. Será necessário incluir as mudanças de SEW/LMUL, grupos de registradores e demais instruções. Multiplicar na largura estreita e só depois ampliar a redução altera a precisão do produto, portanto não serve automaticamente como baseline equivalente. Um dot fundido também muda o contrato.

As cinco famílias customizadas do projeto atendem T8/T16/T32, mas isso, sozinho, não prova economia de opcodes sobre RVV, que também parametriza largura. Encapsular multiplicações e redução em `vtdot` reduz sua expressão a uma palavra customizada; não demonstra menor latência interna. A integração proposta acrescenta semântica ao decoder e uma operação de redução, custos que precisam ser considerados.

Não há porcentagem defensável de redução total de instruções enquanto o caminho comparador for apenas uma função numérica Python e parte do controle Takum permanecer no hospedeiro. O [CSV](../results/validation_v2/counts.csv) rotula o total como `model_actions` para evitar essa confusão.

## Estado de controle

Na ISA F, `frm` e `fflags` são campos acessíveis de `fcsr`: três bits de modo e cinco flags. Seus três endereços de acesso não representam três bancos independentes de estado. [Especificação F, §2](https://docs.riscv.org/reference/isa/v20260120/unpriv/f-st-ext.html), [mapa de CSRs](https://docs.riscv.org/reference/isa/v20260120/priv/priv-csrs.html).

| Aspecto | Contrato Takum deste projeto | Implicação delimitada |
|---|---|---|
| Seleção do formato | Opcode identifica Takum; SEW identifica largura | Não foi introduzido CSR de seleção de formato |
| Arredondamento | Fixo, empate para par no código | O caminho Takum não consulta `frm` |
| Exceções aritméticas | NaR propagado; saturação finita; sem flags acumuladas | O caminho Takum não atualiza `fflags`; perde essa observabilidade |
| Estado vetorial | `vl`, SEW, `vstart`, máscara e políticas do subconjunto | Trocar formato não elimina controle de vetores |
| Coexistência com IEEE | Não executada no simulador | A proposta não justifica remover o `fcsr` de um processador que continue suportando F/D |

O estado vetorial completo da norma inclui sete CSRs; nosso objeto Python não implementa seus endereços, todos os campos, privilégios nem salvamento de contexto. [Modelo de programação V, §3](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html). Portanto, a simplificação observada é **de contrato aritmético e de dependência de estado no caminho Takum**, não uma redução medida da área de CSRs ou do estado total de um núcleo RISC-V.

Para completar a avaliação: definir um baseline executável com a mesma política de operações e memória; incluir instruções de índices e controle; verificar a contagem; só então comparar sequências. Medir área, frequência ou energia exigiria outra implementação e ferramentas de hardware.
