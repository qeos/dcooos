﻿
"D:\Program Files\qemu\qemu-system-x86_64.exe" ../hddimage/hddimage.bin -cpu Nehalem -m 2048 -chardev file,id=char0,path=serial.out -serial chardev:char0