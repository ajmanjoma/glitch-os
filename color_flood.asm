[org 0x8800]

mov ax, 0xB800
mov es, ax

.start:
    xor di, di
    mov cx, 2000
    mov al, 219

    mov bl, 1
.fill:
    mov ah, bl
    stosw
    loop .fill

    inc bl
    jmp .start
