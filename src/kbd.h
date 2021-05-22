#ifndef KBD_H
#define KBD_H


#include <stdbool.h>


void kbd_init();
void kbd_intr();
bool kbhit();
char getch();


#endif // !KBD_H
