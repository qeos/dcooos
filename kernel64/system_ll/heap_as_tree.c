#include "../types.h"
#include "../main.h"
#include "../heap.h"
#include "../idt.h"


#define HEAP_STATE_FREE 0x00
#define HEAP_STATE_USED 0x01

u8 HAT_current_heap_size;

typedef struct{
    u8 h[4];
    u1 state;
    u1 m;
    u2 reserved;
    u8 size;
    struct t_heap_rec *prev;
    struct t_heap_rec *next;
    u8 callbacks[4];
    u8 f[4];
} __attribute__((packed)) t_HAT_heap_rec;

u8 HAT_kmalloc_withoutlog(u8 len){

    t_HAT_heap_rec *rec = (t_HAT_heap_rec*)(KERNEL_HEAP);
    t_HAT_heap_rec *pn;
    while( (rec->state != HEAP_STATE_FREE) || (rec->size < len+sizeof(t_HAT_heap_rec))){
        if(rec->prev){
            pn = rec->prev;
            if(pn->next != rec){
                HLT;
            }
        }
        if(rec->next){
            pn = rec->next;
            if(pn->prev != rec){
                HLT;
            }
        }

        rec = (u8)rec + rec->size + sizeof(t_HAT_heap_rec);
        if((u8)rec >= KERNEL_HEAP+KERNEL_HEAP_SIZE){
            HLT;
        }
    }

    t_HAT_heap_rec *new_rec = (u8)rec + len + sizeof(t_HAT_heap_rec);
    CLI
    new_rec->state = HEAP_STATE_FREE;
    new_rec->size = rec->size - len - sizeof(t_HAT_heap_rec);
    new_rec->prev = rec;
    pn = rec->next;
    new_rec->next = pn;
    if(pn){
        pn->prev = new_rec;
    }

    rec->state = HEAP_STATE_USED;
    rec->size = len;
    rec->next = new_rec;

    HAT_current_heap_size -= len + sizeof(t_HAT_heap_rec);
    STI

    // -------------------------------------------
    // extended information
    u8 i;
    for(i=0;i<4;i++) rec->h[i]=-1;
    for(i=0;i<4;i++) rec->f[i]=-1;
    for(i=0;i<4;i++) new_rec->h[i]=0xcccccccccccccccc;
    for(i=0;i<4;i++) new_rec->f[i]=0xcccccccccccccccc;
    rec->callbacks[0] = __builtin_return_address(0);
    rec->callbacks[1] = __builtin_return_address(1);
    rec->callbacks[2] = __builtin_return_address(2);
    rec->callbacks[3] = __builtin_return_address(3);
    new_rec->reserved = 0;
    if(rec->reserved){
        new_rec->reserved = -1;
        rec->reserved = 0;
    }
    // -------------------------------------------

    u8 ptr = (u8)rec + sizeof(t_HAT_heap_rec);

    return ptr;

}

u8 HAT_kmalloc(u8 len){
    u8 ptr;
    ptr = HAT_kmalloc_withoutlog(len);

    return ptr;
}

static void HAT_join_free(){

    t_HAT_heap_rec *rec_last = (t_HAT_heap_rec*)(KERNEL_HEAP);
    t_HAT_heap_rec *rec = rec_last;
    t_HAT_heap_rec *pn;
    while ((u8)rec < KERNEL_HEAP+KERNEL_HEAP_SIZE){
        rec = (u8)rec_last + rec_last->size + sizeof(t_HAT_heap_rec);
        if((u8)rec >= KERNEL_HEAP+KERNEL_HEAP_SIZE){
            break;
        }
        if((rec->state == HEAP_STATE_FREE) && (rec_last->state == HEAP_STATE_FREE)){
            CLI
            rec_last->size = rec_last->size + rec->size + sizeof(t_HAT_heap_rec);
            pn = rec->next;
            rec_last->next = pn;
            if(pn){
                pn->prev = rec_last;
            }
            STI

            rec_last->m = 0x88;
            rec_last->reserved = 0;
            if(rec->reserved){
                rec_last->reserved = -1;
                rec->reserved = 0;
            }
            continue;
        }
        rec_last = rec;
    }

}

u8 HAT_get_free_heap_size(){
    t_HAT_heap_rec *rec = (t_HAT_heap_rec*)(KERNEL_HEAP);
    u8 size = 0;
    while ((u8)rec < KERNEL_HEAP+KERNEL_HEAP_SIZE){
        if(rec->state == HEAP_STATE_FREE)
            size += rec->size;
        rec = (u8)rec + rec->size + sizeof(t_HAT_heap_rec);
    }
    return size;
}

void HAT_kfree(u8 ptr){
    t_HAT_heap_rec *rec = (t_HAT_heap_rec*)(ptr - sizeof(t_HAT_heap_rec));

    CLI
    rec->state = HEAP_STATE_FREE;
    HAT_current_heap_size += rec->size + sizeof(t_HAT_heap_rec);
    STI

    HAT_join_free();
}

void HAT_heap_print(){
}

void HAT_heap_flush(){
}

void HAT_init_heap(){

    t_HAT_heap_rec *rec = (t_HAT_heap_rec*)(KERNEL_HEAP);
    rec->state = HEAP_STATE_FREE;
    rec->size = KERNEL_HEAP_SIZE-sizeof(t_HAT_heap_rec);
    rec->reserved = -1;
    rec->prev = 0;
    rec->next = 0;

    // debug/out
    HAT_current_heap_size = HAT_get_free_heap_size();

    printk_syslog("--------------------------------------------------------------------------\n");
    printk_syslog("System boot up...\n\n");

    printk_syslog("Found ");
    printk_syslog_number(maxmem/1024/1024, 'd');
    printk_syslog(" Mb of memory\n");
    printk_syslog("Free heap size: ");
    printk_syslog_number(HAT_current_heap_size/1024, 'd');
    printk_syslog(" Kb of heap\n");

    printk_syslog("HEAP init done.\n");
}
