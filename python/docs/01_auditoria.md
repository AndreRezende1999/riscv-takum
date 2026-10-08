# Auditoria técnica e científica do material do grupo

Data: 05/10/2026. Escopo: ZIP recebido, três PDFs fornecidos, inspeção do código, diagnóstico localizado em C e conferência dos dados tabulares. Esta é uma revisão inicial fundamentada; não é certificação completa do simulador.

## 1. Conclusão

O grupo já tem um protótipo substancial: codec, interface para ALU, simulador funcional, testes, benchmarks, especificação, artigo e slides. Entretanto, **as conclusões de superioridade e simplificação ainda não estão suficientemente demonstradas**. Há falhas reproduzidas em casos de fronteira, diferenças de semântica RVV e comparações experimentais que misturam efeitos do formato com efeitos do acumulador.

O artigo recebido tem 3 páginas; os slides, 13. A estrutura e o limite de páginas do artigo são compatíveis com a atividade, mas isso não resolve as lacunas científicas. A autoria ainda está indicada apenas como grupo.

## 2. Origem das exigências

As exigências abaixo foram extraídas de `C:/Users/Isadora/Downloads/ProjectGuidelinesAOC.pdf`, pp. 1–4. São requisitos da atividade apresentados no documento, não autorizações para publicar, enviar mensagens ou submeter material.

| Exigência | Evidência recebida | Estado e ação necessária |
|---|---|---|
| Codec S/D/R/C/F; T8/T16/T32 | `src/takum_codec.c` | Há decodificação própria; conversões usam libtakum. Verificar cada variante contra a definição e o arredondamento adotado. |
| Adição, subtração e multiplicação | `src/takum_alu.c` | São chamadas à libtakum. Atribuir a biblioteca e confirmar se a integração satisfaz a expectativa didática de implementação da ALU. |
| Cinco instruções propostas | `src/rvv_insns.c`, especificação | Implementadas no protótipo, com divergências documentais e casos RVV incorretos. |
| SpMV e comparação FP8/FP16/FP32 | `bench/spmv.c`, `bench/convert_formats.c` | SpMV compara apenas FP32; FP8/FP16 aparecem na conversão de matrizes. Conversão não substitui avaliação aritmética do kernel. |
| Referência Float128 | Benchmarks usam `long double` | Não atende à exigência tal como escrita. Medir características do tipo e usar binary128 explicitamente. |
| Distribuição do erro acumulado | CSVs e gráficos de conversão | Há distribuição do erro de representação; faltam distribuições de SpMV sobre conjunto real de matrizes e referência comum. |
| Instruções e CSRs | Contadores no simulador | A contagem exclui trabalho feito diretamente pelo programa C hospedeiro; definir e aplicar o mesmo perímetro aos dois kernels. |
| Artigo em inglês, até 6 páginas | `paper/main.tex`, `paper/main.pdf` | Presente; reescrever resultados após validação. |
| Apresentação de 15 minutos com demonstração | `slides/` e exemplos | Presente; ensaio e demonstração ainda não verificados nesta revisão. |
| Repositório versionado | ZIP com `.gitmodules` | O ZIP não contém histórico nem conteúdo dos submódulos. É necessário recuperar versões exatas. |

O objetivo 2 cita simuladores em C++/Python, enquanto a implementação é C11. Isso é uma diferença a esclarecer com o docente, não uma conclusão de reprovação. A modalidade aceita simulador funcional; não é necessário presumir obrigação de FPGA. A publicação é uma possibilidade informada pela usuária, sem periódico ou regulamento de seleção fornecido.

## 3. Falhas confirmadas por diagnóstico localizado

Foram compiladas cópias literais de funções do projeto, ligadas ao `src/rvv_state.c` original. Não foram alterados os fontes do grupo. A saída completa e as limitações do diagnóstico estão em [evidências](evidencias/README.md).

### A01. Conversão E4M3 rejeita o maior valor finito

Em `bench/convert_formats.c:98`, a condição `ax >= 448.0L` produz NaN. O teste retornou `0x7f` para +448 e `0xff` para -448; os códigos finitos esperados são `0x7e` e `0xfe`. O valor máximo e o comportamento de conversão são definidos no [OFP8, tabelas 2–3 e seção 5.2](https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1).

**Impacto:** algumas entradas representáveis são contabilizadas como não finitas. Além dos extremos, testar valores entre 448 e o limiar de arredondamento. Não basta trocar `>=` por `>`: a decisão de overflow deve considerar o valor após arredondamento e o modo de saturação escolhido.

### A02. `vsetvli` inverte os casos com `rs1=x0`

Em `src/rvv_state.c:99`, começando com `vl=3` e VLMAX=8, `rd=x0` produz 8, quando deveria conservar 3; `rd=x1` conserva 3, quando deveria produzir 8. A [RVV 1.0, tabela 8](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html) define esses casos. O diagnóstico confirmou ambos.

### A03. Redução mascarada pode perder o resultado

Em `src/rvv_insns.c`, `fredusum` condiciona a escrita final à máscara do elemento zero. Com somente o elemento 1 ativo, de valor 3, o destino permaneceu em 100. A máscara seleciona os elementos de entrada da redução; não deve suprimir a escrita do resultado escalar por `mask[0]=0`. Ver [RVV 1.0, seção 30.1.14](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html).

O mesmo padrão aparece em `zt_dot`; ali a consequência foi identificada por inspeção, sem execução da aritmética Takum neste diagnóstico. Também falta receber o acumulador inicial `vs1[0]` no modelo de `vfredusum.vs`, cuja função atual inicia sempre em zero.

### A04. Casos `vl=0` e `vstart` não preservam o estado esperado

Com `vl=0` e tail agnostic, `fp_binop` alterou o destino de `0x42c80000` para `0xffffffff`. Com `vstart=1`, alterou o elemento 0 de 100 para 6. As regras de elementos anteriores a `vstart` e de ausência de atualização sem elementos de corpo estão na [RVV 1.0, seção 30.1.5.4](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html). Auditar também cargas, stores, operações Takum e permutações.

**Limite dos testes:** são sete observações de falha cobrindo quatro grupos acima; não equivalem à execução de `make test` nem demonstram o comportamento de todas as instruções.

## 4. Problemas da avaliação experimental

### A05. A referência do SpMV depende do formato avaliado

`ref_spmv`, em `bench/spmv.c:142`, primeiro arredonda A e x ao formato em teste. Assim, cada curva tem seu próprio alvo. Isso pode medir erro aritmético sobre entradas quantizadas, mas não mede o erro total em relação ao mesmo problema original.

A afirmação de que T32 é cerca de 15 vezes mais preciso mistura ainda acumuladores diferentes: o caminho Takum amplia para T64 e o caminho FP32 acumula em FP32. O papel do acumulador é relevante também no [PERCIVAL](https://arxiv.org/abs/2111.15286v3); seus resultados não podem ser transferidos para este protótipo.

**Proposta:** separar erro de entrada, erro aritmético e erro total; publicar a largura do acumulador e incluir controles com políticas comparáveis. A metodologia proposta está em [03_proposta_tecnica.md](03_proposta_tecnica.md).

### A06. `long double` não comprova referência Float128

O comentário de `bench/convert_formats.c` assume 80 bits, e o artigo admite essa troca. A precisão real de `long double` depende da plataforma. Registrar `LDBL_MANT_DIG`, tamanho e faixa; usar referência binary128 e uma verificação adicional em precisão maior. O [IEEE 754-2019](https://standards.ieee.org/ieee/754/6210/) é a referência normativa; [MPFR](https://www.mpfr.org/mpfr-current/mpfr.html) é uma alternativa para controle explícito de precisão e arredondamento. Usar MPFR com 113 bits de significando, isoladamente, não emula automaticamente todos os limites e subnormais de binary128.

O leitor Matrix Market converte primeiro com `%lf`; logo, o baseline preserva entradas binary64. Se essa for a semântica do dataset, declará-la. Se a referência for o valor decimal do arquivo, ler diretamente para a referência de maior precisão.

### A07. Instruções e tráfego CSR têm perímetros diferentes

No caminho FP32, `acc += ...` e a escrita do resultado na memória são executados pelo C hospedeiro (`bench/spmv.c:322` e seguintes). No caminho Takum, estreitamento e store passam pelo simulador. Chamadas diretas a `rvv_vsetvli` incrementam `csr_writes`, mas não `insn_count`. Inicializações e controle dos loops também estão fora da ISA simulada.

Os CSVs recebidos registram, no caso `rand`, **161 instruções/33 escritas CSR em FP32 e 193/65 em Takum**. No caso `lap2d`, são **126/26 e 151/51**. Esses números descrevem o perímetro atual, mas não comprovam redução de instruções ou de CSR. O contador `csr_writes` representa eventos modelados de configuração; não é automaticamente o número de escritas físicas a todos os CSRs.

### A08. “96 instruções viram oito” não demonstra equivalência

O artigo compara formas de instruções de um conjunto mais amplo com poucas operações/famílias propostas. Divisão, raiz, min/max, FMA, formas escalares e conversões não têm todas implementação equivalente. A própria descrição “cinco + par de conversão + par divisão/raiz” soma nove operações quando os pares são separados. A tabela de inventário de `docs/rvv-restructuring.md` também mistura categorias sobrepostas.

**Conclusão admissível agora:** existem cinco instruções experimentais implementadas. Uma medida de redução exige inventário versionado, regra uniforme de contagem e cobertura semântica equivalente. O estudo [AVX10.2 de Hunhold](https://doi.org/10.1109/MOCAST65744.2025.11083943) fornece a motivação, não uma prova automática para RVV.

### A09. “Fechamento exato” usa tolerância e explicação incorreta

`bench/closure.c:109` aceita erro relativo de até `1e-15` como exato. Isso é um critério aproximado. Para T8, todos os pares do domínio escolhido são enumerados: uma diferença para a literatura não pode ser atribuída a erro amostral desse conjunto. Em T16, as operações unárias também são enumeradas, embora o CSV as rotule como amostradas. Há filtros diferentes entre operações.

Comparar domínio, inclusão de zero, arredondamento e denominadores com a seção 5.6 de [Hunhold, arXiv:2404.18603v2](https://arxiv.org/abs/2404.18603v2). Retirar a afirmação de reprodução exata até resolver essas diferenças.

### A10. Distribuições e resumos precisam explicitar condicionamento

`scripts/analyze.py` remove os resultados não finitos antes de desenhar cada curva. Isso mostra a distribuição **condicionada aos casos finitos**, com tamanhos diferentes: E4M3 usa 73/100 e Takum usa 100/100. Além disso, o arquivo ordenado e o gráfico calculam o percentual usando denominadores diferentes. O gráfico ordenado pode ser usado, desde que sua definição e a taxa de falhas estejam claras.

O método `percentile` escolhe um elemento pelo índice arredondado; a “mediana” de n par não é a média dos dois valores centrais. A conferência reproduziu os resumos existentes sob essa convenção. Não se deve acusar divergência dos CSVs apenas porque `statistics.median` produz outro número.

Há, contudo, erro textual: entre os formatos de 32 bits, o `summary.txt` registra mediana por índice de aproximadamente **1,038e-9 em posit32 e 1,106e-9 em Takum linear32**. Portanto, Takum não tem a menor mediana entre todos os formatos de 32 bits nessa tabela. A comparação favorável com FP32 é uma observação restrita a esse conjunto e a essa métrica.

### A11. NaR é convertido artificialmente em erro finito

Em `bench/spmv.c:250`, um resultado NaR adiciona `yref²` ao erro, como se a saída fosse zero. Isso pode ocultar falha numérica. Registrar NaR/NaN/Inf separadamente; uma falha não deve entrar como uma aproximação finita comum.

## 5. Especificação, dependências e originalidade

- `docs/spec/zvtakum.adoc:130` diz que `vs1` é reservado em `vtdot`, mas a operação e o código usam `vs1` como segundo vetor. A descrição do destino como grupo de dois registradores precisa ser conciliada com a redução escalar em `vd[0]`.
- O documento fixa o bit 25 em zero, enquanto os encoders e exemplos usam esse bit como `vm`. Resolver em uma única especificação executável.
- O nome “Zvtakum” é a proposta da atividade; não há evidência neste material de extensão ratificada. A alegação de “único funct6 livre” exige checagem contra uma revisão específica do inventário. Não anunciar compatibilidade binária geral.
- `third_party/libtakum` e `third_party/libposit` estão vazios no ZIP. `.gitmodules` indica URLs, mas não fixa commits. O README cita v2.0.0 sem que o arquivo recebido permita confirmar o commit usado nos resultados. Preservar atribuição a [libtakum](https://github.com/takum-arithmetic/libtakum) e [libposit](https://github.com/takum-arithmetic/libposit).
- `bench/matrices` não contém matrizes nem manifesto. O CSV tem 100 nomes únicos; isso não reconstrói a seleção original com hashes e grupos. Citar o dataset [SuiteSparse](https://sparse.tamu.edu/about) e os metadados específicos de cada matriz.
- Os testes da ALU verificam propriedades e limites de erro, mas `neighbor_bound` pode admitir aproximadamente uma distância de vizinhos. Passar nesses testes não prova arredondamento correto bit a bit em todos os casos.

## 6. O que foi e o que não foi verificado

**Verificado nesta sessão:** requisitos dos PDFs; estrutura do ZIP; leitura dos módulos centrais; comparação normativa localizada; sete observações diagnósticas compiladas em GCC no Ubuntu/WSL; 100 linhas distintas no CSV de conversão; 14 configurações no CSV SpMV; resumos regenerados com a convenção do script original; referências listadas no catálogo.

**Pendente:** recuperar bibliotecas/commits e datasets; compilar e executar a suíte completa; corrigir os problemas; rodar novos benchmarks com Float128; validar a ISA inteira do subconjunto; compilar uma versão revisada do artigo; ensaiar a apresentação. Não foram medidos área, energia, frequência, ciclos de hardware ou desempenho em processador RISC-V físico.
