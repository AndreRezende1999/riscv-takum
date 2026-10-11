#ifndef ZT_MACHINE_HPP
#define ZT_MACHINE_HPP

#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <vector>

namespace zt {

// Contadores do perímetro medido. Todo o código do programa executa no simulador,
// inclusive laços, endereços e vsetvli. Escritas implícitas de vl e vtype contam
// como escritas de CSR.
struct Counters {
    uint64_t insn_total = 0;
    uint64_t insn_scalar = 0;
    uint64_t insn_vsetvl = 0;
    uint64_t insn_vector = 0;
    uint64_t insn_zvtakum = 0;
    uint64_t csr_reads = 0;
    uint64_t csr_writes = 0;
    uint64_t elem_active = 0;
    uint64_t bytes_loaded = 0;
    uint64_t bytes_stored = 0;
    uint64_t index_bytes_loaded = 0;
};

class SimError : public std::runtime_error {
public:
    using std::runtime_error::runtime_error;
};

class Machine {
public:
    // vlen_bits: potência de 2 em [128, 4096]. ELEN = 64.
    Machine(unsigned vlen_bits, size_t memory_bytes);

    // Carrega um executável ELF64 RISC-V (ET_EXEC, little-endian) e define o pc.
    void load_elf(const std::vector<uint8_t>& image);

    // Executa até exit ou até max_instructions. Retorna o código de saída.
    int run(uint64_t max_instructions);

    uint64_t reg(unsigned r) const { return r == 0 ? 0 : x_[r]; }
    void set_reg(unsigned r, uint64_t value) { if (r != 0) x_[r] = value; }
    uint64_t pc() const { return pc_; }
    void set_pc(uint64_t value) { pc_ = value; }

    std::vector<uint8_t>& memory() { return mem_; }
    const std::vector<uint8_t>& memory() const { return mem_; }

    uint64_t vl() const { return vl_; }
    uint64_t vtype() const { return vtype_; }
    unsigned vlenb() const { return vlenb_; }
    uint64_t vstart() const { return vstart_; }
    const std::string& stdout_bytes() const { return stdout_; }
    const Counters& counters() const { return cnt_; }

    // Acesso direto ao banco vetorial para testes.
    uint8_t* vreg(unsigned r) { return &vrf_[static_cast<size_t>(r) * vlenb_]; }

private:
    void step();
    void exec_scalar(uint32_t w);
    void exec_system(uint32_t w);
    void exec_opv(uint32_t w);
    void exec_vload(uint32_t w);
    void exec_vstore(uint32_t w);
    void exec_zvtakum(uint32_t w);
    void exec_csr(uint32_t w);
    void vsetvl_common(unsigned rd, uint64_t avl, bool rs1_is_x0, bool rd_is_x0, uint64_t vtypei);

    uint64_t load(uint64_t addr, unsigned bytes) const;
    void store(uint64_t addr, unsigned bytes, uint64_t value);
    uint32_t fetch(uint64_t addr) const;

    uint64_t vread(unsigned base, uint64_t index, unsigned eew_bytes) const;
    void vwrite(unsigned base, uint64_t index, unsigned eew_bytes, uint64_t value);
    void check_group(unsigned base, unsigned emul) const;
    bool active(uint64_t index) const;
    void fill_ones(unsigned base, uint64_t from, uint64_t to, unsigned eew_bytes, bool policy);
    uint64_t vlmax_for(unsigned sew_bits) const;
    void require_vtype_legal() const;

    uint64_t x_[32] = {};
    uint64_t pc_ = 0;
    std::vector<uint8_t> mem_;

    unsigned vlen_bits_;
    unsigned vlenb_;
    std::vector<uint8_t> vrf_;
    uint64_t vl_ = 0;
    uint64_t vtype_ = 0;
    uint64_t vstart_ = 0;
    unsigned sew_ = 8;
    unsigned lmul_ = 1;
    bool vta_ = false;
    bool vma_ = false;
    bool vill_ = true;
    uint64_t vxsat_ = 0;
    uint64_t vxrm_ = 0;

    std::string stdout_;
    Counters cnt_;
    bool exited_ = false;
    int exit_code_ = 0;
};

}  // namespace zt

#endif
