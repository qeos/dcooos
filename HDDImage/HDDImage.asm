start = $
;---------------------------------------------------
; boot loader
;---------------------------------------------------

file '../zeroBootStage/obj/bootStage0.o.bin'






; for vmware 102Mb
; use vmware-vdiskmanager.exe for create other size disk
db 102*1024*1024-0x1e000-($ - start) dup 0
