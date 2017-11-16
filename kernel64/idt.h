#ifndef IDT_H_INCLUDED
#define IDT_H_INCLUDED

typedef struct registers
{
   u8 ds;                  // Data segment selector
   //u8 rdi, rsi, rbp, rsp, rbx, rdx, rcx, rax; // Pushed by pusha.
   u8 rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi; // Pushed by pusha.
   u8 int_no, err_code;    // Interrupt number and error code (if applicable)
   u8 rip, cs, eflags, useresp, ss; // Pushed by the processor automatically.
} registers_t;

typedef u8(*call_t)(registers_t*);


// A struct describing an interrupt gate.
struct idt_entry_struct
{
   u2 base_lo;             // The lower 16 bits of the address to jump to when this interrupt fires.
   u2 sel;                 // Kernel segment selector.
   u1 ist;                 // lowest 3 bit for IST index
   u1 flags;               // More flags. See documentation.
   u2 base_hi;             // The upper 16 bits of the address to jump to.
   u4 base_long;           // Highest 32 bits of address
   u4 reserved;
} __attribute__((packed));
typedef struct idt_entry_struct idt_entry_t;

// A struct describing a pointer to an array of interrupt handlers.
// This is in a format suitable for giving to 'lidt'.
struct idt_ptr_struct
{
   u8 limit;
   u8 base;                // The address of the first element in our idt_entry_t array.
} __attribute__((packed));
typedef struct idt_ptr_struct idt_ptr_t;


//void cli();
//void sti();
//
extern u8 clisti;

#define CLI clisti++;
#define STI clisti--;

//void register_interrupt_handler(u1 n, call_t handler);
void register_interrupt_handler(u1 n, pointer handler);

#endif // IDT_H_INCLUDED
