QEMU = qemu-system-i386
KVM = 
GDB = gdb

QEMUCPUS = 4
QEMUFLAGS = -k en-us -d guest_errors

QEMUREMOTEGDB = -gdb tcp::1234

SERIALPTY = -serial pty


qemu: all
	$(VERBOSE) $(QEMU) -kernel $(KERNEL) -smp $(QEMUCPUS) $(QEMUFLAGS) $(SERIALPTY) $(QEMUREMOTEGDB)

kvm:
	@echo TODO: implement

gdb:
	@echo TODO: implement

connect-gdb:
	@echo TODO: implement

qemu-curses-gdb:
	$(VERBOSE) $(QEMU) -curses -kernel $(KERNEL) -smp $(QEMUCPUS) $(QEMUFLAGS) -S $(SERIALPTY) $(QEMUREMOTEGDB)

qemu-curses: all
	$(VERBOSE) $(QEMU) -curses -kernel $(KERNEL) -smp $(QEMUCPUS) $(QEMUFLAGS) $(SERIALPTY) $(QEMUREMOTEGDB)

kvm-curses:
	@echo TODO: implement

qemu-serial:
	@echo TODO: implement

kvm-serial:
	@echo TODO: implement