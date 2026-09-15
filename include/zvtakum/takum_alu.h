#ifndef ZVTAKUM_TAKUM_ALU_H
#define ZVTAKUM_TAKUM_ALU_H

#include "zvtakum/takum_codec.h"

uint64_t zt_add(zt_variant variant, uint32_t width, uint64_t a, uint64_t b);
uint64_t zt_sub(zt_variant variant, uint32_t width, uint64_t a, uint64_t b);
uint64_t zt_mul(zt_variant variant, uint32_t width, uint64_t a, uint64_t b);
uint64_t zt_div(zt_variant variant, uint32_t width, uint64_t a, uint64_t b);
uint64_t zt_sqrt(zt_variant variant, uint32_t width, uint64_t a);
uint64_t zt_abs(zt_variant variant, uint32_t width, uint64_t a);
uint64_t zt_neg(zt_variant variant, uint32_t width, uint64_t a);
int      zt_cmp(zt_variant variant, uint32_t width, uint64_t a, uint64_t b);
int64_t  zt_to_int64(zt_variant variant, uint32_t width, uint64_t bits);

#endif
