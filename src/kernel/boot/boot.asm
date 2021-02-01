[GLOBAL start]

[SECTION .text]

[EXTERN startKernel]
[EXTERN multibootAddr]

BOOT_STACK_SIZE equ 4096

start:
	jmp skip_multiboot_header

align 4
multiboot_header_info:
	MB_MAGIC equ 0x1badb002		;Multiboot magic word
	MB_FLAGS equ 1 | 2			;Multiboot flags: Page Align, Memory info
	dd MB_MAGIC
	dd MB_FLAGS
	dd -(MB_MAGIC + MB_FLAGS)	;Multiboot checksum

skip_multiboot_header:
	mov [multibootAddr], ebx	; Store the address of the multiboot-header for later

	mov esp, init_stack + BOOT_STACK_SIZE	;Initialize stack pointer to the boot-stack
	call startKernel



[SECTION .bss]
init_stack:
    resb BOOT_STACK_SIZE