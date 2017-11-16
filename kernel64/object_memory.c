#include "types.h"
#include "objects.h"
#include "task.h"
#include "heap.h"
#include "main.h"
#include "strings.h"

// heap data from USER_HEAP to USER_HEAP+USER_HEAP_SIZE
#define USER_HEAP   0x4000000
#define USER_HEAP_SIZE  0x1000000

u8 kfree_callback(GUID guid, u8 *params){
    u1 *some_var = params[2];
    u8 pointer_to_mem;
    if (some_var[0] == '$'){
        pointer_to_mem = obj_property_get_value_u8(guid, some_var+1);
    }else{
        pointer_to_mem = str2int(some_var);
    }

    kfree(pointer_to_mem);



}

u8 kmalloc_callback(GUID guid, u8 *params){

    u1 *some_var = params[2];
    u8 size;
    if (some_var[0] == '$'){
        size = obj_property_get_value_u8(guid, some_var+1);
    }else{
        size = str2int(some_var);
    }

    t_object *obj_c = obj_find(guid);
    if (!obj_c){
        printk_syslog(" OBJECT_MALLOC: object not found.\n");
        return -1;
    }

    u8 result = kmalloc(size);


#if DEBUG(E_NOTICE, ES_OBJECT_MEM)
    printk_syslog("OBJECT_MALLOC: User need ");
    printk_syslog_number(size,'d');
    printk_syslog(" bytes, give him at ");
    printk_syslog_numberInFormat(result,'h',16);
    printk_syslog("\n");
#endif

    return result;
}

u8 require_video_memory(GUID guid, u8 *params){
// 2 - memory start
// 3 - memory size
    u1 *sz = params[2];
    u8 start, size;
    if (sz[0] == '$'){
        size = obj_property_get_value_u8(guid, sz+1);
    }else{
        size = str2int(sz);
    }

    // get VBE LFB from startup data
    start = parametresHW->VBElfb;
    size = parametresHW->VBEResX * parametresHW->VBEResX * (parametresHW->VBEBPP / 8);
#if DEBUG(E_NOTICE, ES_OBJECT_MEM)
    printk_syslog("OBJECT_MALLOC: need video memory from: ");
    printk_syslog_numberInFormat(start,'h',8);
    printk_syslog(" size: ");
    printk_syslog_number(size,'h');
    printk_syslog("\n");
#endif

    // need to switch to kernel PD
    u8 old_pdir;
    // switch to kernel PD
    asm volatile("movq %%cr3, %0" : "=r" (old_pdir));
    asm volatile("movq %0, %%cr3" :: "r" (tasks->pdir));

    make_physical_sized(old_pdir, start, start, size, PS_VIDEO);

    // switch back to fault PD
    asm volatile("movq %0, %%cr3" :: "r" (old_pdir));

//    paging_print_pdir(tasks->pdir);

    return start;

}

void init_object_memory(){
}
