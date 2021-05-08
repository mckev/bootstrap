#include <stdint.h>

#include "idt.h"
#include "system.h"
#include "util.h"


struct idt_entry {
	uint16_t base_low;
	uint16_t selector;
	uint8_t zero;
	uint8_t flags;
	uint16_t base_high;
} PACKED;

struct idt_ptr {
	uint16_t limit;
	uintptr_t base;
} PACKED;

static struct {
	struct idt_entry entries[256];
	struct idt_ptr pointer;
} idt;

// defined in boot.s
extern void idt_load();

void idt_set(uint8_t index, void (*base)(regs32_t*), uint16_t selector, uint8_t flags) {
	idt.entries[index] = (struct idt_entry){
		.base_low = ((uintptr_t)base) & 0xFFFF,
		.base_high = (((uintptr_t)base) >> 16) & 0xFFFF,
		.selector = selector,
		.flags = flags | 0x60,
		.zero = 0
	};
}

void idt_init() {
	idt.pointer.limit = sizeof(idt.entries) - 1;
	idt.pointer.base = (uintptr_t)&idt.entries[0];
	memset(&idt.entries[0], 0, sizeof(idt.entries));
	idt_load((uintptr_t)&idt.pointer);
}
