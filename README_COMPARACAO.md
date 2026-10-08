# Comparação entre as implementações C e Python

Esta branch acrescenta uma implementação independente em `python/`, mantendo os arquivos existentes do grupo. A versão C, sua especificação, artigo e slides continuam na raiz. Nenhum arquivo preexistente foi alterado por esta contribuição.

A implementação Python modela Takum **linear** T8/T16/T32, acumulação T64 e um subconjunto funcional vetorial. A divisão dos módulos e os nomes das operações aproveitam a organização do [protótipo do grupo](docs/spec/zvtakum.adoc); o contrato numérico e as referências reutilizadas estão em [python/docs/05_solucao_python.md](python/docs/05_solucao_python.md). Ela permite comparar comportamento e decisões de arquitetura, sem usar a ALU C como backend.

## Executar a versão Python

Python 3.10+ e biblioteca padrão, sem pacotes externos:

```sh
cd python
python -m unittest discover -s tests -v
python -m takum_rvv demo --vector ones
python tools/run_validation.py --output results/minha_validacao
```

No PowerShell, depois de entrar em `python/`:

```powershell
.\run.ps1 test
.\run.ps1 demo --vector ones
.\run.ps1 validate --output results/minha_validacao
```

## Evidências disponíveis

- [Guia da implementação](python/README.md).
- [Relatório numérico](python/docs/09_validacao_ampliada.md): 68 testes e 112 avaliações SpMV, com sete problemas esparsos e um controle denso, sete formatos e dois cenários de escala.
- [Análise de instruções e CSRs](python/docs/10_analise_isa_csrs.md): contadores do modelo e limites da comparação.
- [Leituras aplicadas](python/docs/06_leituras_para_implementacao.md) e [26 referências entre artigos, normas, software e dados](python/docs/referencias.bib).
- [Resultados e parâmetros](python/results/validation_v2/comparison.json), com hashes, vetores e cópia do modelo executado.

As tabelas em `python/docs/01*` e os primeiros diagnósticos em `python/docs/evidencias/` documentam o ZIP recebido e a análise local; não constituem uma auditoria de todas as alterações posteriores da branch principal. Caminhos absolutos nos manifestos identificam o ambiente da execução original. A rotina usual de testes e os novos benchmarks usam os arquivos locais de `python/`.

Para manter a comparação, consultar esta branch ou o pull request em rascunho antes de decidir qualquer integração. Os resultados de C já presentes e os resultados Python ficam identificados separadamente. A avaliação não demonstra superioridade universal de Takum: no cenário escalado, T32 apresentou menor erro que binary32 nos oito problemas, enquanto E4M3 apresentou menor erro que T8 nos mesmos oito.
