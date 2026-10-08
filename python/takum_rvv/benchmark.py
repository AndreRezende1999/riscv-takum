"""Reproducible SpMV experiments, separated from claims about hardware.

Input/output precision separation is motivated by Hunhold's AVX10.2 study
(arXiv:2503.14067v2) and sparse solvers study (arXiv:2412.20268v2).
The experiment design and functional counters here are project-specific.
Dataset attribution: https://sparse.tamu.edu/about (when SuiteSparse is used).
"""

import csv
import hashlib
import json
import platform
import random
import zipfile
from decimal import Decimal
from fractions import Fraction
from pathlib import Path

from .binary import E4M3, E5M2, BINARY16, BINARY32, BINARY64
from .codec import Takum
from .sparse import (read_matrix_market, reference_spmv, scalar_spmv,
                     exact_quantized_spmv, error_metrics)
from .vector import VectorMachine, encode_instruction
from .scaling import prepare_scaled_inputs, rescale_values


FORMATS = [(Takum(8), Takum(16)), (Takum(16), Takum(32)),
           (Takum(32), Takum(64)), (E4M3, BINARY16), (E5M2, BINARY16),
           (BINARY16, BINARY32), (BINARY32, BINARY64)]


def spmv_vector(matrix, x, bits, vlen=256):
    """Execute every Takum dot/narrow through decoded custom instruction words.

    Raw arrays are the abstract memory. CSR traversal, address generation and
    setting the scalar seed happen in the host, and are NOT RISC-V counts.
    Each strip continues the previous accumulator, preserving CSR order.
    """
    if len(x) != matrix.cols:
        raise ValueError('Vector length differs from matrix column count')
    storage = Takum(bits)
    raw_a = [storage.encode(value) for value in matrix.data]
    raw_x = [storage.encode(value) for value in x]
    machine = VectorMachine(vlen)
    output = []
    for row in range(matrix.rows):
        machine.write(4, 0, 0, bits=2 * bits)
        machine.counts['host_seed_writes'] += 1
        position, end = matrix.rowptr[row:row+2]
        while position < end:
            length = machine.set_vl(end - position, bits)
            machine.load(1, raw_a[position:position+length])
            machine.load(2, raw_x, indices=matrix.colidx[position:position+length])
            machine.execute_word(encode_instruction('vtdot.vv', 4, 1, 2))
            position += length
        machine.set_vl(1, bits)
        machine.execute_word(encode_instruction('vncvt.t.t', 6, 0, 4))
        output.append(machine.store(6)[0])
    return output, dict(machine.counts)


def empirical_cdf(values):
    """Finite thresholds, count <= threshold, total including failed results."""
    finite = sorted(Decimal(v) for v in values if v is not None)
    points = []
    for i, value in enumerate(finite, 1):
        if i == len(finite) or finite[i] != value:
            points.append((str(value), i, len(values)))
    return points


def _digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _exact_original(matrix, x):
    return [sum((matrix.data[k] * x[matrix.colidx[k]]
                 for k in range(matrix.rowptr[r], matrix.rowptr[r+1])), Fraction(0))
            for r in range(matrix.rows)]


def run_experiment(paths, output, seed=2026, vlen=256, vector='random', scaling='none'):
    if vector not in ('random', 'ones'):
        raise ValueError('Vector policy must be random or ones')
    if scaling not in ('none', 'pow2-bound'):
        raise ValueError('Scaling must be none or pow2-bound')
    VectorMachine(vlen)  # Validate before creating any output.
    paths = [Path(p) for p in paths]
    if not paths:
        raise ValueError('Provide at least one Matrix Market file')
    output = Path(output)
    results, inputs, vectors = [], [], []
    for path in paths:
        matrix = read_matrix_market(path)
        rng = random.Random(seed)
        x = [Fraction(1) if vector == 'ones' else Fraction(rng.randint(-1000, 1000), 1000)
             for _ in range(matrix.cols)]
        reference = reference_spmv(matrix, x)
        original_exact = _exact_original(matrix, x)
        compute_matrix, compute_x, matrix_scale, vector_scale = prepare_scaled_inputs(matrix, x, scaling)
        output_scale = matrix_scale * vector_scale
        ref_check = error_metrics(reference, original_exact)
        matrix_id = f'{path.stem}:{_digest(path)[:12]}'
        inputs.append({'matrix_id': matrix_id, 'path': str(path.resolve()),
                       'sha256': _digest(path), 'rows': matrix.rows, 'cols': matrix.cols,
                       'metadata': matrix.metadata, 'reference_vs_exact': ref_check,
                       'matrix_scale': str(matrix_scale), 'vector_scale': str(vector_scale)})
        sidecar = path.with_suffix('.source.json')
        if sidecar.exists():
            provenance = json.loads(sidecar.read_text(encoding='utf-8'))
            if provenance.get('sha256') != _digest(path):
                raise ValueError(f'Provenance hash mismatch: {path}')
            inputs[-1]['provenance'] = provenance
        # Exact generated vectors remove dependence on future PRNG changes.
        vectors.append({'matrix_id': matrix_id, 'x': [str(value) for value in x]})
        for storage, accumulator in FORMATS:
            if isinstance(storage, Takum):
                raw, counts = spmv_vector(compute_matrix, compute_x, storage.bits, vlen)
                execution = 'vector_model'
                scalar = scalar_spmv(compute_matrix, compute_x, storage, accumulator)
                if raw != scalar:
                    raise AssertionError(f'Vector/scalar mismatch for {matrix_id}/{storage.name}')
            else:
                raw = scalar_spmv(compute_matrix, compute_x, storage, accumulator)
                counts, execution = {}, 'scalar_numeric_reference'
            actual = rescale_values([storage.decode(value) for value in raw], output_scale)
            quantized_exact = rescale_values(exact_quantized_spmv(compute_matrix, compute_x, storage), output_scale)
            same = rescale_values([storage.decode(value) for value in scalar_spmv(compute_matrix, compute_x, storage, storage)], output_scale)
            reconstructed_a = rescale_values([storage.decode(storage.encode(a)) for a in compute_matrix.data], matrix_scale)
            matrix_error = error_metrics(reconstructed_a, matrix.data)
            # Pure input quantization: do not mix in binary128's own rounding.
            input_error = error_metrics(quantized_exact, original_exact)
            arithmetic_error = error_metrics(actual, quantized_exact)
            same_error = error_metrics(same, reference)
            result = {'matrix': matrix_id, 'format': storage.name,
                      'scaling': scaling, 'matrix_scale': str(matrix_scale),
                      'vector_scale': str(vector_scale), 'output_scale': str(output_scale),
                      'accumulator': accumulator.name, 'execution': execution,
                      **error_metrics(actual, reference),
                      'matrix_representation_relative_l2': matrix_error['relative_l2'],
                      'matrix_representation_nonfinite': matrix_error['nonfinite_count'],
                      'input_effect_relative_l2': input_error['relative_l2'],
                      'arithmetic_relative_l2': arithmetic_error['relative_l2'],
                      'same_width_relative_l2': same_error['relative_l2'],
                      'same_width_nonfinite': same_error['nonfinite_count'],
                      'counts': json.dumps(counts, sort_keys=True),
                      'output_raw_hex': json.dumps([f'{v:0{storage.bits//4}x}' for v in raw])}
            results.append(result)
    module_dir = Path(__file__).resolve().parent
    manifest = {'schema': 2, 'python': platform.python_version(),
                'reference': 'binary128; separate multiply/add; ties-even',
                'input_semantics': 'exact decimal Matrix Market values; sorted CSR; duplicates summed exactly',
                'takum_variant': 'linear', 'rounding': 'nearest code, ties-even; finite nonzero saturation',
                'fp8_policy': 'OCP layout; nonsaturating conversion/arithmetic; nonfinite is failure',
                'accumulation': '2x storage width; separately rounded products and sums; output in storage format',
                'control': 'same-width accumulator; exact rational dot on quantized inputs',
                'input_effect_metric': 'exact dot of quantized inputs versus exact dot of original inputs',
                'scaling': scaling,
                'scale_cost': 'two global exponents plus host pre/post-processing; excluded from vector counters' if scaling != 'none' else 'none',
                'raw_output_semantics': 'physical value = decode(raw) * matrix_scale * vector_scale',
                'seed': seed, 'vector_policy': vector, 'vlen': vlen, 'lmul': 1,
                'counter_scope': 'Takum vector subset only; host CSR loops/addressing/seed excluded from instruction count; no cycles',
                'sample_claim': 'engineering checks only; no claim of representative SuiteSparse coverage',
                'inputs': inputs,
                'code_sha256': {p.name: _digest(p) for p in sorted(module_dir.glob('*.py'))}}
    output.mkdir(parents=True, exist_ok=True)
    snapshot = output / 'source.zip'
    with zipfile.ZipFile(snapshot, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
        for source in sorted(module_dir.glob('*.py')):
            entry = zipfile.ZipInfo('takum_rvv/' + source.name)
            entry.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(entry, source.read_bytes())
    manifest['source_snapshot'] = {'path': snapshot.name, 'sha256': _digest(snapshot)}
    with (output / 'results.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(results[0]))
        writer.writeheader(); writer.writerows(results)
    for filename, data in (('manifest.json', manifest), ('vectors.json', vectors)):
        (output / filename).write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    with (output / 'cdf.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.writer(stream)
        writer.writerow(['format', 'relative_l2_threshold', 'count_le', 'total_including_invalid'])
        for storage, _ in FORMATS:
            values = [r['relative_l2'] for r in results if r['format'] == storage.name]
            for threshold, count, total in empirical_cdf(values):
                writer.writerow([storage.name, threshold, count, total])
    summary = {}
    for storage, _ in FORMATS:
        rows = [r for r in results if r['format'] == storage.name]
        summary[storage.name] = {
            'total': len(rows), 'defined': sum(r['relative_l2'] is not None for r in rows),
            'undefined': sum(r['relative_l2'] is None for r in rows),
            'nonfinite_results': sum(r['nonfinite_count'] > 0 for r in rows),
            'nonfinite_references': sum(r['reference_nonfinite_count'] > 0 for r in rows),
            'zero_references': sum(r['zero_reference'] for r in rows)}
    (output / 'cdf_summary.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
    return {'manifest': manifest, 'results': results}
