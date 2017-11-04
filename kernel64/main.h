#ifndef MAIN_H_INCLUDED
#define MAIN_H_INCLUDED

#include "types.h"

#define true 1
#define false 0

// set level of debugging messages (php style)
#define E_ERROR     1
#define E_WARNING   2
#define E_NOTICE    4
#define E_ALL       (E_ERROR | E_WARNING | E_NOTICE)
#define DEBUG_LEVEL E_ALL

#define ES_IDT          0x0001
#define ES_HEAP         0x0002
#define ES_PAGING       0x0004
#define ES_HDD          0x0008
#define ES_VSYS         0x0010
#define ES_L3FS         0x0020
#define ES_FILEFORMATS  0x0040
#define ES_TASK         0x0080
#define ES_OBJECTS      0x0100
#define ES_OBJECT_MEM   0x0200
#define ES_SYSCALL      0x1000
#define DEBUG_SYSTEMS   (ES_HEAP | ES_PAGING | ES_FILEFORMATS | ES_TASK | ES_OBJECTS | ES_OBJECT_MEM | ES_SYSCALL)

//#define DEBUG(level)   (DEBUG_LEVEL & level == level)
//#define DEBUG(level, system)   ((DEBUG_LEVEL && level == level) && (DEBUG_SYSTEMS && system == system))
#define DEBUG(level, system)   (DEBUG_LEVEL & level) && (DEBUG_SYSTEMS & system)

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

//#define HLT while(1){asm("hlt");};
#define HLT while(1){;};

typedef struct{
    u4 bootDrive;
    u4 memorySize;
    u4 VBElfb;
} __attribute__((packed)) t_parametresHW;

t_parametresHW *parametresHW;

#endif // MAIN_H_INCLUDED
