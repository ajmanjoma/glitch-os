all: bootloader glitch1 glitch2 glitch3 glitch4 glitch5 img

bootloader:
	nasm bootloader.asm -f bin -o bootloader.bin

glitch1:
	nasm screen_vomit.asm -f bin -o glitch1.bin

glitch2:
	nasm video_shake.asm -f bin -o glitch2.bin

glitch3:
	nasm audio_screech.asm -f bin -o glitch3.bin

glitch4:
	nasm time_warp.asm -f bin -o glitch4.bin

glitch5:
	nasm color_flood.asm -f bin -o glitch5.bin

img:
	rm -f disk.img
	dd if=/dev/zero of=disk.img bs=512 count=2880
	dd if=bootloader.bin of=disk.img conv=notrunc
	dd if=glitch1.bin of=disk.img bs=512 seek=1 conv=notrunc
	dd if=glitch2.bin of=disk.img bs=512 seek=2 conv=notrunc
	dd if=glitch3.bin of=disk.img bs=512 seek=3 conv=notrunc
	dd if=glitch4.bin of=disk.img bs=512 seek=4 conv=notrunc
	dd if=glitch5.bin of=disk.img bs=512 seek=5 conv=notrunc

run:
	qemu-system-i386 -drive format=raw,file=disk.img
