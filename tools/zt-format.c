#include <math.h>
#include <stdio.h>

#include "zvtakum/takum_codec.h"

int
main(void)
{
	zt_variant variants[2] = {ZT_VARIANT_LINEAR, ZT_VARIANT_LOG};
	uint32_t widths[3] = {ZT_T8, ZT_T16, ZT_T32};

	printf("variant width  p_min p_max  min_positive      max_positive"
	       "      dynamic_range\n");

	for (int vi = 0; vi < 2; vi++) {
		for (int wi = 0; wi < 3; wi++) {
			zt_variant v = variants[vi];
			uint32_t w = widths[wi];
			zt_fields fp, fq;

			zt_decode(v, w, 1u, &fp);
			zt_decode(v, w, zt_nar_bits(w) - 1u, &fq);

			printf("%-7s T%-4u %5d %5d  %-16.10Lg  %-16.10Lg  %.6Lg\n",
			       zt_variant_name(v), w, (int)w - 12, (int)w - 5,
			       fp.value, fq.value, fq.value / fp.value);
		}
	}

	return 0;
}
