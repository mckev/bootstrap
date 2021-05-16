#ifndef TERMINAL_H
#define TERMINAL_H


#include <stdint.h>


#define TERMINAL_WIDTH 80
#define TERMINAL_HEIGHT 25

// Hardware text mode color
enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15
};

static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

static inline uint16_t vga_entry(unsigned char ch, uint8_t color) {
	return (uint16_t)ch | (uint16_t)color << 8;
}

void terminal_init();
void terminal_clear();
void terminal_setcolor(uint8_t color);
void terminal_writechar(const char ch);
void terminal_writestring(const char* str);


#endif // !TERMINAL_H
