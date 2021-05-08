#ifndef ISR_H
#define ISR_H


#include "system.h"


void isr_install(size_t i, void (*handler)(regs32_t*));
void isr_init();


#endif // !ISR_H
