"""Gera os programas de teste diferencial (sim/tests/asm/*.S).

Os programas usam apenas instruções padrão (RV64IM, Zicsr e RVV 1.0 sem Zvtakum),
para que o QEMU user-mode sirva de oráculo. Cada programa grava seus resultados em
um buffer através de um ponteiro único (s0) e termina com write(1, buffer, n) e
exit(0), onde n é o número de bytes realmente produzidos. Os testes comparam a
saída do simulador com a do QEMU, byte a byte, para o mesmo VLEN.

    python3 sim/tests/gen_asm.py
"""

from __future__ import annotations

import pathlib

OUT = pathlib.Path(__file__).resolve().parent / "asm"

BUFFER_BYTES = 1 << 16


class Program:
    """Acumula instruções e dados de um programa de teste."""

    def __init__(self) -> None:
        self.lines: list[str] = []
        self.label = 0
        self.data: list[str] = []

    def emit(self, text: str) -> None:
        self.lines.append("    " + text)

    def bind(self, label: str) -> None:
        self.lines.append(f"{label}:")

    def new_label(self) -> str:
        self.label += 1
        return f".L{self.label}"

    def store(self, reg: str) -> None:
        self.emit(f"sd {reg}, 0(s0)")
        self.emit("addi s0, s0, 8")

    def store_vec(self, vreg: str, sew: int = 32, lmul: int = 1) -> None:
        """Grava todo o vetor com vl = VLMAX de (sew, lmul) e avança o ponteiro."""
        self.emit(f"vsetvli t1, x0, e{sew}, m{lmul}, tu, mu")
        self.emit(f"vse{sew}.v {vreg}, (s0)")
        self.emit("csrr t3, vl")
        shift = {8: 0, 16: 1, 32: 2, 64: 3}[sew]
        self.emit(f"slli t3, t3, {shift}")
        self.emit("add s0, s0, t3")

    def text(self) -> str:
        header = [
            "    .option norvc",
            "    .section .text",
            "    .globl _start",
            "_start:",
            "    la s0, out",
            "    mv s6, s0",
        ]
        footer = [
            "    # write(1, out, s0 - s6); exit(0)",
            "    sub a2, s0, s6",
            "    mv a1, s6",
            "    li a0, 1",
            "    li a7, 64",
            "    ecall",
            "    li a0, 0",
            "    li a7, 93",
            "    ecall",
            "    .section .bss",
            "    .balign 16",
            "out:",
            f"    .space {BUFFER_BYTES}",
        ]
        data = []
        if self.data:
            data = ["    .section .data", "    .balign 16"] + self.data
        return "\n".join(header + self.lines + footer + data) + "\n"


def scalar_program() -> None:
    p = Program()
    values = [
        "0", "1", "-1", "2", "7", "-7", "3",
        "0x7fffffffffffffff", "0x8000000000000000", "0xffffffff",
        "0xffffffff80000000", "0x123456789abcdef0",
    ]
    r_ops = [
        "add", "sub", "sll", "slt", "sltu", "xor", "srl", "sra", "or", "and",
        "mul", "mulh", "mulhsu", "mulhu", "div", "divu", "rem", "remu",
        "addw", "subw", "sllw", "srlw", "sraw", "mulw", "divw", "divuw", "remw", "remuw",
    ]
    for op in r_ops:
        for a in values:
            for b in values[:8]:
                p.emit(f"li t0, {a}")
                p.emit(f"li t1, {b}")
                p.emit(f"{op} t2, t0, t1")
                p.store("t2")
    for op in ("addi", "slti", "sltiu", "xori", "ori", "andi", "addiw"):
        for a in values:
            for imm in ("0", "1", "-1", "2047", "-2048", "0x55"):
                p.emit(f"li t0, {a}")
                p.emit(f"{op} t2, t0, {imm}")
                p.store("t2")
    for op, limit in (("slli", 63), ("srli", 63), ("srai", 63),
                      ("slliw", 31), ("srliw", 31), ("sraiw", 31)):
        for a in values:
            for sh in (0, 1, 31, limit):
                p.emit(f"li t0, {a}")
                p.emit(f"{op} t2, t0, {sh}")
                p.store("t2")
    p.emit("la s1, scratch")
    for a in values:
        p.emit(f"li t0, {a}")
        p.emit("sd t0, 0(s1)")
        for op in ("lb", "lh", "lw", "ld", "lbu", "lhu", "lwu"):
            p.emit(f"{op} t2, 0(s1)")
            p.store("t2")
        p.emit("li t3, 0x5a")
        p.emit("sb t3, 3(s1)")
        p.emit("lw t2, 0(s1)")
        p.store("t2")
    for op in ("beq", "bne", "blt", "bge", "bltu", "bgeu"):
        for a, b in (("1", "1"), ("1", "2"), ("-1", "1"), ("0", "-1")):
            taken, done = p.new_label(), p.new_label()
            p.emit(f"li t0, {a}")
            p.emit(f"li t1, {b}")
            p.emit("li t2, 0")
            p.emit(f"{op} t0, t1, {taken}")
            p.emit(f"j {done}")
            p.bind(taken)
            p.emit("li t2, 1")
            p.bind(done)
            p.store("t2")
    p.emit("lui t2, 0x12345")
    p.store("t2")
    func, after = p.new_label(), p.new_label()
    p.emit(f"jal ra, {func}")
    p.emit(f"j {after}")
    p.bind(func)
    p.emit("li t2, 77")
    p.emit("ret")
    p.bind(after)
    p.store("t2")
    for csr in ("vlenb", "vl", "vtype", "vstart"):
        p.emit(f"csrr t2, {csr}")
        p.store("t2")
    p.emit("li t0, 0")
    p.emit("csrrw t2, vstart, t0")
    p.store("t2")
    p.data = ["scratch: .dword 0, 0"]
    (OUT / "scalar_ops.S").write_text(p.text())


def rvv_program() -> None:
    p = Program()
    p.emit("la s1, vmask")
    p.emit("la s2, vdata_a")
    p.emit("la s3, vdata_b")
    p.emit("la s4, vidx")
    p.emit("la s5, vtable")

    # vsetvl: combinações de rd/rs1 e de vl anterior.
    vtypes = ["e8, m1", "e16, m2", "e32, m4", "e64, m8"]
    for vt in vtypes:
        for avl in ("0", "1", "5", "100"):
            p.emit(f"li t0, {avl}")
            p.emit(f"vsetvli t1, t0, {vt}, tu, mu")
            p.store("t1")
            p.emit("csrr t2, vl")
            p.store("t2")
    for vt in vtypes:
        p.emit("li t0, 3")
        p.emit("vsetvli t1, t0, e32, m1, tu, mu")
        p.emit(f"vsetvli x0, x0, {vt}, tu, mu")
        p.emit("csrr t2, vl")
        p.store("t2")
        p.emit("li t0, 2")
        p.emit("vsetvli t1, t0, e32, m1, tu, mu")
        p.emit(f"vsetvli t1, x0, {vt}, tu, mu")
        p.store("t1")
        p.emit("li t0, 4")
        p.emit("vsetvli t1, t0, e32, m1, tu, mu")
        p.emit(f"vsetvli x0, t0, {vt}, tu, mu")
        p.emit("csrr t2, vl")
        p.store("t2")
    p.emit("vsetivli t1, 3, e16, m1, tu, mu")
    p.store("t1")
    p.emit("csrr t2, vl")
    p.store("t2")

    # Máscara em v0 e operações aritméticas com máscara, cauda e reduções.
    p.emit("vsetvli t1, x0, e8, m1, tu, mu")
    p.emit("vle8.v v0, (s1)")
    p.emit("vsetvli t1, x0, e32, m1, tu, mu")
    p.emit("vle32.v v2, (s2)")
    p.emit("vle32.v v3, (s3)")
    p.emit("vmv.v.i v6, 2")
    p.emit("vmv.v.i v7, 2")
    p.emit("vmv.v.i v12, 5")
    p.emit("vfadd.vv v4, v2, v3")
    p.emit("vfmul.vv v5, v2, v3")
    p.emit("vfadd.vv v6, v2, v3, v0.t")
    p.emit("vfmul.vv v7, v2, v3, v0.t")
    p.emit("vmv.v.i v8, 3")
    p.emit("vmv.v.v v9, v2")
    p.emit("vmv.v.i v10, 0")
    p.emit("vfredusum.vs v11, v2, v10")
    p.emit("vfredusum.vs v12, v2, v10, v0.t")
    for reg in ("v4", "v5", "v6", "v7", "v8", "v9", "v11", "v12"):
        p.store_vec(reg)

    # Máscara com o elemento 0 inativo: a redução ainda grava vd[0] (RVV 1.0, §14).
    p.emit("la t5, vmask2")
    p.emit("vsetvli t1, x0, e8, m1, tu, mu")
    p.emit("vle8.v v0, (t5)")
    p.emit("vsetvli t1, x0, e32, m1, tu, mu")
    p.emit("vfredusum.vs v18, v2, v10, v0.t")
    p.store_vec("v18")
    # Políticas agnósticas: elementos de cauda e mascarados (ta, ma).
    p.emit("li t0, 3")
    p.emit("vsetvli t1, t0, e32, m1, ta, ma")
    p.emit("vfadd.vv v20, v2, v3, v0.t")
    p.store_vec("v20")

    # vl = 0: nenhum elemento do destino é atualizado.
    p.emit("li t0, 0")
    p.emit("vsetvli t1, t0, e32, m1, tu, mu")
    p.emit("vfadd.vv v13, v2, v3")
    p.emit("vmv.v.i v14, 9")
    p.emit("vfredusum.vs v15, v2, v10")
    for reg in ("v13", "v14", "v15"):
        p.store_vec(reg)

    # LMUL=2 com gather indexado (índices de 32 bits em v4-v5, dados em v8-v9).
    p.emit("vsetvli t1, x0, e32, m2, tu, mu")
    p.emit("vle32.v v4, (s4)")
    p.emit("vluxei32.v v8, (s5), v4")
    p.store_vec("v8", sew=32, lmul=2)
    p.emit("vsetvli t1, x0, e16, m1, tu, mu")
    p.emit("vle16.v v10, (s2)")
    p.store_vec("v10", sew=16)

    # vstart: elementos antes de vstart ficam intactos; vstart volta a zero.
    p.emit("vsetvli t1, x0, e32, m1, tu, mu")
    p.emit("vmv.v.i v16, 1")
    p.emit("li t0, 2")
    p.emit("csrw vstart, t0")
    p.emit("vmv.v.i v16, 7")
    p.emit("csrr t2, vstart")
    p.store("t2")
    p.store_vec("v16")
    p.emit("li t0, 1")
    p.emit("csrw vstart, t0")
    p.emit("vle32.v v17, (s3)")
    p.emit("csrr t2, vstart")
    p.store("t2")
    p.store_vec("v17")

    p.data = [
        "vmask2: .byte 0xfe, 0x55, 0xaa, 0x0e, 0x7e, 0x3c, 0xc3, 0x81",
        "        .byte 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0",
        "        .byte 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80",
        "        .byte 0xf7, 0xef, 0xdf, 0xbf, 0x7f, 0xfd, 0xfb, 0xf1",
        "        .balign 16",
        "vmask: .byte 0xa5, 0x3c, 0xff, 0x00, 0x5a, 0xc3, 0x0f, 0xf0",
        "       .byte 0x96, 0x69, 0x18, 0x81, 0xe7, 0x7e, 0xaa, 0x55",
        "       .byte 0xf0, 0x0f, 0x33, 0xcc, 0x01, 0x80, 0x7f, 0xfe",
        "       .byte 0x11, 0x22, 0x44, 0x88, 0x0c, 0x30, 0xc0, 0x03",
        "       .balign 16",
        "vdata_a: .float " + ", ".join(
            ["1.5", "-2.25", "3.0e30", "0.0", "-0.0", "1.0e-30", "65504.0", "7.0"] * 16),
        "       .balign 16",
        "vdata_b: .float " + ", ".join(
            ["0.5", "4.0", "-1.0e30", "2.0", "1.25", "-3.0", "1.0e-30", "9.0"] * 16),
        "       .balign 16",
        "vidx: .word " + ", ".join(str(((i * 7) % 64) * 4) for i in range(128)),
        "       .balign 16",
        "vtable: .float " + ", ".join(str(0.5 + i) for i in range(64)),
    ]
    (OUT / "rvv_std.S").write_text(p.text())


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    scalar_program()
    rvv_program()
    print(f"programas gravados em {OUT}")


if __name__ == "__main__":
    main()
