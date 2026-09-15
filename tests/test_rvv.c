#include "zt_test.h"
#include "zvtakum/rvv.h"

#include <math.h>
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

static void
test_vsetvli(void)
{
	rvv_state s;

	rvv_init(&s, VLEN);
	s.x[10] = 100;

	CHECK(rvv_exec(&s, rvv_enc_vsetvli(1, 10, vt(8, 1, 1, 1))) == RVV_OK,
	      "vsetvli e8,m1 falhou");
	CHECK(s.sew == 8 && s.lmul == 1, "sew/lmul incorretos");
	CHECK(s.vl == 32 && s.x[1] == 32, "vl incorreto: %u (x1=%llu)", s.vl,
	      (unsigned long long)s.x[1]);

	CHECK(rvv_exec(&s, rvv_enc_vsetvli(2, 10, vt(32, 1, 0, 0))) == RVV_OK,
	      "vsetvli e32 falhou");
	CHECK(s.vl == 8, "vl incorreto para e32: %u", s.vl);

	CHECK(rvv_exec(&s, rvv_enc_vsetivli(3, 5, vt(16, 2, 1, 1))) == RVV_OK,
	      "vsetivli falhou");
	CHECK(s.vl == 5 && s.x[3] == 5, "vsetivli vl=%u", s.vl);
	CHECK(s.sew == 16 && s.lmul == 2, "vsetivli sew/lmul");

	CHECK(rvv_vsetvli(&s, 0, 0, 1, vt(16, 1, 0, 0)) == RVV_OK,
	      "vsetvli x0, x0 falhou");
	CHECK(s.vl == 16, "vlmax e16,m1 = 16, obtido %u", s.vl);
	CHECK(s.csr_writes >= 4, "contador de CSRs nao avancou");
}

static void
test_load_store(void)
{
	rvv_state s;
	float vals[4] = {1.5f, -2.0f, 3.25f, 0.0f};
	float out[4] = {0};

	rvv_init(&s, VLEN);
	s.x[10] = 4;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(32, 1, 0, 0))) == RVV_OK,
	      "vsetvli");
	memcpy(s.mem, vals, sizeof(vals));
	s.x[5] = 0;
	CHECK(rvv_exec(&s, rvv_enc_load(32, 1, 5, 1)) == RVV_OK, "vle32");
	for (int i = 0; i < 4; i++)
		CHECK(u2f((uint32_t)rvv_elem_get(&s, 1, i)) == vals[i],
		      "vle32 elemento %d", i);

	s.x[6] = 64;
	CHECK(rvv_exec(&s, rvv_enc_store(32, 1, 6, 1)) == RVV_OK, "vse32");
	memcpy(out, s.mem + 64, sizeof(out));
	for (int i = 0; i < 4; i++)
		CHECK(out[i] == vals[i], "vse32 elemento %d", i);
}

static void
test_mask_tail(void)
{
	rvv_state s;

	rvv_init(&s, VLEN);
	/* e8, m1, ta=1, ma=1; vl=3 de 32 */
	s.x[10] = 3;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(8, 1, 1, 1))) == RVV_OK,
	      "vsetvli");
	/* mascara: elementos 0 e 2 ativos */
	memset(s.vreg[0], 0, sizeof(s.vreg[0]));
	s.vreg[0][0] = 0x05;
	/* preenche v1 com sentinela 0xEE */
	memset(s.vreg[1], 0xEE, sizeof(s.vreg[1]));
	s.x[5] = 0;
	for (int i = 0; i < 32; i++)
		s.mem[i] = (uint8_t)(i + 1);
	CHECK(rvv_exec(&s, rvv_enc_load(8, 1, 5, 0)) == RVV_OK, "vle8 mascarado");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 0) == 1, "elem 0 ativo");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 1) == 0xFF, "elem 1 mascara agnostica");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 2) == 3, "elem 2 ativo");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 3) == 0xFF, "tail agnostico");
	CHECK((uint8_t)rvv_elem_get(&s, 1, 31) == 0xFF, "tail agnostico fim");
}

static void
test_fp(void)
{
	rvv_state s;

	rvv_init(&s, VLEN);
	s.x[10] = 4;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(32, 1, 0, 0))) == RVV_OK,
	      "vsetvli");
	for (int i = 0; i < 4; i++) {
		rvv_elem_set(&s, 2, (uint32_t)i, f2u((float)(i + 1)));
		rvv_elem_set(&s, 3, (uint32_t)i, f2u((float)(10 * (i + 1))));
	}
	CHECK(rvv_exec(&s, rvv_enc_vfmul(1, 2, 3, 0, 1)) == RVV_OK, "vfmul.vv");
	for (int i = 0; i < 4; i++)
		CHECK(u2f((uint32_t)rvv_elem_get(&s, 1, i)) ==
		          (float)(10 * (i + 1) * (i + 1)),
		      "vfmul elemento %d", i);

	CHECK(rvv_exec(&s, rvv_enc_vfredusum(4, 1, 1)) == RVV_OK,
	      "vfredusum");
	CHECK(u2f((uint32_t)rvv_elem_get(&s, 4, 0)) == 300.0f,
	      "vfredusum = %g", u2f((uint32_t)rvv_elem_get(&s, 4, 0)));

	s.x[11] = f2u(0.5f);
	CHECK(rvv_exec(&s, rvv_enc_vfmul(5, 2, 11, 1, 1)) == RVV_OK,
	      "vfmul.vf");
	CHECK(u2f((uint32_t)rvv_elem_get(&s, 5, 3)) == 2.0f, "vfmul.vf");
}

static void
test_permute_move(void)
{
	rvv_state s;

	rvv_init(&s, VLEN);
	s.x[10] = 4;
	CHECK(rvv_exec(&s, rvv_enc_vsetvli(0, 10, vt(32, 1, 0, 0))) == RVV_OK,
	      "vsetvli");
	for (int i = 0; i < 4; i++)
		rvv_elem_set(&s, 2, (uint32_t)i, (uint64_t)(100 + i));
	/* indices 3,2,1,0 */
	for (int i = 0; i < 4; i++)
		rvv_elem_set(&s, 3, (uint32_t)i, (uint64_t)(3 - i));
	CHECK(rvv_exec(&s, rvv_enc_vrgather_vv(1, 2, 3, 1)) == RVV_OK,
	      "vrgather");
	for (int i = 0; i < 4; i++)
		CHECK(rvv_elem_get(&s, 1, (uint32_t)i) ==
		          (uint64_t)(100 + 3 - i),
		      "vrgather elemento %d", i);

	CHECK(rvv_exec(&s, rvv_enc_vmv_v_v(5, 2)) == RVV_OK, "vmv.v.v");
	CHECK(rvv_elem_get(&s, 5, 2) == 102, "vmv.v.v");

	CHECK(rvv_exec(&s, rvv_enc_vmv_v_i(6, -3)) == RVV_OK, "vmv.v.i");
	CHECK((int32_t)rvv_elem_get(&s, 6, 1) == -3, "vmv.v.i");

	s.x[12] = f2u(2.5f);
	CHECK(rvv_exec(&s, rvv_enc_vfmv_v_f(7, 12)) == RVV_OK, "vfmv.v.f");
	CHECK(u2f((uint32_t)rvv_elem_get(&s, 7, 0)) == 2.5f, "vfmv.v.f");
}

int
main(void)
{
	test_vsetvli();
	test_load_store();
	test_mask_tail();
	test_fp();
	test_permute_move();

	printf("test_rvv OK\n");

	return 0;
}
