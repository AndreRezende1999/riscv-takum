# Referência externa T16/T32

Esta referência usa a [libtakum de Laslo Hunhold](https://github.com/takum-arithmetic/libtakum/tree/776ac0ca7855f640100731ed8bbb0c7cf83b2d94), versão 2.0.0, commit `776ac0ca7855f640100731ed8bbb0c7cf83b2d94`, sob licença ISC, copyright 2024–2025 Laslo Hunhold. Nessa revisão, os tipos `takum16` e `takum32` são **lineares**. O exportador C é código original deste projeto, utilizado somente para gerar dados de teste. Não integra o simulador Python.

## Conteúdo e seleção

`libtakum_wide.tsv.gz` preserva os dados externos em gzip determinístico, com `mtime=0`. A versão descompactada contém:

1. Cabeçalho `TKWREF1`, tabulação e commit.
2. Três registros `M`: `DBL_MANT_DIG`, `LDBL_MANT_DIG`, `PAIRS_PER_WIDTH`.
3. **65.536 registros `D`**, em ordem de código: `D`, `16`, código hexadecimal, valor retornado por `takum16_to_float64`, impresso em `%a`.
4. **10.000 registros `P` por largura**, primeiro T16, depois T32: `P`, largura, índice, classe, código A, código B, valor A em `%a`, valor B em `%a`, soma, subtração, multiplicação. Os três resultados são padrões binários hexadecimais produzidos pela biblioteca.

Campos são separados por tabulação; registros terminam em LF. Cada largura contém 768 pares `boundary`, 384 `tie_probe` e 8.848 `stratified`. São **registros de teste**, não uma alegação de pares distintos: repetições intencionais aparecem nas fronteiras e nas permutações.

- `boundary`: cada um dos 32 prefixos de cinco bits (sinal/direção/regime), com deslocamento bruto −1, 0 ou +1, é combinado com zero, NaR, +1, −1, mínimo positivo, máximo positivo, seu oposto e ele próprio.
- `tie_probe`: para cada ímpar `i` entre 1 e 31, escolhe-se `j` tal que `i*j mod 2^(n−5)` fique em `2^(n−6)−1`, `2^(n−6)` ou `2^(n−6)+1`. Os operandos são os códigos de `1+i/2^(n−5)` e `1+j/2^(n−5)`, com as quatro combinações de sinais e as duas ordens. Esses casos investigam decisões próximas de um empate.
- `stratified`: ciclos completos pelas 1.024 combinações de prefixos, mais um ciclo parcial. Os bits inferiores vêm de xorshift32 `(13,17,5)`, semente `0x6a09e667 XOR n`. A seleção independe dos resultados do codec Python.

As decodificações de operandos dos pares também são verificadas: 20.000 por largura. Isso acrescenta uma amostra T32 ao conjunto exaustivo de decodificação T16. A aritmética soma/subtração/multiplicação tem 10.000 casos por operação e por largura, totalizando 60.000 resultados externos. A enumeração de pares **não é exaustiva** para T16/T32.

## Precisão e divergências

Todos os valores finitos T16/T32 cabem exatamente no `double` usado na exportação. O leitor `hex_fraction` converte `%a` diretamente em `Fraction`, sem passar por `float` Python. O teste de leitura inclui um valor com mais de 53 bits para detectar uma redução indevida de precisão.

O mesmo não torna exata toda operação intermediária: `src/util.h` da revisão fixada implementa as operações T16/T32 por meio de `double`. Um produto de operandos T32 pode exigir mais de 53 bits significativos. Portanto, resultados diferentes entre a biblioteca e o codec racional devem ser investigados. `matches_all=false` no relatório preserva essa informação; o teste só aceita divergências registradas e justificadas no manifesto e nas [notas de análise](../../docs/evidencias/wide_reference_notes.md).

T64 está fora deste fixture. A biblioteca usa `long double` nessa largura, e sua precisão depende da plataforma. Mesmo 64 bits significativos não bastam para todos os produtos T64 exatos; não se deve promover esse caminho a oráculo universal.

## Reprodução

A partir da raiz do projeto no Linux/WSL, depois da obtenção e compilação da revisão indicada:

```sh
gcc -std=c11 -O2 -Wall -Wextra -Wpedantic -fno-fast-math -I tmp/upstream/libtakum-776ac0ca7855f640100731ed8bbb0c7cf83b2d94 tools/libtakum_wide_reference.c tmp/upstream/libtakum-776ac0ca7855f640100731ed8bbb0c7cf83b2d94/libtakum.a -lm -o tmp/upstream/libtakum_wide_reference
tmp/upstream/libtakum_wide_reference tmp/upstream/libtakum_wide.tsv
python tools/validate_libtakum_wide.py tmp/upstream/libtakum_wide.tsv --compress tests/data/libtakum_wide.tsv.gz --report docs/evidencias/python_libtakum_wide.json
python -m unittest discover -s tests -p test_wide_reference.py -v
```

O exportador seleciona `FE_TONEAREST`. A compressão não altera os registros. O validador retorna código 1 se houver qualquer divergência, inclusive aquelas já analisadas; os testes offline conferem a lista exata de divergências revisadas. O manifesto `libtakum_wide.json` registra hashes do fixture, exportador e biblioteca estática. Não é necessário compilar C nem instalar libtakum para executar os testes com os dados salvos.
