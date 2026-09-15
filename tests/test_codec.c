#include "zt_test.h"
#include "zvtakum/takum_codec.h"

#include <math.h>
#include <stdio.h>

#define RT_SAMPLES_T32      200000u
#define FIELDS_SAMPLES_T32  100000u
#define DIV_SAMPLES         200000u

static void
check_fields(zt_variant v, uint32_t w, uint64_t b)
{
	zt_fields f;
	uint32_t n = (w < 12u) ? 12u : w;

	zt_decode(v, w, b, &f);
	CHECK(f.r >= 0 && f.r <= 7, "regime fora do intervalo: r=%d (T%u b=%llu)",
	      f.r, w, (unsigned long long)b);
	CHECK(f.p == (int32_t)w - f.r - 5,
	      "p inconsistente: T%u b=%llu p=%d r=%d", w,
	      (unsigned long long)b, f.p, f.r);
	CHECK((int32_t)f.p12 == (int32_t)(n - (uint32_t)f.r - 5u),
	      "p12 inconsistente: T%u b=%llu p12=%u r=%d", w,
	      (unsigned long long)b, f.p12, f.r);
	if (!f.is_nar && !f.is_zero)
		CHECK(f.c >= -255 && f.c <= 254,
		      "caracteristica fora do intervalo: c=%d (T%u b=%llu)",
		      f.c, w, (unsigned long long)b);
}

static void
test_monotonic(zt_variant v, uint32_t w)
{
	uint64_t mask = zt_width_mask(w);
	int64_t lo = -(INT64_C(1) << (w - 1));
	int64_t hi = (INT64_C(1) << (w - 1)) - 1;
	long double prev = 0.0L;
	int have = 0;

	for (int64_t i = lo; i <= hi; i++) {
		uint64_t b = (uint64_t)i & mask;
		zt_fields f;

		zt_decode(v, w, b, &f);
		if (f.is_nar)
			continue;
		if (have)
			CHECK(f.value > prev,
			      "monotonicidade %s T%u: bits=%llu prev=%.20Lg cur=%.20Lg",
			      zt_variant_name(v), w, (unsigned long long)b,
			      prev, f.value);
		prev = f.value;
		have = 1;
	}
}

static void
test_negation(zt_variant v, uint32_t w)
{
	uint64_t mask = zt_width_mask(w);
	uint64_t n = (w <= 16) ? mask : 200000u;
	uint64_t rng = 0x5DEECE66DADD1ULL ^ ((uint64_t)v << 24) ^ w;

	for (uint64_t i = 0; i <= n; i++) {
		uint64_t b = (w <= 16) ? i : (zt_xorshift64(&rng) & mask);
		zt_fields f, g;
		uint64_t nb;

		if (zt_is_nar(v, w, b))
			continue;
		nb = ((~b) + 1u) & mask;
		zt_decode(v, w, b, &f);
		zt_decode(v, w, nb, &g);
		CHECK(g.value == -f.value,
		      "negacao %s T%u: bits=%llu v=%.20Lg neg(v)=%.20Lg",
		      zt_variant_name(v), w, (unsigned long long)b, f.value,
		      g.value);
	}
}

static void
test_inversion(zt_variant v, uint32_t w)
{
	uint64_t mask = zt_width_mask(w);
	uint64_t top = zt_nar_bits(w);

	if (v != ZT_VARIANT_LOG)
		return;

	{
		uint64_t n = (w <= 16) ? mask : 200000u;
		uint64_t rng = 0x1D872B41A5B3C7D9ULL ^ w;

		for (uint64_t i = 0; i <= n; i++) {
			uint64_t b = (w <= 16) ? i
			                       : (zt_xorshift64(&rng) & mask);
			zt_fields f, g;
			uint64_t ib, inv;

			if (zt_is_nar(v, w, b))
				continue;
			ib = (b & top) | ((~b) & (mask ^ top));
			inv = (ib + 1u) & mask;
			zt_decode(v, w, b, &f);
			zt_decode(v, w, inv, &g);
			if (f.value == 0.0L) {
				CHECK(g.is_nar,
				      "inversao %s T%u: inverso de 0 deveria ser NaR (bits=%llu -> %llu)",
				      zt_variant_name(v), w,
				      (unsigned long long)b,
				      (unsigned long long)inv);
				continue;
			}
			{
				long double want = 1.0L / f.value;
				long double rel = fabsl(g.value - want) /
				                  fabsl(want);

				CHECK(rel < 1e-12L,
				      "inversao %s T%u: bits=%llu v=%.20Lg inv=%.20Lg (rel=%.3Lg)",
				      zt_variant_name(v), w,
				      (unsigned long long)b, f.value, g.value,
				      rel);
			}
		}
	}
}

static void
check_roundtrip_one(zt_variant v, uint32_t w, uint64_t b)
{
	zt_fields f;

	zt_decode(v, w, b, &f);

	if (f.is_nar) {
		CHECK(zt_is_nar(v, w, zt_from_double(v, w, NAN)),
		      "from_double(NAN) != NaR (%s T%u)", zt_variant_name(v), w);
		CHECK(zt_is_nar(v, w, zt_round_algo1(v, w, nanl(""))),
		      "algo1(NaN) != NaR (%s T%u)", zt_variant_name(v), w);
		return;
	}

	{
		double d = zt_to_double(v, w, b);
		uint64_t back;
		long double rel;

		CHECK(!isnan(d), "to_double(%s T%u bits=%llu) = NaN",
		      zt_variant_name(v), w, (unsigned long long)b);
		back = zt_from_double(v, w, d);
		CHECK(back == b,
		      "roundtrip RNE %s T%u: bits=%llu -> %g -> %llu",
		      zt_variant_name(v), w, (unsigned long long)b, d,
		      (unsigned long long)back);

		rel = fabsl((long double)d - f.value) /
		      (fabsl(f.value) > 0.0L ? fabsl(f.value) : 1.0L);
		CHECK(rel < 1e-13L,
		      "valor decodificado divergente de libtakum: %s T%u bits=%llu rel=%.3Lg",
		      zt_variant_name(v), w, (unsigned long long)b, rel);
	}

	{
		uint64_t back = zt_round_algo1(v, w, f.value);

		CHECK(back == b,
		      "roundtrip Algo1 %s T%u: bits=%llu v=%.20Lg -> %llu",
		      zt_variant_name(v), w, (unsigned long long)b, f.value,
		      (unsigned long long)back);
	}
}

static void
test_roundtrip(zt_variant v, uint32_t w, uint64_t samples)
{
	uint64_t mask = zt_width_mask(w);

	if (w <= 16) {
		for (uint64_t b = 0; b <= mask; b++)
			check_roundtrip_one(v, w, b);
		return;
	}

	for (uint64_t i = 0; i < samples; i++) {
		uint64_t rng = 0x9E3779B97F4A7C15ULL + i;
		uint64_t b = zt_xorshift64(&rng) & mask;

		check_roundtrip_one(v, w, b);
	}

	{
		uint64_t edges[6] = {0u, 1u, 2u, mask / 2u,
		                     (mask / 2u) | 1u, mask};

		for (int i = 0; i < 6; i++)
			check_roundtrip_one(v, w, edges[i]);
	}
}

static void
test_divergence(zt_variant v, uint32_t w)
{
	uint64_t rng = 0x243F6A8885A308D3ULL;
	uint64_t mism = 0, n = DIV_SAMPLES;

	for (uint64_t i = 0; i < n; i++) {
		long double ex = (2.0L * (long double)zt_rand_unit(&rng) - 1.0L) *
		                 110.0L;
		long double x = expl(ex);
		uint64_t a, b;

		if (zt_rand_unit(&rng) < 0.5)
			x = -x;
		a = zt_round_to(v, w, x, ZT_ROUND_RNE);
		b = zt_round_to(v, w, x, ZT_ROUND_ALGO1);
		if (a != b)
			mism++;
	}

	printf("  divergencia RNE vs Algo1 %s T%u: %llu/%llu (%.4f%%)\n",
	       zt_variant_name(v), w, (unsigned long long)mism,
	       (unsigned long long)n, 100.0 * (double)mism / (double)n);
}

int
main(void)
{
	zt_variant variants[2] = {ZT_VARIANT_LINEAR, ZT_VARIANT_LOG};
	uint32_t widths[3] = {ZT_T8, ZT_T16, ZT_T32};

	for (int vi = 0; vi < 2; vi++) {
		zt_variant v = variants[vi];

		for (int wi = 0; wi < 3; wi++) {
			uint32_t w = widths[wi];
			uint64_t mask = zt_width_mask(w);
			uint64_t fsamples = (w <= 16) ? (mask + 1u) : FIELDS_SAMPLES_T32;

			if (w <= 16) {
				for (uint64_t b = 0; b <= mask; b++)
					check_fields(v, w, b);
				test_monotonic(v, w);
			} else {
				uint64_t rng = 0xABCDEF0123456789ULL;

				for (uint64_t i = 0; i < fsamples; i++)
					check_fields(v, w,
					             zt_xorshift64(&rng) & mask);
			}

			test_negation(v, w);
			test_inversion(v, w);
			test_roundtrip(v, w, RT_SAMPLES_T32);
			test_divergence(v, w);

			printf("  %s T%u: OK\n", zt_variant_name(v), w);
		}
	}

	printf("test_codec OK\n");

	return 0;
}
