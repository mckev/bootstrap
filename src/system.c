#include "system.h"


void outportb(uint16_t port, uint8_t data) {
	// Ref:
	// https://www.osdev.org/howtos/2/
	// https://gcc.gnu.org/onlinedocs/gcc/Constraints.html
	asm("outb dx, al" : : "d"(port), "a"(data));
}

uint8_t inportb(uint16_t port) {
	uint8_t data;
	asm("inb al, dx" : "=a"(data) : "d"(port));
	return data;
}

void panic(const char* err) {
	UNUSED(err);
}
