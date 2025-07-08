Here's a complete and clean `README.md` for your `glitch-os` project:

---

````markdown
# 🌀 Glitch OS

**Glitch OS** is a collection of bare-metal x86 assembly demos booting from a custom bootloader.  
Built for experimentation, retro visuals, and real-mode OS development learning.

> Boot into color floods, screen shakes, speaker noise, and more—straight from `0x7C00`.

---

## 📦 Features

- 🔥 Custom bootloader (`bootloader.asm`)
- 🎨 Visual demos (`screen_vomit.asm`, `flood.asm`, `shake.asm`, `warp.asm`)
- 🔊 Audio demo (`screech.asm`)
- 🧪 A Hello World style demo (`hello.asm`)
- 🖥️ Runs in QEMU or VirtualBox
- 🧵 Real-mode x86 assembly (`[org 0x7C00]`, `[org 0x8000]` layout)

---

## 📂 File Structure

| File               | Description                                 |
|--------------------|---------------------------------------------|
| `bootloader.asm`   | Main bootloader with menu & sector loading  |
| `hello.asm`        | Minimal demo that prints text at `0x8000`   |
| `screen_vomit.asm` | Glitchy screen color noise                  |
| `flood.asm`        | Flashing color flood                        |
| `shake.asm`        | Video shake visual effect                   |
| `screech.asm`      | High-pitched audio screech (PC speaker)     |
| `warp.asm`         | Time-warp-like screen flickering            |
| `disk.img`         | Assembled bootable disk image (floppy)      |
| `disk.vdi`         | VirtualBox-compatible version of `disk.img` |
| `build.sh`         | Shell script to assemble and pack image     |
| `README.md`        | This documentation                          |
| `.gitignore`       | Git ignored artifacts and binaries          |

---

## 🛠 Build Instructions

### 🧱 Assemble All Binaries

```bash
nasm bootloader.asm -f bin -o bootloader.bin
nasm hello.asm      -f bin -o hello.bin
nasm screen_vomit.asm -f bin -o glitch1.bin
nasm shake.asm        -f bin -o glitch2.bin
nasm screech.asm      -f bin -o glitch3.bin
nasm warp.asm         -f bin -o glitch4.bin
nasm flood.asm        -f bin -o glitch5.bin
````

### 🖼 Create a Disk Image

```bash
# Create 1.44MB floppy
dd if=/dev/zero of=disk.img bs=512 count=2880

# Write bootloader to sector 0
dd if=bootloader.bin of=disk.img conv=notrunc bs=512 seek=0

# Write demos to sector 1+
dd if=hello.bin      of=disk.img conv=notrunc bs=512 seek=1
dd if=glitch1.bin    of=disk.img conv=notrunc bs=512 seek=2
dd if=glitch2.bin    of=disk.img conv=notrunc bs=512 seek=3
dd if=glitch3.bin    of=disk.img conv=notrunc bs=512 seek=4
dd if=glitch4.bin    of=disk.img conv=notrunc bs=512 seek=5
dd if=glitch5.bin    of=disk.img conv=notrunc bs=512 seek=6
```

---

## 💻 Run It

### ▶️ With QEMU

```bash
qemu-system-i386 -fda disk.img
```

### 📦 With VirtualBox

1. Convert `disk.img`:

   ```bash
   VBoxManage convertfromraw disk.img disk.vdi --format VDI
   ```
2. Create a VM (type: Other → Other/Unknown 32-bit)
3. Attach `disk.vdi` as primary drive
4. Boot it up and enjoy the glitch

---

## ⚠️ Common Pitfall

If your demo code uses `call` or `ret`, make sure to set up a **valid stack**:

```asm
xor ax, ax
mov ds, ax
mov ss, ax
mov sp, 0x9000
```

Otherwise, your CPU will jump into garbage after `call`.

---

## 🔥 Screenshots

> *(Coming soon: visuals of each demo in QEMU!)*

---

## 📖 License

MIT License — fork it, glitch it, and learn from it.

---

## 🌐 Author

Created by [Antony Joseph Mathew](https://github.com/ajmanjoma)
Contributions welcome!

```

---

Would you like me to:
- Include demo images or ASCII diagrams?
- Turn this into a GitHub Pages landing site?
- Auto-generate `build.sh` for sector writing?

Let me know — happy to help.
```
