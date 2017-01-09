
rem set pp=d:\WORK\BUILD\OS\dcooos\BOCHSImage\
set pp=..\BOCHSImage\

start d:\"Program files (x86)"\Bochs\bochsdbg.exe -q -f %pp%\bochsrc.bxrc -rc %pp%\bochsrc.dbgrc
