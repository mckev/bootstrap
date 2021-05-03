#ifndef UTIL_H
#define UTIL_H

#include <stddef.h>
#include <stdint.h>


// Writing and Reading I/O Port
inline void outportb(uint16_t port, uint8_t data) {
	// Ref:
	// https://www.osdev.org/howtos/2/
	// https://gcc.gnu.org/onlinedocs/gcc/Constraints.html
	asm("outb dx, al" : : "d"(port), "a"(data));
}

inline uint8_t inportb(uint16_t port) {
	uint8_t data;
	asm("inb al, dx" : "=a"(data) : "d"(port));
	return data;
}


// Call BIOS by switching temporarily from Protected Mode into Real Mode
// Ref:
//    https://wiki.osdev.org/Drawing_In_Protected_Mode
//    See "Napalm" answer on http://www.rohitab.com/discuss/topic/35103-switch-between-real-mode-and-protected-mode/
typedef struct __attribute__((packed)) {
	uint16_t di, si, bp, sp, bx, dx, cx, ax;
	uint16_t gs, fs, es, ds, eflags;
} regs16_t;
extern void int32(uint8_t intnum, regs16_t* regs);


// String functions
inline size_t strlen(const char* str) {
	size_t len = 0;
	while (str[len]) {
		len++;
	}
	return len;
}

inline char* itoa(int num, char* buffer) {
	int i = 0;
	do {
		int digit = num % 10;
		buffer[i++] = '0' + digit;
	} while (num /= 10);
	buffer[i--] = 0;	// null-terminated
	for (int j = 0; j < i; j++, i--) {
		char ch = buffer[j];
		buffer[j] = buffer[i];
		buffer[i] = ch;
	}
	return buffer;
}


#endif // !UTIL_H
