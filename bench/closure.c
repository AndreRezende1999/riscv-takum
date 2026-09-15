/*
 * Analise de fechamento (replica da Secao 5.6 do artigo 2404.18603):
 * fracao de operacoes cujo resultado e exatamente representavel no proprio
 * formato, sobre os valores positivos representaveis na faixa da posit
 * correspondente (T8: [2^-24, 2^24]; T16: [2^-56, 2^56]).
 *
 * T8: enumeracao exaustiva. T16: 2.000.000 de pares amostrados por
 * operacao binaria (enumeracao completa seria ~1e9 pares) e todas as
 * operacoes unarias.
 *
 * Saida: tabela no stdout e bench/results/closure.csv
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "zvtakum/takum_codec.h"

#define MAXVALS   100000
#define SAMPLES   2000000u

static uint64_t rng_state = 0x9E3779B97F4A7C15ULL;

static uint64_t
xorshift64(void)
{
	uint64_t x = rng_state;

	x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;
	return rng_state = x;
}

static int
collect_values(zt_variant v, uint32_t w, long double lo, long double hi,
               long double *vals)
{
	uint64_t mask = zt_width_mask(w);
	int n = 0;

	for (uint64_t b = 1; b <= mask; b++) {
		zt_fields f;

		if (zt_is_nar(v, w, b))
			continue;
		zt_decode(v, w, b, &f);
		if (f.value <= 0.0L)
			continue;
		if (f.value < lo || f.value > hi)
			continue;
		if (n < MAXVALS)
			vals[n++] = f.value;
	}

	return n;
}

static long double
op_exact(int op, long double x, long double y)
{
	switch (op) {
	case 0:
		return x + y;
	case 1:
		return x - y;
	case 2:
		return x * y;
	case 3:
		return x / y;
	case 4:
		return 1.0L / x;
	case 5:
		return sqrtl(x);
	default:
		return x * x;
	}
}

static int
op_is_exact(zt_variant v, uint32_t w, int op, long double x, long double y)
{
	long double exact = op_exact(op, x, y);
	long double tol;
	zt_fields f;

	if (op == 0 || op == 1) {
		long double ax = fabsl(x);
		long double ay = fabsl(y);
		long double big = ax > ay ? ax : ay;
		long double small = ax > ay ? ay : ax;

		/* se o menor operando fica abaixo do limiar de tolerancia, a
		 * soma nao e verificavel em long double; matematicamente o
		 * resultado nao e representavel exatamente (media zero para
		 * takum/posit). */
		if (small != 0.0L && small < big * 2.0e-15L)
			return 0;
	}

	if (exact == 0.0L)
		return 1;
	if (isnan(exact) || isinf(exact))
		return 0;
	if (fabsl(exact) > 1.0e300L || fabsl(exact) < 1.0e-300L)
		return 0;
	zt_decode(v, w, zt_round_to(v, w, exact, ZT_ROUND_RNE), &f);
	tol = 1.0e-15L * fabsl(exact);

	return fabsl(f.value - exact) <= tol;
}

int
main(void)
{
	zt_variant variants[2] = {ZT_VARIANT_LINEAR, ZT_VARIANT_LOG};
	uint32_t widths[2] = {8, 16};
	long double ranges[2][2] = {{ldexpl(1.0L, -24), ldexpl(1.0L, 24)},
	                            {ldexpl(1.0L, -56), ldexpl(1.0L, 56)}};
	const char *op_names[7] = {"add",  "sub",    "mul",    "div",
	                           "inv", "sqrt",   "square"};
	FILE *csv = fopen("bench/results/closure.csv", "w");

	if (csv == NULL) {
		perror("bench/results/closure.csv");
		return 1;
	}
	fprintf(csv, "variant,width,op,exact,total,pct_exact,modo\n");

	printf("fechamento aritmetico (positivos na faixa da posit correspondente)\n");
	for (int vi = 0; vi < 2; vi++) {
		for (int wi = 0; wi < 2; wi++) {
			zt_variant v = variants[vi];
			uint32_t w = widths[wi];
			static long double vals[MAXVALS];
			int n = collect_values(v, w, ranges[wi][0], ranges[wi][1],
			                       vals);
			int sampled = (w != 8);

			if (n < 2) {
				fprintf(stderr,
				        "aviso: poucos valores para %s T%u\n",
				        zt_variant_name(v), w);
				continue;
			}
			printf("  (%s T%u: %d valores; %s)\n", zt_variant_name(v),
			       w, n, sampled ? "pares amostrados" : "exaustivo");

			for (int op = 0; op < 7; op++) {
				long exact = 0, total = 0;

				if (op == 4 || op == 5 || op == 6) {
					for (int i = 0; i < n; i++) {
						total++;
						exact += op_is_exact(v, w, op,
						                     vals[i], 0.0L);
					}
				} else if (!sampled) {
					for (int i = 0; i < n; i++)
						for (int j = 0; j < n; j++) {
							long double y = vals[j];

							if (op == 3 && y == 0.0L)
								continue;
							if (op == 1 && vals[i] < y)
								continue;
							total++;
							exact += op_is_exact(
							    v, w, op, vals[i], y);
						}
				} else {
					for (uint32_t t = 0; t < SAMPLES; t++) {
						int i = (int)(xorshift64() %
						              (uint64_t)n);
						int j = (int)(xorshift64() %
						              (uint64_t)n);
						long double y = vals[j];

						if (op == 3 && y == 0.0L)
							continue;
						if (op == 1 && vals[i] < y)
							continue;
						total++;
						exact += op_is_exact(v, w, op,
						                     vals[i], y);
					}
				}

				printf("  %-6s T%-3u %-7s %6ld/%7ld = %6.2f%% %s\n",
				       zt_variant_name(v), w, op_names[op], exact,
				       total,
				       100.0 * (double)exact / (double)total,
				       sampled ? "(amostrado)" : "");
				fprintf(csv, "%s,%u,%s,%ld,%ld,%.4f,%s\n",
				        zt_variant_name(v), w, op_names[op], exact,
				        total,
				        100.0 * (double)exact / (double)total,
				        sampled ? "amostrado" : "exaustivo");
			}
		}
	}

	fclose(csv);
	printf("closure.csv gerado\n");

	return 0;
}
