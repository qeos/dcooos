#ifndef MAIN_H_INCLUDED
#define MAIN_H_INCLUDED

#define true 1
#define false 0

// set level of debugging messages (php style)
#define E_ERROR     1
#define E_WARNING   2
#define E_NOTICE    4
#define E_ALL       E_ERROR | E_WARNING | E_NOTICE
#define DEBUG_LEVEL E_ALL


// HEAP
#define KERNEL_HEAP         0x1000000
#define KERNEL_HEAP_SIZE    0x2000000

#define MINIMAL_MEMORY      KERNEL_HEAP+KERNEL_HEAP_SIZE

//#define PAGE_SIZE 0x1000
#define PAGE_SIZE 0x200000

#define KERNEL_PML4E    0x200000

#define PS_NULL     0x00    // can use for any
#define PS_FREE     0x01    // can use for any
#define PS_KERNEL   0x02    // cant use
#define PS_USED     0x03    // used by any task
#define PS_USER     0x04
#define PS_VIDEO    0x05

#define PE_PRESENT         0x01
#define PE_WRITABLE        0x02
#define PE_USER            0x04
#define PE_WRITE_THROUTH   0x08
#define PE_CACHE_DISABLE   0x10
#define PE_ACCESSED        0x20
#define PE_DIRTY           0x40
#define PE_PAGE_SIZE_4M    0x80

#define HLT while(1){asm("hlt");};


#endif // MAIN_H_INCLUDED
