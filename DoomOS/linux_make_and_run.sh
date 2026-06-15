#!/bin/sh

echo "Building bootloader..."
nasm bootloader/bootloader.asm -f bin -o bootloader.bin || exit 1

echo "Building kernel..."
nasm kernel/kernel.asm -f bin -o kernel.bin || exit 1

echo "Creating image..."
cat bootloader.bin kernel.bin > DoomOS_0.1.img || exit 1

echo "Starting DoomOS..."
qemu-system-i386 -drive format=raw,file=DoomOS_0.1.img