#ifndef ZT_TEST_H
#define ZT_TEST_H

#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define CHECK(cond, ...)                                                  \
	do {                                                              \
		if (!(cond)) {                                            \
			fprintf(stderr, "FAIL %s:%d: ", __FILE__, __LINE__); \
			fprintf(stderr, __VA_ARGS__);                      \
			fprintf(stderr, "\n");                             \
			exit(1);                                          \
		}                                                         \
	} while (0)

static inline uint64_t
zt_xorshift64(uint64_t *s)
{
	uint64_t x = *s;

	x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;

	return *s = x;
}

static inline double
zt_rand_unit(uint64_t *s)
{
	return (double)(zt_xorshift64(s) >> 11) / 9007199254740992.0;
}

static inline long double
zt_lambda_log(int p)
{
	if (p < -40)
		return 1.0e30L;
	return expl(ldexpl(1.0L, -p - 1) / 2.0L) - 1.0L;
}

static inline long double
zt_lambda_linear(int p)
{
	if (p <= 0)
		return 1.0L;
	return ldexpl(1.0L, -p - 1);
}

#endif
