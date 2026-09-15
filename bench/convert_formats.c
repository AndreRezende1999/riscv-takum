/*
 * Benchmark de viabilidade de formatos numericos (replica da Figura 3 do
 * artigo AVX10.2): converte as entradas de uma matriz esparsa (Matrix
 * Market) para cada formato, converte de volta para long double e acumula
 * o erro relativo 2-norma:
 *
 *   erro_rel = sqrt(sum (ref - approx)^2) / sqrt(sum ref^2)
 *
 * Referencia: long double (80 bits no x86-64). O artigo usa binary128
 * (Quadmath.jl); a diferenca e irrelevante para os formatos avaliados
 * (<= 32 bits), mas fica registrada como desvio metodologico.
 *
 * Uso:
 *   zt-convert <dir-matrizes> <saida-relative.csv> <saida-log.csv>
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <posit.h>
#include <takum.h>

#include "zvtakum/takum_codec.h"

#define NFMT 15

static const char *fmt_names[NFMT] = {
	"f8_e4m3",  "f8_e5m2",  "f16",      "bf16",     "f32",
	"f64",      "takum8",   "takum16",  "takum32",  "taklog8",
	"taklog16", "taklog32", "posit8",   "posit16",  "posit32",
};

/* --------- formatos IEEE-like -------------------------------------- */

static uint32_t
f2u(float f)
{
	uint32_t u;

	memcpy(&u, &f, sizeof(u));
	return u;
}

static float
u2f(uint32_t u)
{
	float f;

	memcpy(&f, &u, sizeof(f));
	return f;
}

static long
rne_scaled(long double v)
{
	long double r = floorl(v);
	long double frac = v - r;

	if (frac > 0.5L)
		return (long)r + 1;
	if (frac == 0.5L)
		return (long)r + ((long)r & 1);
	return (long)r;
}

static long double
f8_e4m3_decode(uint8_t b)
{
	int s = b >> 7;
	int e = (b >> 3) & 0xf;
	int m = b & 7;
	long double v;

	if (e == 15 && m == 7)
		return NAN;
	if (e == 0)
		v = (long double)m / 8.0L * ldexpl(1.0L, -6);
	else
		v = (1.0L + (long double)m / 8.0L) * ldexpl(1.0L, e - 7);

	return s ? -v : v;
}

static uint8_t
f8_e4m3_encode(double x)
{
	uint8_t s;
	long double ax;

	if (isnan(x))
		return 0x7f;
	s = signbit(x) ? 0x80 : 0x00;
	ax = fabsl((long double)x);
	if (ax == 0.0L)
		return s;
	if (ax >= 448.0L)
		return (uint8_t)(s | 0x7f); /* overflow -> NaN (E4M3 nao tem Inf) */

	if (ax < ldexpl(1.0L, -6)) {
		long m = rne_scaled(ax / ldexpl(1.0L, -9));

		if (m <= 0)
			return s;
		if (m >= 8)
			return (uint8_t)(s | 0x08);
		return (uint8_t)(s | (uint8_t)m);
	}
	{
		int e2;
		long double m2 = frexpl(ax, &e2);
		int e = e2 - 1 + 7;
		long m = rne_scaled((2.0L * m2 - 1.0L) * 8.0L);

		if (m == 8) {
			m = 0;
			e++;
		}
		if (e > 15 || (e == 15 && m > 6))
			return (uint8_t)(s | 0x7f); /* overflow -> NaN */
		return (uint8_t)(s | (uint8_t)(e << 3) | (uint8_t)m);
	}
}

static long double
f8_e5m2_decode(uint8_t b)
{
	int s = b >> 7;
	int e = (b >> 2) & 0x1f;
	int m = b & 3;
	long double v;

	if (e == 31)
		return m ? NAN : (s ? -INFINITY : INFINITY);
	if (e == 0)
		v = (long double)m / 4.0L * ldexpl(1.0L, -14);
	else
		v = (1.0L + (long double)m / 4.0L) * ldexpl(1.0L, e - 15);

	return s ? -v : v;
}

static uint8_t
f8_e5m2_encode(double x)
{
	uint8_t s;
	long double ax;

	if (isnan(x))
		return 0x7f;
	s = signbit(x) ? 0x80 : 0x00;
	ax = fabsl((long double)x);
	if (isinf(x))
		return (uint8_t)(s | 0x7c);
	if (ax == 0.0L)
		return s;
	if (ax >= 61440.0L)
		return (uint8_t)(s | 0x7c);

	if (ax < ldexpl(1.0L, -14)) {
		long m = rne_scaled(ax / ldexpl(1.0L, -16));

		if (m <= 0)
			return s;
		if (m >= 4)
			return (uint8_t)(s | 0x04);
		return (uint8_t)(s | (uint8_t)m);
	}
	{
		int e2;
		long double m2 = frexpl(ax, &e2);
		int e = e2 - 1 + 15;
		long m = rne_scaled((2.0L * m2 - 1.0L) * 4.0L);

		if (m == 4) {
			m = 0;
			e++;
		}
		if (e >= 31)
			return (uint8_t)(s | 0x7c);
		return (uint8_t)(s | (uint8_t)(e << 2) | (uint8_t)m);
	}
}

static long double
bf16_round(double x)
{
	uint32_t u = f2u((float)x);
	uint32_t r = u + 0x7fffu + ((u >> 16) & 1u);

	return (long double)u2f(r & 0xffff0000u);
}

/* --------- takum e posit ------------------------------------------- */

static long double
takum_round(zt_variant variant, uint32_t width, double x)
{
	zt_fields f;

	zt_decode(variant, width, zt_from_double(variant, width, x), &f);
	return f.value;
}

static long double
convert(int fmt, double x)
{
	switch (fmt) {
	case 0:
		return f8_e4m3_decode(f8_e4m3_encode(x));
	case 1:
		return f8_e5m2_decode(f8_e5m2_encode(x));
	case 2:
		return (long double)(_Float16)x;
	case 3:
		return bf16_round(x);
	case 4:
		return (long double)(float)x;
	case 5:
		return (long double)x;
	case 6:
		return takum_round(ZT_VARIANT_LINEAR, 8, x);
	case 7:
		return takum_round(ZT_VARIANT_LINEAR, 16, x);
	case 8:
		return takum_round(ZT_VARIANT_LINEAR, 32, x);
	case 9:
		return takum_round(ZT_VARIANT_LOG, 8, x);
	case 10:
		return takum_round(ZT_VARIANT_LOG, 16, x);
	case 11:
		return takum_round(ZT_VARIANT_LOG, 32, x);
	case 12:
		return posit8_to_extended_float(posit8_from_float64(x));
	case 13:
		return posit16_to_extended_float(posit16_from_float64(x));
	default:
		return posit32_to_extended_float(posit32_from_float64(x));
	}
}

/* --------- leitura de Matrix Market -------------------------------- */

struct acc {
	long double sumsq_ref;
	long double sumsq_err[NFMT];
	long double sumsq_log[NFMT];
	int         nan_log[NFMT];
	long        nnz;
};

static void
accumulate(struct acc *a, double v)
{
	long double ref = (long double)v;

	a->sumsq_ref += ref * ref;
	for (int f = 0; f < NFMT; f++) {
		long double approx = convert(f, v);
		long double d = ref - approx;

		a->sumsq_err[f] += d * d;
		if (ref == 0.0L && approx == 0.0L)
			continue;
		if (ref == 0.0L || approx == 0.0L ||
		    signbit(ref) != signbit(approx)) {
			a->nan_log[f] = 1;
			continue;
		}
		{
			long double dl = logl(approx / ref);

			a->sumsq_log[f] += dl * dl;
		}
	}
	a->nnz++;
}

static int
read_mtx(const char *path, struct acc *a)
{
	FILE *f = fopen(path, "r");
	char line[512];
	int symmetric = 0, pattern = 0, complexm = 0;
	long nrows, ncols, nnz;
	long read = 0;

	if (f == NULL)
		return -1;
	if (fgets(line, sizeof(line), f) == NULL ||
	    strncmp(line, "%%MatrixMarket", 14) != 0) {
		fclose(f);
		return -1;
	}
	if (strstr(line, "symmetric") != NULL)
		symmetric = 1;
	if (strstr(line, "pattern") != NULL)
		pattern = 1;
	if (strstr(line, "complex") != NULL)
		complexm = 1;
	if (complexm) {
		fclose(f);
		return 1; /* ignorada */
	}

	do {
		if (fgets(line, sizeof(line), f) == NULL) {
			fclose(f);
			return -1;
		}
	} while (line[0] == '%');

	if (sscanf(line, "%ld %ld %ld", &nrows, &ncols, &nnz) != 3) {
		fclose(f);
		return -1;
	}
	(void)nrows;
	(void)ncols;

	while (read < nnz && fgets(line, sizeof(line), f) != NULL) {
		long i, j;
		double v = 1.0;

		if (line[0] == '%')
			continue;
		if (pattern) {
			if (sscanf(line, "%ld %ld", &i, &j) != 2)
				continue;
		} else {
			if (sscanf(line, "%ld %ld %lf", &i, &j, &v) != 3)
				continue;
		}
		accumulate(a, v);
		if (symmetric && i != j)
			accumulate(a, v);
		read++;
	}

	fclose(f);
	return 0;
}

/* --------- main ---------------------------------------------------- */

int
main(int argc, char **argv)
{
	struct acc a;
	FILE *frel, *flog;

	if (argc < 4) {
		fprintf(stderr,
		        "uso: %s <dir-matrizes> <relative.csv> <log.csv>\n",
		        argv[0]);
		return 1;
	}

	frel = fopen(argv[2], "w");
	flog = fopen(argv[3], "w");
	if (frel == NULL || flog == NULL) {
		perror("fopen");
		return 1;
	}

	fprintf(frel, "matrix,nnz");
	for (int f = 0; f < NFMT; f++)
		fprintf(frel, ",%s", fmt_names[f]);
	fprintf(frel, "\n");

	fprintf(flog, "matrix,nnz");
	for (int f = 0; f < NFMT; f++)
		fprintf(flog, ",%s", fmt_names[f]);
	fprintf(flog, "\n");

	for (int i = 1; i < argc && i < 2; i++)
		(void)i;

	/* varre o diretorio via popen (ls ordenado) para simplicidade */
	{
		char cmd[1024];
		FILE *ls;
		char path[512];

		snprintf(cmd, sizeof(cmd), "ls -1 '%s'/*.mtx 2>/dev/null | sort",
		         argv[1]);
		ls = popen(cmd, "r");
		if (ls == NULL) {
			perror("popen");
			return 1;
		}
		while (fgets(path, sizeof(path), ls) != NULL) {
			size_t n = strlen(path);

			while (n > 0 && (path[n - 1] == '\n' ||
			                 path[n - 1] == '\r'))
				path[--n] = '\0';
			if (n == 0)
				continue;
			memset(&a, 0, sizeof(a));
			{
				int rc = read_mtx(path, &a);

				if (rc == 1) {
					fprintf(stderr,
					        "aviso: %s ignorada (complexa)\n",
					        path);
					continue;
				}
				if (rc != 0) {
					fprintf(stderr, "aviso: falha em %s\n",
					        path);
					continue;
				}
			}
			if (a.sumsq_ref == 0.0L) {
				fprintf(stderr,
				        "aviso: %s sem valores (ignorada)\n",
				        path);
				continue;
			}
			{
				const char *base = strrchr(path, '/');
				long double rel = sqrtl(a.sumsq_ref);

				base = base ? base + 1 : path;
				fprintf(frel, "%s,%ld", base, a.nnz);
				for (int f = 0; f < NFMT; f++) {
					long double err = sqrtl(
					    a.sumsq_err[f] / a.sumsq_ref);

					fprintf(frel, ",%.6Le", err);
				}
				fprintf(frel, "\n");

				fprintf(flog, "%s,%ld", base, a.nnz);
				for (int f = 0; f < NFMT; f++) {
					if (a.nan_log[f]) {
						fprintf(flog, ",nan");
					} else {
						fprintf(flog, ",%.6Le",
						        sqrtl(a.sumsq_log[f]));
					}
				}
				fprintf(flog, "\n");
				printf("%s nnz=%ld rel=%.3Le\n", base, a.nnz,
				       rel > 0.0L ? sqrtl(a.sumsq_err[8] /
				                          a.sumsq_ref)
				                  : 0.0L);
			}
		}
		pclose(ls);
	}

	fclose(frel);
	fclose(flog);

	return 0;
}
