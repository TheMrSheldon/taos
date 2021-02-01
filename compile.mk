CXX = gcc
CXXFLAGS = -Wall -m32
# Flags to make the operating system stand alone
CXXFLAGS += -ffreestanding -fno-builtin -nodefaultlibs -nostdlib -nostdinc
# Configure warnings
CXXFLAGS += -Wextra -Werror -Wno-error=unused-parameter -Wno-unknown-pragmas -Wno-error=cast-function-type
# 
CXXFLAGS += -O3 -fomit-frame-pointer -fno-rtti
# Floating point flags
CXXFLAGS += -mno-mmx -mno-sse


CMACRO = 

ASM = nasm
ASMFLAGS = -f elf

LD = ld
LDFLAGS = -melf_i386
LDHEAD = $(shell $(CXX) -m32 --print-file-name=crti.o && $(CXX) -m32 --print-file-name=crtbegin.o)
LDTAIL = $(shell $(CXX) -m32 --print-file-name=crtend.o && $(CXX) -m32 --print-file-name=crtn.o)

ifeq ($(DEBUG), 1)
	CXXFLAGS += -g -DDEBUG
else
	CXXFLAGS += -DNDEBUG
endif

##################################################################
##                   Include Dependency Files                   ##
##################################################################
SRC_FILES = $(shell find $(SRCDIR) -name *.cpp)
DEP_FILES = $(patsubst $(SRCDIR)/%.cpp,$(DEPDIR)/%.d,$(SRC_FILES))
ifneq ($(MAKECMDGOALS),clean)
-include $(DEP_FILES)
endif

##################################################################
##                      Building C++ Files                      ##
##################################################################
$(DEPDIR)/%.d : $(SRCDIR)/%.cpp
	@echo "DEP		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) $(CXX) $(CXXFLAGS) -MM -MT $(OBJDIR)/$*.o -MF $@ $<

$(OBJDIR)/%.o : $(SRCDIR)/%.cpp $(MAKEFILE_LIST)
	@echo "CXX		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) $(CXX) -c $(CXXFLAGS) -o $@ $<

$(OBJDIR)/%.asm.o : $(SRCDIR)/%.asm
	@echo "ASM		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) $(ASM) $(ASMFLAGS) -o $@ $<

##################################################################
##                         Kernel Files                         ##
##################################################################
KERNEL_CPP = $(shell find $(SRCDIR)/kernel/ -name *.cpp)
KERNEL_ASM = $(shell find $(SRCDIR)/kernel/ -name *.asm)
KERNEL_O = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(KERNEL_CPP)) $(patsubst $(SRCDIR)/%.asm,$(OBJDIR)/%.asm.o,$(KERNEL_ASM))
KERNEL = $(BINDIR)/system
KERNEL_ENTRYPOINT = start
$(KERNEL) : $(KERNEL_O)
	@echo "LD		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) $(LD) -e $(KERNEL_ENTRYPOINT) -T $(SRCDIR)/kernel/boot/sections.ld -o $(KERNEL) $(LDFLAGS) $(STARTUP_OBJECT) $(LDHEAD) $(KERNEL_O) $(LDTAIL)

kernel: $(KERNEL)

##################################################################
##                         LibSys Files                         ##
##################################################################
LIBSYS_CPP = $(wildcard $(SRCDIR)/libsys/*.cpp)
LIBSYS_O = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(LIBSYS_CPP))
LIBSYS = $(BINDIR)/libsys.a

$(OBJDIR)/libsys/%.o : $(SRCDIR)/libsys/%.cpp $(MAKEFILE_LIST)
	@echo "CXX		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) $(CXX) -c -fpic -fno-use-cxa-atexit $(CXXFLAGS) -o $@ $<

$(LIBSYS): $(LIBSYS_O)
	@echo "AR		$@"
	@if test \( ! \( -d $(@D) \) \) ;then mkdir -p $(@D);fi
	$(VERBOSE) ar rcs $@ $(LIBSYS_O)

libsys: $(LIBSYS_BIN)

.PHONY: kernel libsys
all: kernel libsys