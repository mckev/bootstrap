#include "idt.h"
#include "isr.h"
#include "system.h"


#define NUM_ISRS 48

extern void _isr0(struct registers*);
extern void _isr1(struct registers*);
extern void _isr2(struct registers*);
extern void _isr3(struct registers*);
extern void _isr4(struct registers*);
extern void _isr5(struct registers*);
extern void _isr6(struct registers*);
extern void _isr7(struct registers*);
extern void _isr8(struct registers*);
extern void _isr9(struct registers*);
extern void _isr10(struct registers*);
extern void _isr11(struct registers*);
extern void _isr12(struct registers*);
extern void _isr13(struct registers*);
extern void _isr14(struct registers*);
extern void _isr15(struct registers*);
extern void _isr16(struct registers*);
extern void _isr17(struct registers*);
extern void _isr18(struct registers*);
extern void _isr19(struct registers*);
extern void _isr20(struct registers*);
extern void _isr21(struct registers*);
extern void _isr22(struct registers*);
extern void _isr23(struct registers*);
extern void _isr24(struct registers*);
extern void _isr25(struct registers*);
extern void _isr26(struct registers*);
extern void _isr27(struct registers*);
extern void _isr28(struct registers*);
extern void _isr29(struct registers*);
extern void _isr30(struct registers*);
extern void _isr31(struct registers*);
extern void _isr32(struct registers*);
extern void _isr33(struct registers*);
extern void _isr34(struct registers*);
extern void _isr35(struct registers*);
extern void _isr36(struct registers*);
extern void _isr37(struct registers*);
extern void _isr38(struct registers*);
extern void _isr39(struct registers*);
extern void _isr40(struct registers*);
extern void _isr41(struct registers*);
extern void _isr42(struct registers*);
extern void _isr43(struct registers*);
extern void _isr44(struct registers*);
extern void _isr45(struct registers*);
extern void _isr46(struct registers*);
extern void _isr47(struct registers*);

static void (*stubs[NUM_ISRS])(struct registers*) = {
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
	void (*stub)(struct registers*);
} isrs[NUM_ISRS];

static void (*handlers[NUM_ISRS])(struct registers*) = { 0 };

void isr_install(size_t i, void (*handler)(struct registers*)) {
	handlers[i] = handler;
}

// referenced from start.S
void isr_handler(struct registers* regs) {
	if (handlers[regs->int_no]) {
		handlers[regs->int_no](regs);
	}
}

static void exception_handler(struct registers* regs) {
	panic(exceptions[regs->int_no]);
}

void isr_init() {
	for (size_t i = 0; i < NUM_ISRS; i++) {
		isrs[i].index = i;
		isrs[i].stub = stubs[i];
		idt_set(isrs[i].index, isrs[i].stub, 0x08, 0x8E);
	}

	for (size_t i = 0; i < 32; i++) {
		isr_install(i, exception_handler);
	}
}
