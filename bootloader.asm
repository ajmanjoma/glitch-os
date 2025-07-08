[org 0x7C00]

start:
    ; Set up stack
    cli
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Clear screen
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Show boot menu
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
    int 0x16           ; wait for key press

    ; Convert keypress to sector index
    cmp al, '0'
    jb invalid_key
    cmp al, '5'
    ja invalid_key
    sub al, '0'        ; convert ASCII to 0–5

    mov bl, al         ; BL = demo number (0 = hello test)

    call print_loading
    call load_glitch

    ; Print message before jumping
    mov si, msg_jumping
    call print_string

    jmp 0x0000:0x8000  ; jump to loaded demo

    ; If jump fails for any reason
    jmp crash

invalid_key:
    mov si, msg_invalid
    call print_string
    jmp start

crash:
    mov si, msg_crashed
    call print_string
    hlt
    jmp $

; === load_glitch: Load 1 sector from disk ===
load_glitch:
    mov cl, bl
    add cl, sector_offset

    mov si, msg_reading
    call print_string

    mov ah, 0x02
    mov al, 1
    xor ch, ch
    xor dh, dh
    xor dl, dl

    xor ax, ax
    mov es, ax
    mov bx, 0x8000

    int 0x13
    jc disk_error

    mov si, msg_read_success
    call print_string

    ret

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

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

; === CONSTANTS ===
sector_offset equ 1  ; sector 0 = bootloader, sector 1 = demo 0

; === MESSAGES ===
;msg_menu:
;    db 13, 10
;    db "Glitch OS Boot Menu", 13, 10
;    db "======================", 13, 10
;    db "[0] Hello Test Demo", 13, 10
;    db "[1] Screen Vomit", 13, 10
;    db "[2] Video Shake", 13, 10
;    db "[3] Audio Screech", 13, 10
;    db "[4] Time Warp", 13, 10
;    db "[5] Color Flood", 13, 10, 0

msg_menu:          db "[0] Hello", 13, 10, "[1] Vomit", 13, 10, "[2] Shake", 13, 10, "[3] Screech", 13, 10, "[4] Warp", 13, 10, "[5] Flood", 13, 10, 0
msg_loading:
    db 13, 10, "Loading demo...", 13, 10, 0

msg_error:
    db 13, 10, "Disk read failed!", 13, 10, 0

msg_invalid:
    db 13, 10, "Invalid choice. Pick 0 to 5.", 13, 10, 0

msg_reading:
    db 13, 10, "Reading from disk...", 13, 10, 0

msg_read_success:
    db 13, 10, "Disk read OK.", 13, 10, 0

msg_jumping:
    db 13, 10, "Jumping to 0x8000...", 13, 10, 0

msg_crashed:
    db 13, 10, "Jump failed — returned!", 13, 10, 0


; === Boot sector padding ===
times 510 - ($ - $$) db 0
dw 0xAA55
