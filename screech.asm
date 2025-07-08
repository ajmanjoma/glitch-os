; screech.asm
[org 0x8000]
.loop:
    in al, 0x61
    or al, 0x03
    out 0x61, al
    call delay
    and al, 0xFC
    out 0x61, al
    call delay
    jmp .loop

delay:
    mov cx, 0xFFFF
.d:
    loop .d
    ret
