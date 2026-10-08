# Oráculo externo T8

`libtakum_t8.bin.gz` é uma tabela gerada por `tools/libtakum_reference.c`, ligada à [libtakum de Laslo Hunhold](https://github.com/takum-arithmetic/libtakum), commit **776ac0ca7855f640100731ed8bbb0c7cf83b2d94**, versão 2.0.0. Não foi gerada pelo codec Python. Nessa versão da biblioteca, `takum8` significa **linear** e `takum_log8` significa logarítmico.

Conteúdo descompactado: cabeçalho ASCII `TK8REF1\n`, 256 valores de decodificação em binary64 little-endian (os valores finitos T8 são exatos em binary64), seguidos por três tabelas de 65.536 bytes em ordem `a*256+b`: soma, subtração e multiplicação. Inclui zero e NaR. SHA-256 descompactado: `88b3d655a792b66a074923550911e133fdd789340c9703fa2b81f7741696a9ab`.

Fonte obtida em `https://codeload.github.com/takum-arithmetic/libtakum/zip/776ac0ca7855f640100731ed8bbb0c7cf83b2d94`; SHA-256 do ZIP: `a221cfc06f228389995cf67f829d34c7bf475a3fd32175fab87c18a766878a3b`. Extração e compilação locais em `tmp/upstream/`; não são necessárias para rodar o simulador nem seus testes com esta tabela.

Reprodução no Linux/WSL a partir da raiz do projeto, após baixar/extrair a revisão indicada:

```sh
upstream=tmp/upstream/libtakum-776ac0ca7855f640100731ed8bbb0c7cf83b2d94
make -C "$upstream" libtakum.a -j4
gcc -std=c11 -O2 -I "$upstream" tools/libtakum_reference.c "$upstream/libtakum.a" -lm -o tmp/upstream/libtakum_reference
tmp/upstream/libtakum_reference tmp/upstream/t8_reference.bin
python tools/validate_libtakum.py tmp/upstream/t8_reference.bin
```

O exportador é código próprio. A biblioteca utilizada está sob licença ISC: copyright 2024–2025 Laslo Hunhold. A tabela é evidência diferencial, não uma prova de correção da biblioteca. Para T16/T32/T64 há testes dirigidos; a enumeração de pares só é exaustiva para T8.
