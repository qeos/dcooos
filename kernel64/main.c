#include "main.h"
#include "types.h"
#include "heap.h"

typedef struct{
    u4 bootDrive;
    u4 memorySize;
} __attribute__((packed)) t_parametresHW;

t_parametresHW *parametresHW;

void _main(){
    // *********************************************************************
    // INITIALIZATION
    // *********************************************************************

    u8 p;
    asm("movl %%ebx, %0":"=m"(p));
    parametresHW = (t_parametresHW *)p;
    maxmem = parametresHW->memorySize;
    maxmem = (maxmem*64+17472)*1024; // don`t know why

    // init serial
    init_serial();

#if DEBUG_LEVEL & E_NOTICE
    printk_syslog("--------------------------------------------------------------------------\n");
    printk_syslog("System boot up...\n\n");
    printk_syslog("Memory size: ");
    printk_syslog_number(maxmem/1024/1024, 'd');
    printk_syslog("Mb\n");
#endif // DEBUG_LEVEL

    init_time();

    init_idt();

    init_paging();

    init_heap();

    HLT;


}
