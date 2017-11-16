#include "main.h"
#include "types.h"
#include "heap.h"
#include "vsys.h"
#include "strings.h"

t_parametresHW *parametresHW;

void _main(){
    // *********************************************************************
    // INITIALIZATION
    // *********************************************************************

    u8 p = 0;
    asm volatile("movl %%ebx, %0":"=m"(p));
    parametresHW = (t_parametresHW *)p;
    maxmem = parametresHW->memorySize;
    maxmem = (maxmem*64+17472)*1024; // don`t know why

    // init serial
    init_serial();

    printk_syslog("VESA lfb: ");
    printk_syslog_numberInFormat(parametresHW->VBElfb, 'h', 8);
    printk_syslog("\n");

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

    // drivers
    if((parametresHW->bootDrive & 0x80) == 0x80){
        init_hdd(parametresHW->bootDrive);
    }

    init_vsys();

    init_syscall();

    init_task();

    init_objects();

    vnode_t *script;
    script = vfindnode("/etc/init");
    s1 *scriptdata = (s1*)kmalloc(script->length);
    vread(script, 0, script->length, scriptdata);

    u8 index=0;
    while( (strlen(scriptdata+index)>0) && (index<script->length) ){
        printk_syslog("Executing: '");
        printk_syslog(scriptdata+index);
        printk_syslog("'\n");
        exec(scriptdata+index);
        index+=strlen(scriptdata+index)+1;
    }
    kfree(script);
    kfree(scriptdata);

    show_tasks();
    show_objects();

#if DEBUG_LEVEL & E_NOTICE
    printk_syslog("Kernel initialized.\n");
    printk_syslog("--------------------------------------------------------------------------\n");
#endif // DEBUG_LEVEL

    HLT;


}
