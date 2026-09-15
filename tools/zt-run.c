#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "zvtakum/asm.h"
#include "zvtakum/rvv.h"

static void
usage(const char *prog)
{
	fprintf(stderr,
	        "uso: %s [--variant linear|log] [--vlen N] [--x N=V]... "
	        "arquivo.zt\n",
	        prog);
}

int
main(int argc, char **argv)
{
	rvv_state s;
	const char *path = NULL;
	zt_variant variant = ZT_VARIANT_LOG;
	uint32_t vlen = 256;
	int do_init8 = 0;
	int xargs = 0;
	FILE *f;
	char line[256];
	int lineno = 0;
	int ok = 1;

	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "--variant") == 0 && i + 1 < argc) {
			variant = (strcmp(argv[++i], "linear") == 0)
			              ? ZT_VARIANT_LINEAR
			              : ZT_VARIANT_LOG;
		} else if (strcmp(argv[i], "--vlen") == 0 && i + 1 < argc) {
			vlen = (uint32_t)strtoul(argv[++i], NULL, 0);
		} else if (strcmp(argv[i], "--init8") == 0) {
			do_init8 = 1;
		} else if (strcmp(argv[i], "--x") == 0 && i + 1 < argc) {
			unsigned reg;
			unsigned long long val;

			if (sscanf(argv[++i], "%u=%llu", &reg, &val) != 2 ||
			    reg > 31) {
				usage(argv[0]);
				return 1;
			}
			xargs++;
			/* aplicado apos rvv_init */
			if (xargs == 1) {
				/* nada: apenas marca uso */
			}
		} else if (argv[i][0] == '-') {
			usage(argv[0]);
			return 1;
		} else {
			path = argv[i];
		}
	}

	if (path == NULL) {
		usage(argv[0]);
		return 1;
	}

	f = fopen(path, "r");
	if (f == NULL) {
		perror(path);
		return 1;
	}

	rvv_init(&s, vlen);
	s.variant = variant;

	if (do_init8) {
		for (int i = 0; i < 1024; i++)
			s.mem[i] = (uint8_t)((i * 7 + 3) & 0xff);
	}

	/* segunda passada para --x (simples: reprocessa argv) */
	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "--x") == 0 && i + 1 < argc) {
			unsigned reg;
			unsigned long long val;

			if (sscanf(argv[i + 1], "%u=%llu", &reg, &val) == 2 &&
			    reg <= 31)
				s.x[reg] = val;
		}
	}

	while (fgets(line, sizeof(line), f) != NULL) {
		uint32_t w;

		lineno++;
		if (line[0] == '#' || line[0] == '\n' || line[0] == '\r')
			continue;
		if (zt_asm_encode(line, &w) != 0) {
			fprintf(stderr, "%s:%d: erro de sintaxe: %s", path,
			        lineno, line);
			ok = 0;
			break;
		}
		if (rvv_exec(&s, w) != RVV_OK) {
			fprintf(stderr, "%s:%d: erro de execucao\n", path,
			        lineno);
			ok = 0;
			break;
		}
	}

	fclose(f);

	printf("variant=%s vlen=%u sew=%u lmul=%u vl=%u\n",
	       zt_variant_name(s.variant), s.vlen, s.sew, s.lmul, s.vl);
	printf("instrucoes=%llu (rvv=%llu zvtakum=%llu) csr_writes=%llu "
	       "elementos=%llu\n",
	       (unsigned long long)s.insn_count,
	       (unsigned long long)s.insn_rvv,
	       (unsigned long long)s.insn_zvtakum,
	       (unsigned long long)s.csr_writes,
	       (unsigned long long)s.elements);

	if (ok) {
		printf("v1[0..3] = 0x%02llx 0x%02llx 0x%02llx 0x%02llx (bits brutos)\n",
		       (unsigned long long)rvv_elem_get(&s, 1, 0),
		       (unsigned long long)rvv_elem_get(&s, 1, 1),
		       (unsigned long long)rvv_elem_get(&s, 1, 2),
		       (unsigned long long)rvv_elem_get(&s, 1, 3));
	}

	return ok ? 0 : 1;
}
