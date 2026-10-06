/* Original offline test-data exporter; not a Python runtime dependency.
 * Oracle: Laslo Hunhold, libtakum 2.0.0, ISC license, copyright 2024-2025.
 * https://github.com/takum-arithmetic/libtakum
 * Pinned commit: 776ac0ca7855f640100731ed8bbb0c7cf83b2d94.
 * T16/T32 are LINEAR types in this revision. Their decoded values fit exactly
 * in binary64, but the library's binary64 arithmetic is not an exact oracle
 * for every T32 product. Near-tie probes intentionally expose that limitation.
 * See tests/data/libtakum_wide.md for the TSV schema and sampling procedure.
 */
#include <fenv.h>
#include <float.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include "takum.h"

#define PAIRS 10000u
#define COMMIT "776ac0ca7855f640100731ed8bbb0c7cf83b2d94"

static takum16 as_t16(uint32_t raw) {
    int32_t signed_value = raw < 0x8000u ? (int32_t)raw : (int32_t)raw - 65536;
    return (takum16)signed_value;
}

static takum32 as_t32(uint32_t raw) {
    int64_t signed_value = raw < UINT32_C(0x80000000) ? (int64_t)raw :
                          (int64_t)raw - INT64_C(4294967296);
    return (takum32)signed_value;
}

static uint32_t next_random(uint32_t *state) {
    uint32_t x = *state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    return *state = x;
}

static uint32_t inverse_odd(uint32_t odd) {
    uint32_t inverse = 1;
    for (unsigned i = 0; i < 5; ++i) inverse *= 2u - odd * inverse;
    return inverse;
}

static void emit_pair(FILE *out, unsigned bits, unsigned index, const char *kind,
                      uint32_t a, uint32_t b) {
    double da, db;
    uint32_t add, sub, mul;
    if (bits == 16) {
        takum16 x = as_t16(a), y = as_t16(b);
        da = takum16_to_float64(x);
        db = takum16_to_float64(y);
        add = (uint16_t)takum16_addition(x, y);
        sub = (uint16_t)takum16_subtraction(x, y);
        mul = (uint16_t)takum16_multiplication(x, y);
    } else {
        takum32 x = as_t32(a), y = as_t32(b);
        da = takum32_to_float64(x);
        db = takum32_to_float64(y);
        add = (uint32_t)takum32_addition(x, y);
        sub = (uint32_t)takum32_subtraction(x, y);
        mul = (uint32_t)takum32_multiplication(x, y);
    }
    fprintf(out, "P\t%u\t%u\t%s\t%08" PRIx32 "\t%08" PRIx32
                 "\t%a\t%a\t%08" PRIx32 "\t%08" PRIx32 "\t%08" PRIx32 "\n",
            bits, index, kind, a, b, da, db, add, sub, mul);
}

static void emit_width(FILE *out, unsigned bits) {
    uint32_t mask = bits == 16 ? UINT32_C(0xffff) : UINT32_MAX;
    uint32_t nar = UINT32_C(1) << (bits - 1);
    uint32_t one = UINT32_C(1) << (bits - 2);
    uint32_t fraction_mask = (UINT32_C(1) << (bits - 5)) - 1u;
    unsigned index = 0;

    /* All 32 sign/direction/regime prefixes, and the adjacent raw patterns.
     * Eight pairings cover zero, NaR, units, extrema, cancellation, and squares.
     */
    for (unsigned prefix = 0; prefix < 32; ++prefix) {
        uint32_t center = (uint32_t)prefix << (bits - 5);
        for (int delta = -1; delta <= 1; ++delta) {
            uint32_t a = (center + (uint32_t)delta) & mask;
            uint32_t partners[] = {0, nar, one, (-one) & mask, 1, nar - 1,
                                   (-a) & mask, a};
            for (unsigned p = 0; p < sizeof partners / sizeof partners[0]; ++p)
                emit_pair(out, bits, index++, "boundary", a, partners[p]);
        }
    }

    /* Near-one products: i*j mod 2^(bits-5) is half an output ulp +/-1.
     * Values stay exact on input; signs and operand order are both exercised.
     * For T32 this includes 0x40000001 * 0x44000001, whose low product bit
     * binary64 loses before the library converts the product back to Takum.
     */
    uint32_t half = UINT32_C(1) << (bits - 6);
    for (uint32_t i = 1; i < 32; i += 2) {
        uint32_t inverse = inverse_odd(i);
        for (int delta = -1; delta <= 1; ++delta) {
            uint32_t j = ((half + (uint32_t)delta) * inverse) & fraction_mask;
            for (unsigned signs = 0; signs < 4; ++signs) {
                uint32_t a = one + i, b = one + j;
                if (signs & 1u) a = (-a) & mask;
                if (signs & 2u) b = (-b) & mask;
                emit_pair(out, bits, index++, "tie_probe", a, b);
                emit_pair(out, bits, index++, "tie_probe", b, a);
            }
        }
    }

    /* The remaining 8,848 records cycle over all 32x32 prefix combinations;
     * low bits come from fixed-seed xorshift32, independent of the Python ALU.
     */
    uint32_t state = UINT32_C(0x6a09e667) ^ bits;
    for (unsigned k = 0; index < PAIRS; ++k) {
        uint32_t a = ((uint32_t)(k % 32) << (bits - 5)) |
                     (next_random(&state) & fraction_mask);
        uint32_t b = ((uint32_t)((k / 32) % 32) << (bits - 5)) |
                     (next_random(&state) & fraction_mask);
        emit_pair(out, bits, index++, "stratified", a, b);
    }
}

int main(int argc, char **argv) {
    if (argc != 2) return 2;
    if (FLT_RADIX != 2 || DBL_MANT_DIG < 53 || DBL_MAX_EXP < 1024 ||
        fesetround(FE_TONEAREST) != 0) return 3;
    FILE *out = fopen(argv[1], "wb");
    if (!out) return 4;
    fprintf(out, "TKWREF1\t%s\nM\tDBL_MANT_DIG\t%d\nM\tLDBL_MANT_DIG\t%d\n"
                 "M\tPAIRS_PER_WIDTH\t%u\n", COMMIT, DBL_MANT_DIG,
            LDBL_MANT_DIG, PAIRS);
    for (uint32_t raw = 0; raw < 65536; ++raw)
        fprintf(out, "D\t16\t%04" PRIx32 "\t%a\n", raw,
                takum16_to_float64(as_t16(raw)));
    emit_width(out, 16);
    emit_width(out, 32);
    int error = ferror(out);
    if (fclose(out) || error) return 5;
    return 0;
}
