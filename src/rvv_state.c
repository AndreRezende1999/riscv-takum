#include "zvtakum/rvv.h"

#include <string.h>

void
rvv_init(rvv_state *s, uint32_t vlen)
{
	memset(s, 0, sizeof(*s));
	s->vlen = (vlen == 0) ? 256u : vlen;
	s->sew = 32u;
	s->lmul = 1u;
	s->variant = ZT_VARIANT_LOG;
}

uint32_t
rvv_sew_bytes(const rvv_state *s)
{
	return s->sew / 8u;
}

uint32_t
rvv_vlmax(const rvv_state *s)
{
	return (s->vlen / s->sew) * s->lmul;
}

uint64_t
rvv_elem_get(const rvv_state *s, uint32_t vreg, uint32_t idx)
{
	return rvv_elem_get_w(s, vreg, idx, s->sew);
}

void
rvv_elem_set(rvv_state *s, uint32_t vreg, uint32_t idx, uint64_t val)
{
	rvv_elem_set_w(s, vreg, idx, s->sew, val);
}

uint64_t
rvv_elem_get_w(const rvv_state *s, uint32_t vreg, uint32_t idx, uint32_t width)
{
	uint32_t epb = s->vlen / width; /* elementos por registrador */
	uint32_t ebytes = width / 8u;
	uint32_t r = vreg + idx / epb;
	uint32_t i = idx % epb;
	uint64_t val = 0;

	for (uint32_t k = 0; k < ebytes; k++)
		val |= (uint64_t)s->vreg[r][i * ebytes + k] << (8u * k);

	return val;
}

void
rvv_elem_set_w(rvv_state *s, uint32_t vreg, uint32_t idx, uint32_t width,
               uint64_t val)
{
	uint32_t epb = s->vlen / width;
	uint32_t ebytes = width / 8u;
	uint32_t r = vreg + idx / epb;
	uint32_t i = idx % epb;

	for (uint32_t k = 0; k < ebytes; k++)
		s->vreg[r][i * ebytes + k] = (uint8_t)(val >> (8u * k));
}

int
rvv_vsetvli(rvv_state *s, uint32_t rd, uint64_t avl, int avl_is_x0,
            uint32_t vtypei)
{
	uint32_t vlmul = vtypei & 7u;
	uint32_t vsew = (vtypei >> 3) & 7u;
	uint32_t vta = (vtypei >> 6) & 1u;
	uint32_t vma = (vtypei >> 7) & 1u;
	uint32_t sew, lmul, vlmax;
	uint64_t newvl;

	if (vsew > 2u)
		return RVV_ERR_VTYPE;
	if ((vlmul & 4u) != 0u)
		return RVV_ERR_VTYPE;

	switch (vlmul & 3u) {
	case 0:
		lmul = 1u;
		break;
	case 1:
		lmul = 2u;
		break;
	case 2:
		lmul = 4u;
		break;
	default:
		lmul = 8u;
		break;
	}

	sew = 8u << vsew;
	vlmax = (s->vlen / sew) * lmul;

	if (avl_is_x0)
		newvl = (rd == 0u) ? vlmax : s->vl;
	else
		newvl = avl;
	if (newvl > vlmax)
		newvl = vlmax;

	s->sew = sew;
	s->lmul = lmul;
	s->vta = (uint8_t)vta;
	s->vma = (uint8_t)vma;
	s->vl = (uint32_t)newvl;
	s->vstart = 0;
	s->csr_writes++;
	if (rd != 0u)
		s->x[rd] = newvl;

	return RVV_OK;
}

uint32_t
rvv_enc_vsetvli(uint32_t rd, uint32_t rs1, uint32_t vtypei)
{
	return ((vtypei & 0x7ffu) << 20) | ((rs1 & 0x1fu) << 15) |
	       (7u << 12) | ((rd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vsetivli(uint32_t rd, uint32_t avl, uint32_t vtypei)
{
	return (3u << 30) | ((vtypei & 0x3ffu) << 20) |
	       ((avl & 0x1fu) << 15) | (7u << 12) | ((rd & 0x1fu) << 7) |
	       0x57u;
}

uint32_t
rvv_enc_vsetvl(uint32_t rd, uint32_t rs1, uint32_t rs2)
{
	return (1u << 31) | ((rs2 & 0x1fu) << 20) | ((rs1 & 0x1fu) << 15) |
	       (7u << 12) | ((rd & 0x1fu) << 7) | 0x57u;
}

static uint32_t
width_to_lumop(uint32_t width)
{
	switch (width) {
	case 8:
		return 0u;
	case 16:
		return 5u;
	default:
		return 6u;
	}
}

uint32_t
rvv_enc_load(uint32_t width, uint32_t vd, uint32_t rs1, uint32_t vm)
{
	return ((vm & 1u) << 25) | (width_to_lumop(width) << 20) |
	       ((rs1 & 0x1fu) << 15) | (width_to_lumop(width) << 12) |
	       ((vd & 0x1fu) << 7) | 0x07u;
}

uint32_t
rvv_enc_store(uint32_t width, uint32_t vs3, uint32_t rs1, uint32_t vm)
{
	return ((vm & 1u) << 25) | (width_to_lumop(width) << 20) |
	       ((rs1 & 0x1fu) << 15) | (width_to_lumop(width) << 12) |
	       ((vs3 & 0x1fu) << 7) | 0x27u;
}

uint32_t
rvv_enc_vfadd(uint32_t vd, uint32_t vs2, uint32_t vs1, int vf, uint32_t vm)
{
	return (0x00u << 26) | ((vm & 1u) << 25) | ((vs2 & 0x1fu) << 20) |
	       ((vs1 & 0x1fu) << 15) | ((vf ? 5u : 1u) << 12) |
	       ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vfmul(uint32_t vd, uint32_t vs2, uint32_t vs1, int vf, uint32_t vm)
{
	return (0x24u << 26) | ((vm & 1u) << 25) | ((vs2 & 0x1fu) << 20) |
	       ((vs1 & 0x1fu) << 15) | ((vf ? 5u : 1u) << 12) |
	       ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vfredusum(uint32_t vd, uint32_t vs2, uint32_t vm)
{
	return (0x01u << 26) | ((vm & 1u) << 25) | ((vs2 & 0x1fu) << 20) |
	       (1u << 12) | ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vrgather_vv(uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm)
{
	return (0x0cu << 26) | ((vm & 1u) << 25) | ((vs2 & 0x1fu) << 20) |
	       ((vs1 & 0x1fu) << 15) | ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vmv_v_v(uint32_t vd, uint32_t vs1)
{
	return (0x17u << 26) | (1u << 25) | ((vs1 & 0x1fu) << 15) |
	       ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_vmv_v_i(uint32_t vd, int32_t imm)
{
	return (0x17u << 26) | (1u << 25) | (3u << 12) |
	       (((uint32_t)imm & 0x1fu) << 15) | ((vd & 0x1fu) << 7) |
	       0x57u;
}

uint32_t
rvv_enc_vfmv_v_f(uint32_t vd, uint32_t rs1)
{
	return (0x17u << 26) | (1u << 25) | (5u << 12) |
	       ((rs1 & 0x1fu) << 15) | ((vd & 0x1fu) << 7) | 0x57u;
}

uint32_t
rvv_enc_zt_arith(uint32_t funct3, uint32_t vd, uint32_t vs2, uint32_t vs1,
                 uint32_t vm)
{
	return (0x39u << 26) | ((vm & 1u) << 25) | ((vs2 & 0x1fu) << 20) |
	       ((vs1 & 0x1fu) << 15) | ((funct3 & 7u) << 12) |
	       ((vd & 0x1fu) << 7) | 0x57u;
}
