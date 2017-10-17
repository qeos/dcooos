    jmp loadKernel

%define KERNEL_CODE_BASE 0x25000
%define KERNEL_STACK_BASE 0x25000
%define ARC_KERNELSEG 0x5000
%define SB_SEG  0x0900
%define AT_SEG  0x1000

;**********************************************
;   MEMORY MAP
;
;   start        stop         length
;   0x00007c00 - 0x00007e00 - 0x200     - startup boot
;   0x00008000 - 0x00008200 - 0x200     - reallocated boot
;   0x00008200 - 0x00008400 - 0x200     - continued boot code
;
;   0x00009000 - 0x00009200 - 0x200     - super block
;   0x00010000 - 0x00020000 - 0x5a00    - allcation table
;   0x00020000 - 0x00025000 - 0x5000    - kernel stack
;   0x00025000 - 0x00050000 - 0x25000   - kernel code
;   0x00050000 - 0x00070000 - 0x20000   - acr kernel
;**********************************************

; -------------------------------------------------------
; welcome message
; -------------------------------------------------------
waitString db 'Loading',0

ww:
;    xchg bx, bx
    mov ah, 0x02
    int 0x1a
    push dx
wwloop:
    mov ah, 0x02
    int 0x1a
    pop ax
    push dx
    cmp ah, dh
    je wwloop
    pop dx
    ret

waitingFunction:
    mov si, waitString
waiting:
    mov ah, 0x0e
    mov bl, 0x47
    mov al, [si]
    int 0x10
    inc si
    cmp byte [si], 0
    jne waiting
    mov cx, 0x5
    push cx
wkey:
    mov ah, 0x0e
    mov bl, 0x47
    mov al, '.'
    int 0x10
    call ww
    pop cx
    dec cx
    cmp cx, 0
    je wquit
    push cx
    mov ah, 0x01
    int 0x16
    jz wkey
wquit:
    ret


; -------------------------------------------------------
; Init drive
; -------------------------------------------------------
errorString0 db 'bootStage1: Drive init failed.',0
errorString1 db 'bootStage1: INT13 not supported.',0

initDrive:
    mov cx, 0x0010
    mov si, errorString0
.reset:
    mov ah, 0        ; Reset drive
    mov dl, [bootDrive]
    int 13h          ;
    dec cx
    jz  fail
    jc .reset        ; Failed -> Try again

    ; check what we may
    mov ah, 0x41
    mov bx, 0x55aa
    mov dl, [bootDrive]
    int 0x13
    mov si, errorString1
    jc fail
    ret

; -------------------------------------------------------
; load sector in LBA mode
; -------------------------------------------------------
errorString2 db 'bootStage1: Loading error.',0

DAP     db 0x10 ; size of DAP
        db 0
        db 0x01 ; count of blocks
        db 0
DAP_seg dw 0x0000   ; offset
        dw 0x0000   ; segment
DAP_lba dw 0x0000
        dw 0x0000
        dw 0x0000
        dw 0x0000

; DX:CX:BX:AX - sector
; ES:SI - place

;00H последняя операция выполнена без ошибок
;01H плохая команда: неверный запрос к контроллеру
;02H плохая адресная марка
;03H защита записи: попытка записи на защищенную дискету
;04H ID сектора запорчен или не найден.
;05H ошибка сброса -- _AT_
;08H сбой DMA
;09H перекрытие DMA: попытка записи через 64K-байтовую границу.
;0bH встретился флаг плохой дорожки -- _AT_
;10H сбой CRC: несовпадение контрольной суммы данных.
;11H данные исправлены; исправимая ошибка; исправлено алгоритмом ECC -- _AT_
;20H сбой контроллера
;40H неудачный поиск. Запрошенная дорожка не найдена
;80H Таймаут. Устройство не ответило
;0bbH неопределенная ошибка -- _AT_
;0ffH сбой операции опроса (sense) -- _AT_

loadSector:
    push ax
    push bx
    push cx
    push dx
    push es
    push si
    mov [DAP_lba], ax
    mov [DAP_lba+2], bx
    mov [DAP_lba+4], cx
    mov [DAP_lba+6], dx
    mov [DAP_seg], si
    mov si, es
    mov [DAP_seg+2], si

    mov ah, 0x42
    mov dl, [bootDrive]
    mov si, DAP
    int 0x13
    mov si, errorString2
    jc fail
    pop si
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; -------------------------------------------------------
; MAIN
; -------------------------------------------------------
errorString3 db 'bootStage1: Bad FS.',0

loadKernel:

; -------------------------------------------------------
; Load a binary file off the disk
; -------------------------------------------------------
    call waitingFunction

; -------------------------------------------------------
; init drive
    call initDrive

; read params
    mov bx, SB_SEG
    mov es, bx
    mov si, 0x0000
    mov ax, [bootLength]
    mov bx, 0x0000
    mov cx, 0x0000
    mov dx, 0x0000
    call loadSector

; check
    mov si, SB_SEG
    mov es, si
    mov si, 0
    cmp word [es:si], 0xfcb0
    mov si, errorString3
    jne  fail

    jmp nearJump

; sign end of boot block
times 510-($-$$) db 0
dw 0AA55h

; -------------------------------------------------------
; load all sector in LBA mode for block
; -------------------------------------------------------
; DX:CX:BX:AX - sector
; ES:SI - place
loadBlock:
    call loadSector
    push ds
    mov di, AT_SEG
    mov ds, di
    mov di, ax
    imul di, 4
    mov ax, [ds:di]
    mov bx, [ds:di+2]
    pop ds
    mov di, es
    add di, 0x0020
    mov es, di
    cmp bx, 0xffff
    jne loadBlock
    cmp ax, 0xffff
    jne loadBlock
    ret

; -------------------------------------------------------
; parameters from real mode calls
; -------------------------------------------------------
parametresHW:
    .bootDrive dd 0
    .memorySize dd 0

nearJump:

    mov eax, 0xe801
    int 0x15
    mov [parametresHW.memorySize], ebx

; load allocation table

    mov si, SB_SEG
    mov es, si
    mov ax, [es:0x0e]
    mov bx, [es:0x0e+2]
    mov cx, 0x0000
    mov dx, 0x0000
    mov si, AT_SEG
    mov es, si
    mov si, 0x0000
    call loadBlock

; load kernel
    mov si, SB_SEG
    mov es, si
    mov ax, [es:0x1e]
    mov bx, [es:0x1e+2]
    mov cx, 0x0000
    mov dx, 0x0000
    mov si, ARC_KERNELSEG
    mov es, si
    mov si, 0x0000
    call loadBlock



; -------------------------------------------------------
; prepare paging     2-Mbyte Page Translation—Long Mode
; -------------------------------------------------------

; we need prepare size: MINIMAL_MEMORY = KERNEL_HEAP+KERNEL_HEAP_SIZE

    ; set PML4E
    mov edi, 0x1000
    mov cr3, edi
    xor eax, eax
    mov es, ax
    mov ds, ax
    mov ecx, 4096
    rep stosd
    mov edi, cr3

    ; PML4E
    mov DWORD [edi], 0x2003      ; Set the uint32_t at the destination index to 0x2003.
    add edi, 0x1000              ; Add 0x1000 to the destination index.
    ; PDPE
    mov DWORD [edi], 0x3003      ; Set the uint32_t at the destination index to 0x3003.
    add edi, 0x1000              ; Add 0x1000 to the destination index.
    ; PDE
;    mov DWORD [edi], 0x4003      ; Set the uint32_t at the destination index to 0x4003.
;
;    add edi, 8
;    mov DWORD [edi], 0x5003
;    add edi, 8
;    mov DWORD [edi], 0x6003
;    sub edi, 8
;
;    add edi, 0x1000              ; Add 0x1000 to the destination index.

    mov ebx, 0x00000083          ; Set the B-register to 0x00000003.
    mov ecx, 512                 ; Set the C-register to 512.

.SetEntry:
    mov DWORD [edi], ebx         ; Set the uint32_t at the destination index to the B-register.
    add ebx, 0x200000              ; Add 0x1000 to the B-register. because we use 2Mb pages
    add edi, 8                   ; Add eight to the destination index.
    loop .SetEntry               ; Set the next entry.

    ; restore ds
    mov eax, DEF_INITSEG
    mov ds, ax

; -------------------------------------------------------
; Goto protected mode
; -------------------------------------------------------

    ; enable A20
    in  al, 0x92
    or  al, 2
    out 0x92, al

    ; cli
    cli
    in  al, 0x70
    or  al, 0x80
    out 0x70, al

; set EFER
    mov ecx, 0xc0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

; PAE & PSE
    mov eax, cr4
    or ax, 1 << 5 | 1 << 4
    mov cr4, eax

; paging and protect
    mov eax, cr0
    or eax, 1 << 31 | 1 << 0
    mov cr0, eax

    lgdt [gdt.pointer]
    jmp gdt.code:do_pm+DEF_INITSEG*0x10

[BITS 64]    ; All code from now on will be 64-bit

do_pm:

    mov ax, gdt.data          ; Update the segment registers
    mov ds, ax                ; To complete the transfer to
    mov es, ax                ; 64-bit mode
    mov ss, ax
    xor rax, rax
    mov gs, ax
    mov fs, ax

    ; Update RSP
    mov rsp, KERNEL_STACK_BASE

    ; copy kernel to upper mem
    mov rsi, (ARC_KERNELSEG*0x10)
    xor rcx, rcx
    mov ecx, [rsi]
    mov rsi, ARC_KERNELSEG*0x10+4;
    mov rdi, KERNEL_CODE_BASE
    push rcx
    shr rcx, 2
    rep movsd
    pop rcx
    and rcx, 3
    rep movsb


; Execute the binary file that was loaded previously
; -------------------------------------------------------
    mov dl, [DEF_INITSEG*0x10+bootDrive]
    mov [DEF_INITSEG*0x10+parametresHW.bootDrive], dl
    mov ebx, DEF_INITSEG*0x10+parametresHW
    ; change for x64
    ;jmp gdt.code:KERNEL_CODE_BASE
    ;push word gdt.code
    ;push qword KERNEL_CODE_BASE
    ;lret
    jmp KERNEL_CODE_BASE - DEF_INITSEG*0x10


; -----------------------------------------------
;                      GDT
; -----------------------------------------------
gdt:
    .null
        times 8 db 0            ; NULL Descriptor

    .code equ  $-gdt
        dw 0            ; limit 15:0
        dw 0            ; base 15:0
        db 0            ; base 23:16
        db 0x9A         ; type = present, ring 0, code, non-conforming, readable
        db 0x20         ; long mode
        db 0            ; base 31:24

    .data equ  $-gdt
        dw 0            ; limit 15:0
        dw 0            ; base 15:0
        db 0            ; base 23:16
        db 0x92         ; type = present, ring 0, data, expand-up, writable
        db 0x20         ;
        db 0            ; base 31:24
    .pointer
        dw $ - gdt - 1
        dq gdt + DEF_INITSEG*0x10

times (($-$$)/512+1)*512-($-$$) db 0
