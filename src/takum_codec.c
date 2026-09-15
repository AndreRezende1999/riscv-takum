#include "zvtakum/takum_codec.h"

#include <math.h>
#include <string.h>

#include <takum.h>

uint64_t
zt_width_mask(uint32_t width)
{
	if (width >= 64)
		return UINT64_MAX;
	return (UINT64_C(1) << width) - 1;
}

const char *
zt_variant_name(zt_variant variant)
{
	return (variant == ZT_VARIANT_LOG) ? "log" : "linear";
}

uint64_t
zt_nar_bits(uint32_t width)
{
	return UINT64_C(1) << (width - 1);
}

int
zt_is_zero(zt_variant variant, uint32_t width, uint64_t bits)
{
	(void)variant;
	return (bits & zt_width_mask(width)) == 0;
}

uint64_t
zt_convert(zt_variant variant, uint32_t from_width, uint32_t to_width,
           uint64_t bits)
{
	uint64_t b = bits & zt_width_mask(from_width);

#define ZT_CONV_LINEAR(FW, TW)                                            \
	do {                                                              \
		if (from_width == (FW) && to_width == (TW))               \
			return (uint##TW##_t)takum##TW##_from_takum##FW(  \
			    (takum##FW)(uint##FW##_t)b);                  \
	} while (0)

#define ZT_CONV_LOG(FW, TW)                                                \
	do {                                                               \
		if (from_width == (FW) && to_width == (TW))                \
			return (uint##TW##_t)                              \
			    takum_log##TW##_from_takum_log##FW(            \
			        (takum_log##FW)(uint##FW##_t)b);           \
	} while (0)

	if (from_width == to_width)
		return b;

	if (variant == ZT_VARIANT_LOG) {
		ZT_CONV_LOG(8, 16);
		ZT_CONV_LOG(8, 32);
		ZT_CONV_LOG(16, 8);
		ZT_CONV_LOG(16, 32);
		ZT_CONV_LOG(32, 8);
		ZT_CONV_LOG(32, 16);
	} else {
		ZT_CONV_LINEAR(8, 16);
		ZT_CONV_LINEAR(8, 32);
		ZT_CONV_LINEAR(16, 8);
		ZT_CONV_LINEAR(16, 32);
		ZT_CONV_LINEAR(32, 8);
		ZT_CONV_LINEAR(32, 16);
	}

#undef ZT_CONV_LINEAR
#undef ZT_CONV_LOG

	return b;
}

int
zt_is_nar(zt_variant variant, uint32_t width, uint64_t bits)
{
	uint64_t v = bits & zt_width_mask(width);

	if (variant == ZT_VARIANT_LOG) {
		switch (width) {
		case 8:
			return v == (uint8_t)TAKUM_LOG8_NAR;
		case 16:
			return v == (uint16_t)TAKUM_LOG16_NAR;
		case 32:
			return v == (uint32_t)TAKUM_LOG32_NAR;
		default:
			break;
		}
	} else {
		switch (width) {
		case 8:
			return v == (uint8_t)TAKUM8_NAR;
		case 16:
			return v == (uint16_t)TAKUM16_NAR;
		case 32:
			return v == (uint32_t)TAKUM32_NAR;
		default:
			break;
		}
	}

	return v == zt_nar_bits(width);
}

void
zt_decode(zt_variant variant, uint32_t width, uint64_t bits, zt_fields *f)
{
	uint32_t n, pn, cmask;
	uint64_t e;

	memset(f, 0, sizeof(*f));
	f->variant = variant;
	f->width = width;
	f->bits = bits & zt_width_mask(width);

	f->is_zero = (f->bits == 0);
	f->is_nar = !f->is_zero && zt_is_nar(variant, width, f->bits);

	n = (width < 12u) ? 12u : width;
	e = (width < 12u) ? (f->bits << (12u - width)) : f->bits;

	f->s = (int)((e >> (n - 1)) & 1u);
	f->d = (int)((e >> (n - 2)) & 1u);
	{
		int ui = (int)((e >> (n - 5)) & 7u);
		f->r = f->d ? ui : 7 - ui;
	}
	pn = n - 5u - (uint32_t)f->r;
	cmask = (uint32_t)((UINT64_C(1) << f->r) - 1u);
	f->c = f->d
	       ? (int32_t)(((UINT64_C(1) << f->r) - 1u) + ((e >> pn) & cmask))
	       : (int32_t)(-(int64_t)(UINT64_C(1) << (f->r + 1)) + 1 +
	                   (int64_t)((e >> pn) & cmask));
	f->p12 = pn;
	f->p = (int32_t)width - f->r - 5;
	f->mant = e & ((UINT64_C(1) << pn) - 1u);
	f->m = (long double)f->mant / ldexpl(1.0L, (int)pn);

	if (f->is_zero) {
		f->value = 0.0L;
		return;
	}
	if (f->is_nar) {
		f->value = nanl("");
		return;
	}

	if (variant == ZT_VARIANT_LOG) {
		long double l = (long double)f->c + f->m;
		if (f->s)
			l = -l;
		f->value = expl(l / 2.0L);
		if (f->s)
			f->value = -f->value;
	} else {
		int ex = f->s ? -(f->c + 1) : f->c;
		long double frac = f->s ? (f->m - 2.0L) : (1.0L + f->m);
		f->value = frac * ldexpl(1.0L, ex);
	}
}

double
zt_to_double(zt_variant variant, uint32_t width, uint64_t bits)
{
	uint64_t b = bits & zt_width_mask(width);

	if (variant == ZT_VARIANT_LOG) {
		switch (width) {
		case 8:
			return takum_log8_to_float64((takum_log8)(uint8_t)b);
		case 16:
			return takum_log16_to_float64((takum_log16)(uint16_t)b);
		case 32:
			return takum_log32_to_float64((takum_log32)(uint32_t)b);
		default:
			break;
		}
	} else {
		switch (width) {
		case 8:
			return takum8_to_float64((takum8)(uint8_t)b);
		case 16:
			return takum16_to_float64((takum16)(uint16_t)b);
		case 32:
			return takum32_to_float64((takum32)(uint32_t)b);
		default:
			break;
		}
	}

	return NAN;
}

uint64_t
zt_from_double(zt_variant variant, uint32_t width, double x)
{
	uint64_t u = 0;

	if (variant == ZT_VARIANT_LOG) {
		switch (width) {
		case 8:
			u = (uint8_t)takum_log8_from_float64(x);
			break;
		case 16:
			u = (uint16_t)takum_log16_from_float64(x);
			break;
		case 32:
			u = (uint32_t)takum_log32_from_float64(x);
			break;
		default:
			break;
		}
	} else {
		switch (width) {
		case 8:
			u = (uint8_t)takum8_from_float64(x);
			break;
		case 16:
			u = (uint16_t)takum16_from_float64(x);
			break;
		case 32:
			u = (uint32_t)takum32_from_float64(x);
			break;
		default:
			break;
		}
	}

	return u & zt_width_mask(width);
}

static int
flog2u(uint32_t v)
{
	int r = -1;

	while (v != 0u) {
		v >>= 1;
		r++;
	}

	return r;
}

uint64_t
zt_round_algo1(zt_variant variant, uint32_t width, long double x)
{
	uint32_t n = width;
	uint32_t n1 = n + 1u;
	uint64_t mask = zt_width_mask(n);
	uint64_t nar = zt_nar_bits(n);
	long double vmax, vmin;
	long double ax, u, phi;
	uint64_t full, fb;
	uint32_t full_bits, q, C;
	uint64_t T;
	int s, guard, r, D, ui;

	if (isnan(x))
		return nar;
	if (x == 0.0L)
		return 0;

	vmax = (variant == ZT_VARIANT_LOG) ? expl(127.5L) : ldexpl(1.0L, 255);
	vmin = (variant == ZT_VARIANT_LOG) ? expl(-127.5L) : ldexpl(1.0L, -255);

	if (x <= -vmax)
		return nar | 1u;
	if (x >= vmax)
		return nar - 1u;
	if (x < 0.0L && x >= -vmin)
		return mask;
	if (x > 0.0L && x <= vmin)
		return 1u;

	s = x < 0.0L;
	ax = fabsl(x);

	if (variant == ZT_VARIANT_LOG) {
		u = 2.0L * logl(ax);
		if (s)
			u = -u;
		{
			int32_t c0 = (int32_t)floorl(u);
			phi = u - (long double)c0;
			D = (c0 >= 0);
			r = D ? flog2u((uint32_t)(c0 + 1))
			      : flog2u((uint32_t)(-c0));
			C = (uint32_t)(D ? (c0 - ((int32_t)1 << r) + 1)
			                 : (c0 + ((int32_t)1 << (r + 1)) - 1));
		}
	} else {
		int e2;
		long double m2 = frexpl(ax, &e2);
		long double g = 2.0L * m2 - 1.0L;
		int32_t c0;

		if (!s) {
			c0 = e2 - 1;
			phi = g;
		} else if (g == 0.0L) {
			c0 = -(e2 - 1);
			phi = 0.0L;
		} else {
			c0 = -(e2 - 1) - 1;
			phi = 1.0L - g;
		}
		D = (c0 >= 0);
		r = D ? flog2u((uint32_t)(c0 + 1))
		      : flog2u((uint32_t)(-c0));
		C = (uint32_t)(D ? (c0 - ((int32_t)1 << r) + 1)
		                 : (c0 + ((int32_t)1 << (r + 1)) - 1));
	}

	ui = D ? r : 7 - r;
	full_bits = 5u + (uint32_t)r;

	if (full_bits >= n1) {
		full = ((uint64_t)(s) << (r + 4)) |
		       ((uint64_t)(D) << (r + 3)) |
		       ((uint64_t)(ui & 7) << r) |
		       (uint64_t)C;
		T = full >> (full_bits - n1);
	} else {
		q = n1 - full_bits;
		fb = (uint64_t)ldexpl(phi, (int)q);
		if (fb > ((UINT64_C(1) << q) - 1u))
			fb = (UINT64_C(1) << q) - 1u;
		T = ((uint64_t)(s) << (n1 - 1)) |
		    ((uint64_t)(D) << (n1 - 2)) |
		    ((uint64_t)(ui & 7) << (n1 - 5)) |
		    ((uint64_t)C << q) |
		    (fb & ((UINT64_C(1) << q) - 1u));
	}

	guard = (int)(T & 1u);
	T >>= 1;
	if (guard)
		T += 1u;

	if (T == 0u && x != 0.0L)
		T = (x > 0.0L) ? 1u : mask;
	else if (T == nar)
		T = (x > 0.0L) ? (nar - 1u) : (nar + 1u);

	return T & mask;
}

uint64_t
zt_round_to(zt_variant variant, uint32_t width, long double x,
            zt_round_mode mode)
{
	if (mode == ZT_ROUND_ALGO1)
		return zt_round_algo1(variant, width, x);

	return zt_from_double(variant, width, (double)x);
}
