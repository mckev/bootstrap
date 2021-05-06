#ifndef SYSTEM_H
#define SYSTEM_H


#include <stddef.h>
#include <stdint.h>


#define UNUSED(x) (void)(x)
#define PACKED __attribute__((packed))

// returns the highest set bit of x
// i.e. if x == 0xF, HIBIT(x) == 3 (4th index)
// WARNING: currently only works for up to 32-bit types
#define HIBIT(_x) (31 - __builtin_clz((_x)))

// returns _v with _n-th bit = _x
#define BIT_SET(_v, _n, _x) __extension__({\
        __typeof__(_v) __v = (_v);\
        (__v ^ ((-(_x) ^ __v) & (1 << (_n))));\
        })


// Registers
struct registers {
	uint32_t gs, fs, es, ds;
	uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
	uint32_t int_no, err_code;
	uint32_t eip, cs, eflags, useresp, ss;
};


// Writing and Reading I/O Port
void outportb(uint16_t port, uint8_t data);
uint8_t inportb(uint16_t port);


// Call BIOS by switching temporarily from Protected Mode into Real Mode
// Ref:
//    https://wiki.osdev.org/Drawing_In_Protected_Mode
//    See "Napalm" answer on http://www.rohitab.com/discuss/topic/35103-switch-between-real-mode-and-protected-mode/
typedef struct PACKED {
	uint16_t di, si, bp, sp, bx, dx, cx, ax;
	uint16_t gs, fs, es, ds, eflags;
} regs16_t;
void int32(uint8_t intnum, regs16_t* regs);


// Assembly
#define CLI() asm ("cli")
#define STI() asm ("sti")

void memset(void* dst, uint8_t val, size_t count);


// Misc
void panic(const char* err);


#endif // !SYSTEM_H
