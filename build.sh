#!/bin/bash

set -e

nasm bootloader.asm -f bin -o bootloader.bin
dd if=/dev/zero of=disk.img bs=512 count=2880

dd if=bootloader.bin of=disk.img conv=notrunc

nasm screen_vomit.asm -f bin -o glitch1.bin
nasm video_shake.asm -f bin -o glitch2.bin
nasm audio_screech.asm -f bin -o glitch3.bin
nasm time_warp.asm -f bin -o glitch4.bin
nasm color_flood.asm -f bin -o glitch5.bin

dd if=glitch1.bin of=disk.img bs=512 seek=1 conv=notrunc
dd if=glitch2.bin of=disk.img bs=512 seek=2 conv=notrunc
dd if=glitch3.bin of=disk.img bs=512 seek=3 conv=notrunc
dd if=glitch4.bin of=disk.img bs=512 seek=4 conv=notrunc
dd if=glitch5.bin of=disk.img bs=512 seek=5 conv=notrunc

echo "Build complete. Run with: qemu-system-i386 -drive format=raw,file=disk.img"
