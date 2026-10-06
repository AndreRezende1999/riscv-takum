#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "zvtakum/rvv.h"

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

static uint64_t
elem_ones(uint32_t width)
{
	return (width >= 64u) ? UINT64_MAX
	                      : ((UINT64_C(1) << width) - 1u);
}

static int
mask_get(const rvv_state *s, uint32_t idx)
{
	return (s->vreg[0][idx >> 3] >> (idx & 7u)) & 1u;
}

static void
fill_out(rvv_state *s, uint32_t vreg, uint32_t idx, uint32_t width,
         int agnostic)
{
	if (agnostic)
		rvv_elem_set_w(s, vreg, idx, width, elem_ones(width));
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

static int
fp_binop(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm,
         int is_mul, int vf)
{
	float bscalar = vf ? u2f((uint32_t)s->x[vs1]) : 0.0f;
	uint32_t vlmax = rvv_vlmax(s);

	if (s->sew != 32u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			float a = u2f((uint32_t)rvv_elem_get(s, vs2, i));
			float b = vf ? bscalar
			             : u2f((uint32_t)rvv_elem_get(s, vs1, i));
			float r = is_mul ? (a * b) : (a + b);

			rvv_elem_set(s, vd, i, f2u(r));
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, s->sew, s->vma);
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
fredusum(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vm)
{
	float acc = 0.0f;
	uint32_t vlmax = rvv_vlmax(s);

	if (s->sew != 32u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < s->vl; i++) {
		if (vm != 0u || mask_get(s, i) != 0) {
			acc += u2f((uint32_t)rvv_elem_get(s, vs2, i));
			s->elements++;
		}
	}

	if (s->vl > 0u) {
		if (vm != 0u || mask_get(s, 0u) != 0)
			rvv_elem_set(s, vd, 0u, f2u(acc));
		else
			fill_out(s, vd, 0u, s->sew, s->vma);
	}
	for (uint32_t i = s->vl + (s->vl == 0u); i < vlmax; i++)
		fill_out(s, vd, i, s->sew, s->vta);

	return RVV_OK;
}


int main(void) {
 static rvv_state s;
 printf("E4M3 +448: got=0x%02x expected=0x7e\n", f8_e4m3_encode(448));
 printf("E4M3 -448: got=0x%02x expected=0xfe\n", f8_e4m3_encode(-448));
 rvv_init(&s,256); s.vl=3; rvv_vsetvli(&s,0,0,1,16);
 printf("vsetvli rd=x0 rs1=x0: got_vl=%u expected=3\n",s.vl);
 rvv_init(&s,256); s.vl=3; rvv_vsetvli(&s,1,0,1,16);
 printf("vsetvli rd=x1 rs1=x0: got_vl=%u expected=8\n",s.vl);
 rvv_init(&s,256);s.vl=2;s.vreg[0][0]=2;
 rvv_elem_set(&s,2,0,f2u(2));rvv_elem_set(&s,2,1,f2u(3));
 rvv_elem_set(&s,1,0,f2u(100));fredusum(&s,1,2,0);
 printf("masked reduction bit0=0 bit1=1 zero seed: got=%.1f expected=3.0\n",u2f(rvv_elem_get(&s,1,0)));
 rvv_init(&s,256);s.vl=0;s.vta=1;
 rvv_elem_set(&s,1,0,f2u(100));fp_binop(&s,1,2,3,1,0,0);
 printf("vl=0 FP add: got=0x%08x expected=0x%08x (unchanged)\n",(uint32_t)rvv_elem_get(&s,1,0),f2u(100));
 rvv_init(&s,256);s.vl=2;s.vstart=1;
 rvv_elem_set(&s,1,0,f2u(100));rvv_elem_set(&s,2,0,f2u(2));rvv_elem_set(&s,3,0,f2u(4));
 fp_binop(&s,1,2,3,1,0,0);
 printf("vstart=1 FP add lane0: got=%.1f expected=100.0 (unchanged)\n",u2f(rvv_elem_get(&s,1,0)));
 return 0;
}
