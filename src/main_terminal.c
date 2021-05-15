#include <stdbool.h>

#include "terminal.h"


int main_terminal() {
	terminal_init();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");

	while (true) {
		// Prevents kernel exit
	}

	return 0;
}
