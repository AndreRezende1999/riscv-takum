#include "zvtakum/rvv.h"
#include "zvtakum/takum_alu.h"

#include <string.h>

static uint64_t
elem_ones(uint32_t width)
{
	return (width >= 64u) ? UINT64_MAX
	                      : ((UINT64_C(1) << width) - 1u);
}

static int
mask_get(const rvv_state *s, uint32_t idx)
{
	return (s->vreg[0][idx >> 3] >> (idx & 7u)) & 1u;
}

static void
fill_out(rvv_state *s, uint32_t vreg, uint32_t idx, uint32_t width,
         int agnostic)
{
	if (agnostic)
		rvv_elem_set_w(s, vreg, idx, width, elem_ones(width));
}

static uint32_t
f2u(float f)
{
	uint32_t u;

	memcpy(&u, &f, sizeof(u));
	return u;
}

static float
u2f(uint32_t u)
{
	float f;

	memcpy(&f, &u, sizeof(f));
	return f;
}

static int
elemwise(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm,
         uint64_t (*fn)(zt_variant, uint32_t, uint64_t, uint64_t))
{
	uint32_t vlmax = rvv_vlmax(s);

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			uint64_t a = rvv_elem_get(s, vs2, i);
			uint64_t b = rvv_elem_get(s, vs1, i);

			rvv_elem_set(s, vd, i, fn(s->variant, s->sew, a, b));
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, s->sew, s->vma);
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
zt_dot(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm)
{
	uint32_t w2 = s->sew * 2u;
	uint32_t vlmax_w;
	uint64_t acc;

	if (w2 > 64u)
		return RVV_ERR_ILLEGAL;

	acc = rvv_elem_get_w(s, vd, 0u, w2);
	for (uint32_t i = 0; i < s->vl; i++) {
		if (vm == 0u && mask_get(s, i) == 0)
			continue;
		{
			uint64_t a = rvv_elem_get(s, vs2, i);
			uint64_t b = rvv_elem_get(s, vs1, i);
			uint64_t wa = zt_convert(s->variant, s->sew, w2, a);
			uint64_t wb = zt_convert(s->variant, s->sew, w2, b);
			uint64_t p = zt_mul(s->variant, w2, wa, wb);

			acc = zt_add(s->variant, w2, acc, p);
			s->elements++;
		}
	}

	if (s->vl > 0u) {
		if (vm != 0u || mask_get(s, 0u) != 0)
			rvv_elem_set_w(s, vd, 0u, w2, acc);
		else
			fill_out(s, vd, 0u, w2, s->vma);
	}

	vlmax_w = (s->vlen / w2) * s->lmul;
	for (uint32_t i = 1u; i < vlmax_w; i++)
		fill_out(s, vd, i, w2, s->vta);

	return RVV_OK;
}

static int
zt_ncvt(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vm)
{
	uint32_t w2 = s->sew * 2u;
	uint32_t vlmax = rvv_vlmax(s);

	if (w2 > 64u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			uint64_t src = rvv_elem_get_w(s, vs2, i, w2);
			uint64_t dst = zt_convert(s->variant, w2, s->sew, src);

			rvv_elem_set(s, vd, i, dst);
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, s->sew, s->vma);
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
load_v(rvv_state *s, uint32_t vd, uint32_t rs1, uint32_t width, uint32_t vm)
{
	uint64_t addr = s->x[rs1];
	uint32_t bytes = width / 8u;
	uint32_t vlmax = rvv_vlmax(s);

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			uint64_t ea = addr + (uint64_t)i * bytes;
			uint64_t val = 0;

			if (ea + bytes > RVV_MEM_SIZE)
				return RVV_ERR_ILLEGAL;
			for (uint32_t k = 0; k < bytes; k++)
				val |= (uint64_t)s->mem[ea + k] << (8u * k);
			rvv_elem_set_w(s, vd, i, width, val);
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, width, s->vma);
		} else {
			fill_out(s, vd, i, width, s->vta);
		}
	}

	return RVV_OK;
}

static int
store_v(rvv_state *s, uint32_t vs3, uint32_t rs1, uint32_t width, uint32_t vm)
{
	uint64_t addr = s->x[rs1];
	uint32_t bytes = width / 8u;

	for (uint32_t i = 0; i < s->vl; i++) {
		uint64_t val;

		if (vm == 0u && mask_get(s, i) == 0)
			continue;
		val = rvv_elem_get_w(s, vs3, i, width);
		{
			uint64_t ea = addr + (uint64_t)i * bytes;

			if (ea + bytes > RVV_MEM_SIZE)
				return RVV_ERR_ILLEGAL;
			for (uint32_t k = 0; k < bytes; k++)
				s->mem[ea + k] = (uint8_t)(val >> (8u * k));
			s->elements++;
		}
	}

	return RVV_OK;
}

static int
fp_binop(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm,
         int is_mul, int vf)
{
	float bscalar = vf ? u2f((uint32_t)s->x[vs1]) : 0.0f;
	uint32_t vlmax = rvv_vlmax(s);

	if (s->sew != 32u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			float a = u2f((uint32_t)rvv_elem_get(s, vs2, i));
			float b = vf ? bscalar
			             : u2f((uint32_t)rvv_elem_get(s, vs1, i));
			float r = is_mul ? (a * b) : (a + b);

			rvv_elem_set(s, vd, i, f2u(r));
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, s->sew, s->vma);
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
fredusum(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vm)
{
	float acc = 0.0f;
	uint32_t vlmax = rvv_vlmax(s);

	if (s->sew != 32u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < s->vl; i++) {
		if (vm != 0u || mask_get(s, i) != 0) {
			acc += u2f((uint32_t)rvv_elem_get(s, vs2, i));
			s->elements++;
		}
	}

	if (s->vl > 0u) {
		if (vm != 0u || mask_get(s, 0u) != 0)
			rvv_elem_set(s, vd, 0u, f2u(acc));
		else
			fill_out(s, vd, 0u, s->sew, s->vma);
	}
	for (uint32_t i = s->vl + (s->vl == 0u); i < vlmax; i++)
		fill_out(s, vd, i, s->sew, s->vta);

	return RVV_OK;
}

static int
vrgather_vv(rvv_state *s, uint32_t vd, uint32_t vs2, uint32_t vs1, uint32_t vm)
{
	uint32_t vlmax = rvv_vlmax(s);

	for (uint32_t i = 0; i < vlmax; i++) {
		int active = (i < s->vl) && (vm != 0u || mask_get(s, i) != 0);

		if (active) {
			uint64_t idx = rvv_elem_get(s, vs1, i);

			if (idx < vlmax)
				rvv_elem_set(s, vd, i, rvv_elem_get(s, vs2, idx));
			else
				rvv_elem_set(s, vd, i, 0u);
			s->elements++;
		} else if (i < s->vl) {
			fill_out(s, vd, i, s->sew, s->vma);
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
vmv_v_v(rvv_state *s, uint32_t vd, uint32_t vs1)
{
	uint32_t vlmax = rvv_vlmax(s);

	for (uint32_t i = 0; i < vlmax; i++) {
		if (i < s->vl) {
			rvv_elem_set(s, vd, i, rvv_elem_get(s, vs1, i));
			s->elements++;
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
vmv_v_i(rvv_state *s, uint32_t vd, int32_t imm)
{
	uint32_t vlmax = rvv_vlmax(s);
	uint64_t val = (uint64_t)(int64_t)imm;

	for (uint32_t i = 0; i < vlmax; i++) {
		if (i < s->vl) {
			rvv_elem_set(s, vd, i, val);
			s->elements++;
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

static int
vfmv_v_f(rvv_state *s, uint32_t vd, uint32_t rs1)
{
	uint32_t vlmax = rvv_vlmax(s);
	uint32_t bits = (uint32_t)s->x[rs1];

	if (s->sew != 32u)
		return RVV_ERR_ILLEGAL;

	for (uint32_t i = 0; i < vlmax; i++) {
		if (i < s->vl) {
			rvv_elem_set(s, vd, i, bits);
			s->elements++;
		} else {
			fill_out(s, vd, i, s->sew, s->vta);
		}
	}

	return RVV_OK;
}

int
rvv_exec(rvv_state *s, uint32_t w)
{
	uint32_t opcode = w & 0x7fu;
	uint32_t funct3 = (w >> 12) & 7u;
	uint32_t vd = (w >> 7) & 0x1fu;
	uint32_t vs2 = (w >> 20) & 0x1fu;
	uint32_t vs1 = (w >> 15) & 0x1fu;
	uint32_t vm = (w >> 25) & 1u;
	uint32_t funct6 = (w >> 26) & 0x3fu;
	int rc = RVV_ERR_ILLEGAL;

	s->insn_count++;
	if (s->trace != NULL)
		fprintf(s->trace, "%08x\n", w);

	switch (opcode) {
	case 0x57u:
		if (funct3 == 7u) {
			int avl_is_x0 = (vs1 == 0u);
			uint64_t avl = avl_is_x0 ? 0u : s->x[vs1];
			uint32_t vtypei;

			if (((w >> 31) & 1u) == 0u) {
				vtypei = (w >> 20) & 0x7ffu;
			} else if (((w >> 30) & 1u) == 1u) {
				vtypei = (w >> 20) & 0x3ffu;
				avl = (w >> 15) & 0x1fu;
				avl_is_x0 = 0;
			} else {
				vtypei = (uint32_t)s->x[vs2] & 0x7ffu;
			}
			rc = rvv_vsetvli(s, vd, avl, avl_is_x0, vtypei);
			if (rc == RVV_OK)
				s->insn_rvv++;
			return rc;
		}

		switch (funct6) {
		case 0x00u:
			if (funct3 == 1u || funct3 == 5u)
				rc = fp_binop(s, vd, vs2, vs1, vm, 0,
				              funct3 == 5u);
			break;
		case 0x24u:
			if (funct3 == 1u || funct3 == 5u)
				rc = fp_binop(s, vd, vs2, vs1, vm, 1,
				              funct3 == 5u);
			break;
		case 0x01u:
			if (funct3 == 1u)
				rc = fredusum(s, vd, vs2, vm);
			break;
		case 0x0cu:
			if (funct3 == 0u)
				rc = vrgather_vv(s, vd, vs2, vs1, vm);
			break;
		case 0x17u:
			if (((w >> 25) & 1u) == 1u) {
				switch (funct3) {
				case 0u:
					rc = vmv_v_v(s, vd, vs1);
					break;
				case 3u:
					rc = vmv_v_i(
					    s, vd,
					    (int32_t)(vs1 << 27) >> 27);
					break;
				case 5u:
					rc = vfmv_v_f(s, vd, vs1);
					break;
				default:
					break;
				}
			}
			break;
		case 0x39u:
			switch (funct3) {
			case 0u:
				rc = zt_ncvt(s, vd, vs2, vm);
				break;
			case 1u:
				rc = elemwise(s, vd, vs2, vs1, vm, zt_add);
				break;
			case 2u:
				rc = elemwise(s, vd, vs2, vs1, vm, zt_sub);
				break;
			case 3u:
				rc = elemwise(s, vd, vs2, vs1, vm, zt_mul);
				break;
			case 4u:
				rc = zt_dot(s, vd, vs2, vs1, vm);
				break;
			default:
				break;
			}
			if (rc == RVV_OK)
				s->insn_zvtakum++;
			return rc;
		default:
			break;
		}
		if (rc == RVV_OK)
			s->insn_rvv++;
		return rc;
	case 0x07u:
		if (funct3 == 0u || funct3 == 5u || funct3 == 6u) {
			uint32_t width = (funct3 == 0u) ? 8u
			                 : (funct3 == 5u) ? 16u
			                                  : 32u;

			rc = load_v(s, vd, vs1, width, vm);
			if (rc == RVV_OK)
				s->insn_rvv++;
		}
		return rc;
	case 0x27u:
		if (funct3 == 0u || funct3 == 5u || funct3 == 6u) {
			uint32_t width = (funct3 == 0u) ? 8u
			                 : (funct3 == 5u) ? 16u
			                                  : 32u;

			rc = store_v(s, vd, vs1, width, vm);
			if (rc == RVV_OK)
				s->insn_rvv++;
		}
		return rc;
	default:
		return RVV_ERR_ILLEGAL;
	}
}
