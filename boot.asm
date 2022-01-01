mov ax, 0x7C0
mov ds, ax      ; load data segment

mov ax, 0x7E0
mov ss, ax      ; load stack segment with 0x07C00 + 512B = 07E00

mov sp, 0x2000  ; set sp = 0x2000 for an 8k stack

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



msg:    db "Assembly sure is cool innit", 0
