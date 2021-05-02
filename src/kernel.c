
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#if !defined(__i386__)
#error "This needs to be compiled with a i686-elf compiler"
#endif

#include "terminal.h"
#include "vga.h"


void kernel_main() {
	terminal_initialize();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");

	vga_initialize();
	vga_test();
}
