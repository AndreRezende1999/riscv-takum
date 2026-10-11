#include "zt/takum.hpp"

namespace zt {
namespace {

using u128 = unsigned __int128;

int msb128(u128 v) {
    uint64_t hi = static_cast<uint64_t>(v >> 64);
    if (hi != 0) return 127 - __builtin_clzll(hi);
    uint64_t lo = static_cast<uint64_t>(v);
    return 63 - __builtin_clzll(lo);
}

int floor_log2(uint64_t v) { return 63 - __builtin_clzll(v); }

uint64_t maxpos_code(int n) { return nar_code(n) - 1; }

// Codifica |v| > 0 com expoente c do bit líder e fração em sig (bit 63 = líder).
// Retorna o código positivo (bit de sinal zero) já arredondado.
uint64_t encode_positive(int n, int64_t c, uint64_t sig, bool sticky) {
    if (c > 254) return maxpos_code(n);
    if (c < -255) return 1;

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
    const int m = n + 1;
    const u128 l1 = stream >> (128 - m);
    const u128 rest = stream & ((static_cast<u128>(1) << (128 - m)) - 1);
    const bool st = sticky || rest != 0;

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

}  // namespace

uint64_t width_mask(int n) {
    return n >= 64 ? ~uint64_t(0) : ((uint64_t(1) << n) - 1);
}

uint64_t nar_code(int n) { return uint64_t(1) << (n - 1); }

Exact decode(int n, uint64_t code) {
    code &= width_mask(n);
    Exact out;
    if (code == 0) return out;
    if (code == nar_code(n)) {
        out.kind = Exact::Kind::Nar;
        return out;
    }

    // Janela de 12 bits: códigos curtos recebem zeros fantasmas à direita.
    const int width = n < 12 ? 12 : n;
    const uint64_t raw = n < 12 ? (code << (12 - n)) : code;
    const int s = static_cast<int>((raw >> (width - 1)) & 1);
    const int d = static_cast<int>((raw >> (width - 2)) & 1);
    const int ucode = static_cast<int>((raw >> (width - 5)) & 7);
    const int r = d ? ucode : 7 - ucode;
    const int p = width - 5 - r;
    const uint64_t cbits = (raw >> p) & ((uint64_t(1) << r) - 1);
    const int64_t c = d ? static_cast<int64_t>((uint64_t(1) << r) - 1) + static_cast<int64_t>(cbits)
                        : -(int64_t(1) << (r + 1)) + 1 + static_cast<int64_t>(cbits);
    const uint64_t frac = raw & ((uint64_t(1) << p) - 1);

    // Magnitude = N * 2^q exato.
    uint64_t num;
    int64_t q;
    if (s == 0) {
        num = (uint64_t(1) << p) | frac;
        q = c - p;
    } else {
        num = (uint64_t(1) << (p + 1)) - frac;
        q = -(c + 1) - p;
    }
    const int len = 64 - __builtin_clzll(num);
    out.kind = Exact::Kind::Finite;
    out.neg = s != 0;
    out.sig = num << (64 - len);
    out.e = static_cast<int>(len - 1 + q);
    return out;
}

uint64_t encode(int n, const Exact& value, bool sticky) {
    switch (value.kind) {
        case Exact::Kind::Zero:
            return 0;
        case Exact::Kind::Nar:
            return nar_code(n);
        case Exact::Kind::Finite:
            break;
    }
    uint64_t code = encode_positive(n, value.e, value.sig, sticky);
    if (value.neg) code = (uint64_t(0) - code) & width_mask(n);
    return code;
}

namespace {

uint64_t add_exact(int n, Exact x, Exact y) {
    if (y.e > x.e || (y.e == x.e && y.sig > x.sig)) {
        const Exact t = x;
        x = y;
        y = t;
    }
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

    u128 res;
    if (x.neg == y.neg) {
        res = big + small;
    } else if (st) {
        res = big - small - 1;
    } else {
        res = big - small;
    }
    if (res == 0) return 0;

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
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) return nar_code(n);
    if (x.kind == Exact::Kind::Zero) return b & width_mask(n);
    if (y.kind == Exact::Kind::Zero) return a & width_mask(n);
    return add_exact(n, x, y);
}

uint64_t sub(int n, uint64_t a, uint64_t b) {
    const uint64_t negb = (uint64_t(0) - b) & width_mask(n);
    return add(n, a, negb);
}

uint64_t mul(int n, uint64_t a, uint64_t b) {
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) return nar_code(n);
    if (x.kind == Exact::Kind::Zero || y.kind == Exact::Kind::Zero) return 0;
    bool st = false;
    const Exact p = mul_exact(x, y, st);
    return encode(n, p, st);
}

uint64_t narrow(int from_n, int to_n, uint64_t a) {
    const Exact x = decode(from_n, a);
    return encode(to_n, x, false);
}

uint64_t dot_step(int n, uint64_t acc2n, uint64_t a, uint64_t b) {
    const int w = 2 * n;
    const Exact x = decode(n, a);
    const Exact y = decode(n, b);
    if (x.kind == Exact::Kind::Nar || y.kind == Exact::Kind::Nar) return nar_code(w);
    uint64_t p = 0;
    if (x.kind != Exact::Kind::Zero && y.kind != Exact::Kind::Zero) {
        bool st = false;
        const Exact prod = mul_exact(x, y, st);
        p = encode(w, prod, st);
    }
    return add(w, acc2n, p);
}

}  // namespace zt
