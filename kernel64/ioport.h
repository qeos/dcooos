#ifndef IOPORT_H_INCLUDED
#define IOPORT_H_INCLUDED

u1 inb(u2 port);
u2 inw(u2 port);
u4 inl(u2 port);
void outb(u2 port, u1 data);
void outw(u2 port, u2 data);
void outl(u2 port, u4 data);

#endif // IOPORT_H_INCLUDED
