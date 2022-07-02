#!/bin/sh

set -e


AS=~/opt/cross/bin/i686-elf-as
GCC=~/opt/cross/bin/i686-elf-gcc
GCC_OPTIONS="-std=gnu99 -ffreestanding -O2 -Wall -Wextra -masm=intel"
OBJ_FILES=""

echo "Compiling boot.s"
rm -f boot.o
$AS boot.s -o boot.o
OBJ_FILES="$OBJ_FILES boot.o"

echo "Compiling trap routines"
rm -f trap_asm.o
$AS trap_asm.s -o trap_asm.o
OBJ_FILES="$OBJ_FILES trap_asm.o"
rm -f trap_vectors.o
$AS trap_vectors.s -o trap_vectors.o
OBJ_FILES="$OBJ_FILES trap_vectors.o"

echo "Compiling kernel.c"
rm -f kernel.o
$GCC $GCC_OPTIONS -c kernel.c -o kernel.o
OBJ_FILES="$OBJ_FILES kernel.o"
rm -f main_starfield.o
$GCC $GCC_OPTIONS -c main_starfield.c -o main_starfield.o
OBJ_FILES="$OBJ_FILES main_starfield.o"
rm -f main_terminal.o
$GCC $GCC_OPTIONS -c main_terminal.c -o main_terminal.o
OBJ_FILES="$OBJ_FILES main_terminal.o"

echo "Compiling int32.asm to access BIOS interrupt"
rm -f int32.o
nasm -felf32 int32.asm -o int32.o
OBJ_FILES="$OBJ_FILES int32.o"

echo "Compiling other files"
rm -f kbd.o
$GCC $GCC_OPTIONS -c kbd.c -o kbd.o
OBJ_FILES="$OBJ_FILES kbd.o"
rm -f math.o
$GCC $GCC_OPTIONS -c math.c -o math.o
OBJ_FILES="$OBJ_FILES math.o"
rm -f system.o
$GCC $GCC_OPTIONS -c system.c -o system.o
OBJ_FILES="$OBJ_FILES system.o"
rm -f terminal.o
$GCC $GCC_OPTIONS -c terminal.c -o terminal.o
OBJ_FILES="$OBJ_FILES terminal.o"
rm -f timer.o
$GCC $GCC_OPTIONS -c timer.c -o timer.o
OBJ_FILES="$OBJ_FILES timer.o"
rm -f trap.o
$GCC $GCC_OPTIONS -c trap.c -o trap.o
OBJ_FILES="$OBJ_FILES trap.o"
rm -f util.o
$GCC $GCC_OPTIONS -c util.c -o util.o
OBJ_FILES="$OBJ_FILES util.o"
rm -f vga.o
$GCC $GCC_OPTIONS -c vga.c -o vga.o
OBJ_FILES="$OBJ_FILES vga.o"

echo "Linking"
rm -f myos.bin
echo "OBJ_FILES: $OBJ_FILES"
$GCC -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib $OBJ_FILES -lgcc

echo "Building a bootable CD-ROM image"
if grub-file --is-x86-multiboot myos.bin; then
	echo "Multiboot confirmed"
else
	echo "The file is not multiboot"
	exit 1
fi
rm -rf isodir
mkdir -p isodir/boot/grub
cp -p myos.bin isodir/boot/myos.bin
cp -p grub.cfg isodir/boot/grub/grub.cfg
rm -f myos.iso
grub-mkrescue -o myos.iso isodir

echo "To test please run: qemu-system-i386 -cdrom myos.iso"
