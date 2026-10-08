# Leituras que orientam a implementação em Python

Consulta: 05/10/2026. Escopo atual: codec e ALU Takum linear, modelo funcional vetorial e experimentos esparsos em Python. **Sem integração com Spike nesta etapa; artigo adiado até a validação da solução.** As decisões abaixo são aplicações ao projeto, não afirmações de que os experimentos citados foram reproduzidos.

Foram consultados os textos completos disponíveis dos oito primeiros trabalhos, com leitura dirigida às seções indicadas. Isso significa acesso além do resumo, não auditoria de todas as provas, do código externo ou de cada resultado publicado. Para FAUST, o acesso foi parcial e está explicitado. Os nove trabalhos já se encaixam nas 19 referências anteriores ou nas quatro entradas acrescentadas ao [BibTeX](referencias.bib), que passa a conter 23 entradas.

## 1. Codec Takum: definição antes da otimização

**Hunhold — [Design and Implementation of a Takum Arithmetic Hardware Codec, v4](https://arxiv.org/html/2408.10594v4)**, 25/11/2025. Chave: `hunhold2025codec`. Consultadas as definições da seção 2, representações internas da seção 3 e encoder/decoder das seções 4–5.

O texto distingue Takum logarítmico de linear, trata zero e NaR separadamente e estende com zeros os códigos menores que 12 bits. A seção 5.5 especifica empate para par no código e proteção dos extremos. O arredondamento também pode atingir bits fora da fração; presumir sempre a média aritmética entre valores adjacentes é inadequado.

**Aplicação:** decodificar campos com inteiros, representar valores lineares por frações exatas e quantizar apenas nos pontos previstos pelo contrato. Testar transições de regime, característica truncada, sinais, extremos e os dois lados de cada limiar. A seleção do limiar deve seguir o código estendido. Os resultados de FPGA do artigo caracterizam o codec; não medem nossa ALU, ciclos ou energia.

## 2. Solvers esparsos: protocolo experimental reutilizável

**Hunhold e Quinlan — [Evaluation of Bfloat16, Posit, and Takum Arithmetics in Sparse Linear Solvers, v2](https://arxiv.org/pdf/2412.20268v2)**, 08/03/2025; [IEEE ARITH 2025](https://doi.org/10.1109/ARITH64983.2025.00019). Chave: `hunhold2025solvers`. Consultadas metodologia II.A–F e discussão III–IV.

O estudo avalia LU, QR, GMRES e refinamento iterativo. Seleciona 295 matrizes reais quadradas de posto completo, com até 10.000 não zeros, e usa referência float128, semente fixa e registro de falhas de conversão. Mede comportamento numérico, sem medir tempo ou potência.

**Aplicação:** compartilhar matriz, vetor e referência entre formatos; registrar seleção, parâmetros, conversões e falhas antes de agregar erros. Para SpMV, admitir matrizes retangulares e linhas vazias é uma decisão nossa: as restrições de posto e formato quadrado pertencem aos solvers. Não transportar seus filtros sem justificativa nem chamar um teste de SpMV de reprodução dos quatro algoritmos.

## 3. Arnoldi: aplicação diferente, autoria sobreposta

**Hunhold, Quinlan e Wesner — [Numerical Performance of the Implicitly Restarted Arnoldi Method in OFP8, Bfloat16, Posit, and Takum Arithmetics, v1](https://arxiv.org/html/2504.21130v1)**, 29/04/2025. Chave: `hunhold2025arnoldi`. Consultadas seções 2–3; o [registro](https://arxiv.org/abs/2504.21130v1) identifica a publicação relacionada.

O estudo usa matrizes simétricas da SuiteSparse e laplacianos de grafos, com tolerâncias declaradas por largura. Distingue erro numérico, falta de convergência e insuficiência da faixa de representação. Hunhold e Quinlan também assinam o artigo de solvers; portanto, **não se trata de validação por equipe independente**.

**Aplicação:** apresentar distribuições de erro e proporções de sucesso com denominadores explícitos; manter falhas no relatório. SpMV não tem critério de convergência, mas tem resultados não finitos e perdas na conversão que precisam de categorias próprias. Arnoldi fica como motivação de uso futuro, sem entrar no escopo inicial.

## 4. FFT: resultados dependem do problema

**Hunhold e Gustafson — [Spectral Methods via FFTs in Emerging Machine Number Formats: OFP8, Bfloat16, Posit, and Takum Arithmetics, v1](https://arxiv.org/html/2504.21197v1)**, 29/04/2025. Chave: `hunhold2025fft`. Consultadas seções 2.2–2.4 e 3.1–3.4.

A avaliação converte entradas ao formato testado, executa nele as operações e compara as saídas com uma referência comum. No experimento de ida e volta de FFT em imagens, a seção 3.3 relata vantagem de float16/32/64 sobre os formatos de precisão variável correspondentes. Isso impede usar a literatura como demonstração de superioridade universal de Takum. Tempo e potência não são avaliados.

**Aplicação:** incluir magnitudes, sinais e cancelamentos variados, comparar resultados por caso e preservar os desfavoráveis. FFT não é requisito desta implementação. Citar o preprint consultado; os campos editoriais ainda provisórios no manuscrito não bastam para identificar uma publicação definitiva.

## 5. Inteiros: propriedades para verificar o codec

**Hunhold — [Integer Representations in IEEE 754, OFP8, Bfloat16, Posit, and Takum Arithmetics, v2](https://arxiv.org/html/2412.20273v2)**, 25/11/2025. Chave: `hunhold2025integers`. Consultadas proposições 4–5 e tabela da seção 5. O [registro arXiv](https://arxiv.org/abs/2412.20273v2) usa título abreviado, preservado na entrada bibliográfica anterior.

O texto deriva condições de representação exata e os maiores inteiros consecutivos. Para Takum linear, a tabela apresenta T8: 8; T16: 512; T32: 2^24; T64: 2^55.

**Aplicação:** verificar conversão exata no limite, perda de exatidão no inteiro seguinte e simetria de sinais; para T8/T16, enumerar os inteiros do intervalo. Acrescentar potências de dois e vizinhos, pois expõem mudanças de precisão. Esses valores são critérios externos ao round-trip do próprio código. Não confundir a interpretação ordenada dos bits como inteiro com a conversão numérica Takum→inteiro; são funções distintas.

## 6. FP8/SoftFloat: cobertura e políticas explícitas

**Marcelli et al. — [Eight-Bit Vector SoftFloat Extension for the RISC-V Spike Simulator](https://iris.uniroma1.it/retrieve/25e194f9-a5f5-47d8-9f82-a34f321a7121/Marcelli_Eight-bit-vector_2025.pdf)**, *Electronics* 14(19), 3924, 2025; [DOI](https://doi.org/10.3390/electronics14193924). Chave: `marcelli2025fp8spike`. Consultadas seções 3–4 no PDF completo.

A seção 4 descreve cobertura de 256 entradas para operações unárias e 65.536 pares para binárias. A seção 3 separa variantes OCP/IEEE-like e políticas de saturação. Os tempos reportados são de execução no hospedeiro do simulador, não latências de hardware.

**Aplicação:** enumerar todos os códigos e pares T8, guardar contraexemplos e comparar com implementação externa identificada por commit. Validar estado vetorial em testes separados da aritmética escalar. Para FP8, declarar saturação da conversão e da aritmética independentemente: a [OCP OFP8, revisão 1.0](https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1) define intercâmbio e conversões, sem impor toda a política aritmética do experimento. Reutilizamos a estratégia de verificação; Spike permanece fora do escopo.

## 7. Posit vetorizado em 2021: armazenamento e cálculo

**Cococcioni, Rossi, Ruffaldi e Saponara — [Vectorizing posit operations on RISC-V for faster deep neural networks: experiments and comparison with ARM SVE](https://link.springer.com/article/10.1007/s00521-021-05814-0)**, *Neural Computing and Applications* 33, 10575–10585, 2021. Chave: `cococcioni2021vectorizing`. Consultadas seções 4.1 e 5 no HTML completo.

O trabalho divide a operação em preparação, cálculo e recodificação. Nas operações que precisam de backend numérico, converte posit para float32, calcula e converte de volta. A avaliação usa Spike com RVV 0.8; não é referência normativa para RVV 1.0 nem implementação de uma ALU posit nativa completa.

**Aplicação:** registrar formato de armazenamento, intermediários e saída separadamente. Em comparações de SpMV, descrever o custo de conversões e a precisão efetiva do acumulador. A nossa ALU escalar exata em Python fornece uma especificação funcional; usar float32 ocultamente mudaria esse contrato.

## 8. PVU: dot e integração exigem contrato próprio

**Wu et al. — [PVU: A Posit Vector Processor Unit Based on RISC-V Extension for Advanced Floating-Point Computation, v1](https://arxiv.org/pdf/2503.01313v1)**, 03/03/2025. Chave: `wu2025pvu`. Consultadas seções IV–VI. O histórico lista apenas v1. O [registro](https://arxiv.org/abs/2503.01313v1) usa outro título, anotado no BibTeX; adotamos o título efetivo do PDF/HTML.

A unidade em Chisel separa decodificação, cálculo, normalização e codificação. O dot alinha produtos e acumula com largura ampliada antes do arredondamento final. A validação usa dados quantizados de uma camada de ResNet-18 e reporta divergências na divisão; não constitui prova exaustiva da aritmética.

**Aplicação:** especificar todos os pontos de arredondamento do nosso dot e compará-lo com uma soma exata de produtos como diagnóstico. Não denominar o acumulador ampliado de quire/exato sem demonstrar sua capacidade. Encodings e interpretação de máscara do preprint precisam de confronto com a norma; não devem ser copiados como RVV ratificada.

## 9. FAUST: separar unidade e ambiente de verificação

**Kovač et al. — [FAUST: Design and implementation of a pipelined RISC-V vector floating-point unit](https://www.sciencedirect.com/science/article/pii/S014193312300008X)**, *Microprocessors and Microsystems* 97, artigo 104762, 2023. Chave: `kovac2023faust`.

**Acesso parcial:** metadados, resumo e trechos disponibilizados pela editora; confirmação no [registro institucional](https://iris.uniroma1.it/handle/11573/1699648). O PDF desse registro é restrito. Não foi lido o texto integral.

O resumo descreve uma FPU derivada de FPnew para RVV 1.0 e um modelo SoftFloat no ambiente FPU-V de verificação. É evidência da utilidade de manter modelo de referência e implementação sob teste separados.

**Aplicação:** distinguir oráculo numérico, executor das instruções e testes do estado arquitetural. Não inferir detalhes do testbench inacessível nem usar os resultados de silício como estimativas para Python.

## Do estudo à execução: decisões verificáveis

As ações abaixo são escolhas de engenharia deste projeto, motivadas pelas leituras; seu estado de implementação deve ser conferido nos testes e relatórios, não inferido desta nota.

| Parte | Decisão e evidência esperada | Base da decisão |
|---|---|---|
| Codec | Valores exatos, zero/NaR separados, limiares e empate para par; incluir casos com característica truncada | [Codec, §§2 e 5](https://arxiv.org/html/2408.10594v4) |
| ALU | `add/sub/mul` sobre operandos decodificados, arredondamento somente na saída de cada operação; lista de contraexemplos reproduzíveis | [Codec, §3](https://arxiv.org/html/2408.10594v4), [Marcelli, §4](https://doi.org/10.3390/electronics14193924) |
| Dot | Comparar acumulação em 2×SEW com soma exata; definir semente, ordem, largura e destino | [PVU, §IV.E](https://arxiv.org/html/2503.01313v1), [proposta AVX10.2](https://arxiv.org/abs/2503.14067v2) |
| Verificação | Cobertura T8, propriedades de inteiros, comparação externa e testes vetoriais distintos | [Inteiros, §5](https://arxiv.org/html/2412.20273v2), [Marcelli, §4](https://doi.org/10.3390/electronics14193924) |
| SpMV | Entradas comuns, manifesto de matrizes, referência comum, distribuição dos erros e falhas visíveis | [Solvers, §II](https://arxiv.org/pdf/2412.20268v2) |

Para tornar a comparação do dot inequívoca, sejam `Qw` e `Q2w` os quantizadores de cada largura, `aᵢ,bᵢ` entradas já quantizadas em `w`, e `s` a semente em `2w`:

- **Dot ampliado do projeto:** `pᵢ = Q2w(aᵢ × bᵢ)`; `sᵢ₊₁ = Q2w(sᵢ + pᵢ)`, na ordem dos índices ativos. Produtos e somas sofrem arredondamentos separados.
- **Diagnóstico exato:** `Q2w(s + Σ(aᵢ × bᵢ))`, calculando a expressão interior com frações exatas. Essa modalidade arredonda apenas ao final; não descreve o custo de um circuito.

No benchmark, comparar também a referência sobre os dados originais com a referência sobre entradas quantizadas. Assim, a perda de representação não fica confundida com a perda causada pelas operações. Igualar somente a largura de armazenamento não iguala a precisão da acumulação. Essa separação é uma decisão experimental explícita, inspirada na distinção de etapas discutida por [Cococcioni et al., §4.1](https://link.springer.com/article/10.1007/s00521-021-05814-0).

## Correção sobre o estudo AVX10.2

O conjunto de **1.401 matrizes com até 50.000 não zeros** pertence à avaliação de **representação/conversão** da seção II de [Hunhold, AVX10.2, v2](https://arxiv.org/abs/2503.14067v2), chave `hunhold2025avx102`. O procedimento converte a matriz ao formato avaliado e a float128 para medir erro. Não avalia SpMV. Nossa avaliação de SpMV é uma extensão experimental própria e precisa de resultados próprios. O texto extraído foi preservado no workspace da análise, mas não é distribuído neste repositório; consultar a seção II do artigo no link acima.

As fontes sustentam definições, escolhas de teste e comparações delimitadas. Nenhuma delas valida automaticamente as instruções experimentais, o codec Python ou uma alegação de desempenho deste projeto.
