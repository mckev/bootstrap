#include <stdint.h>

#include "system.h"
#include "terminal.h"
#include "util.h"


static uint16_t* terminal_buffer = (uint16_t*)0xB8000;
static uint8_t terminal_color;
static int terminal_cursor_pos;			// pos = x + TERMINAL_WIDTH * y


#define CRTPORT 0x3d4
static void terminal_update_cursor_pos() {
	outportb(CRTPORT, 14);
	outportb(CRTPORT + 1, terminal_cursor_pos >> 8);
	outportb(CRTPORT, 15);
	outportb(CRTPORT + 1, terminal_cursor_pos);
}

void terminal_init() {
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	terminal_clear();
}

void terminal_clear() {
	for (int pos = 0; pos < TERMINAL_HEIGHT * TERMINAL_WIDTH; pos++) {
		terminal_buffer[pos] = vga_entry(' ', terminal_color);
	}
	terminal_cursor_pos = 0;
	terminal_update_cursor_pos();
}

void terminal_setcolor(uint8_t color) {
	terminal_color = color;
}

static void terminal_scrollup() {
	memmove(terminal_buffer, terminal_buffer + TERMINAL_WIDTH, (TERMINAL_HEIGHT - 1) * TERMINAL_WIDTH * sizeof(uint16_t));
	for (int pos = (TERMINAL_HEIGHT - 1) * TERMINAL_WIDTH; pos < TERMINAL_HEIGHT * TERMINAL_WIDTH; pos++) {
		terminal_buffer[pos] = vga_entry(' ', terminal_color);
	}
}

static void terminal_linefeed() {
	terminal_cursor_pos = terminal_cursor_pos - (terminal_cursor_pos % TERMINAL_WIDTH) + TERMINAL_WIDTH;
	if (terminal_cursor_pos >= TERMINAL_HEIGHT * TERMINAL_WIDTH) {
		terminal_scrollup();
		terminal_cursor_pos -= TERMINAL_WIDTH;
	}
}

void terminal_writechar(const char ch) {
	if (ch == '\n') {
		terminal_linefeed();
	}
	else {
		terminal_buffer[terminal_cursor_pos] = vga_entry(ch, terminal_color);
		terminal_cursor_pos++;
		if (terminal_cursor_pos >= TERMINAL_HEIGHT * TERMINAL_WIDTH) {
			terminal_scrollup();
			terminal_cursor_pos -= TERMINAL_WIDTH;
		}
	}
	terminal_update_cursor_pos();
}

void terminal_writestring(const char* str) {
	for (size_t i = 0; i < strlen(str); i++) {
		terminal_writechar(str[i]);
	}
}
