# Bibliografia comentada e roteiro de citações

Consulta em 05/10/2026. São **19 fontes** no [BibTeX](referencias.bib), incluindo os dois artigos fornecidos, trabalhos acadêmicos adicionais, normas, dataset e software. A escolha prioriza pertinência e fontes primárias; não é uma revisão sistemática exaustiva nem demonstra inexistência de trabalhos semelhantes.

## Como as fontes foram verificadas

Foram consultados registros arXiv, páginas dos autores/editoras, documentação oficial e repositórios originais. Os PDFs fornecidos foram utilizados para verificar definições e metodologia relevantes. Nas adições, a triagem inclui metadados e resumos; houve consulta adicional ao texto HTML do codec e do PERCIVAL e aos trechos normativos RVV/OFP8. Não se alega leitura integral de todos os artigos adicionais nem reprodução de seus resultados.

Não confundir DOI do preprint com DOI da publicação. Onde os metadados editoriais completos não foram confirmados, o BibTeX cita explicitamente o preprint, incluindo DOI da publicação relacionada em nota quando confirmado no registro original. A paginação de um preprint pode diferir da versão publicada.

## Núcleo do projeto

### 1. Hunhold, 2024 — definição de Takum

[Beating Posits at Their Own Game: Takum Arithmetic](https://doi.org/10.1007/978-3-031-72709-2_1). CoNGA/LNCS 14666, pp. 1–51. PDF fornecido: [arXiv v2](https://arxiv.org/abs/2404.18603v2). Chave: `hunhold2024takum`.

Usar para a codificação, variantes linear/logarítmica, propriedades e arredondamento. Referenciar as definições efetivamente implementadas, não apenas a introdução. A seção 5.6 é a origem da análise de fechamento. Resultados teóricos não demonstram automaticamente vantagem em todo kernel.

### 2. Hunhold, 2025 — integração em ISA SIMD

[Streamlining SIMD ISA Extensions with Takum Arithmetic: A Case Study on Intel AVX10.2](https://doi.org/10.1109/MOCAST65744.2025.11083943). MOCAST 2025, pp. 1–6. [Preprint v2 fornecido](https://arxiv.org/abs/2503.14067v2). Chave: `hunhold2025avx102`.

Usar como origem da avaliação de representação e da discussão de simplificação da ISA. Explicitar quais partes são adaptadas para RVV. Seu estudo de AVX10.2 não valida contagens ou encodings RISC-V. A proposta do grupo deve demonstrar suas próprias métricas.

### 3. Hunhold, 2025 — codec em hardware

[Design and Implementation of a Takum Arithmetic Hardware Codec](https://arxiv.org/abs/2408.10594v4). Preprint iniciado em 2024, v4 de 25/11/2025. Chave: `hunhold2025codec`.

Usar para discutir o caminho de decodificação e possíveis implementações futuras. A v4 tem título e extensão diferentes da referência antiga “in VHDL” encontrada no ZIP; preservar coerência entre versão e título. Avaliação de codec não equivale à avaliação de ALU vetorial completa, nem autoriza atribuir seus números de FPGA ao simulador do grupo.

### 4. Hunhold e Quinlan, 2025 — solvers esparsos

[Evaluation of Bfloat16, Posit, and Takum Arithmetics in Sparse Linear Solvers](https://doi.org/10.1109/ARITH64983.2025.00019). IEEE ARITH 2025; [preprint v2](https://arxiv.org/abs/2412.20268v2). Chave: `hunhold2025solvers`.

É uma das adições mais relevantes: avalia LU, QR, GMRES e estratégias de precisão mista com matrizes reais. Usar para justificar a escolha de álgebra linear esparsa e métricas de comportamento numérico. O SpMV do grupo é um kernel; não deve ser descrito como reprodução de um solver completo.

### 5. Hunhold, Quinlan e Wesner, 2025 — Arnoldi

[Numerical Performance of the Implicitly Restarted Arnoldi Method in OFP8, Bfloat16, Posit, and Takum Arithmetics](https://arxiv.org/abs/2504.21130v1). Registro liga à [publicação DOI 10.1145/3712285.3759837](https://doi.org/10.1145/3712285.3759837). Chave: `hunhold2025arnoldi`.

Usar para relacionar operações esparsas a um algoritmo aplicado de autovalores, com SuiteSparse e Network Repository. Citar como evidência do estudo dos autores, preservando workloads e condições. É contexto, não requisito de implementar Arnoldi nesta atividade.

### 6. Hunhold e Gustafson, 2025 — FFT

[Spectral Methods via FFTs in Emerging Machine Number Formats: OFP8, Bfloat16, Posit, and Takum Arithmetics](https://arxiv.org/abs/2504.21197v1). Preprint. Chave: `hunhold2025fft`.

Amplia a revisão para processamento de sinais e métodos espectrais. Ajuda a mostrar que a avaliação depende da aplicação. Prioridade secundária no artigo de seis páginas; incluir apenas se apoiar uma comparação concreta. Não apresentar esse preprint como artigo de periódico sem confirmação.

### 7. Hunhold, 2025 — representação de inteiros

[Integer Representations in IEEE 754, Posit, and Takum Arithmetics](https://arxiv.org/abs/2412.20273v2). Preprint iniciado em 2024, revisado em 2025. Chave: `hunhold2025integers`.

Usar se o trabalho discutir cobertura exata de inteiros ou conversões numéricas. Não confundir ordenação dos padrões binários com conversão do valor Takum para inteiro. Não tratar este texto como evidência de desempenho da ISA.

## Comparadores que fortalecem a análise

### 8. Gustafson e Yonemoto, 2017 — posits

[Beating Floating Point at its Own Game: Posit Arithmetic](https://doi.org/10.14529/jsfi170206). Supercomputing Frontiers and Innovations, 4(2), 71–86. Chave: `gustafson2017posit`.

Fonte histórica para a alternativa posit e precisão variável. Para experimentos, declarar também versão do padrão e parametrização realmente usadas pela biblioteca. Não assumir que todas as versões de posit8, por exemplo, têm a mesma configuração.

### 9. Mallasén et al., 2022 — PERCIVAL

[PERCIVAL: Open-Source Posit RISC-V Core with Quire Capability](https://arxiv.org/abs/2111.15286v3). Preprint revisado; [publicação IEEE TETC](https://doi.org/10.1109/TETC.2022.3187199). Chave: `mallasen2022percival`.

Antecedente diretamente ligado a formatos alternativos em RISC-V, com integração de instruções e acumulador quire. Usar na comparação de contribuições e para motivar o controle do acumulador. O grupo tem simulação funcional de um subconjunto vetorial; não realizou a síntese de hardware ou a integração LLVM desse trabalho.

### 10. Mach et al., 2020 — FPnew

[FPnew: An Open-Source Multi-Format Floating-Point Unit Architecture for Energy-Proportional Transprecision Computing](https://arxiv.org/abs/2007.01530v1). Versão consultada: preprint. Chave: `mach2020fpnew`.

Contraponto necessário à tese de que unificar formatos é a única solução: estuda suporte eficiente a múltiplos formatos e integração em RISC-V. Distinguir custos medidos em hardware no trabalho original das métricas funcionais deste projeto. A revisão não deve apenas selecionar trabalhos favoráveis a Takum.

### 11. Micikevicius et al., 2022 — FP8 em aprendizado profundo

[FP8 Formats for Deep Learning](https://arxiv.org/abs/2209.05433v2). Preprint. Chave: `micikevicius2022fp8`.

Usar para contextualizar E4M3/E5M2 e aplicações de aprendizado profundo. Esses formatos devem ser avaliados com políticas de escala e acumulação explícitas. Um resultado desfavorável de FP8 em SpMV sem escala não invalida seus resultados em redes neurais.

## Normas, dados e instrumentos de pesquisa

### 12. IEEE 754-2019

[IEEE Standard for Floating-Point Arithmetic](https://standards.ieee.org/ieee/754/6210/). Chave: `ieee754`. Registro editorial consultado; não foi obtido o texto integral pago.

Referência normativa para binary16/32/128. OFP8 e bfloat16 precisam de suas próprias referências. Evitar chamar E4M3/E5M2 de formatos padronizados pela IEEE 754.

### 13. Open Compute Project, 2023 — OFP8

[OCP 8-bit Floating Point Specification, revisão 1.0](https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1), com correção datada de 01/12/2023. Chave: `ocp2023ofp8`.

Usar para códigos, extremos, valores especiais e conversões FP8. Declarar SAT/NONSAT e o arredondamento empregado. A comparação deve registrar eventos de saturação e resultados não finitos separadamente.

### 14. RISC-V International — RVV 1.0

[V Standard Extension for Vector Operations](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html), manual release 20260120. Chave: `riscv2026vector`.

Base normativa do subconjunto vetorial. Fixar a revisão citada. O nome Zvtakum no projeto não comprova padronização ou ratificação da proposta.

### 15. Davis e Hu, 2011 — SuiteSparse

[The University of Florida Sparse Matrix Collection](https://doi.org/10.1145/2049662.2049663). ACM TOMS 38(1), artigo 1, 25 páginas. [Orientação oficial de citação](https://sparse.tamu.edu/about). Chave: `davis2011suitesparse`.

Citar em metodologia, legendas e manifesto de dados. A coleção é atualmente chamada SuiteSparse. Registrar grupo, nome, URL, dimensões, nnz e hash de cada arquivo. A citação geral não substitui a identificação das matrizes efetivamente avaliadas.

### 16. Fousse et al., 2007 — MPFR

[MPFR: A Multiple-Precision Binary Floating-Point Library with Correct Rounding](https://doi.org/10.1145/1236463.1236468). ACM TOMS 33(2), artigo 13. [Manual oficial consultado](https://www.mpfr.org/mpfr-current/mpfr.html). Chave: `fousse2007mpfr`.

Usar se a referência/oráculo empregar MPFR. Documentar precisão, faixa e modo de arredondamento. É uma ferramenta para a validação; não uma garantia automática da correção do código que a utiliza.

### 17. Hunhold — libtakum

[Repositório oficial](https://github.com/takum-arithmetic/libtakum). Chave: `libtakum`.

Referenciar na arquitetura, nas operações delegadas e nas instruções de reprodução; preservar licença e atribuição. O commit que gerou os CSVs não foi recuperado. A declaração v2.0.0 do README é evidência documental do grupo, não confirmação da versão efetivamente executada.

### 18. Hunhold — libposit

[Repositório oficial](https://github.com/takum-arithmetic/libposit). Chave: `libposit`.

Referenciar como implementação do comparador posit e registrar commit/configuração. Não atribuir ao grupo sua aritmética. O conteúdo desse submódulo também está ausente no ZIP.

### 19. Google Cloud — bfloat16

[Improve your model's performance with bfloat16](https://docs.cloud.google.com/tpu/docs/bfloat16). Documentação oficial consultada em 05/10/2026. Chave: `google2026bfloat16`.

Usar para contextualizar o formato e o caso de acumulação em FP32. As regras descritas para TPU, inclusive subnormais, são específicas dessa plataforma; não transportá-las silenciosamente para o baseline RVV.

## Pendência do catálogo original

O ZIP cita MuFoLAB v1.2.0, de Hunhold e Quinlan, DOI `10.5281/zenodo.15001855`. Essa identificação também aparece nas referências do PDF AVX10.2 fornecido. O registro Zenodo não pôde ser aberto nesta consulta; por isso não foi incluído como metadado independentemente verificado no novo BibTeX. Manter a atribuição existente e verificar o registro antes de reutilizar seu pipeline ou publicar a referência final.

## Onde citar no artigo e no código

| Conteúdo utilizado | Fonte a associar |
|---|---|
| Definição e equações do formato | `hunhold2024takum` e versão específica |
| Figura adaptada dos campos | Mesma fonte na legenda: “Adapted from...” |
| Metodologia inspirada em AVX10.2 | `hunhold2025avx102`, declarando as alterações |
| Trabalhos relacionados RISC-V | `mallasen2022percival`, `mach2020fpnew` |
| Relevância dos kernels esparsos | `hunhold2025solvers`, opcionalmente `hunhold2025arnoldi` |
| Semântica vetorial e codificação de instruções | `riscv2026vector` e inventário versionado a recuperar |
| Baselines numéricos | `ieee754`, `ocp2023ofp8`, `micikevicius2022fp8` e fonte bf16 adequada |
| Dados experimentais | `davis2011suitesparse`, manifesto das matrizes |
| Operações delegadas a bibliotecas | `libtakum`, `libposit`, commit e licença |
| Oráculo multiprecisão | `fousse2007mpfr`, configuração |
| Número obtido pelo grupo | CSV próprio + configuração + script; citação externa apenas para o método herdado |

Para seis páginas, priorizar as referências efetivamente utilizadas. Bibliografia extensa sem relação com o texto não torna o trabalho mais robusto.
