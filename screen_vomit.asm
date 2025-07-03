[org 0x8000]

mov ax, 0xB800
mov es, ax
xor di, di
xor cx, cx

.loop:
    mov al, 177
    mov ah, 0x0F
    stosw
    inc cx
    cmp cx, 2000
    jl .loop

jmp $
