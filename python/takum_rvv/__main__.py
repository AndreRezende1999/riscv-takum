"""Command line interface; no installed packages needed."""
import argparse
import json
import sys
from decimal import Decimal
from pathlib import Path
from .codec import Takum
from .benchmark import run_experiment


def main():
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser(description='Simulador funcional Takum linear/RVV em Python (sem Spike)')
    commands = parser.add_subparsers(dest='command', required=True)
    inspect = commands.add_parser('encode', help='Mostrar código, campos e valor arredondado')
    inspect.add_argument('value', help='Decimal ou fração, por exemplo 1.1 ou 3/2')
    inspect.add_argument('--bits', type=int, choices=[8, 16, 32, 64], default=8)
    for name in ('demo', 'bench'):
        sub = commands.add_parser(name, help='Executar SpMV e exportar CSV/manifesto')
        if name == 'bench': sub.add_argument('matrices', nargs='+', type=Path)
        sub.add_argument('--output', type=Path, default=Path('results') / ('python_' + name))
        sub.add_argument('--vlen', type=int, default=256)
        sub.add_argument('--seed', type=int, default=2026)
        sub.add_argument('--vector', choices=['random', 'ones'], default='random')
        sub.add_argument('--scaling', choices=['none', 'pow2-bound'], default='none')
    args = parser.parse_args()
    try:
        if args.command == 'encode':
            t = Takum(args.bits)
            raw = t.encode(args.value)
            print(json.dumps({'bits': args.bits, 'raw_hex': hex(raw), 'binary': f'{raw:0{args.bits}b}',
                              'value': str(t.decode(raw)), 'fields': t.fields(raw).__dict__},
                             default=str, indent=2))
        else:
            paths = args.matrices if args.command == 'bench' else sorted(
                (Path(__file__).resolve().parent.parent / 'examples').glob('*.mtx'))
            report = run_experiment(paths, args.output, args.seed, args.vlen, args.vector, args.scaling)
            print(f'{len(paths)} matrizes; {len(report["results"])} avaliações; saída: {args.output.resolve()}')
            print('Formato             matriz                      erro relativo L2       não finitos')
            for row in report['results']:
                error = row['relative_l2']
                display = 'indefinido' if error is None else f'{Decimal(error):.6g}'
                print(f'{row["format"]:19} {row["matrix"][:27]:27} {display:22} {row["nonfinite_count"]}')
            print('Contagens do modelo funcional não são ciclos nem desempenho de hardware.')
    except (ValueError, OSError) as exc:
        parser.error(str(exc))


if __name__ == '__main__':
    main()
