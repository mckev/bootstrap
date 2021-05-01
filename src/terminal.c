#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "terminal.h"


static inline uint16_t vga_entry(unsigned char ch, uint8_t color) {
	return (uint16_t)ch | (uint16_t)color << 8;
}

static size_t strlen(const char* str) {
	size_t len = 0;
	while (str[len])
		len++;
	return len;
}

static const size_t TERMINAL_WIDTH = 80;
static const size_t TERMINAL_HEIGHT = 25;
static uint16_t* terminal_buffer = (uint16_t*)0xB8000;

static size_t terminal_row, terminal_column;
static uint8_t terminal_color;

void terminal_initialize() {
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	terminal_clear();
}

void terminal_clear() {
	for (size_t y = 0; y < TERMINAL_HEIGHT; y++) {
		for (size_t x = 0; x < TERMINAL_WIDTH; x++) {
			const size_t index = y * TERMINAL_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
}

void terminal_setcolor(uint8_t color) {
	terminal_color = color;
}

static void terminal_putentryat(char ch, uint8_t color, size_t x, size_t y) {
	const size_t index = y * TERMINAL_WIDTH + x;
	terminal_buffer[index] = vga_entry(ch, color);
}

static void terminal_putchar(char ch) {
	terminal_putentryat(ch, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == TERMINAL_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == TERMINAL_HEIGHT) {
			// We do not have scroll up function yet
			terminal_row = 0;
		}
	}
}

static void terminal_write(const char* str, size_t size) {
	for (size_t i = 0; i < size; i++) {
		terminal_putchar(str[i]);
	}
}

void terminal_writestring(const char* str) {
	terminal_write(str, strlen(str));
}
