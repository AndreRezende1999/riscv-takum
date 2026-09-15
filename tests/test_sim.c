#include "zt_test.h"
#include "zvtakum/asm.h"
#include "zvtakum/rvv.h"
#include "zvtakum/takum_alu.h"

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

static uint32_t
asm1(const char *text)
{
	uint32_t w = 0;

	CHECK(zt_asm_encode(text, &w) == 0, "asm falhou: %s", text);
	return w;
}

static uint32_t
asm_must_fail(const char *text)
{
	uint32_t w = 0;

	CHECK(zt_asm_encode(text, &w) != 0, "asm deveria falhar: %s", text);
	return w;
}

static void
test_asm_roundtrip(void)
{
	static const char *progs[] = {
	    "vsetvli x1, x10, e32, m1, ta, ma",
	    "vsetivli x0, 5, e16, m2, tu, mu",
	    "vle32.v v1, (x5)",
	    "vse8.v v3, (x6)",
	    "vfadd.vv v1, v2, v3",
	    "vfmul.vf v1, v2, x3",
	    "vfredusum.vs v1, v2",
	    "vrgather.vv v1, v2, v3",
	    "vmv.v.v v1, v2",
	    "vmv.v.i v1, -3",
	    "vfmv.v.f v1, x3",
	    "vtadd.vv v1, v2, v3",
	    "vtsub.vv v1, v2, v3, v0.t",
	    "vtmul.vv v4, v5, v6",
	    "vtdot.vv v1, v2, v3",
	    "vncvt.t.t v1, v2",
	};

	for (size_t i = 0; i < sizeof(progs) / sizeof(progs[0]); i++) {
		uint32_t w = asm1(progs[i]);
		char buf[160];
		uint32_t w2;

		CHECK(zt_disasm(w, buf, sizeof(buf)) > 0, "disasm");
		CHECK(zt_asm_encode(buf, &w2) == 0 &&
		          w2 == w,
		      "roundtrip asm/disasm falhou: %s -> %s (0x%08x != 0x%08x)",
		      progs[i], buf, w, w2);
	}

	asm_must_fail("vtadd.vv v1, v2, 3");
	asm_must_fail("vfmax.vv v1, v2, v3");
}

static void
test_axpy_program(void)
{
	rvv_state s;
	float x[4] = {1.0f, 2.0f, 3.0f, 4.0f};
	float y[4] = {10.0f, 20.0f, 30.0f, 40.0f};
	float alpha = 0.5f;
	float out[4] = {0};
	uint32_t prog[16];
	int n = 0;

	rvv_init(&s, VLEN);
	s.x[10] = 4;
	s.x[20] = 0;  /* x */
	s.x[21] = 16; /* y */
	s.x[22] = 32; /* out */
	s.x[23] = f2u(alpha);
	memcpy(s.mem, x, sizeof(x));
	memcpy(s.mem + 16, y, sizeof(y));

	prog[n++] = rvv_enc_vsetvli(0, 10, vt(32, 1, 0, 0));
	prog[n++] = rvv_enc_load(32, 1, 20, 1);         /* v1 = x */
	prog[n++] = rvv_enc_load(32, 2, 21, 1);         /* v2 = y */
	prog[n++] = rvv_enc_vfmul(2, 2, 23, 1, 1);      /* v2 = y * alpha */
	prog[n++] = rvv_enc_vfadd(1, 1, 2, 0, 1);       /* v1 = x + y*alpha */
	prog[n++] = rvv_enc_store(32, 1, 22, 1);        /* out = v1 */

	for (int i = 0; i < n; i++)
		CHECK(rvv_exec(&s, prog[i]) == RVV_OK, "exec axpy %d", i);

	memcpy(out, s.mem + 32, sizeof(out));
	for (int i = 0; i < 4; i++)
		CHECK(fabsf(out[i] - (x[i] + alpha * y[i])) < 1e-6f,
		      "axpy[%d] = %g", i, out[i]);

	CHECK(s.insn_count == (uint64_t)n, "insn_count=%llu",
	      (unsigned long long)s.insn_count);
	CHECK(s.insn_rvv == (uint64_t)n, "insn_rvv=%llu",
	      (unsigned long long)s.insn_rvv);
	CHECK(s.csr_writes == 1, "csr_writes=%llu",
	      (unsigned long long)s.csr_writes);
}

static void
test_takum_program(zt_variant v)
{
	uint64_t rng = 0x0BADF00D1234ULL ^ (uint64_t)v;
	rvv_state s;
	uint32_t prog[8];
	uint8_t a[8], b[8];

	rvv_init(&s, VLEN);
	s.variant = v;
	s.x[10] = 8;
	s.x[20] = 0;
	s.x[21] = 32;
	s.x[22] = 64;

	for (int i = 0; i < 8; i++) {
		a[i] = (uint8_t)(zt_xorshift64(&rng) & 0xff);
		b[i] = (uint8_t)(zt_xorshift64(&rng) & 0xff);
	}
	memcpy(s.mem, a, sizeof(a));
	memcpy(s.mem + 32, b, sizeof(b));

	prog[0] = rvv_enc_vsetvli(0, 10, vt(8, 1, 0, 0));
	prog[1] = rvv_enc_load(8, 1, 20, 1);
	prog[2] = rvv_enc_load(8, 2, 21, 1);
	prog[3] = rvv_enc_zt_arith(1, 3, 1, 2, 1); /* vtadd */
	prog[4] = rvv_enc_zt_arith(3, 4, 1, 2, 1); /* vtmul */
	prog[5] = rvv_enc_store(8, 3, 22, 1);
	prog[6] = rvv_enc_zt_arith(4, 5, 1, 2, 1); /* vtdot (acc T16 em v5) */

	for (int i = 0; i < 7; i++)
		CHECK(rvv_exec(&s, prog[i]) == RVV_OK, "exec takum %d", i);

	for (int i = 0; i < 8; i++) {
		CHECK(s.mem[64 + i] ==
		          (uint8_t)zt_add(v, 8, a[i], b[i]),
		      "vtadd[%d]", i);
		CHECK(rvv_elem_get(&s, 4, (uint32_t)i) ==
		          zt_mul(v, 8, a[i], b[i]),
		      "vtmul[%d]", i);
	}

	{
		uint64_t acc = 0; /* v5 inicia zerado */

		for (int i = 0; i < 8; i++) {
			uint64_t wa = zt_convert(v, 8, 16, a[i]);
			uint64_t wb = zt_convert(v, 8, 16, b[i]);

			acc = zt_add(v, 16, acc, zt_mul(v, 16, wa, wb));
		}
		CHECK(rvv_elem_get_w(&s, 5, 0, 16) == acc, "vtdot (%s)",
		      zt_variant_name(v));
	}

	CHECK(s.insn_zvtakum == 3, "insn_zvtakum=%llu",
	      (unsigned long long)s.insn_zvtakum);
}

int
main(void)
{
	test_asm_roundtrip();
	test_axpy_program();
	test_takum_program(ZT_VARIANT_LINEAR);
	test_takum_program(ZT_VARIANT_LOG);

	printf("test_sim OK\n");

	return 0;
}
