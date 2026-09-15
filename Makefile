CC       ?= cc
AR       ?= ar
CFLAGS   ?= -std=c11 -O2 -Wall -Wextra -Wpedantic
CPPFLAGS += -Iinclude -Ithird_party/libtakum
LDLIBS   += -lm

BUILD    := build
LIBTAKUM := third_party/libtakum/libtakum.a
LIB      := $(BUILD)/libzvtakum.a

SRC      := $(wildcard src/*.c)
OBJ      := $(patsubst src/%.c,$(BUILD)/src/%.o,$(SRC))
TESTSRC  := $(wildcard tests/*.c)
TESTBIN  := $(patsubst tests/%.c,$(BUILD)/tests/%,$(TESTSRC))
TOOLSRC  := $(wildcard tools/*.c)
TOOLBIN  := $(patsubst tools/%.c,$(BUILD)/tools/%,$(TOOLSRC))

all: $(LIB) $(TESTBIN) $(TOOLBIN)

third_party: $(LIBTAKUM)

$(LIBTAKUM):
	cd third_party/libtakum && ./configure && $(MAKE) libtakum.a

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

.PHONY: all test third_party demo clean distclean
