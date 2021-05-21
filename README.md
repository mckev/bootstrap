# bootstrap
My attempt to access x86 hardware without interference from modern OS, just like the old days :)

What works:
  - Boot into our own 32-bit protected mode kernel via GRUB. There is nothing between us and hardware now :).
  - Print characters on text console by writing into memory address 0xB8000.
  - Access BIOS interrupt 0x10 to enter VGA Graphics mode, by temporarily switch into real mode (legacy BIOS cannot be accessed in protected mode).
      - Draw a pixel in VGA Graphics by writing into memory address 0xA0000.
      - Change palette color by writing I/O port 0x3C8 and 0x3C9.
  - Set PIC Timer to call our function at regular interval (for timing purpose) via IRQ 0. I need to handle GDT, IDT, and IRQ for this.
  - Handle Keyboard press events via IRQ 1:
      - Change cursor location on text console by writing I/O port 0x3D4 and 0x3D5.
  - Starfield animation:
      - Write pixels into a buffer before drawing into VGA memory address for smooth animation.
      - Must write our own rand(), cos(), and sin() functions, as standard C library cannot be used.
  - Write the .iso file and boot into USB Drive on my modern PC i7-7700K and 4K monitor.
