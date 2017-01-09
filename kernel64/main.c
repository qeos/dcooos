#include "types.h"
#include "serial.h"

u1 bootDevice;

void _main(){
    // *********************************************************************
    // INITIALIZATION
    // *********************************************************************

    asm("movb %%dl, %0":"=r"(bootDevice));

    // init serial
    init_serial();

    char *s = "Hello world from kernel under x64";
    do{
        serial_out(*s++);
    }while(*s != 0);

    while(1==1);


}
