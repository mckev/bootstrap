#ifndef UTIL_H
#define UTIL_H

#include <stddef.h>
#include <stdint.h>


// Writing and Reading I/O Port
static inline void outportb(uint16_t port, uint8_t data) {
	// Ref:
	// https://www.osdev.org/howtos/2/
	// https://gcc.gnu.org/onlinedocs/gcc/Constraints.html
	asm("outb dx, al" : : "d"(port), "a"(data));
}

static inline uint8_t inportb(uint16_t port) {
	uint8_t data;
	asm("inb al, dx" : "=a"(data) : "d"(port));
	return data;
}


// Call BIOS by switching temporarily from Protected Mode into Real Mode
// Ref:
//    https://wiki.osdev.org/Drawing_In_Protected_Mode
//    See "Napalm" answer on http://www.rohitab.com/discuss/topic/35103-switch-between-real-mode-and-protected-mode/
typedef struct __attribute__((packed)) {
	unsigned short di, si, bp, sp, bx, dx, cx, ax;
	unsigned short gs, fs, es, ds, eflags;
} regs16_t;
extern void int32(unsigned char intnum, regs16_t* regs);


// Misc functions
static inline size_t strlen(const char* str) {
	size_t len = 0;
	while (str[len]) {
		len++;
	}
	return len;
}


#endif // !UTIL_H
