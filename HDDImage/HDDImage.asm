start = $

;!!! this file has some macros aligned to 512 byte of block, this need to refactoring

macro frame nn, [pframe]{
    common local Sector, LenSectors
        label nn
        Sector = $ / 512 + 1
        LenSectors = 0

    forward
        rb Sector * 512 - $
        .Pos = $ / 512
        Pos = $

        dd @F - $ - 4

;       file pframe
    pframe
        .Len = ($ - Pos) / 512 +1
@@:
        Len = $ - Sector * 512
        LenSectors = Len / 512 + 1
        Sector = Sector + LenSectors
}

; =======================================================================
;!! boot loader !!;
;////////////////////////////////////////////////////////////////////////////////
boot_start = $

    file '../zeroBootStage/obj/bootStage0.o.bin'

boot_len = $-boot_start
boot_secs = boot_len / 512
;////////////////////////////////////////////////////////////////////////////////

FDDTotalBlocks = 2880
FreeBlockID = 0x8888

; =======================================================================
;!! Super block !!;

    sbSIG dd 0xFCB0

  sbTotalBlocks dd FDDTotalBlocks
; 1 - 512 bytes
; 2 - 1024 bytes
; n - 512*n bytes
  sbBlockSize dd 0

  sbAllocationTableSize dd ATLen
  sbAllocationTable dd ATable / 512

  RootDescr dd RDsSector.Pos
  RootData  dd RDaSector.Pos
  RootCache dd 0
;  RootCache dd RCaSector.Pos

    SecondStageLoader dd KFDaSector.Pos
    SecondStageLoaderSize dd KFDaSector.Len

rb boot_len + 512 - $

;!! =======================================================================
;!! allocation_table !!;
;это карта занятости и расположения занятых блоков.
;каждый указывает на следующий блок.
;если значение -1, то дальше ничего нет (последний занятый блок).
;если значение 0, то блок свободен для записи.

macro SetLenContAT start,len{
  repeat len-1
    dd start+%
  end repeat
  dd -1
}

ATable:

; boot block
    SetLenContAT 0, boot_secs
; SB
    SetLenContAT boot_secs, 1
; Allocation table
    SetLenContAT boot_secs+1, ATLenSectors

; /
    SetLenContAT RDsSector.Pos, RDsSector.Len
    SetLenContAT RDaSector.Pos, RDaSector.Len

; /kernel
  SetLenContAT KFDsSector.Pos, KFDsSector.Len
  SetLenContAT KFDaSector.Pos, KFDaSector.Len

; unused space

ATTLen = $ - (boot_len + 512)

  FreeBlocks  dd FDDTotalBlocks-ATTLen/4 dup FreeBlockID;0x88888888


ATLen = $ - (boot_len + 512)
ATLenSectors = ATLen / 512 + 1

;!! =======================================================================
;!! Root directory !!;
;!! /

macro sRDsSector{
    db 'Name = root',0
    db 'Type = Directory',0
}
    frame RDsSector, sRDsSector

macro sRDaSector{
;kernel
  dd KFDsSector.Pos
  dd KFDaSector.Pos
  dd 0
}
    frame RDaSector, sRDaSector


; =======================================================================
;!! Kernel file !!;
;!! /kernel

macro sKFDsSector{
    db 'Description = OS kernel',0
    db 'Type = CBC',0
    db 'TypeDescription = compiled binary code',0
    db 'Name = kernel',0
}
frame KFDsSector, sKFDsSector
frame KFDaSector, file '..\kernel64\bin\kernel64.bin'























; for vmware 102Mb
; use vmware-vdiskmanager.exe for create other size disk
db 102*1024*1024-0x1e000-($ - start) dup 0
