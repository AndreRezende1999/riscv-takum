#include "zvtakum/asm.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "zvtakum/rvv.h"

#define ASM_ERR -1
#define MAXTOK  8

static int
parse_vreg(const char *tok, uint32_t *out)
{
	char *end;
	long v;

	if (tok[0] != 'v')
		return 0;
	v = strtol(tok + 1, &end, 0);
	if (*end != '\0' || v < 0 || v > 31)
		return 0;
	*out = (uint32_t)v;
	return 1;
}

static int
parse_sreg(const char *tok, uint32_t *out)
{
	long v;

	if (tok[0] == 'x') {
		char *end;

		v = strtol(tok + 1, &end, 0);
		if (*end != '\0')
			return 0;
	} else if (tok[0] == 'a' && tok[1] >= '0' && tok[1] <= '7' &&
	           tok[2] == '\0') {
		v = 10 + (tok[1] - '0');
	} else if (tok[0] == 't' && tok[1] >= '0' && tok[1] <= '6' &&
	           tok[2] == '\0') {
		static const long tmap[7] = {5, 6, 7, 28, 29, 30, 31};

		v = tmap[tok[1] - '0'];
	} else if (strcmp(tok, "zero") == 0) {
		v = 0;
	} else {
		return 0;
	}

	if (v < 0 || v > 31)
		return 0;
	*out = (uint32_t)v;
	return 1;
}

static int
parse_imm(const char *tok, long *out)
{
	char *end;
	long v = strtol(tok, &end, 0);

	if (*end != '\0')
		return 0;
	*out = v;
	return 1;
}

/*
 * Divide a linha em tokens, substituindo virgulas por espacos e
 * removendo parenteses de "(xN)".
 */
static int
tokenize(const char *text, char *work, size_t worksz, char *tokens[MAXTOK])
{
	size_t n = 0;
	char *p;
	int nt = 0;

	for (const char *q = text; *q != '\0' && n + 1 < worksz; q++) {
		char c = *q;

		if (c == '\n' || c == '\r')
			break;
		if (c == '#')
			break;
		if (c == ',' || c == '\t' || c == '(' || c == ')')
			c = ' ';
		work[n++] = c;
	}
	work[n] = '\0';

	p = work;
	while (*p != '\0' && nt < MAXTOK) {
		while (*p == ' ')
			p++;
		if (*p == '\0')
			break;
		tokens[nt++] = p;
		while (*p != '\0' && *p != ' ')
			p++;
		if (*p != '\0')
			*p++ = '\0';
	}

	return nt;
}

static int
parse_vtype(char *tokens[MAXTOK], int start, int nt, uint32_t *vtypei)
{
	uint32_t sew = 0, lmul = 0, vta = 0, vma = 0;
	int have_sew = 0, have_lmul = 0;

	for (int i = start; i < nt; i++) {
		const char *t = tokens[i];

		if (strncmp(t, "vtypei=", 7) == 0) {
			*vtypei = (uint32_t)strtoul(t + 7, NULL, 0);
			return 1;
		}
		if (strcmp(t, "e8") == 0) {
			sew = 0;
			have_sew = 1;
		} else if (strcmp(t, "e16") == 0) {
			sew = 1;
			have_sew = 1;
		} else if (strcmp(t, "e32") == 0) {
			sew = 2;
			have_sew = 1;
		} else if (strcmp(t, "m1") == 0) {
			lmul = 0;
			have_lmul = 1;
		} else if (strcmp(t, "m2") == 0) {
			lmul = 1;
			have_lmul = 1;
		} else if (strcmp(t, "m4") == 0) {
			lmul = 2;
			have_lmul = 1;
		} else if (strcmp(t, "m8") == 0) {
			lmul = 3;
			have_lmul = 1;
		} else if (strcmp(t, "ta") == 0) {
			vta = 1;
		} else if (strcmp(t, "tu") == 0) {
			vta = 0;
		} else if (strcmp(t, "ma") == 0) {
			vma = 1;
		} else if (strcmp(t, "mu") == 0) {
			vma = 0;
		} else {
			return 0;
		}
	}

	if (!have_sew)
		sew = 2;
	if (!have_lmul)
		lmul = 0;
	*vtypei = (vma << 7) | (vta << 6) | (sew << 3) | lmul;
	return 1;
}

static const char *
vtype_str(uint32_t vtypei, char *buf, size_t n)
{
	uint32_t vsew = (vtypei >> 3) & 7u;
	uint32_t vlmul = vtypei & 7u;
	const char *sew;
	const char *lm;
	const char *ta = ((vtypei >> 6) & 1u) ? "ta" : "tu";
	const char *ma = ((vtypei >> 7) & 1u) ? "ma" : "mu";

	switch (vsew) {
	case 0:
		sew = "e8";
		break;
	case 1:
		sew = "e16";
		break;
	case 2:
		sew = "e32";
		break;
	case 3:
		sew = "e64";
		break;
	default:
		sew = "e?";
		break;
	}

	switch (vlmul & 3u) {
	case 0:
		lm = (vlmul & 4u) ? "mf8" : "m1";
		break;
	case 1:
		lm = (vlmul & 4u) ? "mf4" : "m2";
		break;
	case 2:
		lm = (vlmul & 4u) ? "mf2" : "m4";
		break;
	default:
		lm = "m8";
		break;
	}

	snprintf(buf, n, "%s, %s, %s, %s", sew, lm, ta, ma);
	return buf;
}

int
zt_asm_encode(const char *text, uint32_t *word)
{
	char work[256];
	char *tok[MAXTOK];
	int nt = tokenize(text, work, sizeof(work), tok);
	const char *mn;
	int w;

	if (nt == 0)
		return ASM_ERR;

	mn = tok[0];
	w = (nt > 1 && strcmp(tok[nt - 1], "v0.t") == 0) ? 0 : 1;
	if (w == 0)
		nt--;

	if (strcmp(mn, "vsetvli") == 0 && nt >= 3) {
		uint32_t rd, rs1, vtypei;
		int use_x0 = 0;

		if (!parse_sreg(tok[1], &rd))
			return ASM_ERR;
		if (!parse_sreg(tok[2], &rs1)) {
			long imm;

			if (!parse_imm(tok[2], &imm) || imm < 0)
				return ASM_ERR;
			rs1 = 0;
			use_x0 = 1;
			(void)imm;
		}
		if (!parse_vtype(tok, 3, nt, &vtypei))
			return ASM_ERR;
		*word = rvv_enc_vsetvli(rd, use_x0 ? 0u : rs1, vtypei);
		return 0;
	}

	if (strcmp(mn, "vsetivli") == 0 && nt >= 3) {
		uint32_t rd, vtypei;
		long avl;

		if (!parse_sreg(tok[1], &rd) || !parse_imm(tok[2], &avl))
			return ASM_ERR;
		if (!parse_vtype(tok, 3, nt, &vtypei))
			return ASM_ERR;
		*word = rvv_enc_vsetivli(rd, (uint32_t)avl, vtypei);
		return 0;
	}

	if (strcmp(mn, "vsetvl") == 0 && nt >= 4) {
		uint32_t rd, rs1, rs2;

		if (!parse_sreg(tok[1], &rd) || !parse_sreg(tok[2], &rs1) ||
		    !parse_sreg(tok[3], &rs2))
			return ASM_ERR;
		*word = rvv_enc_vsetvl(rd, rs1, rs2);
		return 0;
	}

	if (nt >= 3 && (strncmp(mn, "vle", 3) == 0 ||
	                strncmp(mn, "vse", 3) == 0)) {
		uint32_t width = 0, vreg, rs1;

		if (strcmp(mn + 3, "8.v") == 0)
			width = 8;
		else if (strcmp(mn + 3, "16.v") == 0)
			width = 16;
		else if (strcmp(mn + 3, "32.v") == 0)
			width = 32;
		else
			return ASM_ERR;
		if (!parse_vreg(tok[1], &vreg) || !parse_sreg(tok[2], &rs1))
			return ASM_ERR;
		*word = (mn[1] == 'l') ? rvv_enc_load(width, vreg, rs1, (uint32_t)w)
		                       : rvv_enc_store(width, vreg, rs1,
		                                       (uint32_t)w);
		return 0;
	}

	if ((strcmp(mn, "vfadd.vv") == 0 || strcmp(mn, "vfmul.vv") == 0) &&
	    nt >= 4) {
		uint32_t vd, vs2, vs1;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2) ||
		    !parse_vreg(tok[3], &vs1))
			return ASM_ERR;
		*word = (mn[1] == 'f' && mn[2] == 'a')
		            ? rvv_enc_vfadd(vd, vs2, vs1, 0, (uint32_t)w)
		            : rvv_enc_vfmul(vd, vs2, vs1, 0, (uint32_t)w);
		return 0;
	}

	if ((strcmp(mn, "vfadd.vf") == 0 || strcmp(mn, "vfmul.vf") == 0) &&
	    nt >= 4) {
		uint32_t vd, vs2, rs1;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2) ||
		    !parse_sreg(tok[3], &rs1))
			return ASM_ERR;
		*word = (mn[2] == 'a')
		            ? rvv_enc_vfadd(vd, vs2, rs1, 1, (uint32_t)w)
		            : rvv_enc_vfmul(vd, vs2, rs1, 1, (uint32_t)w);
		return 0;
	}

	if (strcmp(mn, "vfredusum.vs") == 0 && nt >= 3) {
		uint32_t vd, vs2;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2))
			return ASM_ERR;
		*word = rvv_enc_vfredusum(vd, vs2, (uint32_t)w);
		return 0;
	}

	if (strcmp(mn, "vrgather.vv") == 0 && nt >= 4) {
		uint32_t vd, vs2, vs1;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2) ||
		    !parse_vreg(tok[3], &vs1))
			return ASM_ERR;
		*word = rvv_enc_vrgather_vv(vd, vs2, vs1, (uint32_t)w);
		return 0;
	}

	if (strcmp(mn, "vmv.v.v") == 0 && nt >= 3) {
		uint32_t vd, vs1;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs1))
			return ASM_ERR;
		*word = rvv_enc_vmv_v_v(vd, vs1);
		return 0;
	}

	if (strcmp(mn, "vmv.v.i") == 0 && nt >= 3) {
		uint32_t vd;
		long imm;

		if (!parse_vreg(tok[1], &vd) || !parse_imm(tok[2], &imm))
			return ASM_ERR;
		*word = rvv_enc_vmv_v_i(vd, (int32_t)imm);
		return 0;
	}

	if (strcmp(mn, "vfmv.v.f") == 0 && nt >= 3) {
		uint32_t vd, rs1;

		if (!parse_vreg(tok[1], &vd) || !parse_sreg(tok[2], &rs1))
			return ASM_ERR;
		*word = rvv_enc_vfmv_v_f(vd, rs1);
		return 0;
	}

	if (strcmp(mn, "vtadd.vv") == 0 || strcmp(mn, "vtsub.vv") == 0 ||
	    strcmp(mn, "vtmul.vv") == 0 || strcmp(mn, "vtdot.vv") == 0) {
		uint32_t vd, vs2, vs1, f3;

		if (nt < 4)
			return ASM_ERR;
		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2) ||
		    !parse_vreg(tok[3], &vs1))
			return ASM_ERR;
		if (strcmp(mn, "vtadd.vv") == 0)
			f3 = 1;
		else if (strcmp(mn, "vtsub.vv") == 0)
			f3 = 2;
		else if (strcmp(mn, "vtmul.vv") == 0)
			f3 = 3;
		else
			f3 = 4;
		*word = rvv_enc_zt_arith(f3, vd, vs2, vs1, (uint32_t)w);
		return 0;
	}

	if (strcmp(mn, "vncvt.t.t") == 0 && nt >= 3) {
		uint32_t vd, vs2;

		if (!parse_vreg(tok[1], &vd) || !parse_vreg(tok[2], &vs2))
			return ASM_ERR;
		*word = rvv_enc_zt_arith(0u, vd, vs2, 0u, (uint32_t)w);
		return 0;
	}

	return ASM_ERR;
}

static int
parse_sreg_disas(uint32_t r, char *buf, size_t n)
{
	return snprintf(buf, n, "x%u", r);
}

int
zt_disasm(uint32_t word, char *buf, size_t bufsz)
{
	uint32_t opcode = word & 0x7fu;
	uint32_t funct3 = (word >> 12) & 7u;
	uint32_t vd = (word >> 7) & 0x1fu;
	uint32_t vs2 = (word >> 20) & 0x1fu;
	uint32_t vs1 = (word >> 15) & 0x1fu;
	uint32_t vm = (word >> 25) & 1u;
	uint32_t funct6 = (word >> 26) & 0x3fu;

	if (opcode == 0x57u && funct3 == 7u) {
		char vtbuf[32];

		if (((word >> 31) & 1u) == 0u)
			return snprintf(buf, bufsz, "vsetvli x%u, x%u, %s", vd,
			                vs1,
			                vtype_str((word >> 20) & 0x7ffu, vtbuf,
			                          sizeof(vtbuf)));
		if (((word >> 30) & 1u) == 1u)
			return snprintf(buf, bufsz, "vsetivli x%u, %u, %s", vd,
			                (word >> 15) & 0x1fu,
			                vtype_str((word >> 20) & 0x3ffu, vtbuf,
			                          sizeof(vtbuf)));
		return snprintf(buf, bufsz, "vsetvl x%u, x%u, x%u", vd, vs1,
		                vs2);
	}

	if (opcode == 0x07u || opcode == 0x27u) {
		const char *w8 = (funct3 == 0u) ? "8" : (funct3 == 5u) ? "16"
		                     : (funct3 == 6u) ? "32"
		                                      : "?";
		int is_load = (opcode == 0x07u);

		if (funct3 > 6u || funct3 == 1u || funct3 == 2u || funct3 == 3u ||
		    funct3 == 4u)
			return snprintf(buf, bufsz, "?");
		return snprintf(buf, bufsz, "%s%s.v v%u, (x%u)%s",
		                is_load ? "vle" : "vse", w8, vd, vs1,
		                vm ? "" : ", v0.t");
	}

	if (opcode != 0x57u)
		return snprintf(buf, bufsz, "?");

	switch (funct6) {
	case 0x00u:
		if (funct3 == 1u)
			return snprintf(buf, bufsz, "vfadd.vv v%u, v%u, v%u%s", vd,
			                vs2, vs1, vm ? "" : ", v0.t");
		if (funct3 == 5u)
			return snprintf(buf, bufsz, "vfadd.vf v%u, v%u, x%u%s", vd,
			                vs2, vs1, vm ? "" : ", v0.t");
		break;
	case 0x24u:
		if (funct3 == 1u)
			return snprintf(buf, bufsz, "vfmul.vv v%u, v%u, v%u%s", vd,
			                vs2, vs1, vm ? "" : ", v0.t");
		if (funct3 == 5u)
			return snprintf(buf, bufsz, "vfmul.vf v%u, v%u, x%u%s", vd,
			                vs2, vs1, vm ? "" : ", v0.t");
		break;
	case 0x01u:
		if (funct3 == 1u)
			return snprintf(buf, bufsz, "vfredusum.vs v%u, v%u%s", vd,
			                vs2, vm ? "" : ", v0.t");
		break;
	case 0x0cu:
		if (funct3 == 0u)
			return snprintf(buf, bufsz, "vrgather.vv v%u, v%u, v%u%s",
			                vd, vs2, vs1, vm ? "" : ", v0.t");
		break;
	case 0x17u:
		if (((word >> 25) & 1u) == 1u) {
			if (funct3 == 0u)
				return snprintf(buf, bufsz, "vmv.v.v v%u, v%u", vd,
				                vs1);
			if (funct3 == 3u)
				return snprintf(buf, bufsz, "vmv.v.i v%u, %d", vd,
				                (int32_t)(vs1 << 27) >> 27);
			if (funct3 == 5u)
				return snprintf(buf, bufsz, "vfmv.v.f v%u, x%u", vd,
				                vs1);
		}
		break;
	case 0x39u:
		switch (funct3) {
		case 0u:
			return snprintf(buf, bufsz, "vncvt.t.t v%u, v%u%s", vd,
			                vs2, vm ? "" : ", v0.t");
		case 1u:
			return snprintf(buf, bufsz, "vtadd.vv v%u, v%u, v%u%s",
			                vd, vs2, vs1, vm ? "" : ", v0.t");
		case 2u:
			return snprintf(buf, bufsz, "vtsub.vv v%u, v%u, v%u%s",
			                vd, vs2, vs1, vm ? "" : ", v0.t");
		case 3u:
			return snprintf(buf, bufsz, "vtmul.vv v%u, v%u, v%u%s",
			                vd, vs2, vs1, vm ? "" : ", v0.t");
		case 4u:
			return snprintf(buf, bufsz, "vtdot.vv v%u, v%u, v%u%s",
			                vd, vs2, vs1, vm ? "" : ", v0.t");
		default:
			break;
		}
		break;
	default:
		break;
	}

	(void)parse_sreg_disas;

	return snprintf(buf, bufsz, "?");
}
