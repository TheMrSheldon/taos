VERBOSE = @

TARGETDIR = /release
DEBUG_BUILD ?= 1
ifeq ($(DEBUG), 1)
	TARGETDIR = /debug
endif

SRCDIR = ./src
OBJDIR = ./obj$(TARGETDIR)
BINDIR = ./bin$(TARGETDIR)
DEPDIR = ./dep$(TARGETDIR)
DOCDIR = ./doc

clean:
	@echo "RM		./obj/"
	$(VERBOSE) $(RM) -r ./obj
	@echo "RM		./bin/"
	$(VERBOSE) $(RM) -r ./bin
	@echo "RM		./dep/"
	$(VERBOSE) $(RM) -r ./dep
	@echo "RM		./doc/*"
	$(VERBOSE) $(RM) -r ./doc/*

docs:
	@echo "Building Docs"
	$(VERBOSE) doxygen doxyfile

.PHONY: all clean docs

.DEFAULT_GOAL = all

include compile.mk run.mk apps.mk