CXX = g++

ifeq ($(PROF), true)
CXXPROF += -pg -no-pie
else
CXXPROF += -s
endif

ifeq ($(BUILD), debug)
CXXFLAGS += -fdiagnostics-color=always -DUNICODE -std=c++20 -Wall -Og -pg -no-pie
else
CXXFLAGS += -DUNICODE -DNDEBUG -std=c++20 -O3 -flto $(CXXPROF) -march=native
endif

SRC_AI = src/util/*.cpp src/engine/*.cpp src/*.cpp

.PHONY: all test clean makedir

all: test

test: makedir
	@$(CXX) $(CXXFLAGS) $(SRC_AI) -o bin/test.exe

clean: makedir
	@rm -rf bin
	@make makedir

makedir:
	@mkdir -p bin

.DEFAULT_GOAL := test