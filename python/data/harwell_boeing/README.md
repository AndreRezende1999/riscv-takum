# Oito matrizes reais para verificar a execução

Arquivos obtidos no **NIST Matrix Market**, coleção Harwell–Boeing, em 06/10/2026. Também são catalogados na SuiteSparse; os bytes utilizados aqui vêm do NIST. Cada `.source.json` preserva URLs, autoria informada no acervo e hashes SHA-256.

| Matriz | Dimensões / não zeros expandidos | Origem e aplicação |
|---|---|---|
| `bcsstk01` | 48 × 48 / 400 | John Lewis, Boeing Computer Services; [engenharia estrutural](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/bcsstruc1/bcsstk01.html) |
| `west0067` | 67 × 67 / 294 | Art Westerberg, University of Pittsburgh; [engenharia química](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/chemwest/west0067.html) |
| `bcsstk02` | 66 × 66 / 4.356 | John Lewis, Boeing Computer Services; [engenharia estrutural](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/bcsstruc1/bcsstk02.html); controle denso |
| `west0132` | 132 × 132 / 413 | Art Westerberg, University of Pittsburgh; [engenharia química](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/chemwest/west0132.html) |
| `jpwh_991` | 991 × 991 / 6.027 | J. P. Whelan, Philips Research Laboratories; [circuitos](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/cirphys/jpwh_991.html) |
| `sherman1` | 1.000 × 1.000 / 3.750 | Andy Sherman, Nolan and Associates; [reservatórios de petróleo](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/sherman/sherman1.html) |
| `pores_1` | 30 × 30 / 180 | John Appleyard, Harwell Laboratory; [reservatórios](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/pores/pores_1.html) |
| `well1033` | 1.033 × 320 / 4.732 | Michael Saunders, Stanford University; [mínimos quadrados, topografia](https://math.nist.gov/MatrixMarket/data/Harwell-Boeing/lsq/well1033.html) |

A `bcsstk01` armazena 224 entradas do triângulo inferior; o carregador expande a simetria para 400 não zeros. `bcsstk02` armazena 2.211 entradas e, após expansão, é inteiramente densa: foi mantida como controle, não contada como problema esparso. `west0132` declara 414 entradas, mas uma é zero explícito; o CSR contém 413 não zeros. Essa limpeza consta nos manifestos. Nenhum valor dos arquivos originais foi editado.

São sete problemas esparsos e um controle denso. Os dois primeiros eram pilotos já observados; os seis adicionais foram escolhidos por metadados antes dos novos resultados. Veja o [protocolo](../../docs/08_plano_validacao_ampliada.md) e o [manifesto do conjunto](../validation_set.json). A seleção é de conveniência, **não uma amostra representativa** nem uma reprodução das 1.401 matrizes do estudo de representação AVX10.2 de [Hunhold](https://arxiv.org/abs/2503.14067v2).

```powershell
.\run.ps1 validate --output results/minha_validacao
```

Esse comando usa os oito arquivos locais e executa os cenários sem escala e com `pow2-bound`. Exige saída vazia ou inexistente para preservar resultados anteriores. Os [resultados desta execução](../../results/validation_v2/comparison.json) têm semente 2026 e VLEN=256.

Os endereços originais da SuiteSparse não completaram o download nesta sessão. Por isso, a proveniência registra explicitamente o NIST. Para os seis novos arquivos, `urllib` recebeu HTTP 403; `Invoke-WebRequest` conseguiu baixar os mesmos URLs públicos. O [registro das tentativas](../validation_download_attempts.json) preserva ambos os resultados. `tools/fetch_validation_set.py` valida os arquivos gzip em `tmp/matrices/`, descompacta e registra hashes; a opção `--download` autoriza tentar downloads quando não há cache. Os testes e o benchmark usam os `.mtx` já presentes e não precisam de rede.
