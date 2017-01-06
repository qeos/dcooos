;*********************************************
; for first iteration we use VM, so we have and been use VESA mode without check it
;*********************************************

%define BOOT_SEGMENT    0x07c0
%define DEF_INITSEG     0x0800

;**********************************************
;   MEMORY MAP
;
;   start        stop         length
;   0x00007c00 - 0x00007e00 - 0x200     - startup boot
;   0x00008000 - 0x00008200 - 0x200     - reallocated boot
;   0x00008200 - 0x00008400 - 0x200     - continued boot code
;**********************************************

[BITS 16]

bootstart:
    jmp startup

; --------------------------------------------
; we may put to that place some drive info
; --------------------------------------------
    Boot_ver    db 0x00
    Boot_ident  db "DCOOOS"
    Boot_length dw 0x01


errorstring db 'zeroBootStage: boot up normal',0
startup:
    mov ax,BOOT_SEGMENT
    mov ds,ax
    mov ax,DEF_INITSEG
    mov es,ax
    mov cx,256
    sub si,si
    sub di,di
    cld
    rep
    movsw
    jmp DEF_INITSEG:go

go:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x0000

    mov si, errorstring
fail:
    mov ah, 0x0e
    mov bl, 0x47
    mov al, [si]
    int 0x10
    inc si
    cmp byte [si], 0
    jne fail
    jmp $


; sign end of boot block
times 510-($-$$) db 0
dw 0AA55h
