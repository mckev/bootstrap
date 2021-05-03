
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#if !defined(__i386__)
#error "This needs to be compiled with a i686-elf compiler"
#endif

#include "terminal.h"
#include "util.h"
#include "vga.h"


void kernel_main() {
	char buffer[1024];

	// VGA Text mode
	terminal_initialize();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");
	terminal_writestring(itoa(987654321, buffer)); terminal_writestring("\n");

	// VGA Graphics mode
	vga_initialize();
	// Set palette
	for (int i = 0; i < 64; i++) { vga_set_palette_color(i, i, i, i); }			// Shades of gray
	for (int i = 0; i < 64; i++) { vga_set_palette_color(64 + i, i, 0, 0); }	// Shades of red
	for (int i = 0; i < 64; i++) { vga_set_palette_color(128 + i, 0, i, 0); }	// Shades of green
	for (int i = 0; i < 64; i++) { vga_set_palette_color(192 + i, 0, 0, i); }	// Shades of blue
	// Draw horizontal lines from (80, 0) to (240, 200) in multiple colors
	for (int y = 0; y < VGA_HEIGHT; y++) {
		for (int x = VGA_WIDTH / 4; x < VGA_WIDTH * 3 / 4; x++) {
			uint8_t palette_no = y * 256 / VGA_HEIGHT;
			vga_draw_pixel(x, y, palette_no);
		}
	}
}
