#include <assert.h>
#include <math.h>
#include <stdio.h>

#include <takum.h>

#include "zvtakum/zvtakum.h"

int
main(void)
{
	takum32 a, b;
	takum_log32 c, d;
	double r, q;

	printf("riscv-takum %s (libtakum smoke test)\n", zvtakum_version());

	a = takum32_from_float64(4.5);
	b = takum32_from_float64(6.5);
	r = takum32_to_float64(takum32_addition(a, b));
	printf("  linear: 4.5 + 6.5 = %.10g (esperado 11)\n", r);
	assert(fabs(r - 11.0) < 1e-9);

	c = takum_log32_from_float64(100.0);
	d = takum_log32_from_float64(10.0);
	q = takum_log32_to_float64(takum_log32_multiplication(c, d));
	printf("  log: 100 * 10 = %.10g (esperado ~1000)\n", q);
	assert(fabs(q - 1000.0) / 1000.0 < 1e-2);

	assert(TAKUM32_NAR == TAKUM32_NAR);
	assert(TAKUM_LOG32_NAR == TAKUM_LOG32_NAR);

	printf("OK\n");

	return 0;
}
