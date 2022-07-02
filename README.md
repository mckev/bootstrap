# bootstrap

My attempt to access x86 hardware without interference from modern OS, just like the old days :)

Main article: https://medium.com/@mckev


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


## Build

 1. Build machine: Debian 10 x86_64 OS
       ```
       parallels@debian-gnu-linux-10:~$ uname -a
       Linux debian-gnu-linux-10 4.19.0-20-amd64 #1 SMP Debian 4.19.235-1 (2022-03-17) x86_64 GNU/Linux
       parallels@debian-gnu-linux-10:~$ cat /etc/issue
       Debian GNU/Linux 10 \n \l
       ```


 2. Build GCC Cross-Compiler (i686-elf):
       - Ref: https://wiki.osdev.org/GCC_Cross-Compiler
         Why do we need: https://wiki.osdev.org/Why_do_I_need_a_Cross_Compiler

       - Pre:
            ```
            $ mkdir -p ~/opt/cross
            $ mkdir -p ~/src
            ```

       - Download GNU Binutils:
            - Browse to: https://www.gnu.org/software/binutils/
              On "Obtaining binutils", check the latest version, for example: 2.38.

            - Browse to: https://ftp.gnu.org/gnu/binutils/
              Copy the link to the latest version, for example: https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.gz

       - Install dependencies:
            ```
            $ sudo apt install -y texinfo
            ```

       - Build GNU Binutils:
            ```
            $ cd ~/src/
            $ wget https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.gz
            $ tar xvzf binutils-2.38.tar.gz > /dev/null

            $ mkdir build-binutils
            $ cd build-binutils/
            $ ../binutils-2.38/configure --target=i686-elf --prefix="/home/parallels/opt/cross" --with-sysroot --disable-nls --disable-werror
            $ make
            $ make install

            $ ls -al ~/opt/cross/bin/
            $ ~/opt/cross/bin/i686-elf-as --version
            GNU assembler (GNU Binutils) 2.38
            This assembler was configured for a target of `i686-elf`.
            ```

       - Download GCC:
            - Browse to: https://www.gnu.org/software/gcc/
              On "Supported Releases", check the latest version, for example: GCC 11.3.

            - Browse to: https://ftp.gnu.org/gnu/gcc/
              Copy the link to the latest version, for example: https://ftp.gnu.org/gnu/gcc/gcc-11.3.0/gcc-11.3.0.tar.gz

       - Install dependencies:
            ```
            $ sudo apt install -y libgmp-dev libmpfr-dev libmpc-dev
            ```

       - Build GCC:
            ```
            $ cd ~/src/
            $ wget https://ftp.gnu.org/gnu/gcc/gcc-11.3.0/gcc-11.3.0.tar.gz
            $ tar xvzf gcc-11.3.0.tar.gz > /dev/null

            $ export PATH="/home/parallels/opt/cross/bin:$PATH"
            $ which -- i686-elf-as || echo i686-elf-as is not in the PATH
            /home/parallels/opt/cross/bin/i686-elf-as

            $ mkdir build-gcc
            $ cd build-gcc
            $ ../gcc-11.3.0/configure --target=i686-elf --prefix="/home/parallels/opt/cross" --disable-nls --enable-languages=c,c++ --without-headers
            $ make all-gcc
            $ make all-target-libgcc
            $ make install-gcc
            $ make install-target-libgcc

            $ ls -al ~/opt/cross/bin/
            $ ~/opt/cross/bin/i686-elf-gcc --version
            i686-elf-gcc (GCC) 11.3.0
            ```


 3. Compile the code:
       - Install dependencies:
            ```
            $ sudo apt install -y nasm xorriso
            ```

       - Compile:
            ```
            $ cd bootstrap/src/
            $ sh compile.sh
            ```


 4. Test using QEMU:
       - Install dependencies:
            ```
            $ sudo apt install -y qemu-system-x86
            ```

       - Test:
            ```
            $ qemu-system-i386 -cdrom myos.iso
            ```


 5. Test using actual hardware:
       - Use Rufus or other utility to burn the ISO file into a USB drive.
       - Boot into USB drive.
