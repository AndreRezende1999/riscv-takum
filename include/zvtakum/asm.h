#ifndef ZVTAKUM_ASM_H
#define ZVTAKUM_ASM_H

#include <stddef.h>
#include <stdint.h>

int zt_asm_encode(const char *text, uint32_t *word);
int zt_disasm(uint32_t word, char *buf, size_t bufsz);

#endif
