#ifndef HEAP_H_INCLUDED
#define HEAP_H_INCLUDED

/*

    HAT - heap_as_tree.c
    HAA - heap_as_array.c

*/

//#define HEAP_MOD_HAT
#define HEAP_MOD_HAA

extern u8 maxmem;

pointer kmalloc_aligned(u8 len, u8 align);
pointer kmalloc(u8 len);
void kfree(pointer ptr);
u8 get_free_heap_size();
void heap_print();
void heap_init();
void init_heap();


#endif // HEAP_H_INCLUDED
