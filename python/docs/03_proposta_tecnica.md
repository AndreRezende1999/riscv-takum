# Proposta para concluir o projeto com evidências reproduzíveis

> Documento histórico. A usuária escolheu solução em Python, sem Spike, com artigo somente depois da implementação. A direção atual está em [05_solucao_python.md](05_solucao_python.md).

Status: proposta para revisão; implementação desta revisão ainda não iniciada. Data: 05/10/2026.

## Resultado pretendido

Concluir o projeto AOC a partir do trabalho do grupo, com código verificável, experimentos reproduzíveis, artigo IEEE em inglês de até seis páginas e apresentação de quinze minutos. Preservar atribuições e distinguir resultados próprios de resultados publicados. A possibilidade de publicação informada pela usuária motiva o rigor, mas não é garantia de aceitação.

**Hipótese de trabalho:** um subconjunto RVV com operações Takum permite estudar o compromisso entre alcance, precisão e custo de instruções em SpMV. A vantagem deve ser medida em condições declaradas; um resultado neutro ou desfavorável também é cientificamente válido. A motivação vem de [Hunhold, 2025](https://doi.org/10.1109/MOCAST65744.2025.11083943), e o formato de [Hunhold, 2024](https://doi.org/10.1007/978-3-031-72709-2_1).

## Rotas consideradas

| Rota | Entrega | Vantagem | Custo e limite |
|---|---|---|---|
| **A. Consolidar o simulador existente — recomendada** | Corrigir semântica, fixar bibliotecas, melhorar referências e experimentos | Aproveita o material e concentra esforço na qualidade da evidência | Não permite alegar área, energia ou ciclos reais de hardware |
| B. Implementar ALU própria além do simulador | Aritmética própria comparada a um oráculo independente | Aumenta a contribuição didática e a independência da validação | Arredondamento e variante logarítmica exigem trabalho adicional considerável |
| C. Acrescentar RTL e síntese | Codec/ALU em HDL com recursos e temporização | Permite avaliar implementação física | Novo subsistema, ferramentas e validação; o prazo parcial está próximo |

A rota A é a proposta principal. A aceitação de C11 e do uso de libtakum como backend da ALU deve ser confirmada com o docente, pois o documento cita C++/Python e “implementar” as operações. Se a exigência for aritmética própria, a rota B torna-se necessária. Não iniciar RTL apenas para aumentar o escopo.

## 1. Arquitetura e limites

Preservar a organização existente: representação (`takum_codec`), backend aritmético (`takum_alu`), estado vetorial (`rvv_state`), execução (`rvv_insns`), assembler e benchmarks. A separação já permite validar cada camada.

- Fixar a versão semântica das duas variantes, denominadas explicitamente Takum linear e Takum logarítmico nos gráficos e no artigo.
- Declarar quais funções são próprias e quais delegam a [libtakum](https://github.com/takum-arithmetic/libtakum). Recuperar commits das bibliotecas; um novo experimento pode usar uma versão escolhida e fixada, mas não atribuí-la retroativamente aos resultados antigos.
- Corrigir os casos confirmados na auditoria. Revisar também limites de registradores, LMUL/EMUL, sobreposição, validação de SEW/VLEN, endereços e instruções ilegais. Implementar ou rejeitar explicitamente casos fora do subconjunto.
- Manter cinco operações experimentais como escopo mínimo: `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv` e `vncvt.t.t`.
- Definir `vtdot` como produto e acumulação sequenciais com arredondamento a cada operação na largura ampliada, se essa continuar sendo a política do código. Não denominá-lo produto exato, fused dot ou quire. O [PERCIVAL](https://arxiv.org/abs/2111.15286v3) ajuda a distinguir essas alternativas.
- Selecionar um encoding experimental consistente e verificar conflitos em inventário fixado. Usar “Zvtakum” como nome da proposta acadêmica, sem anunciar extensão oficial.

## 2. Validação por camadas

| Camada | Critério de aceitação |
|---|---|
| Codec | Decodificação de todos os 256 padrões T8; valores especiais; zero-extension; fronteiras de regime; monotonicidade e sinais |
| Arredondamento | Casos de empate e vizinhança construídos, para a regra escolhida; distinção explícita entre domínio linear e logarítmico |
| ALU | Casos especiais e pares T8; oráculo independente para resultados de referência; T16/T32 amostrados com sementes e fronteiras dirigidas |
| RVV | Casos de `vl`, `vstart`, máscaras e reduções identificados na auditoria; asserções do estado antes/depois; exemplos de registradores válidos e inválidos |
| ISA experimental | Montagem/desmontagem e execução de cada instrução, incluindo conversão e acumulador |
| FP8/FP16/FP32 | Vetores normativos de extremos, subnormais, empates e especiais; modos de saturação identificados |
| Pipeline de dados | Manifesto completo, ausência de perda silenciosa de matrizes, falha explícita quando dados/bibliotecas faltarem |

Um teste que chama a mesma biblioteca nos dois lados apenas confirma integração. Não serve sozinho como demonstração independente de arredondamento correto.

## 3. Desenho dos experimentos

### Conjunto de entrada

Usar um conjunto identificado de matrizes reais de [SuiteSparse](https://sparse.tamu.edu/about), além de casos sintéticos de controle. Preservar a primeira seleção de 100 matrizes se for recuperável; caso contrário, criar uma nova seleção, com manifesto e nova identificação de experimento.

Registrar grupo/nome, URL, SHA-256, dimensões, nnz, tipo real/complexo/pattern, simetria, duplicatas, zeros explícitos e critério de inclusão/exclusão. Não chamar uma amostra de “representativa” sem definir a população e a seleção. Manter fora do experimento formatos de arquivo não suportados, com justificativa registrada.

O SpMV real deverá usar acesso indexado à memória ou carregamento explícito de x por bloco, com contagem definida. O `vrgather` atual requer x residente em registradores e limita o tamanho das demonstrações. A extensão de acesso deve ter seu escopo documentado.

### Referência comum e decomposição do erro

Para cada matriz A e vetor x, definir uma única referência `y* = A x` em binary128. Declarar se A e x representam os números decimais dos arquivos ou os valores binary64 do carregador. Usar verificação multiprecisão adicional para quantificar a sensibilidade do oráculo. A configuração será documentada segundo [IEEE 754](https://standards.ieee.org/ieee/754/6210/) e, se utilizado, [MPFR](https://www.mpfr.org/mpfr-current/mpfr.html).

Para o formato F, seja `Q_F` a quantização e `y_F^in = Q_F(A) Q_F(x)` calculado em alta precisão. Reportar:

1. **Erro de representação:** `||Q_F(A)-A||_F / ||A||_F` e erro de x.
2. **Erro total de SpMV:** `||y_F-y*||_2 / ||y*||_2` — comparação principal, com alvo comum.
3. **Erro aritmético sobre entradas quantizadas:** `||y_F-y_F^in||_2 / ||y_F^in||_2` — diagnóstico separado.
4. **Efeito da quantização de entrada:** `||y_F^in-y*||_2 / ||y*||_2`.

Essas normas não são parcelas que possam ser simplesmente somadas como uma identidade. Se o denominador for zero, reportar norma absoluta e marcar o caso; não inventar divisão por epsilon. Saídas NaR/NaN/Inf constituem resultados não finitos e devem ser contadas separadamente.

### Formatos e acumuladores

Comparação mínima: T8/T16/T32, nas variantes declaradas, versus E4M3/E5M2, binary16 e binary32. bfloat16 e posit podem enriquecer a avaliação, desde que caibam no prazo e tenham semântica e biblioteca identificadas.

Incluir dois painéis de acumulação:

- **Política da arquitetura proposta:** Takum n→2n e as políticas explicitamente escolhidas para os comparadores.
- **Controle do acumulador:** acumulação comum em alta precisão sobre operandos quantizados e saída arredondada, além de alternativas ampliadas dos baselines quando suportadas. Esse painel isola a representação de parte dos efeitos da ALU.

Indicar escala e arredondamento. Para FP8, incluir política sem escala e uma política de escala determinística documentada se o objetivo incluir aplicações de aprendizado de máquina. Resultados de redes neurais como os de [Micikevicius et al.](https://arxiv.org/abs/2209.05433v2) não justificam transportar uma configuração sem declarar suas diferenças.

Não é obrigatório treinar uma rede grande. Um produto escalar ou uma camada linear pequena pode servir como kernel adicional, desde que não seja apresentado como avaliação de qualidade de um modelo completo.

### Contagens e estatística

Medir separadamente operações vetoriais, configurações, cargas, stores, conversões, controle escalar modelado e bytes transferidos. Tudo que for feito pelo hospedeiro deve ser igualmente excluído nos dois caminhos e indicado no nome da métrica, ou movido para a sequência simulada.

Publicar distribuição empírica por matriz, tamanho da amostra e taxa de falhas. Comparações pareadas devem usar as mesmas matrizes e vetores. Não renormalizar silenciosamente curvas após remover não finitos. Documentar regra de percentil, contagens de saturação e variações com VLEN/comprimento das linhas. Para experimentos estocásticos, registrar sementes e incerteza; para enumeração exaustiva, não chamar diferenças de ruído amostral.

## 4. Organização do artigo e da apresentação

Título de trabalho: **“A Reproducible Functional Evaluation of Takum Arithmetic in a RISC-V Vector Subset”**. O título evita prometer implementação física ou vantagem universal.

Distribuição sugerida das seis páginas: introdução e trabalhos relacionados (1–1,25), arquitetura/método (1,5–2), experimentos/resultados/discussão (1,5–2), conclusão e referências (restante). Ajustar pela versão compilada, sem reduzir ilegivelmente a fonte. O texto preliminar está em [04_texto_preliminar_artigo.md](04_texto_preliminar_artigo.md).

Resultados do grupo entram somente após regeneração dos dados. Toda tabela/figura adaptada deve indicar a fonte na legenda. Uma figura própria de resultados deve indicar dataset, configuração e script. Autores e filiação devem ser fornecidos pelo grupo.

Apresentação: problema e motivação (2 min), formato e arquitetura (4), método e resultados (4), demonstração (3), limites e conclusão (2). Esse é um roteiro a ensaiar, não um tempo já verificado.

## 5. Ordem recomendada até a entrega

| Marco | Entrega verificável |
|---|---|
| Base para a parcial de 11/10/2026 | Dependências fixadas, codec/ALU com atribuição, testes relevantes executados e demonstração mínima |
| Correção funcional | Falhas confirmadas resolvidas, regressões e especificação coerente |
| Avaliação | Referência binary128, manifesto, baselines, erros totais e contagens comparáveis |
| Redação | Artigo com citações verificadas e números gerados automaticamente dos dados |
| Preparação final | PDF até seis páginas, slides, demo reexecutada em ambiente limpo e roteiro ensaiado |

A data da segunda prova, o repositório original, a divisão de tarefas e os nomes de autores ainda precisam ser informados. Não foi estimado um prazo de implementação sem essas informações.

## Decisões para revisão

Recomendação: adotar a rota A, preservar ambas as variantes já existentes e tratar a avaliação com referência comum e controle do acumulador como a contribuição central. Se o docente exigir ALU própria, acrescentar a rota B antes da conclusão da primeira fase. Depois de aprovada a direção, detalhar tarefas de implementação, executá-las e só então substituir as conclusões do artigo e dos slides.
