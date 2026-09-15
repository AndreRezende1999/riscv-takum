#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "zvtakum/asm.h"

int
main(int argc, char **argv)
{
	if (argc < 3) {
		fprintf(stderr,
		        "uso: zt-disa encode \"<asm>\" | zt-disa decode <hex>\n");
		return 1;
	}

	if (strcmp(argv[1], "encode") == 0) {
		uint32_t w;

		if (zt_asm_encode(argv[2], &w) != 0) {
			fprintf(stderr, "erro de sintaxe: %s\n", argv[2]);
			return 1;
		}
		printf("0x%08x\n", w);
		return 0;
	}

	if (strcmp(argv[1], "decode") == 0) {
		uint32_t w = (uint32_t)strtoul(argv[2], NULL, 0);
		char buf[160];

		if (zt_disasm(w, buf, sizeof(buf)) < 0)
			return 1;
		printf("%s\n", buf);
		return 0;
	}

	fprintf(stderr, "comando desconhecido: %s\n", argv[1]);
	return 1;
}
