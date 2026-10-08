# Primeira execução da solução Python

Data: 06/10/2026. Registro de engenharia; não é um artigo nem validação da proposta completa para publicação.

**Registro histórico da primeira execução.** A comparação independente T16/T32 e binary128, o conjunto de oito matrizes e o controle de escala foram acrescentados depois. Consulte o [relatório ampliado](09_validacao_ampliada.md) para o estado atual; os resultados e limites abaixo descrevem a etapa anterior.

## Correção numérica e funcional

- T8: todos os 256 códigos comparados à decodificação da **libtakum 2.0.0**, commit `776ac0ca7855f640100731ed8bbb0c7cf83b2d94`. Nenhuma divergência.
- Soma, subtração e multiplicação T8: **65.536 pares ordenados por operação**, incluindo zero e NaR. Nenhuma divergência nas 196.608 operações. [Relatório](evidencias/python_libtakum.json) e [origem do oráculo](../tests/data/README.md).
- T16/T32/T64: valores conhecidos, precisão ao redor de um e limites de inteiros consecutivos de [Hunhold, seção 5](https://arxiv.org/html/2412.20273v2). Não houve enumeração exaustiva dessas larguras.
- Estado vetorial: máscaras, cauda preservada, `vl=0`, `vstart`, formas x0 de `vsetvli`, semente do dot, largura ampliada, sobreposição rejeitada e palavras ilegais. O benchmark também exige igualdade bit a bit entre SpMV vetorial e escalar em todos os casos Takum executados.
- Comparadores: vetores conhecidos IEEE/OFP8, extremos, subnormais, empates, round-trip exaustivo dos valores finitos FP8 e comparações com `struct` de Python para binary16/32/64. Binary128 tem testes dirigidos de precisão/expoente, mas ainda não foi comparado diferencialmente a SoftFloat/MPFR.
- Leitura e análise: Matrix Market, simetria, duplicatas, linhas vazias, referências iguais a zero, não finitos, CDF com falhas e erros fora da faixa binary64.

A suíte está em `tests/`; o [log de execução](evidencias/python_tests.txt) registra a contagem efetivamente executada.

## SpMV real: execução inicial

São dois problemas Harwell–Boeing disponibilizados pelo NIST: [BCSSTK01, engenharia estrutural](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/bcsstruc1/bcsstk01.html), e [WEST0067, engenharia química](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/chemwest/west0067.html). Os arquivos são mantidos sem edição; [fontes e hashes](../data/harwell_boeing/README.md). Esta seleção foi feita pelo tamanho pequeno e por cobrir matrizes simétrica e geral, não por resultados favoráveis.

Configuração: VLEN=256, LMUL=1, vetor aleatório racional em [-1,1], semente 2026, sem escalonamento. Todos os formatos usam acumulador de largura dobrada e saída na largura de armazenamento. A referência comum é SpMV binary128 com produtos e somas arredondados separadamente. [CSV completo](../results/python_real/results.csv), [manifesto](../results/python_real/manifest.json), [vetores exatos](../results/python_real/vectors.json).

| Formato | Erro relativo L2: bcsstk01 | Erro relativo L2: west0067 |
|---|---:|---:|
| Takum linear8 | 0,721605 | 0,0618924 |
| Takum linear16 | 0,00302993 | 0,000225298 |
| Takum linear32 | 5,91655 × 10⁻⁸ | 3,30432 × 10⁻⁹ |
| E4M3 | não finito em 48 saídas | 0,0484675 |
| E5M2 | não finito em 48 saídas | 0,0935485 |
| binary16 | não finito em 48 saídas | 0,000281824 |
| binary32 | 4,48389 × 10⁻⁸ | 4,29647 × 10⁻⁸ |

Os números são frações relativas, **não porcentagens**. Há vantagens e desvantagens: T32 supera binary32 em west0067, mas o resultado se inverte em bcsstk01; E4M3 supera T8 em west0067. Isso impede sustentar uma superioridade universal. Os não finitos de bcsstk01 refletem também a política sem escala e sem saturação dos comparadores. Outra política constitui outro experimento e precisa de identificação própria.

Os casos sintéticos em `examples/` exercitam cancelamento e faixa dinâmica; seus [resultados](../results/python_demo/results.csv) ficam separados dos dados reais. Não somar os dois conjuntos para apresentar uma distribuição supostamente representativa.

## Como interpretar os arquivos

- `relative_l2`: erro total do resultado contra a referência binary128 comum.
- `matrix_representation_relative_l2`: erro da quantização dos valores de A; a norma da lista equivale à **norma de Frobenius** da matriz, não à norma espectral.
- `input_effect_relative_l2`: dot exato das entradas quantizadas contra dot exato das entradas originais. Exclui o arredondamento da referência binary128.
- `arithmetic_relative_l2`: resultado final contra dot exato das entradas quantizadas; inclui a conversão final para a largura de armazenamento.
- `same_width_relative_l2`: controle com acumulador da mesma largura, contra a mesma referência comum.
- Campos vazios representam métricas indefinidas, não zero. Consultar contagens de não finitos e referência zero. `cdf_summary.json` identifica também formatos sem qualquer ponto válido.
- `counts`: operações do subconjunto vetorial Takum e bytes transferidos. `active_products`, `active_sums` e `active_lanes` são contagens de elementos, não instruções. `host_seed_writes` é uma operação do hospedeiro. Os comparadores escalares deixam esse campo vazio.

## Limites e próxima etapa científica

O núcleo funcional já pode ser exercitado e modificado. Para uma avaliação robusta do projeto, ainda falta fixar um conjunto maior de matrizes por critérios anteriores aos resultados, estudar escalonamento/políticas de FP8, ampliar a verificação independente de T16/T32/T64 e binary128 e definir uma comparação defensável de complexidade de ISA/CSRs. Duas matrizes e exemplos sintéticos verificam o programa; não sustentam conclusões gerais, tempo de hardware, energia ou área.

O artigo AVX10.2 motiva formatos e operações, mas seu conjunto de 1.401 matrizes avalia **representação**, não este SpMV. A pergunta experimental, os dados e as conclusões de SpMV aqui devem ser avaliados por seus próprios resultados. [Hunhold, AVX10.2, seção II](https://arxiv.org/abs/2503.14067v2).
