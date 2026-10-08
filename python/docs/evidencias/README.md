# Evidências da auditoria de 05/10/2026

Este índice começa pelo material recebido. A execução Python posterior está no [relatório de validação ampliada](../09_validacao_ampliada.md): `python_tests_ampliados.txt` registra 68 testes; `python_libtakum_wide.json` e `wide_reference_notes.md` preservam as divergências T32; `binary128_reference.json` e `binary128_notes.md` documentam o oráculo externo; `execucao_validacao_ampliada.txt` e `auditoria_validacao_ampliada.json` registram os 112 resultados e a conferência dos artefatos.

## Material recebido

ZIP: `C:/Users/Isadora/Downloads/riscv-takum-main.zip`.

SHA-256: `61dfc579b4abf645efb14b9fe2485fe7558ba16894686c88e7197aaa7594e540`.

Os resultados preexistentes pertencem ao material do grupo. Recalcular seus resumos não significa reproduzir os benchmarks C que os produziram. Os originais permanecem em `riscv-takum-main/`.

## Arquivos

- `conferir_material.py`: script de conferência de integridade e estatísticas.
- `conferencia_material.json`: hashes/quantidades, estado das dependências e dados SpMV recebidos.
- `resumo_csv_recebido.csv`: duas convenções de mediana, p90 e contagens, calculadas do CSV original.
- `probe_original.c`: diagnóstico temporário preservado para inspeção. As funções foram copiadas literalmente de `bench/convert_formats.c` e `src/rvv_insns.c`; a lógica de estado foi ligada diretamente do `src/rvv_state.c` original. Origem: código do grupo no ZIP, licença ISC em `riscv-takum-main/LICENSE`.
- `probe_original.txt`: saída observada da compilação/execução localizada no Ubuntu-20.04/WSL.

Os valores esperados dos diagnósticos são fundamentados na [RVV 1.0](https://docs.riscv.org/reference/isa/v20260120/unpriv/v-st-ext.html) e na [OFP8 revisão 1.0](https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1).

## Reexecução

Na raiz do workspace, com Python:

```text
python docs/evidencias/conferir_material.py
```

Com GCC em ambiente Linux, a partir da mesma raiz:

```sh
gcc -std=c11 -O0 -I riscv-takum-main/include docs/evidencias/probe_original.c riscv-takum-main/src/rvv_state.c -lm -o tmp/audit/probe_original
./tmp/audit/probe_original
```

O diretório `tmp/audit` deve existir. O comando utilizado nesta sessão empregou a cópia em `tmp/audit/probe_original.c`, de conteúdo idêntico à cópia preservada aqui.

O programa imprime o valor obtido e o esperado; o retorno zero apenas indica que o diagnóstico executou, **não que os casos passaram**. Foram observadas sete discrepâncias. Não é uma suíte de conformidade, não chama o assembler/decoder completo e não testa a aritmética da libtakum. O caso de redução foi executado diretamente na função copiada, com o acumulador zero implícito que ela implementa.

## Limitações da reprodução completa

Há GCC, make e Python no WSL, mas o ZIP não traz os fontes dos dois submódulos nem as matrizes. `make test` e os benchmarks completos não foram executados nesta etapa. Antes de qualquer nova comparação, fixar as dependências e registrar configurações novas; os resultados antigos não devem receber retroativamente metadados presumidos.
