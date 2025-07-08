[org 0x8000]

start:
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x9000

    mov si, msg_start
    call print_string

    mov si, msg_hello
    call print_string

    cli
    hlt
    jmp $

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

msg_start: db 13, 10, "[*] Hello.asm started!", 13, 10, 0
msg_hello: db "[*] Reached code at 0x8000!", 13, 10, 0
