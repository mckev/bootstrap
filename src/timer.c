// Intel 8253/8254/82C54 Programmable Interval Timer (PIT)


#include "system.h"
#include "timer.h"
#include "trap.h"


#define IO_TIMER1		0x040				// 8253 Timer #1
#define TIMER_MODE		(IO_TIMER1 + 3)		// timer mode port

// Frequency of all three count-down timers.
// (TIMER_FREQ/freq) is the appropriate count to generate a frequency of freq Hz.

#define TIMER_FREQ		1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

#define TIMER_SEL0		0x00				// select counter 0
#define TIMER_RATEGEN	0x04				// mode 2, rate generator
#define TIMER_16BIT		0x30				// r/w counter 16 bits, LSB first


volatile uint64_t ticks = 0;

void timer_init() {
	// Interrupt TIMER_TPS times/sec
	outportb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
	outportb(IO_TIMER1, TIMER_DIV(TIMER_TPS) % 256);
	outportb(IO_TIMER1, TIMER_DIV(TIMER_TPS) / 256);
	pic_enable(IRQ_TIMER);
}
