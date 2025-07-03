[org 0x8200]

mov ax, 0xB800
mov es, ax

.loop:
    mov dx, 0x03D4
    mov al, 0x0E
    out dx, al
    inc dx
    mov al, 0
    out dx, al

    dec dx
    mov al, 0x0F
    out dx, al
    inc dx
    mov al, 80
    out dx, al

    mov cx, 50000
.delay:
    loop .delay

jmp .loop
