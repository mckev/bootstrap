#ifndef TRAP_H
#define TRAP_H


void trap_vectors_init();
void idt_init();
void pic_init();
void pic_enable(int irq);


#endif // !TRAP_H
