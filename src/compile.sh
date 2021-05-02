#!/bin/sh

set -e


AS="/home/kevin/opt/cross/bin/i686-elf-as"
GCC="/home/kevin/opt/cross/bin/i686-elf-gcc"
GCC_OPTIONS="-std=gnu99 -ffreestanding -O2 -Wall -Wextra -masm=intel"
OBJ_FILES=""

echo "Compiling boot.s"
rm -f boot.o
$AS boot.s -o boot.o
OBJ_FILES="$OBJ_FILES boot.o"

echo "Compiling kernel.c"
rm -f kernel.o
$GCC $GCC_OPTIONS -c kernel.c -o kernel.o
OBJ_FILES="$OBJ_FILES kernel.o"

echo "Compiling int32.asm to access BIOS"
rm -f int32.o
nasm -felf32 int32.asm -o int32.o
OBJ_FILES="$OBJ_FILES int32.o"

echo "Compiling other files"
rm -f terminal.o
$GCC $GCC_OPTIONS -c terminal.c -o terminal.o
OBJ_FILES="$OBJ_FILES terminal.o"
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
