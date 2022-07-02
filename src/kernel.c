
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#if !defined(__i386__)
#error "This needs to be compiled with a i686-elf compiler"
#endif


#include "kbd.h"
#include "system.h"
#include "timer.h"
#include "trap.h"


extern int main_starfield();
extern int main_terminal();


void kernel_main() {
	// Initialize hardware
	pic_init();
	trap_vectors_init();
	idt_init();
	timer_init();
	kbd_init();
	STI();

	// Call main
	main_starfield();
	// main_terminal();
}
