#include "../types.h"
#include "../main.h"
#include "../idt.h"
#include "../task.h"
#include "../heap.h"

u4 kernel_size;

#define PAGING_SPACE 0x10000000

struct memrec{
    u8 *pdir;
    u8 state;
} __attribute__((packed));
typedef struct memrec memrec_t;

memrec_t *memorymap;

u8 *get_free_page_notmarked(u8 *pdir, u8 init_addr){
    u8 index = init_addr / PAGE_SIZE;
    while(memorymap[index].state != PS_FREE){
        index++;
        if (index > maxmem /PAGE_SIZE){
            printk_syslog_number("PAGING: No free mem pages. We need caching.\n");
            show_map();
            current_task->state = TS_CRASH;
            HLT;
        }
    }
    return index;
}

u8 *get_free_page(u8 *pdir, u8 init_addr){
    u8 mempos = get_free_page_notmarked(pdir, init_addr);

    make_physical(pdir, init_addr, mempos*PAGE_SIZE, PS_USED);

    return mempos*PAGE_SIZE;
}

void mark_memory_page(u8 *pdir, u8 paddr_index, u1 state){
    if((state == PS_FREE) || (memorymap[paddr_index].state == PS_NULL) || (memorymap[paddr_index].state == PS_FREE)){
        memorymap[paddr_index].pdir = pdir;
        memorymap[paddr_index].state = state;
    }else{
        printk_syslog("PAGING: Used page for address ");
        printk_syslog_number(paddr_index*PAGE_SIZE,'h');
        printk_syslog(" in memorymap[");
        printk_syslog_number(paddr_index,'h');
        printk_syslog("] = { state:");
        switch(memorymap[paddr_index].state){
            case PS_FREE:   printk_syslog("PS_FREE");    break;
            case PS_KERNEL: printk_syslog("PS_KERNEL");  break;
            case PS_NULL:   printk_syslog("PS_NULL");    break;
            case PS_USED:   printk_syslog("PS_USED");    break;
            case PS_USER:   printk_syslog("PS_USER");    break;
            case PS_VIDEO:  printk_syslog("PS_VIDEO");   break;
        }
        printk_syslog(" = ");
        printk_syslog_number(memorymap[paddr_index].state,'h');
        printk_syslog(", pdir:");
        printk_syslog_number(memorymap[paddr_index].pdir,'h');
        printk_syslog("}\n");

//        current_task->state = TS_CRASH;

        HLT;
    }
}

u8 *copy_pdir(){
    u8 *current_pdir = current_task->pdir;

    // make page directory for owner PD
    u8 dst_pdir_index = get_free_page_notmarked(current_pdir,0);
    u8 *dst_pdir = dst_pdir_index * PAGE_SIZE;
    mark_memory_page(dst_pdir, dst_pdir_index, PS_USED);
    memcpy(dst_pdir, current_pdir, PAGE_SIZE);
    u8 i;
    for(i=0; i<PAGE_SIZE/4; i++){
        u8 ptable_index = get_free_page_notmarked(current_pdir,0);
        u8 *ptable = ptable_index * PAGE_SIZE;
        mark_memory_page(ptable, ptable_index, PS_USED);
        memcpy(ptable, (current_pdir[i] & 0xfffff000), PAGE_SIZE);

        dst_pdir[i] = ((u8)ptable & 0xfffff000) | (dst_pdir[i] & 0xfff);
    }

    return dst_pdir;
}

void paging_callback(registers_t *reg){
    u8 cr2, cr3;
    asm("movq %%cr2, %0":"=r"(cr2));    // access address / page fault linear address
    asm("movq %%cr3, %0":"=r"(cr3));    // page directory

    // switch to kernel PD
    asm("movq %0, %%cr3" :: "r" (tasks->pdir));

    if((cr2 < maxmem) && (memorymap[cr2/PAGE_SIZE].state == PS_FREE)){
        make_physical(cr3, cr2, cr2, PS_USED);
    }else if(memorymap[cr2/PAGE_SIZE].state == PS_VIDEO){
        make_physical(cr3, cr2, cr2, PS_VIDEO);
        paging_print_pdir(current_task->pdir);
    }else{
        u8 phisical = get_free_page(cr3,0);
    }
    // switch back to fault PD
    asm("movq %0, %%cr3" :: "r" (cr3));
    return;

}

void make_physical(u8 *pdir, u8 log_addr, u8 phys_addr, u1 need_markup){
    if (need_markup != 0){
        mark_memory_page(pdir, phys_addr/PAGE_SIZE, need_markup);
    }
    u8 *ptab;
    if (pdir[(log_addr >> 22)] == 0){
        // if absentee then create element in
        ptab = get_free_page(pdir, KERNEL_PT);
        pdir[(log_addr >> 22)] = (u8*)(((u8)ptab & 0xfffffc00) | PE_PRESENT | PE_WRITABLE);
    }else{
        ptab = (u8*)(pdir[(log_addr >> 22)] & 0xfffffc00);
    }
    ptab[(log_addr >> 12) & 0x3ff] = (phys_addr & 0xfffffc00) | PE_PRESENT | PE_WRITABLE;

}

void make_physical_sized(u8 *pdir, u8 log_addr, u8 phys_addr, u8 size_addr, u1 need_markup){
    u8 pmemblock = phys_addr;
    u8 memblock = log_addr; // -page_size becose we need stack
    while (memblock < log_addr + size_addr){
        make_physical(pdir, memblock, pmemblock, need_markup);
        memblock += PAGE_SIZE;
        pmemblock += PAGE_SIZE;
    }
}

void show_map(){
    u8 i,j = 0;
    printk_syslog("PAGING: show memory map size: ");
    printk_syslog_number(maxmem, 'h');
    printk_syslog("\n");
    while (j<maxmem/2){
        printk_syslog_number(j,'h',8);
        printk_syslog(" ");
        for (i=0; i<0x60; i++){
            if (memorymap[j/PAGE_SIZE+i].state == PS_FREE)
                printk_syslog(".");
            else if (memorymap[j/PAGE_SIZE+i].state == PS_USED)
                printk_syslog("*");
            else if (memorymap[j/PAGE_SIZE+i].state == PS_KERNEL)
                printk_syslog("K");
            else if (memorymap[j/PAGE_SIZE+i].state == PS_USER)
                printk_syslog("u");
            else if (memorymap[j/PAGE_SIZE+i].state == PS_VIDEO)
                printk_syslog("@");
            else
                printk_syslog("?");

        }
        printk_syslog("\n");
        j=j+0x60*PAGE_SIZE;
    }
}

#define PTE_PRESENT 0x01
#define PTE_DIRTY   0x40
#define PTE_ACCESSED 0x20

void paging_print_pdir(u8 *pdir){
    printk_syslog("Page directory at: ");
    printk_syslog_number(pdir, 'h');
    printk_syslog("\n");
    u8 i,j;
    u8 *ptable = pdir[0] & 0xfffff000;
    u8 from_addr = 0;
    u8 to_addr = 0;
    u8 state = 3;
    for(i=0;i<PAGE_SIZE/4;i++){//0x10000){
        ptable = pdir[i] & 0xfffff000;
        if(pdir[i] & PE_PRESENT == PE_PRESENT){
            for(j=0;j<PAGE_SIZE/4;j++){
                if((ptable[j] & 0xfff) != state){
                    printk_syslog("From ");
                    printk_syslog_number(from_addr, 'h', 8);
                    printk_syslog(" to ");
                    printk_syslog_number(to_addr, 'h', 8);
                    printk_syslog(" flags ");
                    printk_syslog_number(state, 'b', 8);
                    printk_syslog(" \n");
                    state = ptable[j] & 0xfff;
                    from_addr = ptable[j] & 0xfffff000;
                }
                to_addr = ptable[j] & 0xfffff000;
            }
        }else{
            if((pdir[i] & 0xfff) != state){
                printk_syslog("From ");
                printk_syslog_number(from_addr, 'h', 8);
                printk_syslog(" to ");
                printk_syslog_number(to_addr, 'h', 8);
                printk_syslog(" flags ");
                printk_syslog_number(state, 'b', 8);
                printk_syslog(" \n");
                state = pdir[i] & 0xfff;
                from_addr = PAGE_SIZE/4*i*PAGE_SIZE;
            }
            to_addr = PAGE_SIZE/4*(i+1)*PAGE_SIZE-PAGE_SIZE;
        }
    }
    printk_syslog("From ");
    printk_syslog_number(from_addr, 'h', 8);
    printk_syslog(" to ");
    printk_syslog_number(to_addr, 'h', 8);
    printk_syslog(" flags ");
    printk_syslog_number(state, 'b', 8);
    printk_syslog(" \n");
}

void show_markup(u8 *pdir){
    u8 i,j,k;
    u8 *ptab;
    for (j=0; j<1024; j++){
        if ((pdir[j] & PTE_PRESENT) == PTE_PRESENT){
            if ((pdir[j] & PTE_ACCESSED) == PTE_ACCESSED){
                ptab = (u8*)(pdir[j] & 0xfffffc00);
                printk_syslog("PD index ");
                printk_syslog_number(j,'d');
                printk_syslog(" accesed (");
                printk_syslog_numberInFormat(ptab,'h',8);
                printk_syslog(")\n\t   0\t\t   1\t\t   2\t\t   3\t\t   4\t\t   5");
                for (i=0; i<1024; i++){
                    if((i%0x60)==0){
                        printk_syslog("\n");
                        printk_syslog_numberInFormat((i+j*0x400)*0x1000,'h',8);
                        printk_syslog(" ");
                    }
                    if((ptab[i] & PTE_ACCESSED) == PTE_ACCESSED){
                        printk_syslog("*");
                    }else{
                        printk_syslog(".");
                    }
                }
                printk_syslog("\n");
            }
        }
    }
}

void make_user_area(u8 *pdir, u8 user_space_addr, u8 user_space_size){
    u8 *ptab;
    u8 i, pdi, pti;
    // copy
    for (i=0; i<-1/PAGE_SIZE; i++){
        if(memorymap[i].state == PS_KERNEL){
            pdi = i >> 10;
            if((pdir[pdi] & PTE_PRESENT) != PTE_PRESENT){
                ptab = get_free_page(pdir,0);
                memset(ptab, 0, PAGE_SIZE);
                pdir[pdi] = (((u8)ptab) & 0xfffffc00) | PTE_PRESENT;
            }
            ptab = pdir[pdi] & 0xfffffc00;
            pti = i & 0x3ff;
            ptab[pti] = (i*PAGE_SIZE) | PTE_PRESENT;
        }
    }

    for (i=0; i<(user_space_size/PAGE_SIZE)+1; i++){
        pdi = (user_space_addr/PAGE_SIZE + i) >> 10;
        if((pdir[pdi] & PTE_PRESENT) != PTE_PRESENT){
            ptab = get_free_page(pdir,0);
            memset(ptab, 0, PAGE_SIZE);
            pdir[pdi] = (((u8)ptab) & 0xfffffc00) | PTE_PRESENT;
        }
        ptab = pdir[pdi] & 0xfffffc00;
        pti = (user_space_addr/PAGE_SIZE + i) & 0x3ff;
        ptab[pti] = (((u4)get_free_page(pdir,0)) & 0xfffffc00) | PTE_PRESENT;
    }
}

u8 *make_user_pd(){
    u8 *pdir = get_free_page(0,0);
    memset(pdir, 0, PAGE_SIZE);
    return pdir;
}

void init_paging(){

    register_interrupt_handler(14, &paging_callback);

    // create memory table
    u4 size_pd = 0xffffffff/PAGE_SIZE+1;
    memorymap = (memrec_t*)kmalloc(sizeof(memrec_t)*size_pd);
    memset(*memorymap, 0, sizeof(memrec_t)*size_pd);

    // set all memory as flat for kernal
    u8 i, j;
    u8 line_addr = 0;
    u8 *pdir = (u8*)KERNEL_PD;
    u8 *ptab = (u8*)KERNEL_PT;
    memset(pdir, 0, 0x1000);
    u8 ptab_size = 0;
    while(line_addr < maxmem){
        ptab_size++;
        u8 page_index = line_addr >> 22;
        pdir[page_index] = (u8*)((u8)ptab & 0xfffffc00 | PE_PRESENT | PE_WRITABLE);
        for(j=0; j<PAGE_SIZE/4; j++){
            ptab[j] = (u8*)((u8)line_addr & 0xfffffc00 | PE_PRESENT | PE_WRITABLE);
            mark_memory_page(pdir, line_addr/PAGE_SIZE, PS_FREE);
            line_addr = line_addr + PAGE_SIZE;
        }
        ptab=(u8*)((u8)ptab + PAGE_SIZE);
    }

    // low mem (00000000 - 000d0000)
    for(i=0; i<0xd0000/PAGE_SIZE; i++) memorymap[i].state = PS_KERNEL;
    // unknown VMWare uses (000d0000 - 00100000)
    for(i=0xd0000/PAGE_SIZE; i<0x100000/PAGE_SIZE; i++) memorymap[i].state = PS_KERNEL;
    // heap (01000000 - 02000000)
    for(i=KERNEL_HEAP/PAGE_SIZE; i<(KERNEL_HEAP+KERNEL_HEAP_SIZE)/PAGE_SIZE; i++) memorymap[i].state = PS_KERNEL;
    // page directory (00200000 - 00201000)
    for(i=KERNEL_PD/PAGE_SIZE; i<KERNEL_PD/PAGE_SIZE+1; i++) memorymap[i].state = PS_KERNEL;
    // page table (00201000 - 00601000)
    for(i=KERNEL_PT/PAGE_SIZE; i<KERNEL_PT/PAGE_SIZE+ptab_size; i++) memorymap[i].state = PS_KERNEL;

    // set video memory
    //make_physical(KERNEL_PD, init_data.vba_lfb_address, init_data.vba_lfb_address, PS_VIDEO);

    asm("movq %0, %%cr3" :: "r" ((u8)KERNEL_PD));
    asm("movq %cr0, %rax\n\t"
        "orl $0x80000000, %eax\n\t"
        "movq %rax, %cr0");

    printk_syslog("PAGING init: done.\n");
}