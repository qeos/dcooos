Base description
----------------

This is some realisation of kernel with some futures.
Kernel based on intel x64 architecture.


Sytem requirements for compilation
----------------------------------
For provide compiling a code you need to install some software:
Windows enviroment:
- FASM 1.71.39
- MinGW-w64 6.2.0 (how to setup CodeBlocks see http://yzhong.co/codeblock-compile-64-bit-under-windows-with-mingw-w64/)
    - GDB 7.10.1
- Cygwin GCC
    - NASM 2.10.05
    - GDB 7.10.1
- CodeBlocks 16.01
- VMWare 12.5.1
- QEMU https://qemu.weilnetz.de/w64/

not needed, but can have for some debuging processes:
- BOCHS 2.6.8 (install in "bochs" folder, not "bochs-2.6.8")


Compiling and running
---------------------
In CodeBlocks open workspace 'dcooos.workspace'
Compiling order is:
- zeroBootStage
- HDDImage