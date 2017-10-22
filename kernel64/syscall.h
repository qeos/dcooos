#ifndef SYSCALL_H_INCLUDED
#define SYSCALL_H_INCLUDED

u8 syscall(void *object, char *func);
u8 syscall(void *object, char *func){
    u8 ret;
    asm("int $0x80":"=a" (ret):"a"(object), "b"(func));
    return ret;
}

#endif // SYSCALL_H_INCLUDED
