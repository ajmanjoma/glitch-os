#!/bin/bash
set -e

nasm bootloader.asm -f bin -o bootloader.bin
nasm screen_vomit.asm -f bin -o glitch1.bin      # screen_vomit → glitch1
nasm shake.asm        -f bin -o glitch2.bin      # video shake  → glitch2
nasm screech.asm      -f bin -o glitch3.bin      # audio screech→ glitch3
nasm warp.asm         -f bin -o glitch4.bin      # time warp    → glitch4
nasm flood.asm        -f bin -o glitch5.bin      # color flood  → glitch5
nasm hello.asm        -f bin -o demo0.bin        # hello test   → demo0.bin

# Create disk image with bootloader and demos
cat bootloader.bin demo0.bin glitch1.bin glitch2.bin glitch3.bin glitch4.bin glitch5.bin > disk.img
echo "✅ Build successful. Use qemu-system-i386 -fda disk.img"
