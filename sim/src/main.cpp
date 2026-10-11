// zt-sim: executa um programa ELF RISC-V (RV64IM + Zicsr + RVV subconjunto + Zvtakum).
//
//   zt-sim PROGRAMA.elf [--vlen BITS] [--mem MIB] [--max-insns N]
//          [--stdout ARQUIVO] [--counters ARQUIVO]
//
// A saída de write(1, ...) vai para --stdout. Os contadores saem em JSON.
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iterator>
#include <string>
#include <vector>

#include "zt/machine.hpp"

namespace {

void usage() {
    std::fprintf(stderr,
                 "uso: zt-sim PROGRAMA.elf [--vlen BITS] [--mem MIB] [--max-insns N]\n"
                 "            [--stdout ARQUIVO] [--counters ARQUIVO]\n");
}

bool write_file(const std::string& path, const std::string& data) {
    std::ofstream out(path, std::ios::binary);
    if (!out) return false;
    out.write(data.data(), static_cast<std::streamsize>(data.size()));
    return static_cast<bool>(out);
}

std::string counters_json(const zt::Counters& c, unsigned vlen, int exit_code) {
    char buf[1024];
    std::snprintf(
        buf, sizeof buf,
        "{\n"
        "  \"vlen_bits\": %u,\n"
        "  \"exit_code\": %d,\n"
        "  \"insn_total\": %llu,\n"
        "  \"insn_scalar\": %llu,\n"
        "  \"insn_vsetvl\": %llu,\n"
        "  \"insn_vector\": %llu,\n"
        "  \"insn_zvtakum\": %llu,\n"
        "  \"csr_reads\": %llu,\n"
        "  \"csr_writes\": %llu,\n"
        "  \"elem_active\": %llu,\n"
        "  \"bytes_loaded\": %llu,\n"
        "  \"bytes_stored\": %llu,\n"
        "  \"index_bytes_loaded\": %llu\n"
        "}\n",
        vlen, exit_code, static_cast<unsigned long long>(c.insn_total),
        static_cast<unsigned long long>(c.insn_scalar),
        static_cast<unsigned long long>(c.insn_vsetvl),
        static_cast<unsigned long long>(c.insn_vector),
        static_cast<unsigned long long>(c.insn_zvtakum),
        static_cast<unsigned long long>(c.csr_reads),
        static_cast<unsigned long long>(c.csr_writes),
        static_cast<unsigned long long>(c.elem_active),
        static_cast<unsigned long long>(c.bytes_loaded),
        static_cast<unsigned long long>(c.bytes_stored),
        static_cast<unsigned long long>(c.index_bytes_loaded));
    return buf;
}

}  // namespace

int main(int argc, char** argv) {
    if (argc < 2) {
        usage();
        return 2;
    }
    std::string program;
    unsigned vlen = 256;
    size_t mem_mib = 16;
    uint64_t max_insns = 1ull << 32;
    std::string stdout_path;
    std::string counters_path;
    for (int i = 1; i < argc; ++i) {
        const std::string arg = argv[i];
        auto next = [&]() -> std::string {
            if (i + 1 >= argc) {
                usage();
                std::exit(2);
            }
            return argv[++i];
        };
        if (arg == "--vlen") vlen = static_cast<unsigned>(std::stoul(next()));
        else if (arg == "--mem") mem_mib = std::stoul(next());
        else if (arg == "--max-insns") max_insns = std::stoull(next());
        else if (arg == "--stdout") stdout_path = next();
        else if (arg == "--counters") counters_path = next();
        else if (!arg.empty() && arg[0] == '-') {
            usage();
            return 2;
        } else program = arg;
    }
    if (program.empty()) {
        usage();
        return 2;
    }

    std::ifstream in(program, std::ios::binary);
    if (!in) {
        std::fprintf(stderr, "zt-sim: não foi possível abrir %s\n", program.c_str());
        return 2;
    }
    std::vector<uint8_t> image((std::istreambuf_iterator<char>(in)), std::istreambuf_iterator<char>());

    try {
        zt::Machine machine(vlen, mem_mib << 20);
        machine.load_elf(image);
        const int code = machine.run(max_insns);
        if (!stdout_path.empty() && !write_file(stdout_path, machine.stdout_bytes())) {
            std::fprintf(stderr, "zt-sim: não foi possível gravar %s\n", stdout_path.c_str());
            return 2;
        }
        const std::string json = counters_json(machine.counters(), vlen, code);
        if (!counters_path.empty()) {
            if (!write_file(counters_path, json)) {
                std::fprintf(stderr, "zt-sim: não foi possível gravar %s\n", counters_path.c_str());
                return 2;
            }
        } else {
            std::fputs(json.c_str(), stderr);
        }
        return code == 0 ? 0 : 1;
    } catch (const zt::SimError& err) {
        std::fprintf(stderr, "zt-sim: erro: %s\n", err.what());
        return 3;
    }
}
