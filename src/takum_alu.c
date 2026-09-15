#include "zvtakum/takum_alu.h"

#include <takum.h>

#define ZT_DISPATCH2(name, fn)                                             \
	uint64_t zt_##name(zt_variant variant, uint32_t width, uint64_t a,  \
	                   uint64_t b)                                      \
	{                                                                   \
		if (variant == ZT_VARIANT_LOG) {                            \
			switch (width) {                                    \
			case 8:                                             \
				return (uint8_t)takum_log8_##fn(            \
				    (takum_log8)(uint8_t)a,                 \
				    (takum_log8)(uint8_t)b);                \
			case 16:                                            \
				return (uint16_t)takum_log16_##fn(          \
				    (takum_log16)(uint16_t)a,               \
				    (takum_log16)(uint16_t)b);              \
			case 32:                                            \
				return (uint32_t)takum_log32_##fn(          \
				    (takum_log32)(uint32_t)a,               \
				    (takum_log32)(uint32_t)b);              \
			default:                                            \
				break;                                      \
			}                                                   \
		} else {                                                    \
			switch (width) {                                    \
			case 8:                                             \
				return (uint8_t)takum8_##fn(                \
				    (takum8)(uint8_t)a, (takum8)(uint8_t)b);\
			case 16:                                            \
				return (uint16_t)takum16_##fn(              \
				    (takum16)(uint16_t)a,                   \
				    (takum16)(uint16_t)b);                  \
			case 32:                                            \
				return (uint32_t)takum32_##fn(              \
				    (takum32)(uint32_t)a,                   \
				    (takum32)(uint32_t)b);                  \
			default:                                            \
				break;                                      \
			}                                                   \
		}                                                           \
		return 0;                                                   \
	}

#define ZT_DISPATCH1(name, fn)                                             \
	uint64_t zt_##name(zt_variant variant, uint32_t width, uint64_t a)  \
	{                                                                   \
		if (variant == ZT_VARIANT_LOG) {                            \
			switch (width) {                                    \
			case 8:                                             \
				return (uint8_t)takum_log8_##fn(            \
				    (takum_log8)(uint8_t)a);                \
			case 16:                                            \
				return (uint16_t)takum_log16_##fn(          \
				    (takum_log16)(uint16_t)a);              \
			case 32:                                            \
				return (uint32_t)takum_log32_##fn(          \
				    (takum_log32)(uint32_t)a);              \
			default:                                            \
				break;                                      \
			}                                                   \
		} else {                                                    \
			switch (width) {                                    \
			case 8:                                             \
				return (uint8_t)takum8_##fn((takum8)(uint8_t)a);\
			case 16:                                            \
				return (uint16_t)takum16_##fn(              \
				    (takum16)(uint16_t)a);                  \
			case 32:                                            \
				return (uint32_t)takum32_##fn(              \
				    (takum32)(uint32_t)a);                  \
			default:                                            \
				break;                                      \
			}                                                   \
		}                                                           \
		return 0;                                                   \
	}

ZT_DISPATCH2(add, addition)
ZT_DISPATCH2(sub, subtraction)
ZT_DISPATCH2(mul, multiplication)
ZT_DISPATCH2(div, division)
ZT_DISPATCH1(sqrt, square_root)
ZT_DISPATCH1(abs, absolute)

int64_t
zt_to_int64(zt_variant variant, uint32_t width, uint64_t bits)
{
	(void)variant;
	switch (width) {
	case 8:
		return (int64_t)(int8_t)(uint8_t)bits;
	case 16:
		return (int64_t)(int16_t)(uint16_t)bits;
	case 32:
		return (int64_t)(int32_t)(uint32_t)bits;
	default:
		break;
	}
	return (int64_t)bits;
}

int
zt_cmp(zt_variant variant, uint32_t width, uint64_t a, uint64_t b)
{
	int64_t sa = zt_to_int64(variant, width, a);
	int64_t sb = zt_to_int64(variant, width, b);

	return (sa > sb) - (sa < sb);
}

uint64_t
zt_neg(zt_variant variant, uint32_t width, uint64_t a)
{
	uint64_t mask = zt_width_mask(width);
	uint64_t b = a & mask;

	if (zt_is_nar(variant, width, b))
		return b;
	if (b == 0u)
		return 0u;

	switch (width) {
	case 8:
		return (uint8_t)(-(int8_t)(uint8_t)b);
	case 16:
		return (uint16_t)(-(int16_t)(uint16_t)b);
	case 32:
		return (uint32_t)(-(int32_t)(uint32_t)b);
	default:
		break;
	}

	return 0u;
}
