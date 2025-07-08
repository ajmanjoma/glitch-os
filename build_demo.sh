#!/bin/bash
set -e

nasm bootloader01.asm -f bin -o bootloader01.bin
nasm hello.asm        -f bin -o demo0.bin        # hello test   → demo0.bin

# Create disk image with bootloader and demos
cat bootloader01.bin demo0.bin  > disk.img
echo "✅ Build successful. Use qemu-system-i386 -fda disk.img"


# Write bootloader to sector 0
dd if=bootloader01.bin of=disk.img bs=512 count=1 conv=notrunc

# Write demo0.bin to sector 2 (offset 1024 bytes)
dd if=demo0.bin of=disk.img bs=512 seek=2 conv=notrunc
hexdump -C disk.img | less
# Look at offset 0x0400 for your demo code
