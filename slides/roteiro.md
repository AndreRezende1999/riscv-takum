# Roteiro da apresentação (15 min) e da demo

## Estrutura sugerida (15 min)

| Tempo | Bloco | Conteúdo |
|---|---|---|
| 0-2 min | Motivação | proliferação de formatos; FP8 ausente na RVV; decodificador comum do Takum; replicação do AVX10.2 |
| 2-4 min | Formato e ISA | Takum linear, arredondamento RNE no código; as cinco instruções Zvtakum; por que custom-0 |
| 4-7 min | Arquitetura | núcleo RV64IM+RVV+Zvtakum; unidade Takum em inteiros, sem `double`; contadores |
| 7-9 min | Verificação | vetores dourados do modelo Python; diferencial com QEMU byte a byte; Zvtakum contra o modelo; 96 kernels bit a bit iguais |
| 9-13 min | Resultados | decomposição em 32 bits (formato × acumulador); 8/16 bits e overflow; modelo de contagem e custo de instruções |
| 13-15 min | Conclusão + demo | limitações, trabalhos futuros, demo (`make sim-test` e um kernel) |

Os slides estão em `slides.tex`. Os números vêm de `paper/numeros.tex`, gerado por
`paper/gera_tabelas.py` a partir de `sim/results/`. Se os CSVs mudarem, rode
`make paper-data` antes de recompilar os slides.

## Demo ao vivo (2-3 min)

1. Testes e diferencial (rápido):

```sh
make sim-test      # 21 verificações; termina em menos de 1 s
make sim-check     # 9 execuções: QEMU e modelo, byte a byte
```

2. Um kernel no simulador, com contadores:

```sh
make spmv          # opcional: gera sim/build/spmv/*.elf e os CSVs
sim/build/zt-sim sim/build/spmv/bcsstk01.takum32.v256.elf \
    --vlen 256 --stdout /tmp/y.bin --counters /tmp/c.json
cat /tmp/c.json
```

O JSON traz `insn_total`, `insn_scalar`, `insn_vsetvl`, `insn_vector`,
`insn_zvtakum`, `csr_reads`, `csr_writes`, `elem_active`, `bytes_loaded`,
`bytes_stored` e `index_bytes_loaded`. Aponte a diferença entre o kernel de
Takum32 e o de FP32 (`bcsstk01.fp32.v256.elf`): mesmas escritas de CSR, menos
elementos ativos por causa do `vtdot`.

3. (Opcional) `make paper-data` regenera tabelas e números; `make paper` compila
   o PDF.

## Perguntas prováveis da banca

- **Por que custom-0 e não OP-V?** O inventário do riscv-opcodes mostra que
  `funct6=0b111001` está livre, mas há de 11 a 33 outros valores livres por
  classe de operando. custom-0 é o espaço reservado para extensões não
  padronizadas, sem risco de colisão com extensões futuras.
- **Por que a aritmética não usa a libtakum?** As 128 divergências T32
  registradas contra ela vêm de arredondamento duplo no intermediário
  `double`. A aritmética própria decide o arredondamento exatamente, e é
  verificada contra um modelo independente de racionais exatos.
- **O Takum é mais preciso que o IEEE?** Em 32 bits, com o mesmo acumulador, é
  cerca de 2 vezes melhor nestas oito matrizes. Em 16 bits, não é sempre: o
  Takum16 perde para o FP16 em 2 de 5 matrizes finitas. O que o Takum garante é
  que não estoura, enquanto FP8 e FP16 estouram em 3 ou 4 das 8.
- **O Takum reduz instruções?** Em 32 bits, nunca executa mais que o FP32;
  executa menos quando as linhas precisam de mais de uma faixa. A economia vem
  do `vtdot`, que funde produto e redução. Em 8 e 16 bits o custo depende do
  VLEN, porque o índice de 32 bits exige um `vsetvli` extra por faixa.
- **Os números batem com o artigo do AVX10.2?** A tendência em 32 bits sim; o
  conjunto é diferente (8 matrizes contra 1401) e o protocolo de representação
  do MuFoLAB ainda não foi executado.
- **Encodings são definitivos?** Não; são propostas experimentais do projeto,
  documentadas em `docs/spec/zvtakum.adoc` e `docs/opcodes/zvtakum.opcodes`.
