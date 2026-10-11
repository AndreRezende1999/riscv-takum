"""Gera as tabelas e os números citados no artigo a partir de sim/results/.

Saídas (incluídas por paper/main.tex):
  paper/tabelas-precisao32.tex   erro por matriz em 32 bits, com controles de acumulação;
  paper/tabelas-precisao816.tex  erro por matriz em 8 e 16 bits;
  paper/tabelas-contagens.tex    instruções e escritas de CSR por não nulo;
  paper/tabela-modelo.tex        parâmetros do modelo de contagem N = rR + cS + K;
  paper/numeros.tex              macros \\Num..., \\Par..., \\Rel... citadas no texto.

Comparações entre formatos são pareadas (mesma matriz); nenhuma mediana de conjuntos
diferentes é comparada diretamente.

    python3 paper/gera_tabelas.py
"""

from __future__ import annotations

import csv
import pathlib
import statistics as st
from collections import defaultdict

ROOT = pathlib.Path(__file__).resolve().parents[1]
RES = ROOT / "sim" / "results"
PAPER = ROOT / "paper"
SPMV = RES / "spmv_hb.csv"
NUMERIC = RES / "spmv_numerico_hb.csv"
MODEL = RES / "modelo_contagem.csv"
VLEN_REF = "256"
VLENS = ("128", "256", "512")
WORD = {"fp32": "FP", "takum32": "Trinta", "takum16": "Dez", "takum8": "Oito"}
VLEN_WORD = {"128": "Cento", "256": "Duzentos", "512": "Quinhentos"}


def load(path: pathlib.Path) -> list[dict]:
    with path.open() as handle:
        return list(csv.DictReader(handle))


def comma(text: str) -> str:
    return text.replace(".", "{,}")


def sci(value: float) -> str:
    mantissa, exponent = f"{value:.2e}".split("e")
    return f"${comma(mantissa)} \\times 10^{{{int(exponent)}}}$"


def ratio(value: float) -> str:
    return comma(f"{value:.2f}")


def signed_percent(value: float) -> str:
    sign = "+" if value >= 0 else "$-$"
    return f"{sign}{comma(f'{abs(value):.1f}')}\\%"


def name(matrix: str) -> str:
    return matrix.replace("_", "\\_")


def num(row: dict) -> float | None:
    value = row["relative_l2"]
    return None if value in ("", "None") else float(value)


def cell(row: dict) -> str:
    value = num(row)
    if value is None:
        return f"NF({row['nonfinite']})"
    return sci(value)


def table_star(caption: str, label: str, columns: str, header: list[str], body: list[str],
               footer: list[str]) -> str:
    lines = [
        "\\begin{table*}[t]",
        f"\\caption{{{caption}}}",
        f"\\label{{{label}}}",
        "\\centering",
        "\\footnotesize",
        f"\\begin{{tabular}}{{{columns}}}",
        "\\toprule",
        " & ".join(header) + " \\\\",
        "\\midrule",
        *body,
        *footer,
        "\\bottomrule",
        "\\end{tabular}",
        "\\end{table*}",
    ]
    return "\n".join(lines) + "\n"


def tabela_precisao32(spmv: dict, numeric: dict, matrices: list[str]) -> str:
    body, cols = [], defaultdict(list)
    for m in matrices:
        base = spmv[(m, "fp32", VLEN_REF)]
        t32 = spmv[(m, "takum32", VLEN_REF)]
        b64 = numeric[(m, "binary32_acc64")]
        t32a32 = numeric[(m, "takum32_acc32")]
        for key, row in (("fp32", base), ("takum32", t32), ("b64", b64), ("t32a32", t32a32)):
            cols[key].append(num(row))
        body.append(f"{name(m)} & {base['nnz']} & {cell(base)} & {cell(t32)} & "
                    f"{cell(b64)} & {cell(t32a32)} \\\\")
    footer = ["\\midrule",
              "Mediana & & " + " & ".join(sci(st.median(cols[k])) for k in
                                          ("fp32", "takum32", "b64", "t32a32")) + " \\\\"]
    return table_star(
        "Erro relativo L2 do SpMV em 32 bits (VLEN = 256), por matriz. A coluna FP32 é o kernel "
        "vetorial (acumulador de 32 bits); as colunas de controle usam o modelo numérico com o "
        "acumulador indicado.",
        "tab:precisao32", "@{}lrcccc@{}",
        ["Matriz", "nnz", "FP32", "Takum32", "FP32 (acum.\\ 64)", "Takum32 (acum.\\ 32)"],
        body, footer)


def tabela_precisao816(spmv: dict, numeric: dict, matrices: list[str]) -> str:
    body = []
    for m in matrices:
        body.append(
            f"{name(m)} & {cell(numeric[(m, 'e4m3')])} & {cell(numeric[(m, 'e5m2')])} & "
            f"{cell(numeric[(m, 'binary16')])} & {cell(spmv[(m, 'takum16', VLEN_REF)])} & "
            f"{cell(spmv[(m, 'takum8', VLEN_REF)])} \\\\")
    return table_star(
        "Erro relativo L2 em 8 e 16 bits, por matriz (VLEN = 256). NF($k$) indica $k$ linhas não "
        "finitas (overflow). Acumuladores: E4M3, E5M2 e Takum8 em 16 bits; FP16 e Takum16 em 32 bits.",
        "tab:precisao816", "@{}lccccc@{}",
        ["Matriz", "E4M3", "E5M2", "FP16", "Takum16", "Takum8"],
        body, [])


def tabela_contagens(spmv_rows: list[dict]) -> str:
    grouped = defaultdict(list)
    for r in spmv_rows:
        grouped[(r["format"], r["vlen"])].append(r)

    def per_nnz(rows: list[dict], key: str) -> float:
        return sum(int(r[key]) for r in rows) / sum(int(r["nnz"]) for r in rows)

    keys = ("insn_total", "insn_zvtakum", "csr_writes", "elem_active")
    body = []
    for fmt, label in (("fp32", "FP32"), ("takum32", "Takum32"), ("takum16", "Takum16"),
                       ("takum8", "Takum8")):
        for vlen in VLENS:
            rows = grouped[(fmt, vlen)]
            values = " & ".join(comma(f"{per_nnz(rows, key):.3f}") for key in keys)
            body.append(f"{label} & {vlen} & {values} \\\\")
        body.append("\\midrule")
    body = body[:-1]
    return table_star(
        "Instruções, instruções Zvtakum, escritas de CSR e elementos ativos por elemento não nulo, "
        "somados sobre as oito matrizes. Elementos ativos contam cada elemento processado por "
        "instruções vetoriais de dados (carga, gather, produto, redução e armazenamento).",
        "tab:contagens", "@{}llcccc@{}",
        ["Formato", "VLEN", "Instr./nnz", "Zvtakum/nnz", "Escritas CSR/nnz", "Elem. ativos/nnz"],
        body, [])


def tabela_modelo(model_rows: list[dict]) -> str:
    body = []
    for row in model_rows:
        label = {"fp32": "FP32", "takum32": "Takum32", "takum16": "Takum16", "takum8": "Takum8"}[row["formato"]]
        body.append(
            f"{label} & {row['r']} & {row['c']} & {row['k']} & "
            f"{row['sinteticos_ok']}/{row['sinteticos_total']} & "
            f"{row['exatas']}/{row['execucoes']} \\\\")
    lines = [
        "\\begin{table}[t]",
        "\\caption{Parâmetros do modelo de contagem $N = rR + cS + K$, em que $R$ é o número de "
        "linhas e $S$ o número de faixas das linhas não vazias. A última coluna compara o modelo "
        "com as execuções reais.}",
        "\\label{tab:modelo}",
        "\\centering",
        "\\footnotesize",
        "\\begin{tabular}{@{}lcccrr@{}}",
        "\\toprule",
        "Formato & $r$ & $c$ & $K$ & Sintéticos & Reais exatas \\\\",
        "\\midrule",
        *body,
        "\\bottomrule",
        "\\end{tabular}",
        "\\end{table}",
    ]
    return "\n".join(lines) + "\n"


def pair_stats(takum: list[tuple], other: list[tuple]) -> dict:
    stats = {"Ambos": 0, "TakumVence": 0, "OutroVence": 0, "Empates": 0,
             "TakumNF": 0, "OutroNF": 0}
    for (tv, _), (ov, _) in zip(takum, other):
        stats["TakumNF"] += int(tv is None)
        stats["OutroNF"] += int(ov is None)
        if tv is None or ov is None:
            continue
        stats["Ambos"] += 1
        if tv < ov:
            stats["TakumVence"] += 1
        elif ov < tv:
            stats["OutroVence"] += 1
        else:
            stats["Empates"] += 1
    return stats


def instruction_pairs(spmv_rows: list[dict]) -> dict:
    idx = {(r["matrix"], r["format"], r["vlen"]): r for r in spmv_rows}
    out = {}
    for fmt in ("takum32", "takum16", "takum8"):
        less = equal = more = 0
        for (m, f, v), row in idx.items():
            if f != fmt:
                continue
            delta = int(row["insn_total"]) - int(idx[(m, "fp32", v)]["insn_total"])
            less += int(delta < 0)
            equal += int(delta == 0)
            more += int(delta > 0)
        out[fmt] = (less, equal, more)
    return out


def macros(spmv_rows: list[dict], numeric_rows: list[dict], model_rows: list[dict]) -> str:
    spmv = {(r["matrix"], r["format"], r["vlen"]): r for r in spmv_rows}
    numeric = {(r["matrix"], r["format"]): r for r in numeric_rows}
    matrices = sorted({r["matrix"] for r in spmv_rows})
    out = ["% Gerado por paper/gera_tabelas.py. Não editar à mão."]

    def add(key: str, value: str) -> None:
        out.append(f"\\newcommand{{\\{key}}}{{{value}\\xspace}}")

    def med_spmv(fmt: str, vlen: str = VLEN_REF) -> float:
        return st.median([num(spmv[(m, fmt, vlen)]) for m in matrices
                          if num(spmv[(m, fmt, vlen)]) is not None])

    def med_num(fmt: str) -> float:
        return st.median([num(numeric[(m, fmt)]) for m in matrices
                          if num(numeric[(m, fmt)]) is not None])

    def per_nnz(fmt: str, vlen: str, key: str) -> float:
        rows = [r for r in spmv_rows if r["format"] == fmt and r["vlen"] == vlen]
        return sum(int(r[key]) for r in rows) / sum(int(r["nnz"]) for r in rows)

    add("NumMatrizes", str(len(matrices)))
    add("NumExecSpmv", str(len(spmv_rows)))
    add("NumBitExatas", str(sum(r["bit_exact"] == "True" for r in spmv_rows)))
    add("MinLinhas", str(min(int(r["rows"]) for r in spmv_rows)))
    add("MaxLinhas", str(max(int(r["rows"]) for r in spmv_rows)))
    add("MaxNnz", str(max(int(r["nnz"]) for r in spmv_rows)))

    add("MedFPtrinta", sci(med_spmv("fp32")))
    add("MedTakumTrinta", sci(med_spmv("takum32")))
    add("MedFPtrintaAcSes", sci(med_num("binary32_acc64")))
    add("MedTakumTrintaAcTrinta", sci(med_num("takum32_acc32")))
    add("RazaoFormatoAcTrinta", ratio(med_num("binary32") / med_num("takum32_acc32")))
    add("RazaoAcumuladorTakum", ratio(med_num("takum32_acc32") / med_spmv("takum32")))
    add("RazaoKernelTrinta", ratio(med_spmv("fp32") / med_spmv("takum32")))
    add("RazaoAcAmpliadoTrinta", ratio(med_num("binary32_acc64") / med_spmv("takum32")))

    takum8 = [(num(spmv[(m, "takum8", VLEN_REF)]), 0) for m in matrices]
    takum16 = [(num(spmv[(m, "takum16", VLEN_REF)]), 0) for m in matrices]
    takum32 = [(num(spmv[(m, "takum32", VLEN_REF)]), 0) for m in matrices]
    takum32_acc32 = [(num(numeric[(m, "takum32_acc32")]), 0) for m in matrices]

    def other(fmt_key: str) -> list[tuple]:
        return [(num(numeric[(m, fmt_key)]), 0) for m in matrices]

    pares = {
        "TrintaFP": (takum32, [(num(spmv[(m, "fp32", VLEN_REF)]), 0) for m in matrices]),
        "TrintaAcFP": (takum32_acc32, other("binary32")),
        "DezFP": (takum16, other("binary16")),
        "OitoEquatrom": (takum8, other("e4m3")),
        "OitoCincodois": (takum8, other("e5m2")),
    }
    for tag, (takum, reference) in pares.items():
        stats = pair_stats(takum, reference)
        for key, value in stats.items():
            add(f"Par{tag}{key}", str(value))
    add("NFTakumOito", str(sum(1 for m in matrices if num(spmv[(m, "takum8", VLEN_REF)]) is None)))
    add("NFTakumDez", str(sum(1 for m in matrices if num(spmv[(m, "takum16", VLEN_REF)]) is None)))
    add("NFEquatrom", str(sum(1 for m in matrices if int(numeric[(m, "e4m3")]["nonfinite"]) > 0)))
    add("NFCincodois", str(sum(1 for m in matrices if int(numeric[(m, "e5m2")]["nonfinite"]) > 0)))
    add("NFDez", str(sum(1 for m in matrices if int(numeric[(m, "binary16")]["nonfinite"]) > 0)))

    add("ElemNnzFP", comma(f"{per_nnz('fp32', VLEN_REF, 'elem_active'):.2f}"))
    add("ElemNnzTakum", comma(f"{per_nnz('takum32', VLEN_REF, 'elem_active'):.2f}"))

    for fmt, word in WORD.items():
        for vlen, vword in VLEN_WORD.items():
            add(f"InsnNnz{word}{vword}", comma(f"{per_nnz(fmt, vlen, 'insn_total'):.2f}"))
            add(f"CsrNnz{word}{vword}", comma(f"{per_nnz(fmt, vlen, 'csr_writes'):.2f}"))
            if fmt != "fp32":
                rel_insn = 100 * (per_nnz(fmt, vlen, "insn_total") / per_nnz("fp32", vlen, "insn_total") - 1)
                rel_csr = 100 * (per_nnz(fmt, vlen, "csr_writes") / per_nnz("fp32", vlen, "csr_writes") - 1)
                add(f"RelInsn{word}{vword}", signed_percent(rel_insn))
                add(f"RelCsr{word}{vword}", signed_percent(rel_csr))
                if fmt == "takum32":
                    add(f"Economia{vword}", comma(f"{-rel_insn:.1f}") + "\\%")
                add(f"ZvtNnz{word}{vword}", comma(f"{per_nnz(fmt, vlen, 'insn_zvtakum'):.2f}"))

    for fmt, (less, equal, more) in instruction_pairs(spmv_rows).items():
        add(f"InsnMenor{WORD[fmt]}", str(less))
        add(f"InsnIgual{WORD[fmt]}", str(equal))
        add(f"InsnMaior{WORD[fmt]}", str(more))
    add("InsnPares", str(len(matrices) * len(VLENS)))

    for row in model_rows:
        word = WORD[row["formato"]]
        add(f"ModR{word}", row["r"])
        add(f"ModC{word}", row["c"])
        add(f"ModK{word}", row["k"])
    add("ModExatas", str(sum(int(r["exatas"]) for r in model_rows)))
    add("ModExec", str(sum(int(r["execucoes"]) for r in model_rows)))
    add("ModSinteticosOk", str(sum(int(r["sinteticos_ok"]) for r in model_rows)))
    add("ModSinteticosTotal", str(sum(int(r["sinteticos_total"]) for r in model_rows)))
    add("ModResiduoMax", str(max(int(r["residuo_max"]) for r in model_rows)))
    return "\n".join(out) + "\n"


def main() -> None:
    spmv_rows = load(SPMV)
    numeric_rows = load(NUMERIC)
    model_rows = load(MODEL)
    spmv = {(r["matrix"], r["format"], r["vlen"]): r for r in spmv_rows}
    numeric = {(r["matrix"], r["format"]): r for r in numeric_rows}
    matrices = sorted({r["matrix"] for r in spmv_rows})
    (PAPER / "tabelas-precisao32.tex").write_text(tabela_precisao32(spmv, numeric, matrices))
    (PAPER / "tabelas-precisao816.tex").write_text(tabela_precisao816(spmv, numeric, matrices))
    (PAPER / "tabelas-contagens.tex").write_text(tabela_contagens(spmv_rows))
    (PAPER / "tabela-modelo.tex").write_text(tabela_modelo(model_rows))
    (PAPER / "numeros.tex").write_text(macros(spmv_rows, numeric_rows, model_rows))
    print("gerado: paper/tabelas-*.tex, paper/tabela-modelo.tex e paper/numeros.tex")


if __name__ == "__main__":
    main()
