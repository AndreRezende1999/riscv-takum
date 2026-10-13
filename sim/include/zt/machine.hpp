// Functional RV64IM/RVV/Zvtakum machine interface (Fase 2).
// The architecture and unsupported instructions are documented in
// docs/arquitetura.md and docs/spec/zvtakum.adoc.
#ifndef ZT_MACHINE_HPP
#define ZT_MACHINE_HPP

#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <vector>

namespace zt {

// Counters for the measured perimeter. The program, loops, addresses, and
// vsetvli all execute in the simulator; implicit vl/vtype writes count as CSR
// writes so kernels can be compared by the same accounting rule.
struct Counters {
    uint64_t insn_total = 0;       // All retired instructions.
    uint64_t insn_scalar = 0;      // RV64I/M and system instructions.
    uint64_t insn_vsetvl = 0;      // vsetvl/vsetvli configuration operations.
    uint64_t insn_vector = 0;      // Standard RVV data operations.
    uint64_t insn_zvtakum = 0;     // Experimental Takum vector operations.
    uint64_t csr_reads = 0;        // Explicit CSR reads.
    uint64_t csr_writes = 0;       // Explicit and implicit CSR writes.
    uint64_t elem_active = 0;      // Active elements processed by vector ops.
    uint64_t bytes_loaded = 0;     // Data bytes read by vector/scalar loads.
    uint64_t bytes_stored = 0;     // Data bytes written by stores.
    uint64_t index_bytes_loaded = 0;  // Bytes read by indexed vector loads.
};

class SimError : public std::runtime_error {
public:
    using std::runtime_error::runtime_error;
};

class Machine {
public:
    // Construct a machine with RVV VLEN in [128,4096] and ELEN=64.
    // memory_bytes is the byte-addressable user memory; invalid accesses throw.
    Machine(unsigned vlen_bits, size_t memory_bytes);

    // Load a little-endian ELF64 RISC-V ET_EXEC image and set the entry PC.
    void load_elf(const std::vector<uint8_t>& image);

    // Execute until the guest exits or max_instructions is reached.
    // Returns the guest exit code; illegal instructions and malformed images
    // raise SimError instead of silently producing a result.
    int run(uint64_t max_instructions);

    // Read or write an integer register; x0 is hard-wired to zero.
    uint64_t reg(unsigned r) const { return r == 0 ? 0 : x_[r]; }
    void set_reg(unsigned r, uint64_t value) { if (r != 0) x_[r] = value; }
    // Program counter accessors used by tests and ELF loading.
    uint64_t pc() const { return pc_; }
    void set_pc(uint64_t value) { pc_ = value; }

    // Guest memory access; references remain valid until the machine is resized.
    std::vector<uint8_t>& memory() { return mem_; }
    const std::vector<uint8_t>& memory() const { return mem_; }

    // RVV state visible to tests and counter/reporting code.
    uint64_t vl() const { return vl_; }
    uint64_t vtype() const { return vtype_; }
    unsigned vlenb() const { return vlenb_; }
    uint64_t vstart() const { return vstart_; }
    const std::string& stdout_bytes() const { return stdout_; }
    const Counters& counters() const { return cnt_; }

    // Direct vector-register access for golden tests. The caller must use a
    // valid register number and respect the configured vlenb.
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
