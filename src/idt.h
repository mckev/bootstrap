#ifndef IDT_H
#define IDT_H


#include "system.h"


void idt_set(uint8_t index, void (*base)(struct registers*), uint16_t selector, uint8_t flags);
void idt_init();


#endif // !IDT_H
