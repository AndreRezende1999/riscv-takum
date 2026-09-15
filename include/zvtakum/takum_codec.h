#ifndef ZVTAKUM_TAKUM_CODEC_H
#define ZVTAKUM_TAKUM_CODEC_H

#include <stdint.h>

typedef enum {
	ZT_VARIANT_LINEAR = 0,
	ZT_VARIANT_LOG    = 1
} zt_variant;

typedef enum {
	ZT_ROUND_RNE   = 0,
	ZT_ROUND_ALGO1 = 1
} zt_round_mode;

typedef enum {
	ZT_OK        = 0,
	ZT_EOVERFLOW = 1,
	ZT_EUNDERFLOW = 2,
	ZT_ENAR      = 3
} zt_convert_result;

#define ZT_T8  8u
#define ZT_T16 16u
#define ZT_T32 32u

typedef struct {
	zt_variant  variant;
	uint32_t    width;
	uint64_t    bits;
	int         s;
	int         d;
	int         r;
	int32_t     c;
	int32_t     p;
	uint32_t    p12;
	uint64_t    mant;
	long double m;
	int         is_zero;
	int         is_nar;
	long double value;
} zt_fields;

uint64_t   zt_width_mask(uint32_t width);
uint64_t   zt_nar_bits(uint32_t width);
int        zt_is_nar(zt_variant variant, uint32_t width, uint64_t bits);
int        zt_is_zero(zt_variant variant, uint32_t width, uint64_t bits);
void       zt_decode(zt_variant variant, uint32_t width, uint64_t bits,
                     zt_fields *f);
double     zt_to_double(zt_variant variant, uint32_t width, uint64_t bits);
uint64_t   zt_from_double(zt_variant variant, uint32_t width, double x);
uint64_t   zt_round_algo1(zt_variant variant, uint32_t width, long double x);
uint64_t   zt_round_to(zt_variant variant, uint32_t width, long double x,
                       zt_round_mode mode);
const char *zt_variant_name(zt_variant variant);

#endif
