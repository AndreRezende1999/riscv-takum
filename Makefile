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

clean:
	rm -rf $(BUILD)

distclean: clean
	cd third_party/libtakum && $(MAKE) clean

.PHONY: all test third_party clean distclean
