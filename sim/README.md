# Functional simulator

`zt-sim` models the RV64IM + Zicsr core, the exercised RVV 1.0 subset, and
the experimental Zvtakum instructions. `src/takum.cpp` implements the integer
Takum codec and ALU; `src/machine.cpp` implements ELF loading, scalar/CSR
execution, vector state, and Zvtakum; `src/main.cpp` provides the command-line
driver. `kernels/` contains the SpMV generators and numeric baselines, and
`tests/` contains golden-vector and differential tests.

Build and run the simulator tests from the repository root:

```sh
make sim-test
make sim-check       # requires llvm-mc, a RISC-V linker and qemu-riscv64
make spmv
```

Manual execution accepts an ELF and writes counters as JSON:

```sh
sim/build/zt-sim sim/build/spmv/bcsstk01.takum32.v256.elf \
  --vlen 256 --stdout /tmp/y.bin --counters /tmp/counters.json
cat /tmp/counters.json
```

The simulator tests cover the Takum core, narrowing and dot products, while
`sim-check` compares standard RVV behavior with QEMU and Zvtakum behavior with
the Python model. Golden vectors are versioned under `tests/golden/`.
