# glitch-os

A collection of x86 assembly demos and a custom bootloader for experimental and educational purposes. This project includes:

- Custom bootloader (bootloader.asm)
- Visual and audio demos (screen_vomit.asm, color_flood.asm, video_shake.asm, audio_screech.asm, time_warp.asm)
- Pre-built binaries for quick testing (glitch1.bin, glitch2.bin, etc.)
- Disk images for use with emulators or real hardware

## Boot Menu

When the system boots, you will see a menu. Each menu option corresponds to one of the provided `.asm` files (e.g., `screen_vomit.asm`, `color_flood.asm`, etc.). Selecting an option will run the associated demo.

## Usage

1. Build the project using the provided `build.sh` script or the `Makefile`.
2. Run the disk image (`disk.img`) in an emulator like QEMU or VirtualBox, or write it to a USB drive for real hardware testing.
   - The `disk.img` file can be directly attached as a virtual hard disk in VirtualBox or similar x86 emulators.

## Requirements
- NASM assembler
- QEMU or VirtualBox (for emulation)

## Disclaimer
This project is for educational and experimental use. Use at your own risk. 