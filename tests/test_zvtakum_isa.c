#include "zt_test.h"
#include "zvtakum/rvv.h"
#include "zvtakum/takum_alu.h"

#include <string.h>

#define VLEN 256u

static uint32_t
vt(uint32_t sew, uint32_t lmul, int ta, int ma)
{
	uint32_t vsew = (sew == 8u) ? 0u : (sew == 16u) ? 1u : 2u;
	uint32_t vlmul = (lmul == 1u) ? 0u : (lmul == 2u) ? 1u
	                 : (lmul == 4u) ? 2u
	                                : 3u;

	return (uint32_t)((ma << 7) | (ta << 6) | (vsew << 3) | vlmul);
}

static uint32_t
rand_bits(uint64_t *rng, uint32_t width)
{
	return (uint32_t)(zt_xorshift64(rng) & zt_width_mask(width));
}

static void
test_elementwise(zt_variant v)
{
	uint64_t rng = 0x123456789ABCDEFULL ^ (uint64_t)v;
	rvv_state s;
	uint32_t vlmax;

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = 32;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(8, 1, 0, 0))) == RVV_OK,
	      "vsetvli e8");
	vlmax = rvv_vlmax(&s);
	CHECK(vlmax == 32, "vlmax=%u", vlmax);

	for (int trial = 0; trial < 200; trial++) {
		for (uint32_t i = 0; i < vlmax; i++) {
			rvv_elem_set(&s, 2, i, rand_bits(&rng, 8));
			rvv_elem_set(&s, 3, i, rand_bits(&rng, 8));
		}
		CHECK(rvv_exec(&s, rvv_enc_zt_arith(1, 1, 2, 3, 1)) == RVV_OK,
		      "vtadd");
		for (uint32_t i = 0; i < vlmax; i++) {
			uint64_t want = zt_add(v, 8, rvv_elem_get(&s, 2, i),
			                       rvv_elem_get(&s, 3, i));

			CHECK(rvv_elem_get(&s, 1, i) == want,
			      "vtadd (%s) i=%u a=%llu b=%llu got=%llu want=%llu",
			      zt_variant_name(v), i,
			      (unsigned long long)rvv_elem_get(&s, 2, i),
			      (unsigned long long)rvv_elem_get(&s, 3, i),
			      (unsigned long long)rvv_elem_get(&s, 1, i),
			      (unsigned long long)want);
		}

		CHECK(rvv_exec(&s, rvv_enc_zt_arith(2, 1, 2, 3, 1)) == RVV_OK,
		      "vtsub");
		CHECK(rvv_exec(&s, rvv_enc_zt_arith(3, 4, 2, 3, 1)) == RVV_OK,
		      "vtmul");
		for (uint32_t i = 0; i < vlmax; i++) {
			CHECK(rvv_elem_get(&s, 1, i) ==
			          zt_sub(v, 8, rvv_elem_get(&s, 2, i),
			                 rvv_elem_get(&s, 3, i)),
			      "vtsub i=%u", i);
			CHECK(rvv_elem_get(&s, 4, i) ==
			          zt_mul(v, 8, rvv_elem_get(&s, 2, i),
			                 rvv_elem_get(&s, 3, i)),
			      "vtmul i=%u", i);
		}
	}
}

static void
test_ncvt(zt_variant v)
{
	uint64_t rng = 0xFACEB00C12345ULL ^ (uint64_t)v;
	rvv_state s;

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = 16;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(16, 1, 0, 0))) == RVV_OK,
	      "vsetvli e16");

	for (int trial = 0; trial < 200; trial++) {
		for (uint32_t i = 0; i < 16; i++)
			rvv_elem_set_w(&s, 2, i, 32, rand_bits(&rng, 32));
		CHECK(rvv_exec(&s, rvv_enc_zt_arith(0, 1, 2, 0, 1)) == RVV_OK,
		      "vncvt");
		for (uint32_t i = 0; i < 16; i++) {
			uint64_t src = rvv_elem_get_w(&s, 2, i, 32);
			uint64_t want = zt_convert(v, 32, 16, src);

			CHECK(rvv_elem_get(&s, 1, i) == want,
			      "vncvt (%s) i=%u src=%08llx got=%04llx want=%04llx",
			      zt_variant_name(v), i,
			      (unsigned long long)src,
			      (unsigned long long)rvv_elem_get(&s, 1, i),
			      (unsigned long long)want);
		}
	}
}

static void
test_dot(zt_variant v)
{
	uint64_t rng = 0xD0D0D0D0ABCDEFULL ^ (uint64_t)v;
	rvv_state s;

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = 32;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(8, 1, 0, 0))) == RVV_OK,
	      "vsetvli e8");

	for (int trial = 0; trial < 100; trial++) {
		uint64_t acc = rand_bits(&rng, 16);

		for (uint32_t i = 0; i < 32; i++) {
			rvv_elem_set(&s, 2, i, rand_bits(&rng, 8));
			rvv_elem_set(&s, 3, i, rand_bits(&rng, 8));
		}
		rvv_elem_set_w(&s, 1, 0, 16, acc);
		CHECK(rvv_exec(&s, rvv_enc_zt_arith(4, 1, 2, 3, 1)) == RVV_OK,
		      "vtdot");

		for (uint32_t i = 0; i < 32; i++) {
			uint64_t wa = zt_convert(v, 8, 16, rvv_elem_get(&s, 2, i));
			uint64_t wb = zt_convert(v, 8, 16, rvv_elem_get(&s, 3, i));
			uint64_t p = zt_mul(v, 16, wa, wb);

			acc = zt_add(v, 16, acc, p);
		}
		CHECK(rvv_elem_get_w(&s, 1, 0, 16) == acc,
		      "vtdot (%s) got=%04llx want=%04llx",
		      zt_variant_name(v),
		      (unsigned long long)rvv_elem_get_w(&s, 1, 0, 16),
		      (unsigned long long)acc);
	}
}

static void
test_masking(void)
{
	zt_variant v = ZT_VARIANT_LOG;
	uint64_t rng = 0x5555AAAA9999ULL;
	rvv_state s;

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = 4;
	/* ta=1, ma=0 (mascara undisturbed) */
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(8, 1, 1, 0))) == RVV_OK,
	      "vsetvli");
	memset(s.vreg[0], 0, sizeof(s.vreg[0]));
	s.vreg[0][0] = 0x05; /* elementos 0 e 2 ativos */
	memset(s.vreg[1], 0xEE, sizeof(s.vreg[1]));
	for (uint32_t i = 0; i < 32; i++) {
		rvv_elem_set(&s, 2, i, rand_bits(&rng, 8));
		rvv_elem_set(&s, 3, i, rand_bits(&rng, 8));
	}
	CHECK(rvv_exec(&s, rvv_enc_zt_arith(1, 1, 2, 3, 0)) == RVV_OK,
	      "vtadd mascarado");
	CHECK(rvv_elem_get(&s, 1, 0) ==
	          zt_add(v, 8, rvv_elem_get(&s, 2, 0), rvv_elem_get(&s, 3, 0)),
	      "elem ativo 0");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 1) == 0xEE,
	      "elem mascarado undisturbed");
	CHECK(rvv_elem_get(&s, 1, 2) ==
	          zt_add(v, 8, rvv_elem_get(&s, 2, 2), rvv_elem_get(&s, 3, 2)),
	      "elem ativo 2");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 3) == 0xEE,
	      "elem mascarado 3 undisturbed");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 5) == 0xFF,
	      "tail agnostico (ta=1)");
}

int
main(void)
{
	zt_variant variants[2] = {ZT_VARIANT_LINEAR, ZT_VARIANT_LOG};

	for (int i = 0; i < 2; i++) {
		test_elementwise(variants[i]);
		test_ncvt(variants[i]);
		test_dot(variants[i]);
		printf("  %s: OK\n", zt_variant_name(variants[i]));
	}

	test_masking();
	printf("  mascaramento: OK\n");

	printf("test_zvtakum_isa OK\n");

	return 0;
}
