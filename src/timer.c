#include "irq.h"
#include "system.h"
#include "timer.h"


#define PIT_A		0x40
#define PIT_B		0x41
#define PIT_C		0x42
#define PIT_CONTROL	0x43
#define PIT_MASK	0xFF
#define PIT_SET		0x36
#define PIT_HZ		1193180
#define DIV_OF_FREQ(_f) (PIT_HZ / (_f))
#define FREQ_OF_DIV(_d) (PIT_HZ / (_d))
#define REAL_FREQ_OF_FREQ(_f) (FREQ_OF_DIV(DIV_OF_FREQ((_f))))

static struct {
	uint64_t frequency;
	uint64_t divisor;
	uint64_t ticks;
} state;


static void timer_set(int hz) {
	int divisor = PIT_HZ / hz;
	outportb(PIT_CONTROL, PIT_SET);
	outportb(PIT_A, divisor & PIT_MASK);
	outportb(PIT_A, (divisor >> 8) & PIT_MASK);
}

uint64_t timer_get() {
	return state.ticks;
}

static void timer_handler(regs32_t* regs) {
	UNUSED(regs);
	state.ticks++;
}

void timer_init() {
	const uint64_t freq = REAL_FREQ_OF_FREQ(TIMER_TPS);
	state.frequency = freq;							// freq = TIMER_TPS = 363
	state.divisor = DIV_OF_FREQ(freq);
	state.ticks = 0;
	timer_set(TIMER_TPS);
	irq_install(0, timer_handler);
}
