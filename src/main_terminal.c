#include <stdbool.h>

#include "system.h"
#include "terminal.h"


void console_intr(int (*getc)()) {
	// Ref: https://github.com/phf/xv6/blob/master/console.c at consoleintr()
	int c;

	while ((c = getc()) >= 0) {
		switch (c) {
		default:
			if (c != 0) {
				terminal_putchar(c);
			}
		}
	}
}


int main_terminal() {
	terminal_init();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");

	// Endless loop to prevent kernel from exiting
	while (true) {
		HLT();				// to lower CPU usage
	}

	return 0;
}
