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


Setting up the CodeBlocks:
---------------------
1. Setup cross compiler
I put cross compiling utilites in D:\mingw64-sjlj. So we need add compiler setting in CodeBlocks.
I named it as "MinGW (x64)". Also programs need like this:
x86_64-w64-mingw32-gcc.exe
x86_64-w64-mingw32-g++.exe
x86_64-w64-mingw32-g++.exe
x86_64-w64-mingw32-gcc-ar.exe
windres.exe
mingw32-make.exe

2. Setup debugger
Add debuger named as "GDB 64 remote"
Where "Executable path" eq "D:\mingw64-sjlj\bin\gdb.exe"
Debugger initialization command is: "target remote localhost:1234"
And set "Do *not* run the debugee"
Set it as default in previous paragraph


Compiling and running
---------------------
In CodeBlocks open workspace 'dcooos.workspace'
Compiling order is:
- zeroBootStage
- HDDImage

Debugging
---------------------
now you can do this:
1. start QEMU from directory with "_start.cmd"
2. run debugging from CodeBlocks
3. after run debugging is stoped. you need continue with press 'c' in debugger window
