# Paper

Regenerate the English tables, macros, and error-CDF figure from
`sim/results/`, then compile the IEEE PDF:

```sh
make paper-data
make paper
```

`gera_tabelas.py` preserves numeric values and emits English labels. The CDF
generator writes `figures/error-cdf-data.csv` and, when finite per-matrix data
exists and ImageMagick is available, `figures/error-cdf.pdf`. It never edits
the result CSVs.
