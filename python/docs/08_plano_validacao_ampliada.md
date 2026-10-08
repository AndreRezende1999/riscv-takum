# Validação ampliada: protocolo antes dos novos resultados

Data: 06/10/2026. Continuação autorizada pela usuária. Solução permanece inteiramente em Python, sem Spike; programas C são apenas exportadores de oráculos externos para testes.

## 1. Oráculos

- Enumerar todas as decodificações T16 e comparar pares T16/T32 dirigidos e estratificados com a mesma revisão da libtakum já fixada. A biblioteca usa `double` em operações T32 e pode sofrer dupla aproximação: uma divergência será examinada com frações exatas, sem alterar o modelo apenas para concordar com o oráculo. [libtakum, fonte](https://github.com/takum-arithmetic/libtakum).
- Conferir o modelo binary128 contra aritmética GCC `__float128`/libquadmath, com round-to-nearest-even, sem `fast-math` nem contração de operações. Preservar corpus e metadados; comparar a semântica finita declarada, tratando sinais de zero e não finitos explicitamente. [GCC libquadmath](https://gcc.gnu.org/onlinedocs/libquadmath/).

## 2. Controle de escala comum a todos os formatos

A literatura de FP8 destaca a importância da escala, mas não determina uma única política para nosso SpMV. [Micikevicius et al., 2022](https://arxiv.org/abs/2209.05433v2). Compararemos a execução atual sem escala a **uma política própria e determinística**, aplicada igualmente a Takum, FP8, binary16 e binary32:

1. `sA` é a menor potência de dois maior ou igual à maior soma absoluta de uma linha de A.
2. `sx` é a menor potência de dois maior ou igual ao maior módulo de x.
3. Se a norma for zero, sua escala é 1. Quantizar `A/sA` e `x/sx`, executar o mesmo kernel e reconstruir a saída por `sA*sx` em aritmética exata externa.

Antes da quantização, `|(A/sA)(x/sx)| <= 1` componente a componente, pela desigualdade triangular. Isso evita escolher escala após observar o erro de um formato. **Não garante ausência de arredondamento, underflow ou toda possibilidade de overflow intermediário após quantização.** Dois expoentes globais adicionais e o trabalho de pré/pós-processamento fazem parte da representação escalada; seu custo não está nas instruções vetoriais modeladas. Nenhuma vantagem de hardware será inferida desse controle.

A referência binary128 usa sempre os dados originais. Os erros de representação e entrada serão medidos após desfazer a escala, também contra os originais. A política da saída (mesma largura do armazenamento) e a acumulação ampliada permanecem as mesmas. Os resultados antigos ficam preservados; cada novo braço tem diretório e manifesto próprios.

## 3. Matrizes e vetores

Manter os dois pilotos (`bcsstk01`, `west0067`), cujos resultados já são conhecidos, e acrescentar seis problemas pequenos escolhidos por metadados do NIST antes da execução nova: `bcsstk02`, `west0132`, `jpwh_991`, `sherman1`, `pores_1`, `well1033`. Critérios: problemas reais Harwell–Boeing, até 50.000 não zeros, formatos já suportados, variação de domínio e inclusão de uma matriz retangular. Seleção intencional de conveniência, não amostra aleatória da SuiteSparse. Uma falha de download/leitura será registrada; não substituir silenciosamente por uma matriz mais favorável.

Usar vetor racional pseudoaleatório em [-1,1], semente 2026, idêntico entre os dois braços e todos os formatos; VLEN=256, LMUL=1. Esse ensaio não estima a sensibilidade à semente. Registrar hashes e fontes dos arquivos, vetores exatos, erros relativos/absolutos, falhas, controles de acumulação e distribuição empírica com denominador integral.

## 4. Ordem e aceite

Testes de regressão → implementação da escala → comparação com oráculos → coleta do conjunto fixado → dois braços de SpMV → revisão de manifestos e resultados. Concluir com relatório técnico de execução e limitações, sem redigir o artigo.
