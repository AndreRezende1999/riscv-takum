/*
 * SpMV (y = A * x) no simulador funcional:
 * - kernels Takum (Zvtakum): vle + vrgather.vv + vtdot.vv (acumulacao
 *   alargada com strip-mining) + vncvt.t.t + vse;
 * - kernel IEEE f32: vle + vrgather.vv + vfmul.vv + vfredusum.vs;
 * - referencia: long double sobre entradas ja arredondadas ao formato.
 *
 * Saida: bench/results/spmv.csv (erro relativo 2-norma de y e contadores).
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "zvtakum/rvv.h"
#include "zvtakum/takum_codec.h"

#define VLEN    1024u
#define MAXN    256
#define OFF_IDX 4096u
#define OFF_VAL 8192u
#define OFF_Y   12288u

struct mat {
	char   name[64];
	int    n;
	int    nnz;
	int    rowptr[MAXN + 1];
	int    col[MAXN * 16];
	double val[MAXN * 16];
};

struct spmv_result {
	long double relerr;
	uint64_t insns, rvv, zvtakum, csr, elements;
};

static uint64_t rng_state = 0xC0FFEE123456789ULL;

static uint64_t
xorshift64(void)
{
	uint64_t x = rng_state;

	x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;
	return rng_state = x;
}

static uint32_t
f2u(float f)
{
	uint32_t u;

	memcpy(&u, &f, 4);
	return u;
}

static float
u2f(uint32_t u)
{
	float f;

	memcpy(&f, &u, 4);
	return f;
}

static double
x_value(int c)
{
	return 1.0 + (double)(c % 5) * 0.25;
}

static void
gen_laplacian(struct mat *m, int side)
{
	int n = side * side;
	int k = 0;

	memset(m, 0, sizeof(*m));
	snprintf(m->name, sizeof(m->name), "lap2d");
	m->n = n;
	for (int r = 0; r < n; r++) {
		int i = r / side, j = r % side;

		m->rowptr[r] = k;
		m->col[k] = r;
		m->val[k++] = 4.0;
		if (i > 0) {
			m->col[k] = r - side;
			m->val[k++] = -1.0;
		}
		if (i < side - 1) {
			m->col[k] = r + side;
			m->val[k++] = -1.0;
		}
		if (j > 0) {
			m->col[k] = r - 1;
			m->val[k++] = -1.0;
		}
		if (j < side - 1) {
			m->col[k] = r + 1;
			m->val[k++] = -1.0;
		}
	}
	m->rowptr[n] = k;
	m->nnz = k;
}

static void
gen_random(struct mat *m, int n, int per_row)
{
	int k = 0;

	memset(m, 0, sizeof(*m));
	snprintf(m->name, sizeof(m->name), "rand");
	m->n = n;
	for (int r = 0; r < n; r++) {
		m->rowptr[r] = k;
		for (int t = 0; t < per_row; t++) {
			m->col[k] = (int)(xorshift64() % (uint64_t)n);
			m->val[k] = ((double)(xorshift64() % 2000) - 1000.0) /
			            1000.0;
			k++;
		}
	}
	m->rowptr[n] = k;
	m->nnz = k;
}

static uint32_t
vtypei_for(uint32_t width)
{
	uint32_t vsew = (width == 8u) ? 0u : (width == 16u) ? 1u : 2u;

	return (1u << 6) | (vsew << 3); /* ta=1, ma=0, m1 */
}

static void
ref_spmv(const struct mat *m, int is_f32, zt_variant v, uint32_t width,
         long double *yref)
{
	for (int r = 0; r < m->n; r++) {
		long double sum = 0.0L;

		for (int k = m->rowptr[r]; k < m->rowptr[r + 1]; k++) {
			long double av, xv;

			if (is_f32) {
				av = (long double)(float)m->val[k];
				xv = (long double)(float)x_value(m->col[k]);
			} else {
				zt_fields fa, fx;

				zt_decode(v, width,
				          zt_from_double(v, width, m->val[k]),
				          &fa);
				zt_decode(v, width,
				          zt_from_double(v, width,
				                         x_value(m->col[k])),
				          &fx);
				av = fa.value;
				xv = fx.value;
			}
			sum += av * xv;
		}
		yref[r] = sum;
	}
}

static long double
run_takum(const struct mat *m, zt_variant v, uint32_t width,
          struct spmv_result *out, const long double *yref)
{
	rvv_state s;
	uint32_t bytes = width / 8u;
	long double err2 = 0.0L, ref2 = 0.0L;

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = (uint64_t)m->n;
	if (rvv_exec(&s, rvv_enc_vsetvli(0, 10, vtypei_for(width))) != RVV_OK)
		return -1.0L;

	/* x no registrador v4 (bits do formato) */
	for (int c = 0; c < m->n; c++)
		rvv_elem_set(&s, 4, (uint32_t)c,
		             zt_from_double(v, width, x_value(c)));

	for (int r = 0; r < m->n; r++) {
		int len = m->rowptr[r + 1] - m->rowptr[r];
		int done = 0;

		rvv_elem_set_w(&s, 1, 0, width * 2u, 0); /* acumulador */
		while (done < len) {
			uint32_t vlmax = rvv_vlmax(&s);
			int take = len - done;

			if ((uint32_t)take > vlmax)
				take = (int)vlmax;
			for (int t = 0; t < take; t++) {
				uint64_t idx =
				    (uint64_t)m->col[m->rowptr[r] + done + t];
				uint64_t bits = zt_from_double(
				    v, width, m->val[m->rowptr[r] + done + t]);

				for (uint32_t b = 0; b < bytes; b++) {
					s.mem[OFF_IDX + bytes * (uint32_t)t +
					      b] = (uint8_t)(idx >> (8u * b));
					s.mem[OFF_VAL + bytes * (uint32_t)t +
					      b] = (uint8_t)(bits >> (8u * b));
				}
			}
			if (rvv_vsetvli(&s, 0, (uint64_t)take, 0,
			                vtypei_for(width)) != RVV_OK)
				return -1.0L;
			s.x[11] = OFF_IDX;
			s.x[12] = OFF_VAL;
			if (rvv_exec(&s, rvv_enc_load(bytes * 8u, 3, 11, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_load(bytes * 8u, 2, 12, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_vrgather_vv(5, 4, 3, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_zt_arith(4, 1, 2, 5, 1)) !=
			        RVV_OK)
				return -1.0L;
			done += take;
		}

		if (rvv_vsetvli(&s, 0, 1u, 0, vtypei_for(width)) != RVV_OK)
			return -1.0L;
		if (rvv_exec(&s, rvv_enc_zt_arith(0, 6, 1, 0, 1)) != RVV_OK)
			return -1.0L;
		s.x[13] = OFF_Y + bytes * (uint64_t)r;
		if (rvv_exec(&s, rvv_enc_store(bytes * 8u, 6, 13, 1)) !=
		    RVV_OK)
			return -1.0L;
	}

	for (int r = 0; r < m->n; r++) {
		uint64_t yb = 0;
		zt_fields f;

		for (uint32_t b = 0; b < bytes; b++)
			yb |= (uint64_t)s.mem[OFF_Y + bytes * (uint64_t)r + b]
			      << (8u * b);
		if (zt_is_nar(v, width, yb)) {
			err2 += yref[r] * yref[r];
			ref2 += yref[r] * yref[r];
			continue;
		}
		zt_decode(v, width, yb, &f);
		err2 += (yref[r] - f.value) * (yref[r] - f.value);
		ref2 += yref[r] * yref[r];
	}

	out->relerr = sqrtl(err2 / ref2);
	out->insns = s.insn_count;
	out->rvv = s.insn_rvv;
	out->zvtakum = s.insn_zvtakum;
	out->csr = s.csr_writes;
	out->elements = s.elements;

	return out->relerr;
}

static long double
run_f32(const struct mat *m, struct spmv_result *out,
        const long double *yref)
{
	rvv_state s;
	long double err2 = 0.0L, ref2 = 0.0L;

	rvv_init(&s, VLEN);
	s.x[10] = (uint64_t)m->n;
	if (rvv_exec(&s, rvv_enc_vsetvli(0, 10, vtypei_for(32))) != RVV_OK)
		return -1.0L;

	for (int c = 0; c < m->n; c++)
		rvv_elem_set(&s, 4, (uint32_t)c,
		             f2u((float)x_value(c)));

	for (int r = 0; r < m->n; r++) {
		int len = m->rowptr[r + 1] - m->rowptr[r];
		int done = 0;
		float acc = 0.0f;

		while (done < len) {
			uint32_t vlmax = rvv_vlmax(&s);
			int take = len - done;

			if ((uint32_t)take > vlmax)
				take = (int)vlmax;
			for (int t = 0; t < take; t++) {
				uint32_t idx =
				    (uint32_t)m->col[m->rowptr[r] + done + t];
				float fv = (float)m->val[m->rowptr[r] + done + t];

				memcpy(s.mem + OFF_IDX + 4u * (uint32_t)t,
				       &idx, 4);
				memcpy(s.mem + OFF_VAL + 4u * (uint32_t)t, &fv,
				       4);
			}
			if (rvv_vsetvli(&s, 0, (uint64_t)take, 0,
			                vtypei_for(32)) != RVV_OK)
				return -1.0L;
			s.x[11] = OFF_IDX;
			s.x[12] = OFF_VAL;
			if (rvv_exec(&s, rvv_enc_load(32, 3, 11, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_load(32, 2, 12, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_vrgather_vv(5, 4, 3, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_vfmul(6, 2, 5, 0, 1)) !=
			        RVV_OK ||
			    rvv_exec(&s, rvv_enc_vfredusum(7, 6, 1)) != RVV_OK)
				return -1.0L;
			acc += u2f((uint32_t)rvv_elem_get(&s, 7, 0));
			done += take;
		}
		{
			uint32_t ub = f2u(acc);

			for (uint32_t b = 0; b < 4u; b++)
				s.mem[OFF_Y + 4u * (uint64_t)r + b] =
				    (uint8_t)(ub >> (8u * b));
		}
	}

	for (int r = 0; r < m->n; r++) {
		uint32_t ub = 0;
		float f;

		for (uint32_t b = 0; b < 4u; b++)
			ub |= (uint32_t)s.mem[OFF_Y + 4u * (uint64_t)r + b]
			      << (8u * b);
		f = u2f(ub);
		if (getenv("SPMV_DEBUG") != NULL && r < 3)
			printf("  dbg row %d: sim=%.9g ref=%.18Lg\n", r, f,
			       yref[r]);
		err2 += (yref[r] - (long double)f) *
		        (yref[r] - (long double)f);
		ref2 += yref[r] * yref[r];
	}

	out->relerr = sqrtl(err2 / ref2);
	out->insns = s.insn_count;
	out->rvv = s.insn_rvv;
	out->zvtakum = s.insn_zvtakum;
	out->csr = s.csr_writes;
	out->elements = s.elements;

	return out->relerr;
}

int
main(void)
{
	struct mat mats[2];
	long double yref[MAXN];
	FILE *csv;

	gen_laplacian(&mats[0], 5);
	gen_random(&mats[1], 32, 6);

	csv = fopen("bench/results/spmv.csv", "w");
	if (csv == NULL) {
		perror("bench/results/spmv.csv");
		return 1;
	}
	fprintf(csv,
	        "matrix,format,relerr,insns,insns_rvv,insns_zvtakum,"
	        "csr_writes,elements\n");

	for (int mi = 0; mi < 2; mi++) {
		struct mat *m = &mats[mi];

		for (int cfg = 0; cfg < 7; cfg++) {
			const char *names[7] = {"f32",      "linear8",
			                        "linear16", "linear32",
			                        "log8",     "log16",
			                        "log32"};
			int is_f32 = (cfg == 0);
			zt_variant v = (cfg <= 3) ? ZT_VARIANT_LINEAR
			                          : ZT_VARIANT_LOG;
			uint32_t width = (cfg == 0) ? 32u
			                 : (cfg == 1) ? 8u
			                 : (cfg == 2) ? 16u
			                 : (cfg == 3) ? 32u
			                 : (cfg == 4) ? 8u
			                 : (cfg == 5) ? 16u
			                              : 32u;
			struct spmv_result res;
			long double err;

			ref_spmv(m, is_f32, v, width, yref);
			if (is_f32)
				err = run_f32(m, &res, yref);
			else
				err = run_takum(m, v, width, &res, yref);

			printf("%-6s %-8s relerr=%.3Le insns=%llu (rvv=%llu "
			       "zt=%llu) csr=%llu elem=%llu\n",
			       m->name, names[cfg], err,
			       (unsigned long long)res.insns,
			       (unsigned long long)res.rvv,
			       (unsigned long long)res.zvtakum,
			       (unsigned long long)res.csr,
			       (unsigned long long)res.elements);
			fprintf(csv, "%s,%s,%.6Le,%llu,%llu,%llu,%llu,%llu\n",
			        m->name, names[cfg], err,
			        (unsigned long long)res.insns,
			        (unsigned long long)res.rvv,
			        (unsigned long long)res.zvtakum,
			        (unsigned long long)res.csr,
			        (unsigned long long)res.elements);
		}
	}

	fclose(csv);
	printf("spmv.csv gerado\n");

	return 0;
}
