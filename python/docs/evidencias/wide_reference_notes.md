# Validação diferencial ampliada: T16/T32

Executada em 06/10/2026. Exportador C ligado à [libtakum 2.0.0, commit 776ac0ca7855f640100731ed8bbb0c7cf83b2d94](https://github.com/takum-arithmetic/libtakum/tree/776ac0ca7855f640100731ed8bbb0c7cf83b2d94). O exportador não usa o codec Python para construir os resultados. O C é exclusivamente uma ferramenta de geração de testes offline; não há integração com Spike.

Artefatos: [dados gzip](../../tests/data/libtakum_wide.tsv.gz), [proveniência e divergências revisadas](../../tests/data/libtakum_wide.json), [método de amostragem](../../tests/data/libtakum_wide.md) e [relatório completo](python_libtakum_wide.json). O relatório conserva `matches_all: false`: existem diferenças reais entre implementações, analisadas abaixo.

## Resultados

| Verificação | Casos | Divergências |
|---|---:|---:|
| Decodificação T16, todos os padrões | 65.536 | 0 |
| Decodificação dos operandos T16 amostrados | 20.000 | 0 |
| Decodificação dos operandos T32 amostrados | 20.000 | 0 |
| Soma T16 | 10.000 | 0 |
| Subtração T16 | 10.000 | 0 |
| Multiplicação T16 | 10.000 | 0 |
| Soma T32 | 10.000 | 0 |
| Subtração T32 | 10.000 | 0 |
| Multiplicação T32 | 10.000 | 128 |

São 165.536 comparações, incluindo repetições intencionais. Os 128 resultados diferentes pertencem aos casos dirigidos de produto próximo de empate: 16 pares de magnitudes, cada um exercitado nas duas ordens e nas quatro combinações de sinais. Não houve divergência nas classes `boundary` e `stratified` desta amostra. Essa distribuição foi provocada pelo desenho dos testes e não estima a frequência de falha em aplicações.

## Por que a biblioteca difere nos 128 casos

Na revisão fixada, [src/util.h](https://github.com/takum-arithmetic/libtakum/blob/776ac0ca7855f640100731ed8bbb0c7cf83b2d94/src/util.h) encaminha as operações lineares T16/T32 para `double`. [src/multiplication.c](https://github.com/takum-arithmetic/libtakum/blob/776ac0ca7855f640100731ed8bbb0c7cf83b2d94/src/multiplication.c) multiplica nesse tipo e o resultado volta a Takum. A geração registrou `DBL_MANT_DIG=53`, `LDBL_MANT_DIG=64` e arredondamento `FE_TONEAREST`.

Os valores T32 de entrada cabem exatamente em binary64. Isso não garante que o produto caiba: na região próxima de 1, cada operando T32 pode ter 28 bits significativos. A primeira aproximação pode apagar o bit que decide de qual lado de um limiar Takum está o resultado exato.

Considere o caso 784:

```text
a = 0x40000001 = 1 + 2^-27
b = 0x44000001 = 3/2 + 2^-27
Python:   0x44000003
libtakum: 0x44000002
```

Escrevendo `u = 2^-27`, o produto exato é `3/2 + (5/2)u + u²`. Os dois candidatos adjacentes são `3/2 + 2u` e `3/2 + 3u`; seu ponto médio é `3/2 + (5/2)u`. O produto exato está **2^-54 acima** desse ponto médio, portanto o candidato correto é `0x44000003`.

O espaçamento binary64 nessa região é `2^-52`. O ponto médio é representável em binary64, e a diferença `2^-54` é menor que meio espaçamento (`2^-53`). O intermediário `double` arredonda o produto para o ponto médio. A conversão seguinte encontra um empate e escolhe o código par `0x44000002`. Trata-se de **duplo arredondamento no caminho de referência**, não de razão para alterar a ALU racional do projeto.

O validador verifica uma prova equivalente para **cada um dos 128 registros**, diretamente a partir dos operandos externos `%a`, usando `Fraction`. Reconstrói os dois candidatos pela fórmula fechada da grade T32 em magnitude `[1,2)`, sem chamar `Takum.encode` ou `Takum.decode` nessa análise. Confere que:

- Os códigos são adjacentes, e o escolhido pela biblioteca é par.
- O resultado exato é estritamente mais próximo do candidato Python.
- O ponto médio é representável em binary64, e sua distância ao produto exato é positiva e menor que `2^-53`.

Todos foram classificados como `upstream_binary64_double_rounding`; nenhum ficou sem classificação. Distâncias, produtos e candidatos racionais estão preservados no relatório JSON. Nos campos históricos `actual`/`expected`, `actual` significa Python e `expected` significa resultado da biblioteca fixada, sem presumir que este seja matematicamente correto.

## O que os testes garantem

`tests/test_wide_reference.py` verifica o hash dos dados descompactados, a revisão da biblioteca, as contagens, o parser hexadecimal exato e a lista completa de diferenças revisadas. Exige também a classificação matemática; trocar os resultados alegadamente correto/incorreto faz o teste da análise rejeitar a conclusão. Qualquer divergência nova ou alteração dos casos conhecidos causa falha. Nenhum valor divergente do fixture foi substituído pelo resultado Python.

A concordância na amostra não prova correção de todos os pares T16/T32. A decodificação é exaustiva somente para T16 neste conjunto. T64 não foi avaliado neste fixture; a precisão de `long double` também exige cuidado como referência aritmética nessa largura.

SHA-256 do TSV descompactado: `b030eb0478d705fd7f9258835de42ada67fcf6ebb5bfe03c7d8fc93aa3498803`. Hashes do arquivo gzip, exportador, biblioteca estática e configuração de compilação estão no manifesto de proveniência. O compilador foi invocado no Ubuntu-20.04/WSL com os parâmetros registrados; sua versão não foi capturada separadamente.
