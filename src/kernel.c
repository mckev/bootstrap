
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#if !defined(__i386__)
#error "This needs to be compiled with a i686-elf compiler"
#endif

#include "terminal.h"
#include "vga.h"


void kernel_main() {
	// VGA Text mode
	terminal_initialize();
	terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLUE));
	terminal_clear();
	terminal_writestring("Hello, kernel world!\n");

	// VGA Graphics mode
	vga_initialize();
	// Set palette
	for (uint8_t i = 0; i < 64; i++) { vga_set_palette_color(i, i, i, i); }			// Shades of gray
	for (uint8_t i = 0; i < 64; i++) { vga_set_palette_color(64 + i, i, 0, 0); }	// Shades of red
	for (uint8_t i = 0; i < 64; i++) { vga_set_palette_color(128 + i, 0, i, 0); }	// Shades of green
	for (uint8_t i = 0; i < 64; i++) { vga_set_palette_color(192 + i, 0, 0, i); }	// Shades of blue
	// Set background color
	for (int y = 0; y < VGA_HEIGHT; y++) {
		for (int x = 0; x < VGA_WIDTH; x++) {
			vga_draw_pixel(x, y, 1);
		}
	}
	// Draw horizontal lines from 0,80 to 200,240 in multiple colors
	for (int y = 0; y < VGA_HEIGHT; y++) {
		for (int x = VGA_WIDTH / 4; x < VGA_WIDTH * 3 / 4; x++) {
			vga_draw_pixel(x, y, y * 256 / VGA_HEIGHT);
		}
	}
}
