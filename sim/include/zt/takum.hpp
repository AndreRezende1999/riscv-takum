#ifndef ZT_TAKUM_HPP
#define ZT_TAKUM_HPP

#include <cstdint>

namespace zt {

// Takum linear de largura n (8, 16, 32 ou 64 bits), nos bits baixos de um uint64_t.
// Definição: Hunhold, arXiv:2404.18603v2, Def. 8. Arredondamento: RNE no código
// (ver docs/spec/zvtakum.adoc, seção "Arredondamento").

// Valor exato: (-1)^neg * sig * 2^(e-63), com o bit 63 de sig igual a 1 quando finito.
struct Exact {
    enum class Kind { Zero, Nar, Finite };
    Kind kind = Kind::Zero;
    bool neg = false;
    uint64_t sig = 0;
    int e = 0;
};

uint64_t width_mask(int n);
uint64_t nar_code(int n);
Exact decode(int n, uint64_t code);

// Codifica um valor exato. sticky indica bits não nulos abaixo da precisão de sig.
uint64_t encode(int n, const Exact& value, bool sticky = false);

uint64_t add(int n, uint64_t a, uint64_t b);
uint64_t sub(int n, uint64_t a, uint64_t b);
uint64_t mul(int n, uint64_t a, uint64_t b);

// vncvt: converte um takum de largura from_n para to_n (RNE no código).
uint64_t narrow(int from_n, int to_n, uint64_t a);

// Um passo de vtdot: acc (largura 2n) += a*b, com o produto arredondado em 2n
// antes da soma. a e b têm largura n.
uint64_t dot_step(int n, uint64_t acc2n, uint64_t a, uint64_t b);

}  // namespace zt

#endif
