# bootstrap

My attempt to access x86 hardware without interference from modern OS, just like the old days :)

## What works

- Boot into our own 32-bit protected mode kernel via GRUB. There is nothing between us and hardware now :).
- Print characters on text console by writing into memory address 0xB8000.
- Access BIOS interrupt 0x10 to enter VGA Graphics mode, by temporarily switch into real mode (legacy BIOS cannot be
  accessed in protected mode).
    - Draw a pixel in VGA Graphics by writing into memory address 0xA0000.
    - Change palette color by writing I/O port 0x3C8 and 0x3C9.
- Set PIC Timer to call our function at regular interval (for timing purpose) via IRQ 0. I need to handle GDT, IDT, and
  IRQ for this.
- Handle Keyboard press events via IRQ 1:
    - Change cursor location on text console by writing I/O port 0x3D4 and 0x3D5.
    - Implement kbhit() through circular buffer.
- Starfield animation:
    - Write pixels into a buffer before drawing into VGA memory address for smooth animation.
    - Must write our own rand(), cos(), and sin() functions, as standard C library cannot be used.
- Write the .iso file and boot into USB Drive on my modern PC i7-7700K and 4K monitor.

## My documentation

This is what I understood about 32-bit x86 Protected Mode Kernel:

- GCC cannot generate 16-bit code unfortunately for Real Mode, so we're kind of forced to use 32-bit Protected Mode for
  our kernel.
- GDT: A table (8 bytes per segment entry) which describes: actual location of a segment (i.e. its base memory), its
  size, and its permission whether can execute/read or read/write. Unlike 16-bit Real Mode where DS, ES, SS points to
  the upper 16-bit out of 20-bit address, on 32-bit Protected Mode DS, ES, FS, GS, SS refers to this table entry. GDT
  table is activated by executing assembly command "lgdt".
- IDT: A table (8 bytes per interrupt) which desribes memory location of the function to execute for the interrupt.
  There are 256 interrupts (ISR). ISR 0 - 31 are reserved for CPU Exceptions, ISR 32 - 47 are typically for Hardware
  interrupts IRQ 0 - 15, and the rest can be used for OS interrupts. IDT table is activated by executing assembly
  command "lidt".
- IRQ: IRQ 0 is triggered by PIC Timer (after you enabled the timer by writing into specific I/O Ports) and the function
  is called n-th times per second. IRQ 1 is triggered by Keyboard.
- You cannot access Legacy BIOS interrupts while in Protected Mode. We can temporarily switch to Real Mode to access
  BIOS interrupt 0x10 to change into VGA Graphics 320 x 200 for example.
