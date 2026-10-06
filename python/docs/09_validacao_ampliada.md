# Validação ampliada da solução Python

Executada em 06/10/2026, sem Spike e sem iniciar a redação do artigo. **68 testes passaram; 112 avaliações SpMV foram concluídas**: oito matrizes × sete formatos × dois cenários de escala. O resultado mais relevante é que a política de escala muda a comparação: T32 apresentou menor erro que binary32 nos oito casos escalados, enquanto E4M3 apresentou menor erro que T8 nos mesmos oito casos. São observações desta amostra, não conclusões gerais.

## O que foi executado

O [protocolo anterior aos novos resultados](08_plano_validacao_ampliada.md) fixa seis novas matrizes e mantém dois pilotos já observados. São sete problemas esparsos e um controle denso, `bcsstk02`; `well1033` é retangular. Os dados vieram do [NIST Matrix Market](https://math.nist.gov/MatrixMarket/), coleção Harwell–Boeing; [autores, aplicações, URLs e dimensões](../data/harwell_boeing/README.md) e [hashes dos arquivos](../data/validation_set.json) estão preservados. Em `west0132`, 414 entradas declaradas incluem um zero explícito, resultando em 413 não zeros no CSR.

Todos os formatos recebem a mesma matriz e o mesmo vetor racional pseudoaleatório, com semente 2026. VLEN=256 e LMUL=1. Multiplicação e adição arredondam separadamente no acumulador de largura dobrada; a saída volta à largura de armazenamento. Takum usa o executor vetorial, conferido bit a bit contra a execução escalar. E4M3/E5M2 e binary16/32 usam referências numéricas escalares; não há contagem de instruções comparável para esses formatos.

Há dois braços, executados sem escolher a melhor política individualmente para cada formato:

- `none`: valores originais, sem escala.
- `pow2-bound`: dividir A pela menor potência de dois que limita sua maior soma absoluta por linha; dividir x pela menor potência de dois que limita seu maior módulo. Reconstruir a saída externamente pelo produto das escalas. Valores nulos usam escala 1.

O controle é uma escolha deste projeto, motivada pela importância de explicitar escala nos estudos FP8, e não uma reprodução do algoritmo de calibração de [Micikevicius et al.](https://arxiv.org/abs/2209.05433v2). Dois expoentes globais e pré/pós-processamento são custos adicionais excluídos das contagens vetoriais. A reconstrução exata externa não significa que a saída física caiba no formato estreito sem a escala.

A referência é sempre o SpMV dos dados originais em binary128 em software. A comparação dessa referência com o produto racional exato teve erro relativo máximo de **2,25226 × 10⁻³⁴** neste conjunto. Isso é uma observação, não uma garantia universal. A distinção entre conversão, cálculo e resultado segue o cuidado metodológico discutido nas [leituras aplicadas](06_leituras_para_implementacao.md).

## Comparação independente dos modelos numéricos

| Verificação | Cobertura | Resultado observado |
|---|---|---|
| T8 × libtakum | 256 decodificações e 196.608 operações, todos os pares por operação | Nenhuma divergência |
| T16 × libtakum | 65.536 decodificações, 20.000 decodificações de operandos amostrados e 30.000 operações | Nenhuma divergência |
| T32 × libtakum | 20.000 decodificações de operandos e 30.000 operações | 128 diferenças na multiplicação; nenhuma nas demais comparações |
| binary128 × GCC `__float128`/libquadmath | 6.000 operações e 17 conversões decimais | 6.014 resultados iguais em bits, 3 diferenças de sinal de zero e nenhuma outra divergência |

A biblioteca foi fixada na [libtakum 2.0.0, commit 776ac0c](https://github.com/takum-arithmetic/libtakum/tree/776ac0ca7855f640100731ed8bbb0c7cf83b2d94). Nos 128 casos T32, o produto racional exato fica de um lado do limiar Takum, mas o intermediário `double` da biblioteca o arredonda para o próprio limiar. A conversão seguinte escolhe o código par e perde a decisão correta. O exemplo `0x40000001 × 0x44000001` produz `0x44000003` no modelo exato e `0x44000002` na biblioteca. A [análise de cada caso](evidencias/wide_reference_notes.md) usa os operandos exportados em hexadecimal e uma fórmula independente para a grade local; nenhum resultado externo foi substituído por um valor Python.

Essas diferenças pertencem a casos dirigidos próximos de empates. **128/10.000 não é uma estimativa de frequência de falhas em aplicações.** O [relatório diferencial](evidencias/python_libtakum_wide.json) preserva `matches_all: false`; os testes exigem exatamente a lista revisada e sua classificação matemática. A amostragem não prova correção de todos os pares T16/T32. T64 ainda não tem comparação aritmética externa equivalente.

A referência binary128 foi gerada com GCC 9.4.0 no WSL, sem fast math ou contração, usando os [tipos e operadores documentados pelo GCC](https://gcc.gnu.org/onlinedocs/gcc/Floating-Types.html) e a [libquadmath](https://gcc.gnu.org/onlinedocs/libquadmath/). As três diferenças de zero são compatíveis com o contrato declarado do modelo, que normaliza zeros na aritmética. [Corpus, ambiente e limites](evidencias/binary128_notes.md). Isso não certifica flags, payloads de NaN nem conformidade IEEE completa.

Os programas C servem apenas para gerar os dados externos de teste. Os 68 testes, o simulador e a repetição dos experimentos funcionam offline com a biblioteca padrão de Python. [Log dos testes](evidencias/python_tests_ampliados.txt).

## Erro relativo L2 por matriz

Valores relativos, não porcentagens. `NF(n)` indica n componentes não finitos e erro global indefinido; não foi substituído por zero. As tabelas exibem cinco algarismos significativos; os CSVs preservam maior precisão. T8/T16/T32 significam Takum **linear**.

Sem escala:

| Matriz | T8 | T16 | T32 | E4M3 | E5M2 | binary16 | binary32 |
|---|---:|---:|---:|---:|---:|---:|---:|
| bcsstk01 | 0,72160 | 0,0030299 | 5,9165e-8 | NF(48) | NF(48) | NF(48) | 4,4839e-8 |
| west0067 | 0,061892 | 0,00022530 | 3,3043e-9 | 0,048468 | 0,093548 | 0,00028182 | 4,2965e-8 |
| bcsstk02, densa | 0,27293 | 0,0014870 | 1,9178e-8 | NF(66) | 0,10436 | 0,00027066 | 4,7138e-8 |
| west0132 | 1,8127 | 0,00069221 | 1,9558e-8 | NF(17) | NF(3) | NF(3) | 2,7130e-8 |
| jpwh_991 | 0,077625 | 0,00028268 | 4,1341e-9 | 0,036114 | 0,079833 | 0,00028722 | 3,1433e-8 |
| sherman1 | 0,070006 | 0,00024747 | 3,9103e-9 | 0,038043 | 0,10250 | 0,00030380 | 3,7043e-8 |
| pores_1 | 0,34165 | 0,0010272 | 3,5117e-8 | NF(30) | NF(15) | NF(15) | 4,1440e-8 |
| well1033 | 0,064926 | 0,00024409 | 4,0098e-9 | 0,040431 | 0,079246 | 0,00034267 | 3,7119e-8 |

Com `pow2-bound`:

| Matriz | T8 | T16 | T32 | E4M3 | E5M2 | binary16 | binary32 |
|---|---:|---:|---:|---:|---:|---:|---:|
| bcsstk01 | 0,079295 | 0,00035132 | 6,3250e-9 | 0,046927 | 0,082145 | 0,00040586 | 4,4839e-8 |
| west0067 | 0,088691 | 0,00035923 | 5,1568e-9 | 0,048360 | 0,093548 | 0,00028182 | 4,2965e-8 |
| bcsstk02, densa | 0,11122 | 0,00030990 | 5,7570e-9 | 0,040133 | 0,10436 | 0,00027071 | 4,7138e-8 |
| west0132 | 0,14201 | 0,00036980 | 2,8658e-9 | 0,053922 | 0,089944 | 0,00030813 | 2,7130e-8 |
| jpwh_991 | 0,080592 | 0,00028769 | 4,2010e-9 | 0,036153 | 0,079833 | 0,00028722 | 3,1433e-8 |
| sherman1 | 0,10974 | 0,00033272 | 5,6391e-9 | 0,038499 | 0,10250 | 0,00030384 | 3,7043e-8 |
| pores_1 | 0,13193 | 0,00017625 | 6,7424e-9 | 0,029599 | 0,068282 | 0,00018115 | 4,1440e-8 |
| well1033 | 0,11844 | 0,00043463 | 6,4020e-9 | 0,041676 | 0,079246 | 0,00034267 | 3,7119e-8 |

Fontes dos números: [CSV sem escala](../results/validation_v2/none/results.csv) e [CSV escalado](../results/validation_v2/pow2-bound/results.csv). Resultados são deste projeto; as matrizes são atribuídas ao NIST e seus contribuidores acima.

## O que os resultados permitem dizer

- Sem escala, E4M3 teve resultado finito em 4/8 matrizes; E5M2 e binary16, em 5/8. Com a escala declarada, todos os sete formatos tiveram resultados finitos em 8/8. Ser finito não implica erro pequeno: o erro T8 sem escala chegou a 1,8127 em `west0132`.
- Nos três Takum, a escala melhorou quatro matrizes e piorou quatro. Em binary32, os resultados ficaram iguais nos oito casos. A conclusão sobre melhora global não deve vir apenas da mediana.
- No braço escalado, T32 teve menor erro que binary32 em 8/8 casos; T16 teve menor erro que binary16 em 2/8. E4M3 teve menor erro que T8 em 8/8. Cada comparação mantém largura de armazenamento e política de acumulação declaradas; não iguala automaticamente a precisão efetiva dos formatos.
- Acumulação ampliada não trouxe melhora estrita em todo caso: em `west0132` escalada, T8 passou de 0,14078697 no controle de mesma largura para 0,14200659 com largura dobrada. T16/T32 melhoraram nos oito casos dos dois braços. Os controles completos permanecem no CSV; não foram descartados casos desfavoráveis.

O [resumo pareado](../results/validation_v2/paired.csv) distingue melhora, piora, igualdade e recuperação de resultado indefinido. As medianas no [JSON de comparação](../results/validation_v2/comparison.json) são calculadas **somente entre resultados definidos**, com seu denominador; quando os conjuntos válidos diferem, não constituem comparação pareada. As CDFs mantêm os oito problemas no denominador: a curva sem escala de E4M3 termina em 4/8, sem esconder as quatro falhas.

## Reprodução e integridade

Na raiz do projeto, usando Python 3.10+:

```sh
python -m unittest discover -s tests -v
python tools/run_validation.py --output results/minha_validacao
python tools/check_validation_artifacts.py --input results/minha_validacao --report results/minha_validacao/audit.json
```

Neste computador, o inicializador localiza também o Python fornecido pelo aplicativo:

```powershell
.\run.ps1 test
.\run.ps1 validate --output results/minha_validacao
```

O executor exige um diretório vazio ou novo; os resultados anteriores foram preservados. Cada braço contém código do modelo em `source.zip`, hashes, vetores racionais, fontes das matrizes, escalas e parâmetros. Para reproduzir uma versão antiga do modelo, extrair seu `source.zip` em outra pasta e usar sua CLI com as mesmas matrizes/parâmetros. Os vetores salvos permitem conferir o gerador, que pode variar entre versões de Python. Os resultados anteriores a esta etapa têm hashes, mas não uma cópia arquivada do código.

A [auditoria executada](evidencias/auditoria_validacao_ampliada.json) verificou os hashes, identidade dos vetores entre braços, 112 linhas e 48 conjuntos de contadores Takum contra fórmulas derivadas do CSR. [Contagens](../results/validation_v2/counts.csv) e [escopo da análise de ISA/CSRs](10_analise_isa_csrs.md). A execução completa está no [log](evidencias/execucao_validacao_ampliada.txt).

## Trabalho ainda necessário

A amostra é pequena e intencional, com uma semente e dois pilotos conhecidos; não se podem inferir taxas para toda a SuiteSparse. Antes de alegações amplas, fixar seleção maior e múltiplos vetores, verificar sensibilidade à ordem/cancelamento e separar o controle denso. Falta validar externamente T64 de forma compatível com sua precisão e construir um baseline de instruções IEEE/RVV com os mesmos custos de memória, índices e controle. A análise atual não mede ciclos, área ou energia. A redação do artigo e a apresentação continuam adiadas conforme a orientação da usuária.
