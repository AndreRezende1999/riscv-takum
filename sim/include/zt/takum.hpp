#ifndef ZT_TAKUM_HPP
#define ZT_TAKUM_HPP

// =============================================================================
// Núcleo Takum (Fase 1): decodificação e aritmética para T8, T16 e T32.
//
// Este arquivo cobre os dois itens da Fase 1:
//   1. extração do bit de sinal (S), do bit de direção (D), dos bits de regime
//      (R), dos bits de característica (C) e dos bits de fração (F);
//   2. adição, subtração e multiplicação para elementos de 8, 16 e 32 bits.
//
// A especificação do formato, os algoritmos e a estratégia de verificação
// estão em docs/fase1.md.  A definição do Takum é a de Hunhold, "Beating
// Posits at Their Own Game: Takum Arithmetic" (arXiv:2404.18603v2, Def. 8),
// variante linear; o arredondamento é para o par no código (RNE).
// =============================================================================

#include <cstdint>

namespace zt {

// Takum linear de largura n (8, 16, 32 ou, internamente, 64 bits), guardado
// nos bits baixos de um uint64_t.  O núcleo é genérico em n; a Fase 1 usa e
// testa n = 8, 16 e 32.

// Valor exato de um takum decodificado: (-1)^neg * sig * 2^(e-63), com o bit
// 63 de sig valendo 1 quando o valor é finito (sig normalizado).  kind
// distingue zero e NaR; nesses casos neg, sig e e não têm significado.
struct Exact {
    enum class Kind { Zero, Nar, Finite };
    Kind kind = Kind::Zero;
    bool neg = false;
    uint64_t sig = 0;
    int e = 0;
};

// Máscara com os n bits baixos em 1 (n < 64).
uint64_t width_mask(int n);

// Código do NaR (Not a Real): apenas o bit mais significativo em 1.
uint64_t nar_code(int n);

// Decodifica os n bits de code no valor exato correspondente.
//   - code = 0 devolve Kind::Zero;
//   - code = nar_code(n) devolve Kind::Nar;
//   - caso contrário devolve Kind::Finite com o valor exato em sig (bit 63
//     em 1) e no expoente e, sem perda de precisão.
Exact decode(int n, uint64_t code);

// Codifica um valor exato em n bits, arredondando para o par no código.
//   - Kind::Zero devolve 0 e Kind::Nar devolve nar_code(n);
//   - valores entre o menor e o maior positivos são arredondados para o
//     vizinho representável (empate para o código par);
//   - valores acima de maxpos saturam em maxpos e valores positivos abaixo
//     de minpos saturam em minpos; não há infinito.
// sticky sinaliza bits não nulos abaixo da precisão de sig: as operações o
// usam para não perder informação descartada antes do arredondamento final.
uint64_t encode(int n, const Exact& value, bool sticky = false);

// Adição, subtração e multiplicação em n bits, com o resultado arredondado
// para o par (RNE) e saturado.  NaR se propaga em qualquer operando; zero se
// comporta como elemento neutro (add/sub) ou absorvente (mul).
uint64_t add(int n, uint64_t a, uint64_t b);
uint64_t sub(int n, uint64_t a, uint64_t b);
uint64_t mul(int n, uint64_t a, uint64_t b);

// Converte um código Takum de from_n para to_n bits, arredondando no código
// de destino.  NaR e zero mantêm sua semântica; a conversão não produz
// infinito e satura nos extremos representáveis.
uint64_t narrow(int from_n, int to_n, uint64_t a);

// Executa um passo de produto escalar: decodifica a e b em n bits, calcula o
// produto e acumula em acc2n de largura 2n.  O produto é arredondado em 2n
// antes da soma, como exige a instrução vtdot; NaR propaga.
uint64_t dot_step(int n, uint64_t acc2n, uint64_t a, uint64_t b);

// Campos do código extraídos na decodificação, acessíveis separadamente para
// inspeção e testes (item 1 do enunciado).  A fração F é exposta em bits crus
// (frac) e na largura p: F = frac / 2^p.  Para n < 12, a leitura usa a janela
// de 12 bits, com zeros fantasmas à direita.
struct Fields {
    int s = 0;            // S: bit de sinal (0 positivo, 1 negativo)
    int d = 0;            // D: bit de direção (0 abaixo de 1, 1 acima de 1)
    int regime_bits = 0;  // R: os 3 bits de regime, como lidos
    int regime = 0;       // r: regime efetivo (R se D=1; 7-R se D=0)
    uint64_t cbits = 0;   // C: os r bits de característica
    int64_t c = 0;        // c: característica combinada da fórmula do expoente
    uint64_t frac = 0;    // F: os p bits de fração (bits crus)
    int p = 0;            // p: número de bits de fração
};

// Extrai S, D, R, C e F do código, sem resolver zero/NaR nem o valor exato
// (para o valor use decode).  O código é mascarado em n bits.
Fields decode_fields(int n, uint64_t code);

}  // namespace zt

#endif
