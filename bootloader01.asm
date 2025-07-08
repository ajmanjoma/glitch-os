[org 0x7C00]

start:
    ; Setup stack
    cli
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Clear screen
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Show menu
    mov si, msg_menu
print_menu:
    lodsb
    or al, al
    jz wait_key
    mov ah, 0x0E
    int 0x10
    jmp print_menu

wait_key:
    xor ah, ah
    int 0x16

    cmp al, '0'
    jne invalid_key
    ; If '0' pressed → load demo0.bin at 0x8000

    call print_loading
    call load_hello_demo
    jmp 0x0000:0x8000  ; Jump after print_hex

invalid_key:
    mov si, msg_invalid
    call print_string
    jmp start

load_hello_demo:
    ; 1. Show jump address
    mov si, msg_jumping_prefix
    call print_string

    mov bx, 0x8000
    call print_hex16

    ; 2. Load demo0.bin into 0x8000
    mov ah, 0x02
    mov al, 1          ; sectors to read
    xor ch, ch
    xor dh, dh
    xor dl, dl
    mov cl, 2          ; sector 2 = after bootloader
    xor ax, ax
    mov es, ax
    mov bx, 0x8000
    int 0x13
    jc disk_error

    ; 3. Print newline
    mov al, 13
    call print_char
    mov al, 10
    call print_char

    ret
call load_hello_demo
jmp 0x0000:0x8000



print_loading:
    mov si, msg_loading
    call print_string
    ret

disk_error:
    mov si, msg_error
    call print_string
    cli
    hlt
    jmp $

; === Print a string (null-terminated) ===
print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; === Print a single char (AL) ===
print_char:
    mov ah, 0x0E
    int 0x10
    ret

print_hex16:
    push ax
    push bx
    push cx
    push dx

    mov cx, 4          ; 4 hex digits (4 nibbles)

.hex_loop:
    mov ax, bx
    rol ax, 4          ; Rotate left 4 bits
    mov bx, ax         ; Update BX with rotated value
    and al, 0x0F       ; Mask lower nibble
    call print_hex_digit
    loop .hex_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret



print_hex_digit:
    and al, 0x0F
    cmp al, 10
    jl .num
    add al, 'A' - 10
    jmp .out
.num:
    add al, '0'
.out:
    mov ah, 0x0E
    int 0x10
    ret

; === Strings ===
msg_menu:
    db 13, 10
    db "Glitch OS Boot Menu", 13, 10
    db "======================", 13, 10
    db "[0] Hello Test Demo", 13, 10, 0

msg_loading:
    db 13, 10, "Loading demo...", 13, 10, 0

msg_error:
    db 13, 10, "Disk read failed!", 13, 10, 0

msg_invalid:
    db 13, 10, "Invalid key! Use 0.", 13, 10, 0

msg_jumping_prefix:
    db 13, 10, "Jumping to 0x", 0

; === Boot sector padding ===
times 510 - ($ - $$) db 0
dw 0xAA55
