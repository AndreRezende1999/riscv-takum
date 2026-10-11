#include "zt/machine.hpp"

#include <cstdio>
#include <cstring>
#include <limits>

#include "zt/takum.hpp"

namespace zt {
namespace {

int64_t sext(uint64_t value, unsigned bits) {
    const uint64_t sign = uint64_t(1) << (bits - 1);
    return static_cast<int64_t>((value ^ sign) - sign);
}

uint64_t sext32(uint64_t value) {
    return static_cast<uint64_t>(static_cast<int64_t>(static_cast<int32_t>(static_cast<uint32_t>(value))));
}

int64_t imm_i(uint32_t w) { return static_cast<int32_t>(w) >> 20; }

int64_t imm_s(uint32_t w) {
    const uint32_t raw = ((w >> 25) << 5) | ((w >> 7) & 0x1f);
    return sext(raw, 12);
}

int64_t imm_b(uint32_t w) {
    const uint32_t raw = (((w >> 31) & 1) << 12) | (((w >> 7) & 1) << 11) |
                         (((w >> 25) & 0x3f) << 5) | (((w >> 8) & 0xf) << 1);
    return sext(raw, 13);
}

int64_t imm_j(uint32_t w) {
    const uint32_t raw = (((w >> 31) & 1) << 20) | (((w >> 12) & 0xff) << 12) |
                         (((w >> 20) & 1) << 11) | (((w >> 21) & 0x3ff) << 1);
    return sext(raw, 21);
}

int64_t imm_u(uint32_t w) { return static_cast<int32_t>(w & 0xfffff000u); }

float bits_to_float(uint64_t bits) {
    const uint32_t u = static_cast<uint32_t>(bits);
    float f;
    std::memcpy(&f, &u, sizeof f);
    return f;
}

uint64_t float_to_bits(float f) {
    uint32_t u;
    std::memcpy(&u, &f, sizeof u);
    return u;
}

[[noreturn]] void illegal(uint32_t w) {
    char buf[64];
    std::snprintf(buf, sizeof buf, "instrução ilegal ou não suportada: 0x%08x", w);
    throw SimError(buf);
}

}  // namespace

Machine::Machine(unsigned vlen_bits, size_t memory_bytes)
    : mem_(memory_bytes, 0), vlen_bits_(vlen_bits), vlenb_(vlen_bits / 8) {
    if (vlen_bits < 128 || vlen_bits > 4096 || (vlen_bits & (vlen_bits - 1)) != 0) {
        throw SimError("VLEN deve ser potência de 2 entre 128 e 4096");
    }
    vrf_.assign(static_cast<size_t>(32) * vlenb_, 0);
    x_[2] = memory_bytes - 64;
}

uint32_t Machine::fetch(uint64_t addr) const {
    if ((addr & 3) != 0 || addr + 4 > mem_.size()) throw SimError("busca de instrução inválida");
    uint32_t w;
    std::memcpy(&w, &mem_[addr], 4);
    return w;
}

uint64_t Machine::load(uint64_t addr, unsigned bytes) const {
    if (addr > mem_.size() || bytes > mem_.size() - addr) throw SimError("leitura fora da memória");
    uint64_t v = 0;
    for (unsigned k = 0; k < bytes; ++k) v |= static_cast<uint64_t>(mem_[addr + k]) << (8 * k);
    return v;
}

void Machine::store(uint64_t addr, unsigned bytes, uint64_t value) {
    if (addr > mem_.size() || bytes > mem_.size() - addr) throw SimError("escrita fora da memória");
    for (unsigned k = 0; k < bytes; ++k) mem_[addr + k] = static_cast<uint8_t>(value >> (8 * k));
}

void Machine::load_elf(const std::vector<uint8_t>& image) {
    if (image.size() < 64 || std::memcmp(image.data(), "\x7f" "ELF", 4) != 0) {
        throw SimError("arquivo não é ELF");
    }
    if (image[4] != 2 || image[5] != 1) throw SimError("ELF deve ser ELF64 little-endian");
    auto rd16 = [&](size_t off) { uint16_t v; std::memcpy(&v, &image[off], 2); return v; };
    auto rd64 = [&](size_t off) { uint64_t v; std::memcpy(&v, &image[off], 8); return v; };
    if (rd16(16) != 2) throw SimError("ELF deve ser ET_EXEC");
    if (rd16(18) != 243) throw SimError("ELF não é RISC-V");
    const uint64_t entry = rd64(24);
    const uint64_t phoff = rd64(32);
    const uint16_t phentsize = rd16(54);
    const uint16_t phnum = rd16(56);
    for (uint16_t i = 0; i < phnum; ++i) {
        const size_t ph = phoff + static_cast<size_t>(i) * phentsize;
        if (ph + 56 > image.size()) throw SimError("cabeçalho de programa fora do arquivo");
        uint32_t type;
        std::memcpy(&type, &image[ph], 4);
        if (type != 1) continue;  // PT_LOAD
        const uint64_t off = rd64(ph + 8);
        const uint64_t vaddr = rd64(ph + 16);
        const uint64_t filesz = rd64(ph + 32);
        const uint64_t memsz = rd64(ph + 40);
        if (off + filesz > image.size() || vaddr > mem_.size() || memsz > mem_.size() - vaddr) {
            throw SimError("segmento ELF fora da memória do simulador");
        }
        std::memcpy(&mem_[vaddr], &image[off], filesz);
        std::memset(&mem_[vaddr + filesz], 0, memsz - filesz);
    }
    pc_ = entry;
}

int Machine::run(uint64_t max_instructions) {
    uint64_t executed = 0;
    while (!exited_) {
        if (executed++ >= max_instructions) throw SimError("limite de instruções atingido");
        step();
    }
    return exit_code_;
}

void Machine::step() {
    const uint32_t w = fetch(pc_);
    ++cnt_.insn_total;
    switch (w & 0x7f) {
        case 0x37:
        case 0x17:
        case 0x6f:
        case 0x67:
        case 0x63:
        case 0x03:
        case 0x23:
        case 0x13:
        case 0x33:
        case 0x1b:
        case 0x3b:
        case 0x0f:
            exec_scalar(w);
            return;
        case 0x73:
            exec_system(w);
            return;
        case 0x57:
            exec_opv(w);
            return;
        case 0x07:
            exec_vload(w);
            return;
        case 0x27:
            exec_vstore(w);
            return;
        case 0x0b:
            exec_zvtakum(w);
            return;
        default:
            illegal(w);
    }
}

// ---------------------------------------------------------------- escalar

void Machine::exec_scalar(uint32_t w) {
    ++cnt_.insn_scalar;
    const uint32_t op = w & 0x7f;
    const unsigned rd = (w >> 7) & 31;
    const unsigned f3 = (w >> 12) & 7;
    const unsigned rs1 = (w >> 15) & 31;
    const unsigned rs2 = (w >> 20) & 31;
    const uint32_t f7 = w >> 25;
    const uint64_t a = reg(rs1);
    const uint64_t b = reg(rs2);
    const uint64_t next = pc_ + 4;
    uint64_t new_pc = next;

    switch (op) {
        case 0x37:
            set_reg(rd, static_cast<uint64_t>(imm_u(w)));
            break;
        case 0x17:
            set_reg(rd, pc_ + static_cast<uint64_t>(imm_u(w)));
            break;
        case 0x6f:
            set_reg(rd, next);
            new_pc = pc_ + static_cast<uint64_t>(imm_j(w));
            break;
        case 0x67: {
            if (f3 != 0) illegal(w);
            const uint64_t target = (a + static_cast<uint64_t>(imm_i(w))) & ~uint64_t(1);
            set_reg(rd, next);
            new_pc = target;
            break;
        }
        case 0x63: {
            bool taken = false;
            switch (f3) {
                case 0: taken = a == b; break;
                case 1: taken = a != b; break;
                case 4: taken = static_cast<int64_t>(a) < static_cast<int64_t>(b); break;
                case 5: taken = static_cast<int64_t>(a) >= static_cast<int64_t>(b); break;
                case 6: taken = a < b; break;
                case 7: taken = a >= b; break;
                default: illegal(w);
            }
            if (taken) new_pc = pc_ + static_cast<uint64_t>(imm_b(w));
            break;
        }
        case 0x03: {
            const uint64_t addr = a + static_cast<uint64_t>(imm_i(w));
            uint64_t v = 0;
            switch (f3) {
                case 0: v = static_cast<uint64_t>(sext(load(addr, 1), 8)); break;
                case 1: v = static_cast<uint64_t>(sext(load(addr, 2), 16)); break;
                case 2: v = static_cast<uint64_t>(sext(load(addr, 4), 32)); break;
                case 3: v = load(addr, 8); break;
                case 4: v = load(addr, 1); break;
                case 5: v = load(addr, 2); break;
                case 6: v = load(addr, 4); break;
                default: illegal(w);
            }
            set_reg(rd, v);
            break;
        }
        case 0x23: {
            const uint64_t addr = a + static_cast<uint64_t>(imm_s(w));
            const unsigned bytes = f3 == 0 ? 1 : f3 == 1 ? 2 : f3 == 2 ? 4 : f3 == 3 ? 8 : 0;
            if (bytes == 0) illegal(w);
            store(addr, bytes, b);
            break;
        }
        case 0x13: {
            const uint64_t imm = static_cast<uint64_t>(imm_i(w));
            const unsigned shamt = (w >> 20) & 63;
            const uint32_t hi6 = w >> 26;
            switch (f3) {
                case 0: set_reg(rd, a + imm); break;
                case 1:
                    if (hi6 != 0) illegal(w);
                    set_reg(rd, a << shamt);
                    break;
                case 2: set_reg(rd, static_cast<int64_t>(a) < imm_i(w) ? 1 : 0); break;
                case 3: set_reg(rd, a < imm ? 1 : 0); break;
                case 4: set_reg(rd, a ^ imm); break;
                case 5:
                    if (hi6 == 0) {
                        set_reg(rd, a >> shamt);
                    } else if (hi6 == 0x10) {
                        set_reg(rd, static_cast<uint64_t>(static_cast<int64_t>(a) >> shamt));
                    } else {
                        illegal(w);
                    }
                    break;
                case 6: set_reg(rd, a | imm); break;
                case 7: set_reg(rd, a & imm); break;
            }
            break;
        }
        case 0x33: {
            const unsigned shamt = b & 63;
            if (f7 == 0x01) {
                switch (f3) {
                    case 0: set_reg(rd, a * b); break;
                    case 1: {
                        const __int128 p = static_cast<__int128>(static_cast<int64_t>(a)) *
                                           static_cast<__int128>(static_cast<int64_t>(b));
                        set_reg(rd, static_cast<uint64_t>(p >> 64));
                        break;
                    }
                    case 2: {
                        const __int128 p = static_cast<__int128>(static_cast<int64_t>(a)) *
                                           static_cast<__int128>(b);
                        set_reg(rd, static_cast<uint64_t>(p >> 64));
                        break;
                    }
                    case 3: {
                        const unsigned __int128 p = static_cast<unsigned __int128>(a) * b;
                        set_reg(rd, static_cast<uint64_t>(p >> 64));
                        break;
                    }
                    case 4: {
                        const int64_t sa = static_cast<int64_t>(a), sb = static_cast<int64_t>(b);
                        if (sb == 0) set_reg(rd, ~uint64_t(0));
                        else if (sa == std::numeric_limits<int64_t>::min() && sb == -1) set_reg(rd, a);
                        else set_reg(rd, static_cast<uint64_t>(sa / sb));
                        break;
                    }
                    case 5: set_reg(rd, b == 0 ? ~uint64_t(0) : a / b); break;
                    case 6: {
                        const int64_t sa = static_cast<int64_t>(a), sb = static_cast<int64_t>(b);
                        if (sb == 0) set_reg(rd, a);
                        else if (sa == std::numeric_limits<int64_t>::min() && sb == -1) set_reg(rd, 0);
                        else set_reg(rd, static_cast<uint64_t>(sa % sb));
                        break;
                    }
                    case 7: set_reg(rd, b == 0 ? a : a % b); break;
                }
                break;
            }
            if (f7 == 0x00) {
                switch (f3) {
                    case 0: set_reg(rd, a + b); break;
                    case 1: set_reg(rd, a << shamt); break;
                    case 2: set_reg(rd, static_cast<int64_t>(a) < static_cast<int64_t>(b) ? 1 : 0); break;
                    case 3: set_reg(rd, a < b ? 1 : 0); break;
                    case 4: set_reg(rd, a ^ b); break;
                    case 5: set_reg(rd, a >> shamt); break;
                    case 6: set_reg(rd, a | b); break;
                    case 7: set_reg(rd, a & b); break;
                }
                break;
            }
            if (f7 == 0x20 && f3 == 0) {
                set_reg(rd, a - b);
                break;
            }
            if (f7 == 0x20 && f3 == 5) {
                set_reg(rd, static_cast<uint64_t>(static_cast<int64_t>(a) >> shamt));
                break;
            }
            illegal(w);
        }
        case 0x1b: {
            const uint64_t imm = static_cast<uint64_t>(imm_i(w));
            const unsigned shamt = (w >> 20) & 31;
            switch (f3) {
                case 0: set_reg(rd, sext32(a + imm)); break;
                case 1:
                    if (f7 != 0) illegal(w);
                    set_reg(rd, sext32(static_cast<uint32_t>(a) << shamt));
                    break;
                case 5:
                    if (f7 == 0x00) set_reg(rd, sext32(static_cast<uint32_t>(a) >> shamt));
                    else if (f7 == 0x20) set_reg(rd, static_cast<uint64_t>(static_cast<int32_t>(a) >> shamt));
                    else illegal(w);
                    break;
                default: illegal(w);
            }
            break;
        }
        case 0x3b: {
            const unsigned shamt = b & 31;
            if (f7 == 0x01) {
                const int32_t sa = static_cast<int32_t>(a), sb = static_cast<int32_t>(b);
                switch (f3) {
                    case 0: set_reg(rd, sext32(a * b)); break;
                    case 4:
                        if (sb == 0) set_reg(rd, ~uint64_t(0));
                        else if (sa == std::numeric_limits<int32_t>::min() && sb == -1)
                            set_reg(rd, sext32(static_cast<uint32_t>(sa)));
                        else set_reg(rd, sext32(static_cast<uint32_t>(sa / sb)));
                        break;
                    case 5: {
                        const uint32_t ua = static_cast<uint32_t>(a), ub = static_cast<uint32_t>(b);
                        set_reg(rd, ub == 0 ? ~uint64_t(0) : sext32(ua / ub));
                        break;
                    }
                    case 6:
                        if (sb == 0) set_reg(rd, sext32(static_cast<uint32_t>(sa)));
                        else if (sa == std::numeric_limits<int32_t>::min() && sb == -1) set_reg(rd, 0);
                        else set_reg(rd, sext32(static_cast<uint32_t>(sa % sb)));
                        break;
                    case 7: {
                        const uint32_t ua = static_cast<uint32_t>(a), ub = static_cast<uint32_t>(b);
                        set_reg(rd, ub == 0 ? sext32(ua) : sext32(ua % ub));
                        break;
                    }
                    default: illegal(w);
                }
                break;
            }
            if (f7 == 0x00) {
                switch (f3) {
                    case 0: set_reg(rd, sext32(a + b)); break;
                    case 1: set_reg(rd, sext32(static_cast<uint32_t>(a) << shamt)); break;
                    case 5: set_reg(rd, sext32(static_cast<uint32_t>(a) >> shamt)); break;
                    default: illegal(w);
                }
                break;
            }
            if (f7 == 0x20 && f3 == 0) {
                set_reg(rd, sext32(a - b));
                break;
            }
            if (f7 == 0x20 && f3 == 5) {
                set_reg(rd, static_cast<uint64_t>(static_cast<int32_t>(a) >> shamt));
                break;
            }
            illegal(w);
        }
        case 0x0f:
            break;  // FENCE: sem efeito em um modelo sequencial
        default:
            illegal(w);
    }
    pc_ = new_pc;
}

void Machine::exec_system(uint32_t w) {
    ++cnt_.insn_scalar;
    const unsigned f3 = (w >> 12) & 7;
    if (f3 == 0) {
        if (w == 0x00000073) {  // ecall
            const uint64_t number = reg(17);
            if (number == 64) {  // write(fd, buf, len)
                const uint64_t fd = reg(10), buf = reg(11), len = reg(12);
                if (len > mem_.size() || buf > mem_.size() - len) throw SimError("write fora da memória");
                if (fd == 1) stdout_.append(reinterpret_cast<const char*>(&mem_[buf]), len);
                set_reg(10, len);
            } else if (number == 93) {  // exit(code)
                exit_code_ = static_cast<int>(reg(10));
                exited_ = true;
                return;
            } else {
                throw SimError("ecall não suportado");
            }
            pc_ += 4;
            return;
        }
        if (w == 0x00100073) throw SimError("ebreak");
        illegal(w);
    }
    exec_csr(w);
}

void Machine::exec_csr(uint32_t w) {
    const unsigned rd = (w >> 7) & 31;
    const unsigned f3 = (w >> 12) & 7;
    const unsigned rs1 = (w >> 15) & 31;
    const uint32_t csr = w >> 20;
    const bool immediate = f3 >= 5;
    const uint64_t src = immediate ? rs1 : reg(rs1);
    const bool writes = (f3 & 3) == 1 ? true : src != 0;
    const bool reads = (f3 & 3) == 1 ? rd != 0 : true;

    uint64_t old = 0;
    if (reads) {
        ++cnt_.csr_reads;
        switch (csr) {
            case 0x008: old = vstart_; break;
            case 0x009: old = vxsat_; break;
            case 0x00a: old = vxrm_; break;
            case 0x00f: old = (vxrm_ << 1) | vxsat_; break;
            case 0xc00:
            case 0xc02: old = cnt_.insn_total; break;
            case 0xc20: old = vl_; break;
            case 0xc21: old = vill_ ? (uint64_t(1) << 63) | vtype_ : vtype_; break;
            case 0xc22: old = vlenb_; break;
            default: illegal(w);
        }
    }

    if (writes) {
        const bool writable = csr == 0x008 || csr == 0x009 || csr == 0x00a || csr == 0x00f;
        if (!writable) illegal(w);
        uint64_t value = (f3 & 3) == 1 ? src : ((f3 & 3) == 2 ? (old | src) : (old & ~src));
        ++cnt_.csr_writes;
        switch (csr) {
            case 0x008: vstart_ = value; break;
            case 0x009: vxsat_ = value & 1; break;
            case 0x00a: vxrm_ = value & 3; break;
            case 0x00f:
                vxsat_ = value & 1;
                vxrm_ = (value >> 1) & 3;
                break;
        }
    }
    set_reg(rd, old);
    pc_ += 4;
}

// ------------------------------------------------------------ vetorial: helpers

uint64_t Machine::vlmax_for(unsigned sew_bits) const {
    return static_cast<uint64_t>(vlen_bits_) * lmul_ / sew_bits;
}

void Machine::require_vtype_legal() const {
    if (vill_) throw SimError("instrução vetorial com vtype inválido (vill)");
}

void Machine::check_group(unsigned base, unsigned emul) const {
    if (emul == 0 || emul > 8 || base % emul != 0 || base + emul > 32) {
        throw SimError("grupo de registradores vetoriais inválido");
    }
}

bool Machine::active(uint64_t index) const {
    return ((vrf_[index / 8] >> (index % 8)) & 1) != 0;
}

uint64_t Machine::vread(unsigned base, uint64_t index, unsigned eew) const {
    const uint64_t off = index * eew;
    const uint64_t reg_index = base + off / vlenb_;
    if (reg_index >= 32) throw SimError("acesso de elemento além de v31");
    const uint8_t* p = &vrf_[reg_index * vlenb_ + off % vlenb_];
    uint64_t v = 0;
    for (unsigned k = 0; k < eew; ++k) v |= static_cast<uint64_t>(p[k]) << (8 * k);
    return v;
}

void Machine::vwrite(unsigned base, uint64_t index, unsigned eew, uint64_t value) {
    const uint64_t off = index * eew;
    const uint64_t reg_index = base + off / vlenb_;
    if (reg_index >= 32) throw SimError("escrita de elemento além de v31");
    uint8_t* p = &vrf_[reg_index * vlenb_ + off % vlenb_];
    for (unsigned k = 0; k < eew; ++k) p[k] = static_cast<uint8_t>(value >> (8 * k));
}

void Machine::fill_ones(unsigned base, uint64_t from, uint64_t to, unsigned eew, bool policy) {
    if (!policy) return;
    for (uint64_t i = from; i < to; ++i) vwrite(base, i, eew, ~uint64_t(0));
}

// -------------------------------------------------------- vetorial: configuração

void Machine::vsetvl_common(unsigned rd, uint64_t avl, bool rs1_is_x0, bool rd_is_x0,
                            uint64_t vtypei) {
    const bool vill_bit = (vtypei >> 63) & 1;
    const unsigned vlmul = static_cast<unsigned>(vtypei & 7);
    const unsigned vsew = static_cast<unsigned>((vtypei >> 3) & 7);
    const bool reserved = (vtypei >> 8) != 0;
    if (vill_bit || reserved || vlmul >= 4 || vsew > 3) {
        vill_ = true;
        vtype_ = 0;
        vl_ = 0;
        vstart_ = 0;
        if (!rd_is_x0) set_reg(rd, 0);
        cnt_.csr_writes += 2;
        return;
    }
    vill_ = false;
    sew_ = 8u << vsew;
    lmul_ = 1u << vlmul;
    vta_ = ((vtypei >> 6) & 1) != 0;
    vma_ = ((vtypei >> 7) & 1) != 0;
    vtype_ = vtypei & 0xff;

    const uint64_t vlmax = vlmax_for(sew_);
    uint64_t avl_eff;
    if (rs1_is_x0) {
        avl_eff = rd_is_x0 ? vl_ : ~uint64_t(0);
    } else {
        avl_eff = avl;
    }
    vl_ = avl_eff < vlmax ? avl_eff : vlmax;
    vstart_ = 0;
    if (!rd_is_x0) set_reg(rd, vl_);
    cnt_.csr_writes += 2;
}

// --------------------------------------------------------- vetorial: operações

void Machine::exec_opv(uint32_t w) {
    const unsigned f3 = (w >> 12) & 7;
    const unsigned rd = (w >> 7) & 31;
    const unsigned rs1 = (w >> 15) & 31;
    const unsigned rs2 = (w >> 20) & 31;

    if (f3 == 7) {  // OPCFG: vsetvli, vsetivli, vsetvl
        ++cnt_.insn_vsetvl;
        if (((w >> 31) & 1) == 0) {
            vsetvl_common(rd, reg(rs1), rs1 == 0, rd == 0, (w >> 20) & 0x7ff);
        } else if (((w >> 30) & 1) == 1) {
            vsetvl_common(rd, rs1, false, rd == 0, (w >> 20) & 0x3ff);
        } else {
            if (((w >> 25) & 0x7f) != 0x40) illegal(w);
            vsetvl_common(rd, reg(rs1), rs1 == 0, rd == 0, reg(rs2));
        }
        pc_ += 4;
        return;
    }

    ++cnt_.insn_vector;
    require_vtype_legal();
    const uint32_t funct6 = w >> 26;
    const unsigned vm = (w >> 25) & 1;
    const unsigned vd = rd;
    const unsigned vs2 = rs2;
    const unsigned vs1 = rs1;
    const unsigned sew = sew_;
    const unsigned eb = sew / 8;
    const uint64_t vlmax = vlmax_for(sew);

    if (f3 == 0 && funct6 == 0x17 && vm == 1 && vs2 == 0) {  // vmv.v.v
        check_group(vd, lmul_);
        check_group(vs1, lmul_);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i < vl_) {
                vwrite(vd, i, eb, vread(vs1, i, eb));
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vta_);
            }
        }
    } else if (f3 == 3 && funct6 == 0x17 && vm == 1 && vs2 == 0) {  // vmv.v.i
        check_group(vd, lmul_);
        const int64_t imm = sext(vs1, 5);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i < vl_) {
                vwrite(vd, i, eb, static_cast<uint64_t>(imm));
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vta_);
            }
        }
    } else if (f3 == 1 && (funct6 == 0x00 || funct6 == 0x24)) {  // vfadd.vv, vfmul.vv
        if (sew != 32) illegal(w);
        check_group(vd, lmul_);
        check_group(vs2, lmul_);
        check_group(vs1, lmul_);
        if (vm == 0 && vd == 0) illegal(w);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i >= vl_) {
                fill_ones(vd, i, i + 1, eb, vta_);
                continue;
            }
            if (vm == 1 || active(i)) {
                const float a = bits_to_float(vread(vs2, i, 4));
                const float b = bits_to_float(vread(vs1, i, 4));
                const float r = funct6 == 0x00 ? a + b : a * b;
                vwrite(vd, i, 4, float_to_bits(r));
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vma_);
            }
        }
    } else if (f3 == 1 && funct6 == 0x01) {  // vfredusum.vs: vd[0] = vs1[0] + sum(vs2)
        if (sew != 32) illegal(w);
        if (vstart_ != 0) illegal(w);
        check_group(vs2, lmul_);
        if (vm == 0 && vd == 0) illegal(w);
        float acc = bits_to_float(vread(vs1, 0, 4));
        for (uint64_t i = 0; i < vl_; ++i) {
            if (vm == 1 || active(i)) {
                acc = acc + bits_to_float(vread(vs2, i, 4));
                ++cnt_.elem_active;
            }
        }
        const uint64_t elems_per_reg = vlen_bits_ / (8 * 4);
        if (vl_ > 0) {
            vwrite(vd, 0, 4, float_to_bits(acc));
        } else {
            fill_ones(vd, 0, 1, 4, vta_);
        }
        fill_ones(vd, 1, elems_per_reg, 4, vta_);
    } else {
        illegal(w);
    }
    vstart_ = 0;
    pc_ += 4;
}

void Machine::exec_vload(uint32_t w) {
    ++cnt_.insn_vector;
    require_vtype_legal();
    const unsigned f3 = (w >> 12) & 7;
    const unsigned eew_code = f3;
    unsigned index_or_eew;
    if (eew_code == 0) index_or_eew = 1;
    else if (eew_code == 5) index_or_eew = 2;
    else if (eew_code == 6) index_or_eew = 4;
    else illegal(w);
    const unsigned mop = (w >> 26) & 3;
    const unsigned mew = (w >> 28) & 1;
    const unsigned nf = (w >> 29) & 7;
    if (mew != 0 || nf != 0) illegal(w);
    const unsigned vm = (w >> 25) & 1;
    const unsigned rs2 = (w >> 20) & 31;
    const unsigned vd = (w >> 7) & 31;
    const unsigned rs1 = (w >> 15) & 31;
    const unsigned sew = sew_;
    const unsigned eb = sew / 8;
    const uint64_t vlmax = vlmax_for(sew);
    const uint64_t base = reg(rs1);
    check_group(vd, lmul_);
    if (vm == 0 && vd == 0) illegal(w);

    if (mop == 0) {  // unit-stride
        if (rs2 != 0 || index_or_eew != eb) illegal(w);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i >= vl_) {
                fill_ones(vd, i, i + 1, eb, vta_);
                continue;
            }
            if (vm == 1 || active(i)) {
                vwrite(vd, i, eb, load(base + i * eb, eb));
                cnt_.bytes_loaded += eb;
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vma_);
            }
        }
    } else if (mop == 1) {  // indexed-unordered, índice de 32 bits
        if (index_or_eew != 4) illegal(w);
        const unsigned emul_idx = sew >= 32 ? lmul_ : lmul_ * (32 / sew);
        check_group(rs2, emul_idx);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i >= vl_) {
                fill_ones(vd, i, i + 1, eb, vta_);
                continue;
            }
            if (vm == 1 || active(i)) {
                const uint64_t idx = vread(rs2, i, 4);
                vwrite(vd, i, eb, load(base + idx, eb));
                cnt_.bytes_loaded += eb;
                cnt_.index_bytes_loaded += 4;
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vma_);
            }
        }
    } else {
        illegal(w);
    }
    vstart_ = 0;
    pc_ += 4;
}

void Machine::exec_vstore(uint32_t w) {
    ++cnt_.insn_vector;
    require_vtype_legal();
    const unsigned f3 = (w >> 12) & 7;
    unsigned eew;
    if (f3 == 0) eew = 1;
    else if (f3 == 5) eew = 2;
    else if (f3 == 6) eew = 4;
    else illegal(w);
    const unsigned mop = (w >> 26) & 3;
    const unsigned mew = (w >> 28) & 1;
    const unsigned nf = (w >> 29) & 7;
    const unsigned vm = (w >> 25) & 1;
    const unsigned sumop = (w >> 20) & 31;
    const unsigned vs3 = (w >> 7) & 31;
    const unsigned rs1 = (w >> 15) & 31;
    if (mop != 0 || sumop != 0 || mew != 0 || nf != 0) illegal(w);
    if (eew != sew_ / 8) illegal(w);
    check_group(vs3, lmul_);
    const uint64_t base = reg(rs1);
    for (uint64_t i = vstart_; i < vl_; ++i) {
        if (vm == 1 || active(i)) {
            store(base + i * eew, eew, vread(vs3, i, eew));
            cnt_.bytes_stored += eew;
            ++cnt_.elem_active;
        }
    }
    vstart_ = 0;
    pc_ += 4;
}

void Machine::exec_zvtakum(uint32_t w) {
    ++cnt_.insn_zvtakum;
    require_vtype_legal();
    const unsigned f3 = (w >> 12) & 7;
    const uint32_t funct6 = w >> 26;
    if (f3 != 0 || funct6 > 4) illegal(w);
    const unsigned vm = (w >> 25) & 1;
    const unsigned vs2 = (w >> 20) & 31;
    const unsigned vs1 = (w >> 15) & 31;
    const unsigned vd = (w >> 7) & 31;
    const unsigned sew = sew_;
    if (sew > 32) illegal(w);
    const unsigned eb = sew / 8;
    const uint64_t vlmax = vlmax_for(sew);
    if (vm == 0 && vd == 0) illegal(w);

    if (funct6 <= 2) {  // vtadd, vtsub, vtmul
        check_group(vd, lmul_);
        check_group(vs2, lmul_);
        check_group(vs1, lmul_);
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i >= vl_) {
                fill_ones(vd, i, i + 1, eb, vta_);
                continue;
            }
            if (vm == 1 || active(i)) {
                const uint64_t a = vread(vs2, i, eb);
                const uint64_t b = vread(vs1, i, eb);
                const uint64_t r = funct6 == 0 ? add(sew, a, b)
                                   : funct6 == 1 ? sub(sew, a, b)
                                                 : mul(sew, a, b);
                vwrite(vd, i, eb, r);
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vma_);
            }
        }
    } else if (funct6 == 3) {  // vtdot: vd[0] (2*SEW) += sum vs2[i]*vs1[i]
        if (vstart_ != 0) illegal(w);
        check_group(vs2, lmul_);
        check_group(vs1, lmul_);
        const unsigned eb2 = 2 * eb;
        uint64_t acc = vread(vd, 0, eb2);
        for (uint64_t i = 0; i < vl_; ++i) {
            if (vm == 1 || active(i)) {
                acc = dot_step(sew, acc, vread(vs2, i, eb), vread(vs1, i, eb));
                ++cnt_.elem_active;
            }
        }
        const uint64_t elems_per_reg = vlen_bits_ / (8 * eb2);
        if (vl_ > 0) {
            vwrite(vd, 0, eb2, acc);
        } else {
            fill_ones(vd, 0, 1, eb2, vta_);
        }
        fill_ones(vd, 1, elems_per_reg, eb2, vta_);
    } else {  // vncvt.t.t
        if (vs1 != 0) illegal(w);
        check_group(vs2, 2 * lmul_);
        check_group(vd, lmul_);
        const unsigned eb2 = 2 * eb;
        for (uint64_t i = 0; i < vlmax; ++i) {
            if (i < vstart_) continue;
            if (i >= vl_) {
                fill_ones(vd, i, i + 1, eb, vta_);
                continue;
            }
            if (vm == 1 || active(i)) {
                const uint64_t narrowed = narrow(2 * sew, sew, vread(vs2, i, eb2));
                vwrite(vd, i, eb, narrowed);
                ++cnt_.elem_active;
            } else {
                fill_ones(vd, i, i + 1, eb, vma_);
            }
        }
    }
    vstart_ = 0;
    pc_ += 4;
}

}  // namespace zt
