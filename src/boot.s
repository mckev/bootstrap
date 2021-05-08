/* Declare constants for the multiboot header. */
.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */

/* Declare a multiboot header that marks the program as a kernel. These are magic values that are documented in the multiboot standard. The bootloader will search for this signature in the first 8 KiB of the kernel file, aligned at a 32-bit boundary. The signature is in its own section so the header can be forced to be within the first 8 KiB of the kernel file. */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


/* The multiboot standard does not define the value of the stack pointer register (esp) and it is up to the kernel to provide a stack. This allocates room for a small stack by creating a symbol at the bottom of it, then allocating 16384 bytes for it, and finally creating a symbol at the top. The stack grows downwards on x86. The stack is in its own section so it can be marked nobits, which means the kernel file is smaller because it does not contain an uninitialized stack. The stack on x86 must be 16-byte aligned according to the System V ABI standard and de-facto extensions. The compiler will assume the stack is properly aligned and failure to align the stack will result in undefined behavior. */
.section .bss
.align 16
stack_bottom:
    .skip 16384 # 16 KiB
stack_top:


/* The linker script specifies _start as the entry point to the kernel and the bootloader will jump to this position once the kernel has been loaded. It doesn't make sense to return from this function as the bootloader is gone. */
.section .text
.global _start
.type _start, @function
_start:
    /* The bootloader has loaded us into 32-bit protected mode on a x86 machine. Interrupts are disabled. Paging is disabled. The processor state is as defined in the multiboot standard. The kernel has full control of the CPU. The kernel can only make use of hardware features and any code it provides as part of itself. There's no printf function, unless the kernel provides its own <stdio.h> header and a printf implementation. There are no security restrictions, no safeguards, no debugging mechanisms, only what the kernel provides itself. It has absolute and complete power over the machine. */

    /* To set up a stack, we set the esp register to point to the top of the stack (as it grows downwards on x86 systems). This is necessarily done in assembly as languages such as C cannot function without a stack. */
    movl $stack_top, %esp

    /* This is a good place to initialize crucial processor state before the high-level kernel is entered. It's best to minimize the early environment where crucial features are offline. Note that the processor is not fully initialized yet: Features such as floating point instructions and instruction set extensions are not initialized yet. The GDT should be loaded here. Paging should be enabled here. C++ features such as global constructors and exceptions will require runtime support to work as well. */
    call gdt_load

    /* Enter the high-level kernel. The ABI requires the stack is 16-byte aligned at the time of the call instruction (which afterwards pushes the return pointer of size 4 bytes). The stack was originally 16-byte aligned above and we've pushed a multiple of 16 bytes to the stack since (pushed 0 bytes so far), so the alignment has thus been preserved and the call is well defined. */
    call kernel_main

    /* If the system has nothing more to do, put the computer into an infinite loop. To do that:
    1) Disable interrupts with cli (clear interrupt enable in eflags). They are already disabled by the bootloader, so this is not needed. Mind that you might later enable interrupts and return from kernel_main (which is sort of nonsensical to do).
    2) Wait for the next interrupt to arrive with hlt (halt instruction). Since they are disabled, this will lock up the computer.
    3) Jump to the hlt instruction if it ever wakes up due to a non-maskable interrupt occurring or due to system management mode. */
    cli
1:  hlt
    jmp 1b


/*
   Global Descriptor Table
   Refs:
      https://wiki.osdev.org/Interrupts_tutorial#Interrupts_in_GRUB
      https://forum.osdev.org/viewtopic.php?f=1&t=33160&p=285871#p285871 (see "pvc" answer)
      https://github.com/phf/xv6/blob/master/multiboot.S
*/
gdt_base:
    // null segment descriptor
    .long 0x00000000
    .long 0x00000000
    // code segment descriptor
    .word 0xFFFF                            // limit  0:15
    .word 0x0000                            // base   0:15
    .byte 0x00                              // base  16:23
    .byte 0b10011010                        // present, iopl/0, code, execute/read
    .byte 0b11001111                        // 4 KB granularity, 32-bit selector; limit 16:19
    .byte 0x00                              // base  24:31
    // data segment descriptor
    .word 0xFFFF                            // limit  0:15
    .word 0x0000                            // base   0:15
    .byte 0x00                              // base  16:23
    .byte 0b10010010                        // present, iopl/0, data, read/write
    .byte 0b11001111                        // 4 KB granularity, 32-bit selector; limit 16:19
    .byte 0x00                              // base  24:31
gdt_ptr:
    .word (gdt_ptr - gdt_base - 1)
    .long gdt_base

gdt_load:
    lgdt gdt_ptr
    ljmp $(1 << 3), $fix_cs                 // GDTENTRY(1) = 0x0008 = code
fix_cs:
    movw $(2 << 3), %ax                     // GDTENTRY(2) = 0x0010 = data
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    movw %ax, %ss
    ret


/* Interrupt Descriptor Table */
.global idt_load
.type idt_load, @function
idt_load:
    mov 4(%esp), %eax
    lidt (%eax)
    ret


/* Interrupt Service Routines */
.macro ISR_NO_ERR index
    .global _isr\index
    _isr\index:
        cli
        push $0
        push $\index
        jmp isr_common
.endm

.macro ISR_ERR index
    .global _isr\index
    _isr\index:
        cli
        push $\index
        jmp isr_common
.endm

ISR_NO_ERR 0
ISR_NO_ERR 1
ISR_NO_ERR 2
ISR_NO_ERR 3
ISR_NO_ERR 4
ISR_NO_ERR 5
ISR_NO_ERR 6
ISR_NO_ERR 7
ISR_ERR 8
ISR_NO_ERR 9
ISR_ERR 10
ISR_ERR 11
ISR_ERR 12
ISR_ERR 13
ISR_ERR 14
ISR_NO_ERR 15
ISR_NO_ERR 16
ISR_NO_ERR 17
ISR_NO_ERR 18
ISR_NO_ERR 19
ISR_NO_ERR 20
ISR_NO_ERR 21
ISR_NO_ERR 22
ISR_NO_ERR 23
ISR_NO_ERR 24
ISR_NO_ERR 25
ISR_NO_ERR 26
ISR_NO_ERR 27
ISR_NO_ERR 28
ISR_NO_ERR 29
ISR_NO_ERR 30
ISR_NO_ERR 31
ISR_NO_ERR 32
ISR_NO_ERR 33
ISR_NO_ERR 34
ISR_NO_ERR 35
ISR_NO_ERR 36
ISR_NO_ERR 37
ISR_NO_ERR 38
ISR_NO_ERR 39
ISR_NO_ERR 40
ISR_NO_ERR 41
ISR_NO_ERR 42
ISR_NO_ERR 43
ISR_NO_ERR 44
ISR_NO_ERR 45
ISR_NO_ERR 46
ISR_NO_ERR 47

.extern isr_handler
.type isr_handler, @function

isr_common:
    pusha
    push %ds
    push %es
    push %fs
    push %gs

    movw $(2 << 3), %ax                     // GDTENTRY(2) = 0x0010 = data
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    cld

    push %esp
    call isr_handler                        // defined in isr.c
    add $4, %esp

    pop %gs
    pop %fs
    pop %es
    pop %ds

    popa

    add $8, %esp
    iret


/* Set the size of the _start symbol to the current location '.' minus its start. This is useful when debugging or when you implement call tracing. */
.size _start, . - _start
