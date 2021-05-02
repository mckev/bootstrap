#include <stdint.h>

#include "util.h"
#include "vga.h"


static const int VGA_WIDTH = 320;
static const int VGA_HEIGHT = 200;

static uint8_t* vga_buffer = (uint8_t*)0xA0000;


void vga_initialize() {
	// Set video mode 320x200 256 color graphics (VGA) by calling BIOS int 10h
	regs16_t regs;
	regs.ax = 0x0013;
	int32(0x10, &regs);
}

void vga_test() {
	// Set background blue
	for (int y = 0; y < VGA_HEIGHT; y++) {
		for (int x = 0; x < VGA_WIDTH; x++) {
			vga_buffer[y * VGA_WIDTH + x] = 1;
		}
	}
	// Draw horizontal lines from 0,80 to 200,240 in multiple colors
	for (int y = 0; y < VGA_HEIGHT; y++) {
		for (int x = 80; x < 240; x++) {
			vga_buffer[y * VGA_WIDTH + x] = y;
		}
	}
}
