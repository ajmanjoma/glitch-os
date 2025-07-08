[org 0x8000]

start:
    mov ax, 0xB800
    mov es, ax
    xor di, di
    xor cx, cx

.loop:
    mov al, 177        ; ASCII ▒ (garbage-style)
    mov ah, 0x0F       ; White text on black
    stosw
    inc cx
    cmp cx, 2000       ; 80x25 = 2000 characters
    jl .loop

hang:
    jmp hang
