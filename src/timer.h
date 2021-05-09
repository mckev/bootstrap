#ifndef TIMER_H
#define TIMER_H


#define TIMER_TPS 100

extern volatile uint64_t ticks;					// "volatile" hints the C compiler that this global variable may be updated from other place (i.e. interrupt / IRQ 0), so don't optimize

void timer_init();


#endif // !TIMER_H
