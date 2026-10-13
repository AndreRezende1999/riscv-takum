# Modelo Python de referência

O diretório `python/` contém o modelo independente usado como gabarito:
racionais exatos para Takum, referência binary128 por software, geradores de
matrizes e ferramentas de validação. Ele não compara mais uma implementação C
removida; as comparações atuais são entre o modelo Python, o núcleo C++ e o
simulador em `sim/`.

Os testes podem ser executados com:

```sh
cd python
python3 -m unittest discover -s tests -v
```

Os resultados regeneráveis ficam documentados pelos alvos `make spmv` e
`make paper-data`.
