// =============================================================================
// Núcleo Takum (Fase 1) -- implementação.
//
// Cobre os dois itens do enunciado:
//   1. extração de S, D, R, C e F na decodificação;
//   2. adição, subtração e multiplicação em T8, T16 e T32.
//
// A especificação do formato, os algoritmos e a estratégia de verificação
// estão em docs/fase1.md.  Toda a aritmética é feita em inteiros (uint64_t e
// unsigned __int128), sem double: o arredondamento é definido no código de
// n+1 bits (prefixo) mais o bit sticky, não no valor.
// =============================================================================

#include "zt/takum.hpp"

namespace zt {
namespace {

using u128 = unsigned __int128;

// Índice (base 0) do bit mais significativo de v != 0.
int msb128(u128 v) {
    uint64_t hi = static_cast<uint64_t>(v >> 64);
    if (hi != 0) return 127 - __builtin_clzll(hi);
    uint64_t lo = static_cast<uint64_t>(v);
    return 63 - __builtin_clzll(lo);
}

// Índice (base 0) do bit mais significativo de v != 0 (v < 2^64).
int floor_log2(uint64_t v) { return 63 - __builtin_clzll(v); }

// Maior código positivo representável (maxpos): o código do NaR menos 1.
uint64_t maxpos_code(int n) { return nar_code(n) - 1; }

// Codifica |v| > 0 a partir do expoente c do bit líder e do significando em
// sig (bit 63 = líder; valor = sig * 2^(c-63)) e devolve o código positivo já
// arredondado para o par no código, limitado a [1, maxpos_code(n)].
// sticky indica bits não nulos já descartados de sig.
uint64_t encode_positive(int n, int64_t c, uint64_t sig, bool sticky) {
    // Saturação grosseira pelos extremos de expoente, antes de montar bits.
    if (c > 254) return maxpos_code(n);
    if (c < -255) return 1;

    // Cabeçalho do código: D (direção), R (regime) e C (característica).
    // Para c >= 0: r = floor(log2(c+1)) e C = c - (2^r - 1).
    // Para c < 0:  r = floor(log2(-c)) e C = c + 2^(r+1) - 1; no código, o
    // regime lido é 7 - r, pois a direção negativa desce a partir de 1.
    const bool d = c >= 0;
    const int r = d ? floor_log2(static_cast<uint64_t>(c + 1))
                     : floor_log2(static_cast<uint64_t>(-c));
    const uint64_t regime = d ? static_cast<uint64_t>(r) : static_cast<uint64_t>(7 - r);
    const uint64_t cbits = d ? static_cast<uint64_t>(c - ((int64_t(1) << r) - 1))
                             : static_cast<uint64_t>(c + (int64_t(1) << (r + 1)) - 1);
    const int hdr = r + 5;
    const uint64_t header = (static_cast<uint64_t>(d) << (r + 3)) | (regime << r) | cbits;

    // Cadeia infinita do código: cabeçalho, depois os bits de fração de sig.
    u128 stream = static_cast<u128>(header) << (128 - hdr);
    const uint64_t frac = sig & ((uint64_t(1) << 63) - 1);
    stream |= static_cast<u128>(frac) << (128 - hdr - 63);

    // Prefixo de n+1 bits; o último bit é o de meio-ponto; o resto é sticky.
    // (O prefixo existe porque a cadeia do código é infinita à direita.)
    const int m = n + 1;
    const u128 l1 = stream >> (128 - m);
    const u128 rest = stream & ((static_cast<u128>(1) << (128 - m)) - 1);
    const bool st = sticky || rest != 0;

    // RNE no código: sobe quando o bit de meio-ponto é 1 e há descartes não
    // nulos (st) ou quando o prefixo de n bits é ímpar (empate para par).
    // Por fim satura: nunca devolve 0 nem passa de maxpos.
    // Por que n+1 bits implementam RNE: o bit extra é exatamente o de
    // meio-ponto entre dois códigos vizinhos de n bits.  Com ele em 0, o
    // valor está na metade de baixo (trunca, mesmo com sticky); em 1 com
    // sticky, está estritamente acima do meio (sobe); em 1 sem sticky, é
    // empate exato, resolvido pelo código par (sobe se lo for ímpar).
    u128 lo = l1 >> 1;
    u128 res = lo;
    if ((l1 & 1) != 0 && (st || (lo & 1) != 0)) res = lo + 1;
    if (res == 0) res = 1;
    if (res > maxpos_code(n)) res = maxpos_code(n);
    return static_cast<uint64_t>(res);
}

// Produto exato de dois finitos; sticky recebe os bits descartados.
Exact mul_exact(const Exact& x, const Exact& y, bool& sticky) {
    const u128 p = static_cast<u128>(x.sig) * y.sig;
    const int m = msb128(p);
    const int shift = m - 63;
    Exact out;
    out.kind = Exact::Kind::Finite;
    out.neg = x.neg != y.neg;
    out.sig = static_cast<uint64_t>(p >> shift);
    out.e = x.e + y.e + (m - 126);
    sticky = (p & ((static_cast<u128>(1) << shift) - 1)) != 0;
    return out;
}

// Campos lidos da janela de decodificação, compartilhados por decode() e
// decode_fields() para que exista uma única extração de S, D, R, C e F.
struct RawFields {
    int s;            // S
    int d;            // D
    int regime_bits;  // R, como lido
    int regime;       // r efetivo
    int p;            // bits de fração
    uint64_t cbits;   // C
    int64_t c;        // característica combinada
    uint64_t frac;    // F
};

RawFields parse_fields(int n, uint64_t code) {
    // Janela de 12 bits: códigos curtos (n < 12) recebem zeros fantasmas à
    // direita, de modo que S, D e R caiam sempre nas mesmas posições.
    const int width = n < 12 ? 12 : n;
    const uint64_t raw = n < 12 ? (code << (12 - n)) : code;
    RawFields f;

    // S (bit mais alto), D (o seguinte) e os 3 bits de regime.  O regime
    // efetivo é R quando D = 1 e 7 - R quando D = 0 (a direção desce).
    f.s = static_cast<int>((raw >> (width - 1)) & 1);
    f.d = static_cast<int>((raw >> (width - 2)) & 1);
    const int ucode = static_cast<int>((raw >> (width - 5)) & 7);
    f.regime_bits = ucode;
    f.regime = f.d ? ucode : 7 - ucode;

    // C ocupa os r bits seguintes e F os p = width - 5 - r bits restantes.
    f.p = width - 5 - f.regime;
    f.cbits = (raw >> f.p) & ((uint64_t(1) << f.regime) - 1);

    // Característica c: c = 2^r - 1 + C (D = 1) ou c = -2^(r+1) + 1 + C
    // (D = 0).  O expoente do valor é (-1)^S * (c + S), usado por decode().
    f.c = f.d ? static_cast<int64_t>((uint64_t(1) << f.regime) - 1) + static_cast<int64_t>(f.cbits)
              : -(int64_t(1) << (f.regime + 1)) + 1 + static_cast<int64_t>(f.cbits);
    f.frac = raw & ((uint64_t(1) << f.p) - 1);
    return f;
}

}  // namespace

uint64_t width_mask(int n) {
    return n >= 64 ? ~uint64_t(0) : ((uint64_t(1) << n) - 1);
}

uint64_t nar_code(int n) { return uint64_t(1) << (n - 1); }

Exact decode(int n, uint64_t code) {
    code &= width_mask(n);
    Exact out;

    // Casos especiais: zero é o código todo em 0; NaR é S = 1 e o resto 0.
    if (code == 0) return out;
    if (code == nar_code(n)) {
        out.kind = Exact::Kind::Nar;
        return out;
    }

    // Extrai S, D, R, C e F (janela de 12 bits com zeros fantasmas para
    // n < 12) e reconstrói a magnitude exata N * 2^q, com a assimetria do
    // código embutida:
    //   S = 0: N = 2^p + F      e q = c - p;
    //   S = 1: N = 2^(p+1) - F  e q = -(c+1) - p.
    const RawFields f = parse_fields(n, code);
    uint64_t num;
    int64_t q;
    if (f.s == 0) {
        num = (uint64_t(1) << f.p) | f.frac;
        q = f.c - f.p;
    } else {
        num = (uint64_t(1) << (f.p + 1)) - f.frac;
        q = -(f.c + 1) - f.p;
    }

    // Normaliza N para o bit 63 de sig ficar em 1; o expoente e inclui o
    // deslocamento da normalização.  Resultado: valor = sig * 2^(e-63).
    const int len = 64 - __builtin_clzll(num);
    out.kind = Exact::Kind::Finite;
    out.neg = f.s != 0;
    out.sig = num << (64 - len);
    out.e = static_cast<int>(len - 1 + q);
    return out;
}

// Extrai os campos do código sem resolver zero/NaR nem o valor exato.
Fields decode_fields(int n, uint64_t code) {
    const RawFields f = parse_fields(n, code & width_mask(n));
    Fields out;
    out.s = f.s;
    out.d = f.d;
    out.regime_bits = f.regime_bits;
    out.regime = f.regime;
    out.cbits = f.cbits;
    out.c = f.c;
    out.frac = f.frac;
    out.p = f.p;
    return out;
}

uint64_t encode(int n, const Exact& value, bool sticky) {
    switch (value.kind) {
        // Zero e NaR têm códigos fixos, independentes de arredondamento.
        case Exact::Kind::Zero:
            return 0;
        case Exact::Kind::Nar:
            return nar_code(n);
        case Exact::Kind::Finite:
            break;
    }

    // Codifica a magnitude e, para negativos, aplica o complemento de dois
    // (a negação no formato é o complemento de dois do código).
    uint64_t code = encode_positive(n, value.e, value.sig, sticky);
    if (value.neg) code = (uint64_t(0) - code) & width_mask(n);
    return code;
}

namespace {

uint64_t add_exact(int n, Exact x, Exact y) {
    // Ordena para que x tenha o maior expoente (no empate, o maior
    // significando); o alinhamento desloca y, o menor, para a direita.
    if (y.e > x.e || (y.e == x.e && y.sig > x.sig)) {
        const Exact t = x;
        x = y;
        y = t;
    }
    // Coloca os significandos no topo de u128 e alinha y, acumulando sticky
    // nos bits descartados.
    const u128 big = static_cast<u128>(x.sig) << 63;
    const u128 y0 = static_cast<u128>(y.sig) << 63;
    const int64_t d = static_cast<int64_t>(x.e) - y.e;

    u128 small = 0;
    bool st = false;
    if (d >= 127) {
        st = true;
    } else {
        small = y0 >> d;
        st = d > 0 && (y0 & ((static_cast<u128>(1) << d) - 1)) != 0;
    }

    // Mesmo sinal: soma.  Sinais opostos: subtrai; com bits descartados, o
    // sticky vira o "borrow" subtraído de 1.
    u128 res;
    if (x.neg == y.neg) {
        res = big + small;
    } else if (st) {
        res = big - small - 1;
    } else {
        res = big - small;
    }
    if (res == 0) return 0;

    // Normaliza: se o bit líder passou de 63, desloca à direita e acumula
    // sticky; senão desloca à esquerda.  O expoente acompanha o
    // deslocamento (126 = 63 + 63 do alinhamento inicial).
    const int m = msb128(res);
    uint64_t sig;
    if (m >= 63) {
        const int shift = m - 63;
        sig = static_cast<uint64_t>(res >> shift);
        st = st || (res & ((static_cast<u128>(1) << shift) - 1)) != 0;
    } else {
        sig = static_cast<uint64_t>(res << (63 - m));
    }
    Exact out;
    out.kind = Exact::Kind::Finite;
    out.neg = x.neg;
    out.sig = sig;
    out.e = x.e + (m - 126);
    return encode(n, out, st);
}

}  // namespace

uint64_t add(int n, uint64_t a, uint64_t b) {
    // Especiais antes da aritmética: NaR vence qualquer operação; zero
    // devolve o outro operando (já mascarado).
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) return nar_code(n);
    if (x.kind == Exact::Kind::Zero) return b & width_mask(n);
    if (y.kind == Exact::Kind::Zero) return a & width_mask(n);
    return add_exact(n, x, y);
}

uint64_t sub(int n, uint64_t a, uint64_t b) {
    // Subtração = soma com b negado pelo complemento de dois do código.
    const uint64_t negb = (uint64_t(0) - b) & width_mask(n);
    return add(n, a, negb);
}

uint64_t mul(int n, uint64_t a, uint64_t b) {
    // NaR vence; zero absorve.  O produto exato é arredondado uma única vez,
    // na codificação, com o sticky do produto.
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) return nar_code(n);
    if (x.kind == Exact::Kind::Zero || y.kind == Exact::Kind::Zero) return 0;
    bool st = false;
    const Exact p = mul_exact(x, y, st);
    return encode(n, p, st);
}

uint64_t narrow(int from_n, int to_n, uint64_t a) {
    // A conversão é uma decodificação exata seguida de uma única codificação
    // na largura de destino; isso preserva RNE e a saturação do formato.
    const Exact x = decode(from_n, a);
    return encode(to_n, x, false);
}

uint64_t dot_step(int n, uint64_t acc2n, uint64_t a, uint64_t b) {
    // O acumulador usa o dobro da largura dos operandos, mas o produto é
    // arredondado nessa largura antes de ser somado ao acumulador.
    const int w = 2 * n;
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) {
        return nar_code(w);
    }
    uint64_t product = 0;
    if (x.kind != Exact::Kind::Zero && y.kind != Exact::Kind::Zero) {
        bool st = false;
        product = encode(w, mul_exact(x, y, st), st);
    }
    return add(w, acc2n, product);
}

}  // namespace zt
