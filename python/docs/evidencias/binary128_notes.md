# Referência independente binary128

O produto continua sendo Python e biblioteca padrão. O programa C em
`tools/binary128_reference.c` serve exclusivamente para gerar uma referência
externa de validação; ele não participa da execução de SpMV, não exige Spike
e não introduz uma dependência de compilador nos testes posteriores.

## Execução observada

O oráculo foi compilado e executado no WSL Ubuntu 20.04 em 6 de outubro de
2026, às 11:14:43 UTC, com GCC 9.4.0 e ABI x86_64. O relatório efetivamente
gerado em `docs/evidencias/binary128_reference.json` registra **6.014 resultados
idênticos em bits, três diferenças de sinal de zero e zero divergências fora
do contrato**, nas 6.000 operações e 17 conversões. As diferenças de zero são
uma adição e duas multiplicações; todos os outros resultados coincidem em
bits, inclusive os 17 casos de conversão decimal.

O arquivo externo `tests/data/binary128_cases.jsonl` tem SHA-256
`e24497d2bff25d2ca2d47941c8029234aa2651605321e7cb466d4510ccb5105b`.
Após sua geração, os quatro testes de `test_binary128_reference.py` passaram
em uma execução offline com Python 3.12.14. Esses resultados comprovam a
comparação nesse corpus e ambiente, sujeitos aos limites descritos abaixo.

O GCC documenta [`__float128` e seus operadores aritméticos](https://gcc.gnu.org/onlinedocs/gcc/Floating-Types.html).
A biblioteca [libquadmath](https://gcc.gnu.org/onlinedocs/libquadmath/)
fornece as [constantes de precisão e intervalo](https://gcc.gnu.org/onlinedocs/libquadmath/Typedef-and-constants.html)
e a conversão decimal `strtoflt128`. O programa exige `FLT128_MANT_DIG=113`,
`FLT128_MAX_EXP=16384`, `FLT128_MIN_EXP=-16381` e tamanho de 16 bytes. Esses
expoentes seguem a convenção das macros C; os expoentes normais não enviesados
vão de −16382 a 16383. Uma verificação dos padrões de `1` e `-0` confirma a
compatibilidade entre a representação de `__float128` e a palavra inteira.

## Corpus e comparação

O gerador usa a semente 20261006 e constrói 2.000 pares finitos diretamente
por campos de bits. Inclui padrões uniformes, vizinhanças de 1, extremos de
expoente, subnormais, transições normal/subnormal, cancelamento e empates de
arredondamento. Nenhuma entrada binária é produzida pelo codificador Python.
Cada par gera três respostas externas: adição, subtração e multiplicação,
totalizando 6.000 operações. Há também 17 conversões decimais por
`strtoflt128`, incluindo empates exatos em torno de 1, zeros, overflow e
underflow. Os literais são registrados no arquivo de casos.

O programa configura `FE_TONEAREST`. Operandos e resultados aritméticos são
`volatile __float128`, e cada expressão contém uma única operação. A
compilação desativa fast math e contração de operações. O programa rejeita
uma compilação que defina `__FAST_MATH__` e registra compilador, arquitetura,
precisão, expoentes, ambiente de arredondamento e flags observadas. O comando
de compilação informado ao executor é registrado como declaração do operador;
o executável não consegue comprovar todas as opções de compilação sozinho.

A comparação exige igualdade de bits em todos os resultados finitos não
nulos. O contrato já documentado do modelo Python normaliza os dois zeros
para `Fraction(0)` e todas as infinidades/NaNs para `None`. Por isso, diferenças
brutas que esse contrato aceita são contadas separadamente:

- `signed_zero_difference`: zeros com sinais distintos;
- `nonfinite_kind_difference`: NaN contra infinito;
- `nan_payload_or_sign_difference`: payload ou sinal de NaN diferente;
- `infinity_sign_difference`: sinais distintos de infinito.

O relatório preserva contagens e exemplos desses casos. Uma diferença entre
finito e não finito, ou entre dois valores finitos não nulos, é um erro. As
flags C são preservadas no arquivo externo, mas não comparadas: o modelo
Python não implementa estado de exceções IEEE. Como os operandos aritméticos
são finitos, este corpus não é um teste de propagação de payloads de NaN;
os testes do classificador cobrem essa distinção separadamente.

## Reprodução com o WSL já existente

Executar na raiz do projeto em PowerShell, sem instalar dependências:

```powershell
New-Item -ItemType Directory -Force -Path tmp/binary128-reference
wsl -d Ubuntu-20.04 --exec gcc -std=gnu11 -O2 -fno-fast-math -frounding-math -ffp-contract=off tools/binary128_reference.c -lquadmath -lm -o tmp/binary128-reference/binary128_reference
& 'C:\Users\Isadora\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools/validate_binary128.py --fixture tests/data/binary128_cases.jsonl --report docs/evidencias/binary128_reference.json --build-command 'gcc -std=gnu11 -O2 -fno-fast-math -frounding-math -ffp-contract=off tools/binary128_reference.c -lquadmath -lm -o tmp/binary128-reference/binary128_reference' --oracle wsl -d Ubuntu-20.04 --exec tmp/binary128-reference/binary128_reference
```

O executor envia somente os casos ao processo externo, verifica se a resposta
preserva todos os IDs e operandos e então grava `tests/data/binary128_cases.jsonl`.
O cabeçalho registra hashes SHA-256 do código C, do gerador e do protocolo de
entrada, além do comando externo e da data real da geração. O relatório
`docs/evidencias/binary128_reference.json` inclui o hash do arquivo de casos e
do modelo Python examinado. Ausência de um arquivo de referência gerado é
falha de teste explícita, nunca um teste omitido ou aprovado artificialmente.

Depois da geração, a validação funciona sem WSL, GCC ou libquadmath:

```powershell
& 'C:\Users\Isadora\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools/validate_binary128.py --fixture tests/data/binary128_cases.jsonl
& 'C:\Users\Isadora\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' -m unittest discover -s tests -p test_binary128_reference.py -v
```

O resultado válido é determinado pelo campo `matches_all` do relatório real,
pelas contagens por operação e pelas diferenças classificadas. O corpus é
uma verificação diferencial determinística, não uma prova exaustiva de todos
os operandos binary128 nem uma certificação de conformidade IEEE completa.
