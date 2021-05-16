#include <stdint.h>

#include "system.h"
#include "terminal.h"
#include "util.h"


static uint16_t* terminal_buffer = (uint16_t*)0xB8000;
static int terminal_row, terminal_column;
static uint8_t terminal_color;


#define CRTPORT 0x3d4
static void terminal_set_cursor_pos(int x, int y) {
	int pos = x + TERMINAL_WIDTH * y;
	outportb(CRTPORT, 14);
	outportb(CRTPORT + 1, pos >> 8);
	outportb(CRTPORT, 15);
	outportb(CRTPORT + 1, pos);
}

void terminal_init() {
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	terminal_clear();
}

void terminal_clear() {
	terminal_row = 0;
	terminal_column = 0;
	for (int index = 0; index < TERMINAL_HEIGHT * TERMINAL_WIDTH; index++) {
		terminal_buffer[index] = vga_entry(' ', terminal_color);
	}
	terminal_set_cursor_pos(0, 0);
}

void terminal_setcolor(uint8_t color) {
	terminal_color = color;
}

static void terminal_linefeed() {
	terminal_column = 0;
	if (++terminal_row == TERMINAL_HEIGHT) {
		// Scroll up
		memcpy(terminal_buffer, terminal_buffer + TERMINAL_WIDTH, (TERMINAL_HEIGHT - 1) * TERMINAL_WIDTH * sizeof(uint16_t));
		for (int index = (TERMINAL_HEIGHT - 1) * TERMINAL_WIDTH; index < TERMINAL_HEIGHT * TERMINAL_WIDTH; index++) {
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
		terminal_row = TERMINAL_HEIGHT - 1;
	}
}

void terminal_putchar(char ch) {
	if (ch == '\n') {
		terminal_linefeed();
	}
	else {
		const int index = terminal_row * TERMINAL_WIDTH + terminal_column;
		terminal_buffer[index] = vga_entry(ch, terminal_color);
		if (++terminal_column == TERMINAL_WIDTH) {
			terminal_linefeed();
		}
	}
	terminal_set_cursor_pos(terminal_column, terminal_row);
}

static void terminal_write(const char* str, int size) {
	for (int i = 0; i < size; i++) {
		terminal_putchar(str[i]);
	}
}

void terminal_writestring(const char* str) {
	terminal_write(str, strlen(str));
}
