"""Generate the paper's versioned error-CDF figure from existing CSV values.

The script never changes result CSVs.  It writes an intermediate SVG and, when
ImageMagick is available, converts it to ``figures/error-cdf.pdf``.  With
insufficient per-matrix finite values it writes a diagnostic CSV and exits
without fabricating a curve.
"""

from __future__ import annotations

import csv
import math
import pathlib
import shutil
import subprocess

ROOT = pathlib.Path(__file__).resolve().parents[1]
RESULTS = ROOT / "results"
if not RESULTS.exists():
    RESULTS = ROOT / "sim" / "results"
OUT = ROOT / "paper" / "figures"


def rows(path: pathlib.Path) -> list[dict[str, str]]:
    with path.open(newline="") as handle:
        return list(csv.DictReader(handle))


def finite(value: str) -> float | None:
    try:
        result = float(value)
    except (TypeError, ValueError):
        return None
    return result if math.isfinite(result) and result > 0 else None


def collect() -> dict[str, list[float]]:
    """Collect finite relative errors grouped by paper format."""
    grouped: dict[str, list[float]] = {
        "FP32": [], "Takum32": [], "E4M3": [], "E5M2": [],
        "FP16": [], "Takum16": [], "Takum8": [],
    }
    for row in rows(RESULTS / "spmv_hb.csv"):
        name = {"fp32": "FP32", "takum32": "Takum32",
                "takum16": "Takum16", "takum8": "Takum8"}.get(row["format"])
        if name:
            value = finite(row["relative_l2"])
            if value is not None:
                grouped[name].append(value)
    for row in rows(RESULTS / "spmv_numerico_hb.csv"):
        name = {"e4m3": "E4M3", "e5m2": "E5M2",
                "binary16": "FP16"}.get(row["format"])
        if name:
            value = finite(row["relative_l2"])
            if value is not None:
                grouped[name].append(value)
    return grouped


def write_svg(grouped: dict[str, list[float]], path: pathlib.Path) -> None:
    """Write a monochrome log-x CDF as a self-contained SVG."""
    width, height = 760, 430
    left, right, top, bottom = 78, 24, 28, 62
    values = [v for series in grouped.values() for v in series]
    lo, hi = min(values), max(values)
    lo_exp, hi_exp = math.floor(math.log10(lo)), math.ceil(math.log10(hi))
    colors = ["#000", "#000", "#555", "#555", "#000", "#000", "#888"]
    dashes = ["", "8,4", "2,3", "10,3,2,3", "4,4", "12,3", "1,3"]

    def x(value: float) -> float:
        return left + (math.log10(value) - lo_exp) / (hi_exp - lo_exp) * (width - left - right)

    def y(rank: int, total: int) -> float:
        return top + (height - top - bottom) * (1 - rank / max(1, total - 1))

    parts = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
             f'viewBox="0 0 {width} {height}"><rect width="100%" height="100%" fill="white"/>']
    parts.append(f'<line x1="{left}" y1="{top}" x2="{left}" y2="{height-bottom}" stroke="black"/>')
    parts.append(f'<line x1="{left}" y1="{height-bottom}" x2="{width-right}" y2="{height-bottom}" stroke="black"/>')
    for exponent in range(lo_exp, hi_exp + 1):
        xpos = x(10 ** exponent)
        parts.append(f'<line x1="{xpos:.1f}" y1="{height-bottom}" x2="{xpos:.1f}" y2="{height-bottom+5}" stroke="black"/>')
        parts.append(f'<text x="{xpos:.1f}" y="{height-bottom+22}" text-anchor="middle" font-size="12">10^{exponent}</text>')
    for index, (name, series) in enumerate(grouped.items()):
        if not series:
            continue
        ordered = sorted(series)
        points = " ".join(f"{x(value):.1f},{y(rank, len(ordered)):.1f}"
                          for rank, value in enumerate(ordered))
        dash = f' stroke-dasharray="{dashes[index]}"' if dashes[index] else ""
        parts.append(f'<polyline points="{points}" fill="none" stroke="{colors[index]}" '
                     f'stroke-width="2"{dash}/>')
        ly = top + 18 * index
        parts.append(f'<line x1="{width-190}" y1="{ly}" x2="{width-165}" y2="{ly}" '
                     f'stroke="{colors[index]}" stroke-width="2"{dash}/>')
        parts.append(f'<text x="{width-158}" y="{ly+4}" font-size="12">{name}</text>')
    parts.append(f'<text x="{(left+width-right)/2:.1f}" y="{height-12}" text-anchor="middle" font-size="13">'
                 'Relative L2 error (log scale)</text>')
    parts.append(f'<text transform="translate(16 {(top+height-bottom)/2:.1f}) rotate(-90)" '
                 'text-anchor="middle" font-size="13">Cumulative fraction</text></svg>')
    path.write_text("".join(parts))


def main() -> None:
    """Generate the CDF artifacts, or report why a curve cannot be generated."""
    grouped = collect()
    OUT.mkdir(parents=True, exist_ok=True)
    available = {name: len(values) for name, values in grouped.items()}
    (OUT / "error-cdf-data.csv").write_text(
        "format,count\n" + "\n".join(f"{name},{count}" for name, count in available.items()) + "\n")
    if not grouped["FP32"] or not grouped["Takum32"]:
        print("gera_figuras: insufficient finite per-matrix data for CDF; kept diagnostic CSV")
        return
    svg = OUT / "error-cdf.svg"
    write_svg(grouped, svg)
    convert = shutil.which("convert")
    if convert:
        subprocess.run([convert, "-density", "150", str(svg), str(OUT / "error-cdf.pdf")],
                       check=True)
    else:
        print("gera_figuras: ImageMagick not found; kept SVG and diagnostic CSV")


if __name__ == "__main__":
    main()
