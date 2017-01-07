
set pp=d:\WORK\BUILD\OS\dcooos\BOCHSImage\

d:
cd "\Program files (x86)\Bochs\" 
start bochsdbg -q -f %pp%\bochsrc.bxrc -rc %pp%\bochsrc.dbgrc
