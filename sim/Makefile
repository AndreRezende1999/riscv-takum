# Simulador ISA Takum-RVV (C++17). Ver docs/arquitetura.md.
#
#   make -C sim          compila build/zt-sim
#   make -C sim test     compila e executa build/zt-test (vetores em tests/golden)

CXX      ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra -Werror -ffp-contract=off
CPPFLAGS += -Iinclude

BUILD := build
LIB_SRC := src/takum.cpp src/machine.cpp
LIB_OBJ := $(LIB_SRC:src/%.cpp=$(BUILD)/%.o)

all: $(BUILD)/zt-sim

$(BUILD)/%.o: src/%.cpp include/zt/*.hpp
	@mkdir -p $(@D)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

$(BUILD)/zt-sim: $(LIB_OBJ) src/main.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ src/main.cpp $(LIB_OBJ)

$(BUILD)/zt-test: tests/test_main.cpp $(LIB_OBJ)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -DZT_GOLDEN_DIR='"tests/golden"' -o $@ tests/test_main.cpp $(LIB_OBJ)

test: all $(BUILD)/zt-test
	./$(BUILD)/zt-test

clean:
	rm -rf $(BUILD)

.PHONY: all test clean
