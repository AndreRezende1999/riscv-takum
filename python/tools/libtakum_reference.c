/* Test-data exporter, not a runtime dependency of the Python simulator.
 * Oracle: Laslo Hunhold's libtakum, ISC, https://github.com/takum-arithmetic/libtakum
 * Required revision: 776ac0ca7855f640100731ed8bbb0c7cf83b2d94 (2.0.0).
 * This wrapper is original project code. Output order is documented below.
 */
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "takum.h"

int main(int argc, char **argv) {
    if (argc != 2) return 2;
    FILE *out = fopen(argv[1], "wb");
    if (!out) return 3;
    fwrite("TK8REF1\n", 1, 8, out);
    /* 256 decoded binary64 values, explicitly little-endian IEEE bit patterns. */
    for (int a = 0; a < 256; ++a) {
        takum8 x = (takum8)(a < 128 ? a : a - 256);
        double d = takum8_to_float64(x);
        uint64_t bits;
        memcpy(&bits, &d, sizeof bits);
        for (int b = 0; b < 8; ++b) fputc((bits >> (8 * b)) & 255, out);
    }
    /* add, sub, mul: all ordered pairs, row=a and column=b. */
    for (int op = 0; op < 3; ++op)
        for (int a = 0; a < 256; ++a)
            for (int b = 0; b < 256; ++b) {
                takum8 x = (takum8)(a < 128 ? a : a - 256);
                takum8 y = (takum8)(b < 128 ? b : b - 256);
                takum8 r = op == 0 ? takum8_addition(x, y) :
                           op == 1 ? takum8_subtraction(x, y) :
                                     takum8_multiplication(x, y);
                fputc((uint8_t)r, out);
            }
    int error = ferror(out);
    if (fclose(out) || error) return 4;
    return 0;
}
