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

bootStart:
    jmp startup

; --------------------------------------------
; we may put to that place some drive info
; --------------------------------------------
    bootVersion db 0x00         ; reserved for futures
    bootIdent   db "DCOOOS   v1.0"
    ; we need align next var to offset 0x10
    ; else see 'l3fs.c' in func 'init_l3fs()'
    bootLength  dw lenBlocks
; --------------------------------------------
; this boot variables
; --------------------------------------------
    bootDrive   db 0


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

; if we has error
errorString db 'bootStage0: Error loading stage 1.',0
fail:
    mov ah, 0x0e
    mov bl, 0x47
    mov al, [si]
    int 0x10
    inc si
    cmp byte [si], 0
    jne fail
    jmp $

go:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x0000

    ; save boot drive
    mov [bootDrive], dl
    ; correct boot length
    mov ax, [bootLength]
    shr ax, 9
    mov [bootLength], ax

    ; load
    mov ax, [bootLength]
    dec ax
    mov ah, 0x02
    mov bx, DEF_INITSEG
    mov es, bx
    mov bx, 0x0200
    mov cx, 0x0002
    mov dh, 0x00
    mov dl, [bootDrive]
    int 0x13
    mov si, errorString
    jc fail

%include "bootStage1.asm"
