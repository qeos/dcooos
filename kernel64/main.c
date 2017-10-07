#include "main.h"
#include "types.h"

u1 bootDevice;

void _main(){
    // *********************************************************************
    // INITIALIZATION
    // *********************************************************************

    asm("movb %%dl, %0":"=r"(bootDevice));

    // init serial
    init_serial();

#if DEBUG_LEVEL & E_NOTICE
    printk_syslog("--------------------------------------------------------------------------\n");
    printk_syslog("System boot up...\n\n");
#endif // DEBUG_LEVEL

    init_time();

    init_idt();

    init_paging();

    init_heap();

    HLT;


}
