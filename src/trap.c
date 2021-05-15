/*
	CPU Interrupt Handler
	Ref: https://github.com/phf/xv6/blob/master/trap.c
*/


#include <stdint.h>

#include "kbd.h"
#include "system.h"
#include "timer.h"


// Trap function
#define T_IRQ0			32
#define PIC1			0x20
#define PIC_EOI			0x20

typedef struct {
	// registers pushed by pushal
	uint32_t edi, esi, ebp, oesp /* useless & ignored */, ebx, edx, ecx, eax;
	// rest of trap frame
	uint16_t gs, padding1, fs, padding2, es, padding3, ds, padding4;
	uint32_t trapno;
	// below here defined by x86 hardware
	uint32_t err, eip;
	uint16_t cs, padding5;
	uint32_t eflags;
	// below here only when crossing rings, such as from user to kernel
	uint32_t esp;
	uint16_t ss, padding6;
} trapframe;

void trap(trapframe* tf) {
	/*
		Referenced from trap_vectors.s and trap_asm.s

		All CPU interrupt is handled here:
		   - CPU Exceptions (ISR 0 - ISR 31)
		   - Hardware interrupt (IRQ 0 - IRQ 15, mapped into ISR 32 - ISR 47)
		   - Software interrupt (int)
	*/
	switch (tf->trapno) {
	case T_IRQ0 + IRQ_TIMER:
		ticks++;
		break;
	case T_IRQ0 + IRQ_KBD:
		kbd_intr();
		break;
	}
	// No need to acknowledge interrupt as we are using Automatic EOI
	// outportb(PIC1, PIC_EOI);
}


// Interrupt Descriptor Table (IDT)
typedef struct {
	uint32_t off_15_0 : 16;		// low 16 bits of offset in segment
	uint32_t cs : 16;			// code segment selector
	uint32_t args : 5;			// # args, 0 for interrupt/trap gates
	uint32_t rsv1 : 3;			// reserved(should be zero I guess)
	uint32_t type : 4;			// type(STS_{TG,IG32,TG32})
	uint32_t s : 1;				// must be 0 (system)
	uint32_t dpl : 2;			// descriptor(meaning new) privilege level
	uint32_t p : 1;				// Present
	uint32_t off_31_16 : 16;	// high bits of offset in segment
} gatedesc;
gatedesc idt[256];

extern uint32_t trap_vectors[];	// in trap_vectors.s

#define STS_TG32		0xF		// 32-bit Trap Gate
#define STS_IG32		0xE		// 32-bit Interrupt Gate 
#define SETGATE(gate, istrap, sel, off, d) {			\
	(gate).off_15_0 = (uint32_t)(off) & 0xffff;			\
	(gate).cs = (sel);									\
	(gate).args = 0;									\
	(gate).rsv1 = 0;									\
	(gate).type = (istrap) ? STS_TG32 : STS_IG32;		\
	(gate).s = 0;										\
	(gate).dpl = (d);									\
	(gate).p = 1;										\
	(gate).off_31_16 = (uint32_t)(off) >> 16;			\
}

void trap_vectors_init() {
	for (int i = 0; i < 256; i++) {
		SETGATE(idt[i], 0, SEG_KCODE << 3, trap_vectors[i], 0);
	}
}


// Load IDT into CPU
static inline void lidt(gatedesc* p, int size) {
	volatile uint16_t pd[3];
	pd[0] = size - 1;
	pd[1] = (uint32_t)p;
	pd[2] = (uint32_t)p >> 16;
	asm volatile("lidt [%0]" : : "r" (pd));
}

void idt_init() {
	lidt(idt, sizeof(idt));
}


// PIC
#define IO_PIC1			0x20	// Master (IRQ 0 - 7)
#define IO_PIC2			0xA0	// Slave (IRQ 8 - 15)
#define IRQ_SLAVE		2		// IRQ at which slave connects to master

static uint16_t irqmask = 0xFFFF;

static void pic_setmask(uint16_t mask) {
	irqmask = mask;
	outportb(IO_PIC1 + 1, mask);
	outportb(IO_PIC2 + 1, mask >> 8);
}

void pic_init() {
	// Mask all interrupts
	outportb(IO_PIC1 + 1, 0xFF);
	outportb(IO_PIC2 + 1, 0xFF);

	// Set up master (8259A-1)

	// ICW1:  0001g0hi
	//    g:  0 = edge triggering, 1 = level triggering
	//    h:  0 = cascaded PICs, 1 = master only
	//    i:  0 = no ICW4, 1 = ICW4 required
	outportb(IO_PIC1, 0x11);

	// ICW2:  Vector offset
	outportb(IO_PIC1 + 1, T_IRQ0);

	// ICW3:  (master PIC) bit mask of IR lines connected to slaves
	//        (slave PIC) 3-bit # of slave's connection to master
	outportb(IO_PIC1 + 1, 1 << IRQ_SLAVE);

	// ICW4:  000nbmap
	//    n:  1 = special fully nested mode
	//    b:  1 = buffered mode
	//    m:  0 = slave PIC, 1 = master PIC
	//        (ignored when b is 0, as the master/slave role can be hardwired).
	//    a:  1 = Automatic EOI mode
	//    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
	outportb(IO_PIC1 + 1, 0x3);

	// Set up slave (8259A-2)
	outportb(IO_PIC2, 0x11);			// ICW1
	outportb(IO_PIC2 + 1, T_IRQ0 + 8);	// ICW2
	outportb(IO_PIC2 + 1, IRQ_SLAVE);	// ICW3
	// NB: Automatic EOI mode doesn't tend to work on the slave. Linux source code says it's "to be investigated".
	outportb(IO_PIC2 + 1, 0x3);			// ICW4

	// OCW3:  0ef01prs
	//   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
	//    p:  0 = no polling, 1 = polling mode
	//   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
	outportb(IO_PIC1, 0x68);			// clear specific mask
	outportb(IO_PIC1, 0x0a);			// read IRR by default

	outportb(IO_PIC2, 0x68);			// OCW3
	outportb(IO_PIC2, 0x0a);			// OCW3

	if (irqmask != 0xFFFF) {
		pic_setmask(irqmask);
	}
}

void pic_enable(int irq) {
	pic_setmask(irqmask & ~(1 << irq));
}
