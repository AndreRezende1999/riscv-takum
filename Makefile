CC       ?= cc
CFLAGS   ?= -std=c11 -O2 -Wall -Wextra -Wpedantic
CPPFLAGS += -Iinclude -Ithird_party/libtakum
LDLIBS   += -lm

BUILD    := build
LIBTAKUM := third_party/libtakum/libtakum.a
SRC      := src/zt_version.c
OBJ      := $(patsubst src/%.c,$(BUILD)/%.o,$(SRC))
SMOKE    := $(BUILD)/smoke

all: $(SMOKE)

third_party: $(LIBTAKUM)

$(LIBTAKUM):
	cd third_party/libtakum && ./configure && $(MAKE) libtakum.a

$(BUILD)/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(SMOKE): tests/smoke.c $(OBJ) $(LIBTAKUM)
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ tests/smoke.c $(OBJ) $(LIBTAKUM) $(LDLIBS)

test: all
	$(SMOKE)

clean:
	rm -rf $(BUILD)

distclean: clean
	cd third_party/libtakum && $(MAKE) clean

.PHONY: all test third_party clean distclean
