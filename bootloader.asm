[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    call show_menu

.wait_input:
    mov ah, 0
    int 0x16
    cmp al, '1'
    je load_glitch1
    cmp al, '2'
    je load_glitch2
    cmp al, '3'
    je load_glitch3
    cmp al, '4'
    je load_glitch4
    cmp al, '5'
    je load_glitch5
    jmp .wait_input

load_glitch1:
    mov bx, 0x8000
    call load_sector1
    jmp 0x0000:0x8000

load_glitch2:
    mov bx, 0x8200
    call load_sector2
    jmp 0x0000:0x8200

load_glitch3:
    mov bx, 0x8400
    call load_sector3
    jmp 0x0000:0x8400

load_glitch4:
    mov bx, 0x8600
    call load_sector4
    jmp 0x0000:0x8600

load_glitch5:
    mov bx, 0x8800
    call load_sector5
    jmp 0x0000:0x8800

load_sector1:  ; Load 1 sector from LBA 1 to ES:BX
    mov ax, 0x0201
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov es, bx
    xor bx, bx
    int 0x13
    ret

load_sector2:
    mov ax, 0x0201
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 3
    mov es, bx
    xor bx, bx
    int 0x13
    ret

load_sector3:
    mov ax, 0x0201
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 4
    mov es, bx
    xor bx, bx
    int 0x13
    ret

load_sector4:
    mov ax, 0x0201
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 5
    mov es, bx
    xor bx, bx
    int 0x13
    ret

load_sector5:
    mov ax, 0x0201
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 6
    mov es, bx
    xor bx, bx
    int 0x13
    ret

show_menu:
    mov si, menu
.print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .print
.done:
    ret

menu db 'Glitch OS Boot Menu:', 13, 10
     db '1. Screen Vomit', 13, 10
     db '2. Video Shake', 13, 10
     db '3. Audio Screech', 13, 10
     db '4. Time Warp', 13, 10
     db '5. Color Flood', 13, 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55
