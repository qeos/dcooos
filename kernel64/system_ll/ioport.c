#include "../types.h"

u1 inb(u2 port){
    u1 data;
    asm volatile("inb (%w1)" :"=a" (data):"Nd" (port));
    return data;
}
u2 inw(u2 port){
    unsigned short data;
    asm volatile("inw (%w1)" :"=a" (data):"Nd" (port));
    return data;
}
u4 inl(u2 port){
    unsigned short data;
    asm volatile("inl (%w1)" :"=a" (data):"Nd" (port));
    return data;
}
void outb(u2 port, u1 data){
    asm volatile("outb (%w1)" : : "a" (data), "dN" (port));
}
void outw(u2 port, u2 data){
    asm volatile("outw (%w1)" : : "a" (data), "dN" (port));
}
void outl(u2 port, u4 data){
    asm volatile("outl (%w1)" : : "a" (data), "dN" (port));
}

