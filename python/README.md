# Takum linear + RVV: simulador funcional em Python

Solução em Python 3.10+, sem dependências externas e **sem Spike**. O foco é desenvolver e validar o projeto; a redação do artigo fica para outra etapa. O projeto C do grupo permanece na raiz do repositório; esta implementação independente fica em `python/`. Veja [a comparação](../README_COMPARACAO.md).

## Executar

Na pasta deste projeto:

```sh
python -m unittest discover -s tests -v
python -m takum_rvv encode 1.1 --bits 8
python -m takum_rvv demo --vector ones
python -m takum_rvv bench caminho/matriz.mtx --vlen 256 --seed 2026 --output results/experimento
python -m takum_rvv bench caminho/matriz.mtx --scaling pow2-bound --output results/escalado
python tools/run_validation.py --output results/minha_validacao
```

No computador desta sessão, o inicializador PowerShell também localiza o Python fornecido pelo aplicativo:

```powershell
.\run.ps1 test
.\run.ps1 encode 1.1 --bits 8
.\run.ps1 demo --vector ones
.\run.ps1 validate --output results/minha_validacao
```

`demo` usa **dois casos sintéticos**. `bench` aceita vários arquivos Matrix Market. A execução gera `results.csv`, `cdf.csv`, `cdf_summary.json`, `manifest.json`, `vectors.json` e uma cópia do modelo em `source.zip`. Reusar a mesma pasta de saída de `bench` substitui seus arquivos; escolher outra pasta preserva a execução anterior. `validate` executa as oito matrizes locais nos dois cenários e exige saída vazia ou nova. Esses comandos não baixam dados.

## Implementado

- Codec e soma/subtração/multiplicação Takum **linear** T8/T16/T32, com T64 para acumulação. Frações exatas nos intermediários, arredondamento para par no código, zero/NaR e saturação definidos.
- 32 registradores, VLEN configurável, SEW 8/16/32, LMUL=1, máscaras, `vl`, `vstart`, cauda e máscara preservadas.
- Cinco instruções experimentais: `vtadd.vv`, `vtsub.vv`, `vtmul.vv`, `vtdot.vv`, `vncvt.t.t`; codificação própria em `custom-0` e executor de palavras de 32 bits.
- Dot em 2×SEW, com multiplicação e soma arredondadas separadamente; semente explícita e continuidade entre blocos. Não é dot fundido ou quire.
- SpMV CSR, carregamento indexado de x, linhas maiores que um registrador e linhas vazias. Leitura decimal exata, simetria, fusão de duplicatas e metadados de limpeza.
- Comparação com E4M3/E5M2 e binary16/32; referência comum em **binary128 em software** (113 bits significativos, expoente de 15 bits). Também há controle com acumulador da mesma largura e diagnóstico exato sobre entradas quantizadas.
- Manifesto com hashes do código e das matrizes, vetor x salvo exatamente, configuração numérica e falhas explícitas. CDF mantém resultados inválidos no denominador e seu resumo mostra formatos sem resultados válidos.
- Controle de escala `pow2-bound`, comum a todos os formatos, com dois expoentes globais e reconstrução exata externa explicitados. A referência continua usando os dados originais; o custo da escala não está nas contagens vetoriais.

## Evidência e limites

Os testes incluem **todos os 256 códigos T8 e 65.536 pares por operação** contra uma tabela gerada pela libtakum, revisão fixada. [Proveniência e reprodução](tests/data/README.md) · [relatório diferencial](docs/evidencias/python_libtakum.json). O simulador e seus testes usuais usam somente Python; a ferramenta C opcional em `tools/` serve para regenerar o oráculo externo.

Na validação ampliada, **68 testes passaram**. A comparação com a libtakum cobre agora todas as decodificações T16 e 10.000 pares por largura T16/T32, nas três operações. Foram preservadas e justificadas matematicamente **128 divergências de multiplicação T32**, causadas por duplo arredondamento no intermediário `double` da biblioteca nos casos dirigidos. [Análise e evidências](docs/evidencias/wide_reference_notes.md).

Binary128 foi comparado a um oráculo GCC `__float128`/libquadmath: 6.017 resultados, dos quais 6.014 iguais em bits e três diferenças de sinal de zero previstas no contrato. [Método e limites](docs/evidencias/binary128_notes.md).

Foram concluídas **112 avaliações SpMV** com [oito matrizes Harwell–Boeing do NIST](data/harwell_boeing/README.md), sete formatos e dois cenários de escala. São sete problemas esparsos e um controle denso, com uma única semente. A escala recuperou os resultados não finitos de FP8/FP16. No cenário escalado, T32 teve menor erro que binary32 em 8/8 casos, mas E4M3 também teve menor erro que T8 em 8/8. [Relatório completo](docs/09_validacao_ampliada.md), [comparação pareada](results/validation_v2/comparison.json) e [contagens de operações/CSRs](docs/10_analise_isa_csrs.md). A [primeira execução](docs/07_validacao_python.md) permanece como registro histórico.

A aritmética T16/T32 foi amostrada; T64 tem testes dirigidos e ainda precisa de um oráculo externo apropriado. O modelo implementa um **subconjunto funcional**: não executa ELF, não simula o processador completo, caches ou ciclos, e não mede área/energia. As contagens cobrem ações vetoriais Takum modeladas; o controle escalar CSR e geração de endereços no hospedeiro estão excluídos. Os comparadores IEEE/FP8 são referências numéricas escalares, sem contagem de instruções comparável.

O backend binário modela aritmética finita e arredondamento; NaN/Inf são falhas não finitas, sem flags IEEE ou propagação de payload. O carregador suporta `coordinate real/integer/pattern`, `general/symmetric`; arquivos simétricos devem fornecer o triângulo inferior. Casos não suportados são rejeitados explicitamente. A variante Takum logarítmica não está implementada.

Não há ainda base para concluir superioridade geral de Takum ou redução de complexidade da ISA. Isso exige um conjunto de experimentos maior e uma definição comparável de custo.

## Referências ligadas às decisões

O formato vem de [Hunhold, 2024](https://arxiv.org/abs/2404.18603v2); o desempate para par segue a [versão 4 do codec, §5.5](https://arxiv.org/html/2408.10594v4). A organização do estado vetorial usa a [RVV 1.0](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html). A estratégia de enumeração de entradas se apoia no precedente FP8 de [Marcelli et al., 2025](https://doi.org/10.3390/electronics14193924). As cinco instruções Takum e a política específica do dot são escolhas deste projeto, sem status de extensão ratificada.

- [Contrato da solução](docs/05_solucao_python.md) e [leituras aplicadas à implementação](docs/06_leituras_para_implementacao.md).
- [Bibliografia BibTeX — 26 fontes entre artigos, normas, software e dados](docs/referencias.bib) e [curadoria inicial](docs/02_bibliografia_comentada.md).
- [Auditoria do material original](docs/01_auditoria.md) e [evidências recebidas](docs/evidencias/README.md).

Definições, algoritmos, bibliotecas e datasets utilizados têm atribuição próxima ao uso. Dados sintéticos e código próprio são identificados como tais. As propostas e o rascunho de artigo anteriores estão preservados em `docs/03*` e `docs/04*`, mas não representam a direção atual.
