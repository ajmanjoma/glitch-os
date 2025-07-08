; flood.asm - Color Flood Demo
[org 0x8000]

mov ax, 0xB800       ; Set segment for video memory
mov es, ax
xor di, di           ; Start at ES:DI = B800:0000

.loop:
    mov cx, 2000     ; 80x25 characters = 2000
    mov al, [color]  ; Get color byte

.fill:
    mov byte [es:di], 0xDB   ; Character: █ (219 in ASCII)
    inc di
    mov byte [es:di], al     ; Attribute = color
    inc di
    loop .fill

    inc byte [color]
    xor di, di
    jmp .loop

color db 0
