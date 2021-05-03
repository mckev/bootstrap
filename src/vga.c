#include <stdint.h>

#include "util.h"
#include "vga.h"


const int VGA_WIDTH = 320;
const int VGA_HEIGHT = 200;
static uint8_t* vga_buffer = (uint8_t*)0xA0000;


void vga_initialize() {
	// Set video mode 320x200 256 color graphics (VGA) by calling BIOS int 10h
	regs16_t regs;
	regs.ax = 0x0013;
	int32(0x10, &regs);
}

#define PALETTE_WRITE 0x3C8
#define PALETTE_DATA 0x3C9

void vga_set_palette_color(uint8_t palette_no, uint8_t r, uint8_t g, uint8_t b) {
	outportb(PALETTE_WRITE, palette_no);
	// Valid range of r, g, b is 0 - 63
	outportb(PALETTE_DATA, r);
	outportb(PALETTE_DATA, g);
	outportb(PALETTE_DATA, b);
}

void vga_draw_pixel(int x, int y, uint8_t palette_no) {
	vga_buffer[y * VGA_WIDTH + x] = palette_no;
}
