#include <stdbool.h>

#include "math.h"
#include "timer.h"
#include "vga.h"


static uint8_t buffer[VGA_WIDTH * VGA_HEIGHT];

void screen_init() {
	// VGA graphics mode
	vga_init();
	// Set palette color
	for (int i = 0; i < 64; i++) { vga_set_palette_color(i, i, i, i); }			// Shades of gray
	for (int i = 0; i < 64; i++) { vga_set_palette_color(64 + i, i, 0, 0); }	// Shades of red
	for (int i = 0; i < 64; i++) { vga_set_palette_color(128 + i, 0, i, 0); }	// Shades of green
	for (int i = 0; i < 64; i++) { vga_set_palette_color(192 + i, 0, 0, i); }	// Shades of blue
}


static float rand_f(float a, float b) {
	return (b - a) * ((float)rand() / RAND_MAX) + a;
}


#define N_STARS 1000
typedef struct {
	float angle;
	float distance;
	float speed;
	float lum;
} star_t;
star_t stars[N_STARS];

void stars_init() {
	for (int i = 0; i < N_STARS; i++) {
		stars[i].angle = rand_f(0.0, 2.0 * PI);
		stars[i].speed = rand_f(10.0, 100.0);
		stars[i].distance = rand_f(20.0, 200.0);
		stars[i].lum = rand_f(0.3, 1.0);
	}
}

void stars_update(float elapsed_time) {
	vga_buffer_clear(buffer);
	for (int i = 0; i < N_STARS; i++) {
		stars[i].distance += stars[i].speed * elapsed_time * (stars[i].distance / 100.0);
		if (stars[i].distance > 200.0) {
			stars[i].angle = rand_f(0.0, 2.0 * PI);
			stars[i].speed = rand_f(10.0, 100.0);
			stars[i].distance = rand_f(20.0, 200.0);
			stars[i].lum = rand_f(0.3, 1.0);
		}
		int x = cos(stars[i].angle) * stars[i].distance + VGA_WIDTH / 2;
		int y = sin(stars[i].angle) * stars[i].distance + VGA_HEIGHT / 2;
		int palette_no = (int)(stars[i].lum * 63);	// palette 0 - 63 is grayscale from black to white
		if (x >= 0 && x < VGA_WIDTH && y >= 0 && y < VGA_HEIGHT) {
			vga_buffer_draw_pixel(buffer, x, y, palette_no);
		}
	}
	vga_draw_buffer(buffer);
}


int main_starfield() {
	screen_init();
	stars_init();
	while (true) {
		float elapsed_time = (float)ticks / TIMER_TPS;
		stars_update(elapsed_time);
	}
	return 0;
}
