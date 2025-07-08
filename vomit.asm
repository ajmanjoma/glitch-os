; vomit.asm
[org 0x8000]
mov si, 0xB8000
.fill:
    mov al, byte [cs:tick]
    inc byte [cs:tick]
    mov [si], al
    inc si
    mov [si], 0x0F
    inc si
    jmp .fill

tick db 0
