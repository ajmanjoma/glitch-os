# Glitch OS

**Glitch OS** is an experimental, bare-metal x86 system that showcases a series of audio-visual glitch demos, booting from a custom-written bootloader. Built entirely in assembly, this project is designed for low-level enthusiasts, retro hackers, and educational explorers.

---

## 🔧 Features

- 🛠️ Custom Bootloader (`bootloader.asm`)
- 🖼️ Visual demos: `screen_vomit`, `video_shake`, `color_flood`, `time_warp`
- 🔊 Audio demo: `audio_screech`
- 🧮 Boot menu with demo selector
- 💾 Disk images: `disk.img` (floppy style), `disk.vdi` (VirtualBox style)
- ✅ Precompiled `.bin` files for quick testing

---

## 📦 Files Overview

| Filename           | Description                             |
|--------------------|-----------------------------------------|
| `bootloader.asm`   | Master bootloader with menu system      |
| `screen_vomit.asm` | Random glitchy screen color effect      |
| `video_shake.asm`  | Horizontal/vertical screen distortion   |
| `audio_screech.asm`| High-pitch speaker noise demo           |
| `time_warp.asm`    | Time distortion + flicker effects       |
| `color_flood.asm`  | Screen flood with solid color flashes   |
| `glitch1.bin`–`glitch5.bin` | Compiled binaries for each demo |
| `disk.img`         | Bootable disk image for emulators       |
| `disk.vdi`         | VirtualBox-compatible hard disk image   |
| `Makefile`         | Build automation                        |
| `build.sh`         | Shell script to assemble all binaries   |
| `README.md`        | This documentation                      |

---

## 🚀 Build Instructions

### Individual Commands:

```bash
nasm screen_vomit.asm -f bin -o glitch1.bin
nasm video_shake.asm -f bin -o glitch2.bin
nasm audio_screech.asm -f bin -o glitch3.bin
nasm time_warp.asm    -f bin -o glitch4.bin
nasm color_flood.asm  -f bin -o glitch5.bin
```

Or simply run:

```bash
./build.sh
# OR
make
```

---

## 💻 Running Glitch OS

### QEMU:

```bash
qemu-system-i386 -fda disk.img
```

### VirtualBox:

* Import `disk.vdi` as a virtual hard disk
* Boot from it using a minimal x86 machine profile

### Real Hardware:

Use `dd` or BalenaEtcher to write `disk.img` to a USB stick:

```bash
sudo dd if=disk.img of=/dev/sdX bs=4M status=progress
```

*Be cautious — replace `/dev/sdX` with your actual USB device path.*

---

## 📺 Boot Menu

At boot, Glitch OS shows a menu with 5 glitch demo options. Use keys `1` to `5` to launch each one.

---

## 🧪 Educational Purpose

This project is ideal for:

* Learning low-level x86 Assembly
* Understanding bootloaders and MBR
* Experimenting with BIOS interrupts
* Creating artistic glitches with direct hardware control

---

## ⚠️ Disclaimer

This project is for **educational and experimental** use. It runs in real mode and interacts directly with video memory and hardware registers — may cause unexpected behavior on real machines. Use with care.

---

## 📜 License

MIT License — fork it, break it, rebuild it.

--- 