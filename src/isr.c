#include "idt.h"
#include "isr.h"
#include "system.h"


#define NUM_ISRS 48

// defined in boot.s
extern void _isr0(regs32_t*);
extern void _isr1(regs32_t*);
extern void _isr2(regs32_t*);
extern void _isr3(regs32_t*);
extern void _isr4(regs32_t*);
extern void _isr5(regs32_t*);
extern void _isr6(regs32_t*);
extern void _isr7(regs32_t*);
extern void _isr8(regs32_t*);
extern void _isr9(regs32_t*);
extern void _isr10(regs32_t*);
extern void _isr11(regs32_t*);
extern void _isr12(regs32_t*);
extern void _isr13(regs32_t*);
extern void _isr14(regs32_t*);
extern void _isr15(regs32_t*);
extern void _isr16(regs32_t*);
extern void _isr17(regs32_t*);
extern void _isr18(regs32_t*);
extern void _isr19(regs32_t*);
extern void _isr20(regs32_t*);
extern void _isr21(regs32_t*);
extern void _isr22(regs32_t*);
extern void _isr23(regs32_t*);
extern void _isr24(regs32_t*);
extern void _isr25(regs32_t*);
extern void _isr26(regs32_t*);
extern void _isr27(regs32_t*);
extern void _isr28(regs32_t*);
extern void _isr29(regs32_t*);
extern void _isr30(regs32_t*);
extern void _isr31(regs32_t*);
extern void _isr32(regs32_t*);
extern void _isr33(regs32_t*);
extern void _isr34(regs32_t*);
extern void _isr35(regs32_t*);
extern void _isr36(regs32_t*);
extern void _isr37(regs32_t*);
extern void _isr38(regs32_t*);
extern void _isr39(regs32_t*);
extern void _isr40(regs32_t*);
extern void _isr41(regs32_t*);
extern void _isr42(regs32_t*);
extern void _isr43(regs32_t*);
extern void _isr44(regs32_t*);
extern void _isr45(regs32_t*);
extern void _isr46(regs32_t*);
extern void _isr47(regs32_t*);

static void (*stubs[NUM_ISRS])(regs32_t*) = {
	_isr0,
	_isr1,
	_isr2,
	_isr3,
	_isr4,
	_isr5,
	_isr6,
	_isr7,
	_isr8,
	_isr9,
	_isr10,
	_isr11,
	_isr12,
	_isr13,
	_isr14,
	_isr15,
	_isr16,
	_isr17,
	_isr18,
	_isr19,
	_isr20,
	_isr21,
	_isr22,
	_isr23,
	_isr24,
	_isr25,
	_isr26,
	_isr27,
	_isr28,
	_isr29,
	_isr30,
	_isr31,
	_isr32,
	_isr33,
	_isr34,
	_isr35,
	_isr36,
	_isr37,
	_isr38,
	_isr39,
	_isr40,
	_isr41,
	_isr42,
	_isr43,
	_isr44,
	_isr45,
	_isr46,
	_isr47,
};

static const char* exceptions[32] = {
	"Divide by zero",
	"Debug",
	"NMI",
	"Breakpoint",
	"Overflow",
	"OOB",
	"Invalid opcode",
	"No coprocessor",
	"Double fault",
	"Coprocessor segment overrun",
	"Bad TSS",
	"Segment not present",
	"Stack fault",
	"General protection fault",
	"Page fault",
	"Unrecognized interrupt",
	"Coprocessor fault",
	"Alignment check",
	"Machine check",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED",
	"RESERVED"
};

static struct {
	size_t index;
	void (*stub)(regs32_t*);
} isrs[NUM_ISRS];

static void (*handlers[NUM_ISRS])(regs32_t*) = { 0 };

void isr_install(size_t i, void (*handler)(regs32_t*)) {
	handlers[i] = handler;
}

// referenced from boot.s
void isr_handler(regs32_t* regs) {
	if (handlers[regs->int_no]) {
		handlers[regs->int_no](regs);
	}
}

static void exception_handler(regs32_t* regs) {
	panic(exceptions[regs->int_no]);
}

void isr_init() {
	for (size_t i = 0; i < NUM_ISRS; i++) {
		isrs[i].index = i;
		isrs[i].stub = stubs[i];
		idt_set(isrs[i].index, isrs[i].stub, 0x08, 0x8E);
	}
	// ISR 0 - 31 is handled by exception_handler()
	// ISR 32 - 47 will be used for IRQ 0 - 15
	for (size_t i = 0; i < 32; i++) {
		isr_install(i, exception_handler);
	}
}
