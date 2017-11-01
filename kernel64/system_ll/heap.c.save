#include "../main.h"
#include "../types.h"
#include "../heap.h"

u8 kmalloc_aligned(u8 len, u8 align){

#ifdef HEAP_MOD_HAT
    return HAT_kmalloc(len, align);
#endif // HEAP_MOD_HAT

#ifdef HEAP_MOD_HAA
    return HAA_kmalloc(len, align);
#endif // HEAP_MOD_HAA

}

u8 kmalloc(u8 len){

    return kmalloc_aligned(len, 0);

}

void kfree(u8 ptr){

#ifdef HEAP_MOD_HAT
    HAT_kfree(ptr);
#endif // HEAP_MOD_HAT

#ifdef HEAP_MOD_HAA
    HAA_kfree(ptr);
#endif // HEAP_MOD_HAA

}

u8 get_free_heap_size(){

#ifdef HEAP_MOD_HAT
    return HAT_get_free_heap_size();
#endif // HEAP_MOD_HAT

#ifdef HEAP_MOD_HAA
    return HAA_get_free_heap_size();
#endif // HEAP_MOD_HAA

}

void heap_print(){

#ifdef HEAP_MOD_HAT
    HAT_heap_print();
#endif // HEAP_MOD_HAT

#ifdef HEAP_MOD_HAA
    HAA_heap_print();
#endif // HEAP_MOD_HAA

}

void heap_init(){
#ifdef HEAP_MOD_HAT
    HAT_init_heap();
#endif // HEAP_MOD_HAT

#ifdef HEAP_MOD_HAA
    HAA_init_heap();
#endif // HEAP_MOD_HAA
}

void init_heap(){

//    maxmem = get_max_mem();

    heap_init();

    printk_syslog("Found ");
    printk_syslog_number(maxmem/1024/1024, 'd');
    printk_syslog(" Mb of memory\n");

    printk_syslog("Free heap size: ");
    u8 free_heap = get_free_heap_size();
    if(free_heap/1024/1024 == 0){
        printk_syslog_number(free_heap/1024, 'd');
        printk_syslog(" Kbytes\n");
    }else{
        printk_syslog_number(free_heap/1024/1024, 'd');
        printk_syslog(" Mbytes\n");
    }

    printk_syslog("HEAP init done.\n");

}

