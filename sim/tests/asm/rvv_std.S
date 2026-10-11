    .option norvc
    .section .text
    .globl _start
_start:
    la s0, out
    mv s6, s0
    la s1, vmask
    la s2, vdata_a
    la s3, vdata_b
    la s4, vidx
    la s5, vtable
    li t0, 0
    vsetvli t1, t0, e8, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    vsetvli t1, t0, e8, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 5
    vsetvli t1, t0, e8, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 100
    vsetvli t1, t0, e8, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    vsetvli t1, t0, e16, m2, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    vsetvli t1, t0, e16, m2, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 5
    vsetvli t1, t0, e16, m2, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 100
    vsetvli t1, t0, e16, m2, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    vsetvli t1, t0, e32, m4, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    vsetvli t1, t0, e32, m4, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 5
    vsetvli t1, t0, e32, m4, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 100
    vsetvli t1, t0, e32, m4, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 0
    vsetvli t1, t0, e64, m8, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 1
    vsetvli t1, t0, e64, m8, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 5
    vsetvli t1, t0, e64, m8, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 100
    vsetvli t1, t0, e64, m8, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, x0, e8, m1, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli t1, x0, e8, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    li t0, 4
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, t0, e8, m1, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, x0, e16, m2, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli t1, x0, e16, m2, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    li t0, 4
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, t0, e16, m2, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, x0, e32, m4, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli t1, x0, e32, m4, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    li t0, 4
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, t0, e32, m4, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 3
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, x0, e64, m8, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    li t0, 2
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli t1, x0, e64, m8, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    li t0, 4
    vsetvli t1, t0, e32, m1, tu, mu
    vsetvli x0, t0, e64, m8, tu, mu
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    vsetivli t1, 3, e16, m1, tu, mu
    sd t1, 0(s0)
    addi s0, s0, 8
    csrr t2, vl
    sd t2, 0(s0)
    addi s0, s0, 8
    vsetvli t1, x0, e8, m1, tu, mu
    vle8.v v0, (s1)
    vsetvli t1, x0, e32, m1, tu, mu
    vle32.v v2, (s2)
    vle32.v v3, (s3)
    vmv.v.i v6, 2
    vmv.v.i v7, 2
    vmv.v.i v12, 5
    vfadd.vv v4, v2, v3
    vfmul.vv v5, v2, v3
    vfadd.vv v6, v2, v3, v0.t
    vfmul.vv v7, v2, v3, v0.t
    vmv.v.i v8, 3
    vmv.v.v v9, v2
    vmv.v.i v10, 0
    vfredusum.vs v11, v2, v10
    vfredusum.vs v12, v2, v10, v0.t
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v4, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v5, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v6, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v7, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v8, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v9, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v11, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v12, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    la t5, vmask2
    vsetvli t1, x0, e8, m1, tu, mu
    vle8.v v0, (t5)
    vsetvli t1, x0, e32, m1, tu, mu
    vfredusum.vs v18, v2, v10, v0.t
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v18, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    li t0, 3
    vsetvli t1, t0, e32, m1, ta, ma
    vfadd.vv v20, v2, v3, v0.t
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v20, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    li t0, 0
    vsetvli t1, t0, e32, m1, tu, mu
    vfadd.vv v13, v2, v3
    vmv.v.i v14, 9
    vfredusum.vs v15, v2, v10
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v13, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v14, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v15, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e32, m2, tu, mu
    vle32.v v4, (s4)
    vluxei32.v v8, (s5), v4
    vsetvli t1, x0, e32, m2, tu, mu
    vse32.v v8, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    vsetvli t1, x0, e16, m1, tu, mu
    vle16.v v10, (s2)
    vsetvli t1, x0, e16, m1, tu, mu
    vse16.v v10, (s0)
    csrr t3, vl
    slli t3, t3, 1
    add s0, s0, t3
    vsetvli t1, x0, e32, m1, tu, mu
    vmv.v.i v16, 1
    li t0, 2
    csrw vstart, t0
    vmv.v.i v16, 7
    csrr t2, vstart
    sd t2, 0(s0)
    addi s0, s0, 8
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v16, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
    li t0, 1
    csrw vstart, t0
    vle32.v v17, (s3)
    csrr t2, vstart
    sd t2, 0(s0)
    addi s0, s0, 8
    vsetvli t1, x0, e32, m1, tu, mu
    vse32.v v17, (s0)
    csrr t3, vl
    slli t3, t3, 2
    add s0, s0, t3
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
vmask2: .byte 0xfe, 0x55, 0xaa, 0x0e, 0x7e, 0x3c, 0xc3, 0x81
        .byte 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0
        .byte 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
        .byte 0xf7, 0xef, 0xdf, 0xbf, 0x7f, 0xfd, 0xfb, 0xf1
        .balign 16
vmask: .byte 0xa5, 0x3c, 0xff, 0x00, 0x5a, 0xc3, 0x0f, 0xf0
       .byte 0x96, 0x69, 0x18, 0x81, 0xe7, 0x7e, 0xaa, 0x55
       .byte 0xf0, 0x0f, 0x33, 0xcc, 0x01, 0x80, 0x7f, 0xfe
       .byte 0x11, 0x22, 0x44, 0x88, 0x0c, 0x30, 0xc0, 0x03
       .balign 16
vdata_a: .float 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0, 1.5, -2.25, 3.0e30, 0.0, -0.0, 1.0e-30, 65504.0, 7.0
       .balign 16
vdata_b: .float 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0, 0.5, 4.0, -1.0e30, 2.0, 1.25, -3.0, 1.0e-30, 9.0
       .balign 16
vidx: .word 0, 28, 56, 84, 112, 140, 168, 196, 224, 252, 24, 52, 80, 108, 136, 164, 192, 220, 248, 20, 48, 76, 104, 132, 160, 188, 216, 244, 16, 44, 72, 100, 128, 156, 184, 212, 240, 12, 40, 68, 96, 124, 152, 180, 208, 236, 8, 36, 64, 92, 120, 148, 176, 204, 232, 4, 32, 60, 88, 116, 144, 172, 200, 228, 0, 28, 56, 84, 112, 140, 168, 196, 224, 252, 24, 52, 80, 108, 136, 164, 192, 220, 248, 20, 48, 76, 104, 132, 160, 188, 216, 244, 16, 44, 72, 100, 128, 156, 184, 212, 240, 12, 40, 68, 96, 124, 152, 180, 208, 236, 8, 36, 64, 92, 120, 148, 176, 204, 232, 4, 32, 60, 88, 116, 144, 172, 200, 228
       .balign 16
vtable: .float 0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5, 16.5, 17.5, 18.5, 19.5, 20.5, 21.5, 22.5, 23.5, 24.5, 25.5, 26.5, 27.5, 28.5, 29.5, 30.5, 31.5, 32.5, 33.5, 34.5, 35.5, 36.5, 37.5, 38.5, 39.5, 40.5, 41.5, 42.5, 43.5, 44.5, 45.5, 46.5, 47.5, 48.5, 49.5, 50.5, 51.5, 52.5, 53.5, 54.5, 55.5, 56.5, 57.5, 58.5, 59.5, 60.5, 61.5, 62.5, 63.5
