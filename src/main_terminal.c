#include <stdbool.h>

#include "kbd.h"
#include "system.h"
#include "terminal.h"


int main_terminal() {
	terminal_init();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");

	// Endless loop to prevent kernel from exiting
	while (true) {
		HLT();				// to lower CPU usage
		if (kbhit()) {
			char ch = getch();
			terminal_writechar(ch);
		}
	}

	return 0;
}
