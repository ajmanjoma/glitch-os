[org 0x8400]

.loop:
    in al, 0x61
    or al, 0x03
    out 0x61, al

    mov cx, 20000
.delay:
    loop .delay

    jmp .loop
