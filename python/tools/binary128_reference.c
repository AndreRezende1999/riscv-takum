/* Independent GCC/libquadmath oracle, not part of the Python product.
 * Build with -fno-fast-math -frounding-math -ffp-contract=off; see notes.
 * Input: P id category a_hex32 b_hex32, or D id category decimal.
 * Output: JSONL metadata followed by raw IEEE binary128 operation results.
 */
#include <ctype.h>
#include <errno.h>
#include <fenv.h>
#include <inttypes.h>
#include <quadmath.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef __FAST_MATH__
#error "The binary128 reference must not be compiled with fast math"
#endif
#pragma STDC FENV_ACCESS ON
#pragma STDC FP_CONTRACT OFF

typedef unsigned __int128 raw128;
_Static_assert(sizeof(__float128) == 16, "128-bit ABI required");
_Static_assert(sizeof(raw128) == 16, "128-bit integer required");

static raw128 raw_of(__float128 value) {
    raw128 raw;
    memcpy(&raw, &value, sizeof(raw));
    return raw;
}

static __float128 value_of(raw128 raw) {
    __float128 value;
    memcpy(&value, &raw, sizeof(value));
    return value;
}

static void print_raw(raw128 raw) {
    printf("%016" PRIx64 "%016" PRIx64, (uint64_t)(raw >> 64), (uint64_t)raw);
}

static int parse_raw(const char *text, raw128 *raw) {
    if (strlen(text) != 32) return 0;
    *raw = 0;
    for (unsigned i = 0; i < 32; ++i) {
        const char ch = (char)tolower((unsigned char)text[i]);
        const char *digits = "0123456789abcdef";
        const char *digit = strchr(digits, ch);
        if (digit == NULL) return 0;
        *raw = (*raw << 4) | (unsigned)(digit - digits);
    }
    return 1;
}

static int safe_category(const char *text) {
    for (; *text; ++text)
        if (!isalnum((unsigned char)*text) && *text != '_') return 0;
    return 1;
}

static int finite_raw(raw128 raw) {
    return ((raw >> 112) & 0x7fff) != 0x7fff;
}

int main(void) {
    if (FLT128_MANT_DIG != 113 || FLT128_MAX_EXP != 16384 ||
        FLT128_MIN_EXP != -16381 || fesetround(FE_TONEAREST) != 0 ||
        fegetround() != FE_TONEAREST) {
        fputs("Required IEEE binary128 / FE_TONEAREST environment unavailable\n", stderr);
        return 2;
    }
    if (raw_of(strtoflt128("1", NULL)) != ((raw128)0x3fff << 112) ||
        raw_of(strtoflt128("-0", NULL)) != ((raw128)1 << 127)) {
        fputs("Unsupported floating/integer ABI layout\n", stderr);
        return 2;
    }
#if defined(__x86_64__)
    const char *architecture = "x86_64";
#elif defined(__i386__)
    const char *architecture = "i386";
#else
    const char *architecture = "other_verified_ieee_binary128";
#endif
    printf("{\"type\":\"metadata\",\"schema\":1,\"compiler\":\"GCC %s\","
           "\"architecture\":\"%s\",\"float128_bytes\":%zu,"
           "\"mantissa_bits\":%d,\"max_exponent\":%d,\"min_exponent\":%d,"
           "\"rounding\":\"FE_TONEAREST\",\"fast_math\":false,"
           "\"abi_one\":\"3fff0000000000000000000000000000\","
           "\"contract\":\"separate volatile add/sub/mul; decimal strtoflt128\"}\n",
           __VERSION__, architecture, sizeof(__float128),
           FLT128_MANT_DIG, FLT128_MAX_EXP, FLT128_MIN_EXP);

    char line[1024];
    unsigned line_number = 0;
    while (fgets(line, sizeof(line), stdin)) {
        char kind, category[64], a_text[256], b_text[256], extra;
        unsigned id;
        ++line_number;
        const int fields = sscanf(line, " %c %u %63s %255s %255s %c",
                                  &kind, &id, category, a_text, b_text, &extra);
        if (fields < 4 || !safe_category(category)) goto invalid;
        if (kind == 'P' && fields == 5) {
            raw128 a_raw, b_raw;
            if (!parse_raw(a_text, &a_raw) || !parse_raw(b_text, &b_raw) ||
                !finite_raw(a_raw) || !finite_raw(b_raw)) goto invalid;
            volatile __float128 a = value_of(a_raw);
            volatile __float128 b = value_of(b_raw);
            feclearexcept(FE_ALL_EXCEPT);
            volatile __float128 sum = a + b;
            const int add_flags = fetestexcept(FE_ALL_EXCEPT);
            feclearexcept(FE_ALL_EXCEPT);
            volatile __float128 difference = a - b;
            const int sub_flags = fetestexcept(FE_ALL_EXCEPT);
            feclearexcept(FE_ALL_EXCEPT);
            volatile __float128 product = a * b;
            const int mul_flags = fetestexcept(FE_ALL_EXCEPT);
            printf("{\"type\":\"pair\",\"id\":%u,\"category\":\"%s\",\"a\":\"", id, category);
            print_raw(a_raw);
            printf("\",\"b\":\""); print_raw(b_raw);
            printf("\",\"add\":\""); print_raw(raw_of(sum));
            printf("\",\"sub\":\""); print_raw(raw_of(difference));
            printf("\",\"mul\":\""); print_raw(raw_of(product));
            printf("\",\"oracle_flags\":{\"add\":%d,\"sub\":%d,\"mul\":%d}}\n",
                   add_flags, sub_flags, mul_flags);
        } else if (kind == 'D' && fields == 4) {
            char *end;
            errno = 0;
            feclearexcept(FE_ALL_EXCEPT);
            volatile __float128 value = strtoflt128(a_text, &end);
            if (end == a_text || *end != '\0') goto invalid;
            const int conversion_errno = errno;
            const int flags = fetestexcept(FE_ALL_EXCEPT);
            printf("{\"type\":\"decimal\",\"id\":%u,\"category\":\"%s\","
                   "\"decimal\":\"%s\",\"raw\":\"", id, category, a_text);
            print_raw(raw_of(value));
            printf("\",\"oracle_flags\":%d,\"oracle_errno\":%d}\n", flags, conversion_errno);
        } else {
invalid:
            fprintf(stderr, "Invalid oracle input on line %u\n", line_number);
            return 2;
        }
    }
    if (ferror(stdin) || fflush(stdout) != 0) {
        fputs("Oracle input/output failure\n", stderr);
        return 2;
    }
    return 0;
}
