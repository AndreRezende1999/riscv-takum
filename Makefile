CC       ?= cc
AR       ?= ar
CFLAGS   ?= -std=c11 -O2 -Wall -Wextra -Wpedantic
CPPFLAGS += -Iinclude -Ithird_party/libtakum
LDLIBS   += -lm

BUILD    := build
LIBTAKUM := third_party/libtakum/libtakum.a
LIBPOSIT := third_party/libposit/libposit.a
LIB      := $(BUILD)/libzvtakum.a

SRC      := $(wildcard src/*.c)
OBJ      := $(patsubst src/%.c,$(BUILD)/src/%.o,$(SRC))
TESTSRC  := $(wildcard tests/*.c)
TESTBIN  := $(patsubst tests/%.c,$(BUILD)/tests/%,$(TESTSRC))
TOOLSRC  := $(wildcard tools/*.c)
TOOLBIN  := $(patsubst tools/%.c,$(BUILD)/tools/%,$(TOOLSRC))
BENCHSRC := $(wildcard bench/*.c)
BENCHBIN := $(patsubst bench/%.c,$(BUILD)/bench/%,$(BENCHSRC))

all: $(LIB) $(TESTBIN) $(TOOLBIN) $(BENCHBIN)

third_party: $(LIBTAKUM) $(LIBPOSIT)

$(LIBTAKUM):
	cd third_party/libtakum && ./configure && $(MAKE) libtakum.a

$(LIBPOSIT):
	cd third_party/libposit && ./configure && $(MAKE) libposit.a

$(BUILD)/src/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(LIB): $(OBJ)
	@mkdir -p $(@D)
	$(AR) rcs $@ $(OBJ)

$(BUILD)/tests/%: tests/%.c $(LIB) $(LIBTAKUM)
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $< $(LIB) $(LIBTAKUM) $(LDLIBS)

$(BUILD)/tools/%: tools/%.c $(LIB) $(LIBTAKUM)
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $< $(LIB) $(LIBTAKUM) $(LDLIBS)

$(BUILD)/bench/%: bench/%.c $(LIB) $(LIBTAKUM) $(LIBPOSIT)
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) -Ithird_party/libposit -std=gnu11 -O2 -Wall -Wextra \
		-Wl,--allow-multiple-definition \
		-o $@ $< $(LIB) $(LIBTAKUM) $(LIBPOSIT) $(LDLIBS)

PYTHON  ?= $(shell test -x .venv/bin/python && echo .venv/bin/python || echo python3)

matrices:
	$(PYTHON) scripts/fetch_matrices.py --count 100 --out bench/matrices

bench-convert: $(BUILD)/bench/convert_formats
	@mkdir -p bench/results
	$(BUILD)/bench/convert_formats bench/matrices \
		bench/results/relative_error.csv bench/results/log_relative_error.csv

bench-analyze:
	$(PYTHON) scripts/analyze.py bench/results/relative_error.csv \
		--outdir bench/results --prefix cdf

bench: bench-convert bench-analyze

test: all
	@for t in $(TESTBIN); do \
		echo "== $$t"; \
		$$t || exit 1; \
	done
	@echo "todos os testes passaram"

demo: all
	@echo "== zt-disa (encode/decode)"
	$(BUILD)/tools/zt-disa encode "vtadd.vv v1, v2, v3"
	$(BUILD)/tools/zt-disa decode 0xe62190d7
	@echo "== axpy IEEE f32"
	$(BUILD)/tools/zt-run --x 10=8 --x 20=0 --x 21=64 --x 23=1056964608 \
		--init8 examples/axpy.zt
	@echo "== produto escalar Takum (log)"
	$(BUILD)/tools/zt-run --variant log --x 10=8 --x 20=0 --x 21=64 \
		--x 22=128 --init8 examples/takum_dot.zt
	@echo "== produto escalar Takum (linear)"
	$(BUILD)/tools/zt-run --variant linear --x 10=8 --x 20=0 --x 21=64 \
		--x 22=128 --init8 examples/takum_dot.zt

clean:
	rm -rf $(BUILD)

distclean: clean
	cd third_party/libtakum && $(MAKE) clean

.PHONY: all test third_party demo matrices bench-convert bench-analyze bench clean distclean
