    .option norvc
    .section .text
    .globl _start
_start:
    la s0, out
    mv s6, s0
    li t0, 0
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    add t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sub t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sll t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    slt t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sltu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    xor t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    srl t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sra t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    or t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    and t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    mul t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    mulh t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    mulhsu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    mulhu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    div t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    divu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    rem t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    remu t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    addw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    subw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sllw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    srlw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    sraw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    mulw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    divw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    divuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    remw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -1
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 2
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, -7
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 3
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    li t1, 0x7fffffffffffffff
    remuw t2, t0, t1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slti t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sltiu t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    xori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    ori t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    andi t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, -1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, 2047
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, -2048
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    addiw t2, t0, 0x55
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srli t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srli t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srli t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srli t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srai t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srai t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srai t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srai t2, t0, 63
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    slliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srliw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srliw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    srliw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sraiw t2, t0, 0
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sraiw t2, t0, 1
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sraiw t2, t0, 31
    sd t2, 0(s0)
    addi s0, s0, 8
    la s1, scratch
    li t0, 0
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 7
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -7
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x7fffffffffffffff
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x8000000000000000
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0xffffffff80000000
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0x123456789abcdef0
    sd t0, 0(s1)
    lb t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lh t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    ld t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lbu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lhu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    lwu t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t3, 0x5a
    sb t3, 3(s1)
    lw t2, 0(s1)
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    beq t0, t1, .L1
    j .L2
.L1:
    li t2, 1
.L2:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    beq t0, t1, .L3
    j .L4
.L3:
    li t2, 1
.L4:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    beq t0, t1, .L5
    j .L6
.L5:
    li t2, 1
.L6:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    beq t0, t1, .L7
    j .L8
.L7:
    li t2, 1
.L8:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    bne t0, t1, .L9
    j .L10
.L9:
    li t2, 1
.L10:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    bne t0, t1, .L11
    j .L12
.L11:
    li t2, 1
.L12:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    bne t0, t1, .L13
    j .L14
.L13:
    li t2, 1
.L14:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    bne t0, t1, .L15
    j .L16
.L15:
    li t2, 1
.L16:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    blt t0, t1, .L17
    j .L18
.L17:
    li t2, 1
.L18:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    blt t0, t1, .L19
    j .L20
.L19:
    li t2, 1
.L20:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    blt t0, t1, .L21
    j .L22
.L21:
    li t2, 1
.L22:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    blt t0, t1, .L23
    j .L24
.L23:
    li t2, 1
.L24:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    bge t0, t1, .L25
    j .L26
.L25:
    li t2, 1
.L26:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    bge t0, t1, .L27
    j .L28
.L27:
    li t2, 1
.L28:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    bge t0, t1, .L29
    j .L30
.L29:
    li t2, 1
.L30:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    bge t0, t1, .L31
    j .L32
.L31:
    li t2, 1
.L32:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    bltu t0, t1, .L33
    j .L34
.L33:
    li t2, 1
.L34:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    bltu t0, t1, .L35
    j .L36
.L35:
    li t2, 1
.L36:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    bltu t0, t1, .L37
    j .L38
.L37:
    li t2, 1
.L38:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    bltu t0, t1, .L39
    j .L40
.L39:
    li t2, 1
.L40:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 1
    li t2, 0
    bgeu t0, t1, .L41
    j .L42
.L41:
    li t2, 1
.L42:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    li t1, 2
    li t2, 0
    bgeu t0, t1, .L43
    j .L44
.L43:
    li t2, 1
.L44:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, -1
    li t1, 1
    li t2, 0
    bgeu t0, t1, .L45
    j .L46
.L45:
    li t2, 1
.L46:
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    li t1, -1
    li t2, 0
    bgeu t0, t1, .L47
    j .L48
.L47:
    li t2, 1
.L48:
    sd t2, 0(s0)
    addi s0, s0, 8
    lui t2, 0x12345
    sd t2, 0(s0)
    addi s0, s0, 8
    jal ra, .L49
    j .L50
.L49:
    li t2, 77
    ret
.L50:
    sd t2, 0(s0)
    addi s0, s0, 8
    csrr t2, vlenb
    sd t2, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    csrr t2, vtype
    sd t2, 0(s0)
    addi s0, s0, 8
    csrr t2, vstart
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    csrrw t2, vstart, t0
    sd t2, 0(s0)
    addi s0, s0, 8
    # write(1, out, s0 - s6); exit(0)
    sub a2, s0, s6
    mv a1, s6
    li a0, 1
    li a7, 64
    ecall
    li a0, 0
    li a7, 93
    ecall
    .section .bss
    .balign 16
out:
    .space 65536
    .section .data
    .balign 16
scratch: .dword 0, 0
