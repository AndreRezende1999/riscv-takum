#include "zt_test.h"
#include "zvtakum/takum_alu.h"
#include "zvtakum/takum_codec.h"

#include <math.h>
#include <stdio.h>

typedef uint64_t (*binop_fn)(zt_variant, uint32_t, uint64_t, uint64_t);

enum {
	OP_ADD = 0,
	OP_SUB = 1,
	OP_MUL = 2,
	OP_DIV = 3
};

#define PAIR_SAMPLES 20000u

static long double
exact_binop(int op, long double x, long double y)
{
	switch (op) {
	case OP_ADD:
		return x + y;
	case OP_SUB:
		return x - y;
	case OP_MUL:
		return x * y;
	default:
		return x / y;
	}
}

static long double
neighbor_bound(zt_variant v, uint32_t w, uint64_t r, long double exact)
{
	zt_fields f;
	long double lo, hi, span;
	uint64_t mask = zt_width_mask(w);

	zt_decode(v, w, r, &f);
	lo = f.value;
	hi = f.value;

	if (r > 0u && !zt_is_nar(v, w, r - 1u)) {
		zt_decode(v, w, r - 1u, &f);
		lo = f.value;
	}
	if (r < mask && !zt_is_nar(v, w, r + 1u)) {
		zt_decode(v, w, r + 1u, &f);
		hi = f.value;
	}

	span = hi - lo;
	if (span <= 0.0L)
		return 1.0e30L;

	return span / fabsl(exact);
}

static void
check_pair(zt_variant v, uint32_t w, int op, binop_fn fn, const char *name,
           uint64_t a, uint64_t b)
{
	zt_fields fa, fb, fr;
	uint64_t r, nar;
	long double exact, rel, bound;

	if (zt_is_nar(v, w, a) || zt_is_nar(v, w, b)) {
		r = fn(v, w, a, b);
		CHECK(zt_is_nar(v, w, r),
		      "%s %s T%u: NaR nao propagou (a=%llu b=%llu r=%llu)",
		      name, zt_variant_name(v), w, (unsigned long long)a,
		      (unsigned long long)b, (unsigned long long)r);
		return;
	}

	zt_decode(v, w, a, &fa);
	zt_decode(v, w, b, &fb);

	if (op == OP_DIV && fb.value == 0.0L)
		return;

	exact = exact_binop(op, fa.value, fb.value);
	r = fn(v, w, a, b);
	zt_decode(v, w, r, &fr);
	nar = zt_nar_bits(w);

	if (exact == 0.0L) {
		CHECK(r == 0u,
		      "%s %s T%u: resultado deveria ser zero (a=%.10Lg b=%.10Lg)",
		      name, zt_variant_name(v), w, fa.value, fb.value);
		return;
	}

	{
		zt_fields fpmin, fpmax, fnmax, fnmin;
		uint64_t mask = zt_width_mask(w);

		zt_decode(v, w, 1u, &fpmin);
		zt_decode(v, w, nar - 1u, &fpmax);
		zt_decode(v, w, mask, &fnmin);
		zt_decode(v, w, nar | 1u, &fnmax);

		if (exact > fpmax.value) {
			CHECK(r == nar - 1u,
			      "%s %s T%u: saturação positiva inesperada (exact=%.6Lg r=%llu)",
			      name, zt_variant_name(v), w, exact,
			      (unsigned long long)r);
			return;
		}
		if (exact < fnmax.value) {
			CHECK(r == (nar | 1u),
			      "%s %s T%u: saturação negativa inesperada (exact=%.6Lg r=%llu)",
			      name, zt_variant_name(v), w, exact,
			      (unsigned long long)r);
			return;
		}
		if (exact > 0.0L && exact < fpmin.value) {
			CHECK(r == 1u,
			      "%s %s T%u: underflow positivo inesperado (exact=%.6Lg r=%llu)",
			      name, zt_variant_name(v), w, exact,
			      (unsigned long long)r);
			return;
		}
		if (exact < 0.0L && exact > fnmin.value) {
			CHECK(r == mask,
			      "%s %s T%u: underflow negativo inesperado (exact=%.6Lg r=%llu)",
			      name, zt_variant_name(v), w, exact,
			      (unsigned long long)r);
			return;
		}
	}

	bound = neighbor_bound(v, w, r, exact);
	rel = fabsl(fr.value - exact) / fabsl(exact);
	CHECK(rel <= bound * 1.000001L + 1e-15L,
	      "%s %s T%u: erro rel %.6Lg > limite %.6Lg (a=%.10Lg b=%.10Lg exato=%.10Lg res=%.10Lg p=%d)",
	      name, zt_variant_name(v), w, rel, bound, fa.value, fb.value,
	      exact, fr.value, fr.p);
}

static void
check_pair_identities(zt_variant v, uint32_t w, uint64_t a)
{
	uint64_t zero = 0u;
	uint64_t one;
	zt_fields f;

	if (zt_is_nar(v, w, a))
		return;

	one = zt_from_double(v, w, 1.0);
	zt_decode(v, w, one, &f);
	CHECK(f.value == 1.0L, "1.0 nao e representavel exatamente (%s T%u)",
	      zt_variant_name(v), w);

	CHECK(zt_add(v, w, a, zero) == a, "a + 0 != a (%s T%u a=%llu)",
	      zt_variant_name(v), w, (unsigned long long)a);
	CHECK(zt_mul(v, w, a, one) == a, "a * 1 != a (%s T%u a=%llu)",
	      zt_variant_name(v), w, (unsigned long long)a);
	CHECK(zt_mul(v, w, a, zero) == zero, "a * 0 != 0 (%s T%u a=%llu)",
	      zt_variant_name(v), w, (unsigned long long)a);
	CHECK(zt_sub(v, w, a, a) == zero, "a - a != 0 (%s T%u a=%llu)",
	      zt_variant_name(v), w, (unsigned long long)a);
}

static void
check_unary(zt_variant v, uint32_t w, uint64_t a)
{
	zt_fields fa, fr;
	uint64_t r;
	long double exact, rel, bound;

	if (zt_is_nar(v, w, a)) {
		CHECK(zt_is_nar(v, w, zt_sqrt(v, w, a)), "sqrt(NaR) != NaR");
		CHECK(zt_is_nar(v, w, zt_abs(v, w, a)), "abs(NaR) != NaR");
		CHECK(zt_is_nar(v, w, zt_neg(v, w, a)), "neg(NaR) != NaR");
		return;
	}

	zt_decode(v, w, a, &fa);

	r = zt_abs(v, w, a);
	zt_decode(v, w, r, &fr);
	CHECK(fr.value == fabsl(fa.value), "abs incorreto (a=%.10Lg)", fa.value);

	r = zt_neg(v, w, a);
	zt_decode(v, w, r, &fr);
	CHECK(fr.value == -fa.value, "neg incorreto (a=%.10Lg)", fa.value);

	r = zt_sqrt(v, w, a);
	if (fa.value < 0.0L) {
		CHECK(zt_is_nar(v, w, r), "sqrt(negativo) != NaR (a=%.10Lg)",
		      fa.value);
		return;
	}
	if (fa.value == 0.0L) {
		CHECK(r == 0u, "sqrt(0) != 0");
		return;
	}

	zt_decode(v, w, r, &fr);
	exact = sqrtl(fa.value);
	bound = neighbor_bound(v, w, r, exact);
	rel = fabsl(fr.value - exact) / exact;
	CHECK(rel <= bound * 1.000001L + 1e-15L,
	      "sqrt %s T%u: erro rel %.6Lg > limite %.6Lg (a=%.10Lg res=%.10Lg)",
	      zt_variant_name(v), w, rel, bound, fa.value, fr.value);
}

static void
run_pairs(zt_variant v, uint32_t w, int op, binop_fn fn, const char *name,
          uint64_t samples)
{
	uint64_t mask = zt_width_mask(w);

	if (w <= 8) {
		for (uint64_t a = 0; a <= mask; a++) {
			for (uint64_t b = 0; b <= mask; b++)
				check_pair(v, w, op, fn, name, a, b);
			check_pair_identities(v, w, a);
		}
		return;
	}

	{
		uint64_t rng = 0xDEADBEEFCAFEBABEULL ^ (uint64_t)op ^
		               ((uint64_t)v << 8) ^ w;

		for (uint64_t i = 0; i < samples; i++) {
			uint64_t a = zt_xorshift64(&rng) & mask;
			uint64_t b = zt_xorshift64(&rng) & mask;

			check_pair(v, w, op, fn, name, a, b);
		}
	}
}

static void
run_unary(zt_variant v, uint32_t w, uint64_t samples)
{
	uint64_t mask = zt_width_mask(w);

	if (w <= 8) {
		for (uint64_t a = 0; a <= mask; a++)
			check_unary(v, w, a);
		return;
	}

	{
		uint64_t rng = 0xF00DFACE12345678ULL ^ ((uint64_t)v << 16) ^ w;

		for (uint64_t i = 0; i < samples; i++)
			check_unary(v, w, zt_xorshift64(&rng) & mask);
	}
}

int
main(void)
{
	zt_variant variants[2] = {ZT_VARIANT_LINEAR, ZT_VARIANT_LOG};

	for (int vi = 0; vi < 2; vi++) {
		zt_variant v = variants[vi];

		run_pairs(v, ZT_T8, OP_ADD, zt_add, "add", 0);
		run_pairs(v, ZT_T8, OP_SUB, zt_sub, "sub", 0);
		run_pairs(v, ZT_T8, OP_MUL, zt_mul, "mul", 0);
		run_pairs(v, ZT_T8, OP_DIV, zt_div, "div", 0);
		run_unary(v, ZT_T8, 0);
		printf("  %s T8: OK (exaustivo)\n", zt_variant_name(v));

		run_pairs(v, ZT_T16, OP_ADD, zt_add, "add", PAIR_SAMPLES);
		run_pairs(v, ZT_T16, OP_SUB, zt_sub, "sub", PAIR_SAMPLES);
		run_pairs(v, ZT_T16, OP_MUL, zt_mul, "mul", PAIR_SAMPLES);
		run_pairs(v, ZT_T16, OP_DIV, zt_div, "div", PAIR_SAMPLES);
		run_unary(v, ZT_T16, PAIR_SAMPLES);
		printf("  %s T16: OK (%u amostras)\n", zt_variant_name(v),
		       PAIR_SAMPLES);

		run_pairs(v, ZT_T32, OP_ADD, zt_add, "add", PAIR_SAMPLES);
		run_pairs(v, ZT_T32, OP_SUB, zt_sub, "sub", PAIR_SAMPLES);
		run_pairs(v, ZT_T32, OP_MUL, zt_mul, "mul", PAIR_SAMPLES);
		run_pairs(v, ZT_T32, OP_DIV, zt_div, "div", PAIR_SAMPLES);
		run_unary(v, ZT_T32, PAIR_SAMPLES);
		printf("  %s T32: OK (%u amostras)\n", zt_variant_name(v),
		       PAIR_SAMPLES);
	}

	printf("test_alu OK\n");

	return 0;
}
