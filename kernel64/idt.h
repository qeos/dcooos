#ifndef IDT_H_INCLUDED
#define IDT_H_INCLUDED

typedef struct registers
{
   u8 ds;                  // Data segment selector
   u8 rdi, rsi, rbp, rsp, rbx, rdx, rcx, rax; // Pushed by pusha.
   u8 int_no, err_code;    // Interrupt number and error code (if applicable)
   u8 rip, cs, eflags, useresp, ss; // Pushed by the processor automatically.
} registers_t;

//void cli();
//void sti();
//
extern u8 clisti;

#define CLI clisti++;
#define STI clisti--;

#endif // IDT_H_INCLUDED
