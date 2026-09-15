#ifndef ZVTAKUM_RVV_H
#define ZVTAKUM_RVV_H

#include <stdint.h>
#include <stdio.h>

#include "zvtakum/takum_codec.h"

#define RVV_VLEN_MAX 4096u
#define RVV_NVREG    32u
#define RVV_MEM_SIZE (1u << 20)

enum {
	RVV_OK          = 0,
	RVV_ERR_ILLEGAL  = -1,
	RVV_ERR_VTYPE    = -2,
	RVV_ERR_ALIGN    = -3
};

typedef struct {
	uint32_t vlen; /* bits */
	uint8_t  vreg[RVV_NVREG][RVV_VLEN_MAX / 8u];
	uint32_t sew;  /* 8, 16, 32 */
	uint32_t lmul; /* 1, 2, 4, 8 */
	uint8_t  vta;  /* tail: 1 = agnostico (1s), 0 = undisturbed */
	uint8_t  vma;  /* mascara: 1 = agnostico (1s), 0 = undisturbed */
	uint32_t vl;
	uint32_t vstart;
	uint64_t x[32];
	uint8_t  mem[RVV_MEM_SIZE];
	zt_variant variant;
	uint64_t insn_count;
	uint64_t insn_rvv;
	uint64_t insn_zvtakum;
	uint64_t csr_writes;
	uint64_t elements;
	FILE    *trace;
} rvv_state;

void     rvv_init(rvv_state *s, uint32_t vlen);
uint32_t rvv_vlmax(const rvv_state *s);
uint32_t rvv_sew_bytes(const rvv_state *s);
uint64_t rvv_elem_get(const rvv_state *s, uint32_t vreg, uint32_t idx);
void     rvv_elem_set(rvv_state *s, uint32_t vreg, uint32_t idx, uint64_t val);
uint64_t rvv_elem_get_w(const rvv_state *s, uint32_t vreg, uint32_t idx,
                        uint32_t width);
void     rvv_elem_set_w(rvv_state *s, uint32_t vreg, uint32_t idx,
                        uint32_t width, uint64_t val);
int      rvv_vsetvli(rvv_state *s, uint32_t rd, uint64_t avl, int avl_is_x0,
                     uint32_t vtypei);
int      rvv_exec(rvv_state *s, uint32_t word);

uint32_t rvv_enc_vsetvli(uint32_t rd, uint32_t rs1, uint32_t vtypei);
uint32_t rvv_enc_vsetivli(uint32_t rd, uint32_t avl, uint32_t vtypei);
uint32_t rvv_enc_vsetvl(uint32_t rd, uint32_t rs1, uint32_t rs2);
uint32_t rvv_enc_load(uint32_t width, uint32_t vd, uint32_t rs1, uint32_t vm);
uint32_t rvv_enc_store(uint32_t width, uint32_t vs3, uint32_t rs1, uint32_t vm);
uint32_t rvv_enc_vfadd(uint32_t vd, uint32_t vs2, uint32_t vs1, int vf,
                       uint32_t vm);
uint32_t rvv_enc_vfmul(uint32_t vd, uint32_t vs2, uint32_t vs1, int vf,
                       uint32_t vm);
uint32_t rvv_enc_vfredusum(uint32_t vd, uint32_t vs2, uint32_t vm);
uint32_t rvv_enc_vrgather_vv(uint32_t vd, uint32_t vs2, uint32_t vs1,
                             uint32_t vm);
uint32_t rvv_enc_vmv_v_v(uint32_t vd, uint32_t vs1);
uint32_t rvv_enc_vmv_v_i(uint32_t vd, int32_t imm);
uint32_t rvv_enc_vfmv_v_f(uint32_t vd, uint32_t rs1);
uint32_t rvv_enc_zt_arith(uint32_t funct3, uint32_t vd, uint32_t vs2,
                          uint32_t vs1, uint32_t vm);

#endif
