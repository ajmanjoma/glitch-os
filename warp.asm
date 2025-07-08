; warp.asm
[org 0x8000]
mov al, 0x36
out 0x43, al
.loop:
    mov ax, word [cs:val]
    out 0x40, al
    mov al, ah
    out 0x40, al
    inc word [cs:val]
    jmp .loop

val dw 0x1234
