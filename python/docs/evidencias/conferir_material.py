"""Reconfere o material recebido sem alterar os arquivos do grupo.

Executar da raiz AOC: python docs/evidencias/conferir_material.py
Usa apenas a biblioteca padrao. Nao executa benchmarks nem valida a ALU.
Fonte dos dados: ZIP e CSVs fornecidos pelo grupo; ver README.md desta pasta.
"""
from pathlib import Path
import csv
import hashlib
import json
import math
import statistics
import zipfile

ROOT = Path(__file__).resolve().parents[2]
PROJECT = ROOT / 'riscv-takum-main'
OUT = Path(__file__).resolve().parent
ZIP = Path(r'C:\Users\Isadora\Downloads\riscv-takum-main.zip')


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def original_percentile(values, probability):
    """Convencao de scripts/analyze.py no ZIP, explicitada para reproducao."""
    return values[min(len(values) - 1, max(0, round(probability * (len(values) - 1))))]


def main():
    with zipfile.ZipFile(ZIP) as archive:
        files = [item for item in archive.infolist() if not item.is_dir()]
        mismatches = [item.filename for item in files
                      if not (ROOT / item.filename).is_file()
                      or sha256(archive.read(item)) != sha256((ROOT / item.filename).read_bytes())]
    with (PROJECT / 'bench/results/relative_error.csv').open(newline='') as stream:
        rows = list(csv.DictReader(stream))
    summaries = []
    for fmt in list(rows[0])[2:]:
        values = [float(row[fmt]) for row in rows]
        finite = sorted(value for value in values if math.isfinite(value))
        summaries.append(dict(format=fmt, total=len(values), finite=len(finite),
                              nonfinite=len(values)-len(finite),
                              median_original_index=original_percentile(finite, 0.5),
                              median_two_central=statistics.median(finite),
                              p90_original_index=original_percentile(finite, 0.9),
                              maximum_finite=max(finite),
                              finite_error_above_one=sum(value > 1 for value in finite)))
    with (PROJECT / 'bench/results/spmv.csv').open(newline='') as stream:
        spmv = list(csv.DictReader(stream))
    report = dict(
        audit_date='2026-10-05',
        provenance='Provided archive; statistics recomputed from supplied CSVs, not new benchmark runs',
        zip_sha256=sha256(ZIP.read_bytes()), zip_regular_files=len(files),
        modified_or_missing_original_files=mismatches,
        conversion_matrix_rows=len(rows),
        conversion_unique_matrix_names=len({row['matrix'] for row in rows}),
        conversion_summaries=summaries, spmv_rows=spmv,
        third_party_contains_source={name: any((PROJECT / 'third_party' / name).rglob('*.c'))
                                    for name in ['libtakum', 'libposit']},
        matrix_market_files=len(list((PROJECT / 'bench/matrices').rglob('*.mtx'))),
    )
    (OUT / 'conferencia_material.json').write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding='utf-8')
    with (OUT / 'resumo_csv_recebido.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(summaries[0]))
        writer.writeheader()
        writer.writerows(summaries)
    print(json.dumps({key: value for key, value in report.items()
                      if key not in {'conversion_summaries', 'spmv_rows'}}, indent=2))
    if mismatches:
        raise SystemExit('Original archive contents no longer match the extracted files.')


if __name__ == '__main__':
    main()
