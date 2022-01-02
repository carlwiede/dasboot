bits 16         ; 16-bit real mode

mov ax, 0x7C0
mov ds, ax      ; load data segment
mov ax, 0x7E0
mov ss, ax      ; load stack segment with (0x07C00 + 512B)/0x10 = 07E0
mov sp, 0x2000  ; set sp = 0x2000 for an 8k stack

call clearscreen

push 0x0000
call movecursor
add sp, 2

push msg
call print
add sp, 2

cli
hlt

clearscreen:
    push bp
    mov bp, sp
    pusha

    mov ah, 0x07    ; tells BIOS to scroll down window
    mov al, 0x00    ; clear entire window
    mov bh, 0x07    ; white on black
    mov cx, 0x00    ; specifies top left of screen as (0,0)
    mov dh, 0x18    ; 0x18 = 24 rows of chars
    mov dl, 0x4f    ; 0x4f = 79 cols of chars
    int 0x10        ; calls video interrupt

    popa
    mov sp, bp
    pop bp
    ret

movecursor:
    push bp,
    mov bp, sp
    pusha

    mov dx, [bp+4]  ; get the argument from the stack. |bp| = 2, |arg| = 2
    mov ah, 0x02    ; set cursor position
    mov bh, 0x00    ; page 0 - doesn't matter, no double buffering
    int 0x10

    popa
    mov sp, bp
    pop bp
    ret

print:
    push bp
    mov bp, sp
    pusha
    mov si, [bp+4]  ; grab the pointer to the data
    mov bh, 0x00    ; page number, 0 again
    mov bl, 0x00    ; foreground color, irrelevant in text mode
    mov ah, 0x0E    ; print character to TTY
.char:
    mov al, [si]    ; get the current char from pointer position
    add si, 1       ; keep incrementing si until we see a null char
    or al, 0
    je .return      ; return if null char is reached
    int 0x10        ; print character if we're not done
    jmp .char
.return:
    popa
    mov sp, bp
    pop bp
    ret

msg:    db "Assembly sure is cool innit", 0

times 510-($-$$) db 0
dw 0xAA55