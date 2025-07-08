; shake.asm
[org 0x8000]
mov ah, 0x02
mov bh, 0
.loop:
    mov dh, byte [cs:rand1]
    mov dl, byte [cs:rand2]
    int 0x10
    inc byte [cs:rand1]
    add byte [cs:rand2], 3
    jmp .loop

rand1 db 0
rand2 db 0
