# Texto preliminar em inglês para o artigo

> Arquivo histórico, fora do foco atual. Por orientação da usuária, primeiro serão desenvolvidos a solução Python, os testes e os experimentos; este rascunho não foi atualizado para a nova implementação.

Este arquivo contém prosa preparatória, não um artigo final nem resultados novos. As referências `[chave]` correspondem a `referencias.bib`; ao integrar em LaTeX, convertê-las para `\cite{chave}`. As métricas e a contribuição final devem ser ajustadas ao que for efetivamente implementado e medido.

## Suggested title

A Reproducible Functional Evaluation of Takum Arithmetic in a RISC-V Vector Subset

## Introduction — draft

Low-precision arithmetic reduces operand storage but requires a careful balance between representable range and numerical accuracy. FP8 E4M3 and E5M2 were proposed for deep-learning workloads, while bfloat16 is used in systems that combine reduced-precision operands with wider accumulation [micikevicius2022fp8, google2026bfloat16]. These use cases motivate explicitly reporting input formats, accumulation precision, rounding, and scaling when comparing numerical representations.

Takum arithmetic introduces a tapered representation with a bounded characteristic encoding and both logarithmic and linear interpretations [hunhold2024takum]. Hunhold subsequently examined its use as a basis for restructuring an AVX10.2 instruction set [hunhold2025avx102]. Adapting that research direction to RISC-V requires an architectural analysis specific to RVV, whose element widths and execution state are part of the vector programming model [riscv2026vector].

The project investigates a functional RVV subset with experimental Takum vector operations for 8-, 16-, and 32-bit operands. Its intended evaluation separates representation error, arithmetic error on quantized inputs, and end-to-end sparse matrix-vector multiplication error. Instruction counts are interpreted within a declared simulation boundary. This scope supports a study of numerical behavior and instruction sequences; it does not by itself establish hardware latency, area, or energy benefits.

## Related work — draft

**Takum representation and numerical applications.** The foundational Takum work defines the representation and its mathematical properties [hunhold2024takum]. The AVX10.2 study examines ISA organization and numerical representation on sparse-matrix data [hunhold2025avx102]. Subsequent work evaluates Takum and competing formats in sparse linear solvers [hunhold2025solvers] and the implicitly restarted Arnoldi method [hunhold2025arnoldi]. These studies motivate application-level evaluation, while the present project focuses on a vector-instruction subset and the SpMV kernel rather than implementing complete solvers.

**Arithmetic formats in RISC-V.** Posits provide an alternative tapered representation [gustafson2017posit]. PERCIVAL integrates posit operations and quire support into a RISC-V core, connecting numerical behavior with hardware and software support [mallasen2022percival]. FPnew investigates a different design direction: a configurable unit supporting several floating-point formats and mixed-precision operations [mach2020fpnew]. Together, these works show why representation, accumulator design, and implementation scope must be distinguished when positioning a new arithmetic extension.

**Hardware and reproducibility.** Takum codec research studies hardware encoding and decoding [hunhold2025codec]. Such evidence concerns the evaluated codec and platform; it should not be interpreted as a measurement of this project's complete vector ALU. The current prototype delegates arithmetic operations to libtakum and uses libposit for the posit comparator [libtakum, libposit]. Experiments using the SuiteSparse collection must identify the evaluated matrices and cite the collection [davis2011suitesparse]. The final artifact should record dependency revisions and numerical-reference settings so that reported results can be checked independently.

## Contribution statement — provisional, to be used after validation

The intended contribution is a reproducible functional evaluation that connects an explicitly specified Takum vector subset with controlled numerical experiments. It comprises: (i) a documented instruction interface and validated simulator behavior; (ii) experiments using a shared high-precision reference and explicit accumulation policies; and (iii) reproducible data and scripts connecting each reported figure to its configuration. Takum's representation, the arithmetic libraries, and prior benchmark methodologies remain attributed to their original authors [hunhold2024takum, hunhold2025avx102, libtakum, libposit].

Do not replace “intended” with a completed-work statement until all three items have been verified.

## Wording to replace in the current manuscript

| Current claim | Evidence-based replacement or action |
|---|---|
| “replaces the 96 ... instructions ... with eight” | State the five implemented experimental instructions; defer a reduction percentage until an equivalent-coverage inventory exists. |
| “Takum T32 ... lowest median” | Restrict the comparison to binary32 if supported by the regenerated data; the supplied posit32 summary has a smaller median than linear Takum32. |
| “within sampling noise” for T8 closure | Report a discrepancy in exhaustive enumeration and investigate the domain and exactness criterion. |
| “80-bit ... far more accurate” as justification for Float128 substitution | Specify the measured type and implement the required reference; quantify reference sensitivity rather than assuming it. |
| “15× more accurate” for SpMV | Recompute against a common reference and distinguish input quantization and accumulator precision. |
| “no new CSRs” as evidence of reduced CSR traffic | Distinguish architectural state added by the proposal from runtime configuration events; measure both with consistent definitions. |

## What the final Results section must contain

The final version needs actual regenerated measurements: dataset/configuration table, paired error distributions, non-finite/saturation rates, accumulation controls, instruction-count boundary, and a discussion of cases where Takum loses. Every number should be traceable to raw outputs. No new benchmark number is supplied in this draft.
