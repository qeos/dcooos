#ifndef PAGING_H_INCLUDED
#define PAGING_H_INCLUDED

#define PTE_PRESENT 0x01
#define PTE_DIRTY   0x40
#define PTE_ACCESSED 0x20

#define PAGING_SPACE 0x10000000
#define PAGING_TABLE_RECORDS 512
#define PAGING_TABLE_SIZE PAGING_TABLE_RECORDS * 8
#define PAGING_ADDR_MASK 0xfffffffffffffc00

struct memrec{
    u8 *pdir;
    u8 state;
} __attribute__((packed));
typedef struct memrec memrec_t;

extern u1 paging_initialized;
extern memrec_t *memorymap;


#endif // PAGING_H_INCLUDED
