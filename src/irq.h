#ifndef IRQ_H
#define IRQ_H


#include "system.h"


void irq_install(size_t i, void (*handler)(struct registers*));
void irq_init();


#endif // !IRQ_H
