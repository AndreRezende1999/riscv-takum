# Roteiro da apresentacao (15 min) e da demo

## Estrutura sugerida (15 min)

| Tempo | Bloco | Conteudo |
|---|---|---|
| 0-2 min | Motivacao | proliferacao de formatos em ISAs vetoriais; 92 instrucoes de FP na RVV, 21 conversoes; FP8 ausente |
| 2-5 min | Takum | formato, decodificador de 12 bits, variantes linear/log, NaR, saturacao; propriedades (negacao/inversao) |
| 5-8 min | Metodologia | codec/ALU + testes exaustivos; especificacao Zvtakum; simulador RVV; benchmarks |
| 8-13 min | Resultados | viabilidade (CDFs), fechamento (tabela), SpMV, reestruturacao do ISA (96 -> 8) |
| 13-15 min | Conclusao + demo | limitacoes, trabalhos futuros, demo (`make demo`) |

Dicas: usar os slides do `slides.tex`; as figuras CDF estao em
`bench/results/cdf_8.png` e `cdf_32.png`; as tabelas vem de
`bench/results/*_summary.txt`.

## Demo ao vivo (2-3 min)

1. Build e testes (rapido):

```sh
make -j4 all
make test
```

2. Encode/decode de uma instrucao Zvtakum:

```sh
build/tools/zt-disa encode "vtadd.vv v1, v2, v3"
build/tools/zt-disa decode 0xe62190d7
```

3. Exemplos (`examples/`):
   - axpy IEEE f32 (mostra contadores de instrucao/CSR);
   - produto escalar takum (log e linear) com `vtdot` (acumulador T16).

```sh
make demo
```

4. (Opcional) Benchmark: `make bench` regenera CSVs/figuras.

## Perguntas provaveis da banca

- **Por que takum e nao posit?** Faixa dinamica limitada ja em 12 bits,
  decodificador comum, inversao por bits (log), precisao garantida de
  `n-12` bits de mantissa (Proposicao 11 do artigo).
- **O que muda no hardware?** So o decodificador/codificador (12 bits) e a
  ALU de takum reutiliza unidades de ponto fixo (LNS); sem novos CSRs.
- **Qual variante e a "certa"?** O artigo designa a logaritmica como
  padrao; o estudo AVX10.2 (e o libtakum v2) usam a linear para avaliacao
  geral. Implementamos as duas; os resultados numericos sao proximos.
- **Os numeros batem com o artigo?** Sim para fechamento (T16 mult 36,7%
  vs 36,6%; sqrt 84,2% vs 84,1%; inv 100%) e para a tendencia de
  viabilidade (T32 melhor que f32). Diferencas: 100 vs 1401 matrizes e
  referencia long double vs binary128.
- **Encodings sao definitivos?** Nao; provisorios no unico `funct6` livre
  do OP-V, documentados no repositorio.
