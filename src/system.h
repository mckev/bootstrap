#ifndef SYSTEM_H
#define SYSTEM_H


#include <stddef.h>
#include <stdint.h>


#define PACKED __attribute__((packed))
#define UNUSED(x) (void)(x)


// Registers
typedef struct PACKED {
	uint32_t gs, fs, es, ds;
	uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
	uint32_t int_no, err_code;
	uint32_t eip, cs, eflags, useresp, ss;
} regs32_t;

typedef struct PACKED {
	uint16_t di, si, bp, sp, bx, dx, cx, ax;
	uint16_t gs, fs, es, ds, eflags;
} regs16_t;


// Assembly
#define CLI() asm ("cli")
#define STI() asm ("sti")


// Writing and Reading I/O Port
void outportb(uint16_t port, uint8_t data);
uint8_t inportb(uint16_t port);


// Call BIOS interrupt by switching temporarily from Protected Mode into Real Mode
// Ref:
//    https://wiki.osdev.org/Drawing_In_Protected_Mode
//    See "Napalm" answer on http://www.rohitab.com/discuss/topic/35103-switch-between-real-mode-and-protected-mode/
void int32(uint8_t intnum, regs16_t* regs);


// Misc
void panic(const char* err);


#endif // !SYSTEM_H
