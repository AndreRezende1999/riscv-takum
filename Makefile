# Projeto: simulador ISA Takum-RVV (C++17) em sim/, modelo de referência em python/,
# artigo em paper/ e slides em slides/. Ver README.md e docs/arquitetura.md.

PYTHON  ?= $(shell test -x .venv/bin/python && echo .venv/bin/python || echo python3)

all: sim

sim:
	$(MAKE) -C sim all

sim-test:
	$(MAKE) -C sim test

sim-check: sim
	$(PYTHON) sim/tests/gen_asm.py
	$(PYTHON) sim/tests/gen_zvt.py
	$(PYTHON) sim/tests/difftest.py

spmv: sim
	$(PYTHON) sim/kernels/spmv.py
	$(PYTHON) sim/kernels/numeric_baselines.py
	$(PYTHON) sim/kernels/modelo_contagem.py

paper-data:
	$(PYTHON) paper/gera_tabelas.py

paper:
	cd paper && latexmk -pdf -interaction=nonstopmode main.tex

slides:
	cd slides && latexmk -pdf -interaction=nonstopmode slides.tex

test: sim-test

clean:
	$(MAKE) -C sim clean

.PHONY: all sim sim-test sim-check spmv paper-data paper slides test clean
