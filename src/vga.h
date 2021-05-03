#ifndef VGA_H
#define VGA_H


extern const int VGA_WIDTH;
extern const int VGA_HEIGHT;

void vga_initialize();
void vga_set_palette_color(uint8_t palette_no, uint8_t r, uint8_t g, uint8_t b);
void vga_draw_pixel(int x, int y, uint8_t palette_no);


#endif // !VGA_H
