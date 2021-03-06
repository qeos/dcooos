#include "../types.h"
#include "../idt.h"
#include "../main.h"
#include "../task.h"

call_t interrupt_handlers[256];

u8 clisti = 0;

// made it statical
idt_entry_t idt_entries[256];
idt_ptr_t   idt_ptr;

// These extern directives let us access the addresses of our ASM ISR handlers.
extern void isr0 ();
extern void isr1 ();
extern void isr2 ();
extern void isr3 ();
extern void isr4 ();
extern void isr5 ();
extern void isr6 ();
extern void isr7 ();
extern void isr8 ();
extern void isr9 ();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();
extern void isr128();
extern void irq0 ();
extern void irq1 ();
extern void irq2 ();
extern void irq3 ();
extern void irq4 ();
extern void irq5 ();
extern void irq6 ();
extern void irq7 ();
extern void irq8 ();
extern void irq9 ();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();

extern void isr_common_stub();
extern void irq_common_stub();

// ******************************************************************************************************************************

//void register_interrupt_handler(u1 n, call_t handler)
void register_interrupt_handler(u1 n, pointer handler)
{
    interrupt_handlers[n] = handler;
}

// This gets called from our ASM interrupt handler stub.
void isr_handler(registers_t regs)
{
#if DEBUG(E_NOTICE, ES_IDT)
    printk_syslog_timestamp();
    printk_syslog("isr interrupt: 0x");
    printk_syslog_number(regs.int_no,'h');
    printk_syslog("\n");
#endif // DEBUG_LEVEL

    // This line is important. When the processor extends the 8-bit interrupt number
    // to a 32bit value, it sign-extends, not zero extends. So if the most significant
    // bit (0x80) is set, regs.int_no will be very large (about 0xffffff80).
    u1 int_no = regs.int_no & 0xFF;
    if (interrupt_handlers[int_no] != 0)
    {
        call_t handler = interrupt_handlers[int_no];
        handler(&regs);
    }
    else
    {
#if DEBUG_LEVEL & E_NOTICE
        printk_syslog_timestamp();
        printk_syslog("unhandled interrupt: ");
        printk_syslog_number(int_no,'d');
        printk_syslog("\n");
        idt_dump_state(regs);
#endif // DEBUG_LEVEL
        current_task->state = TS_CRASH;
        HLT;
    }
}

// This gets called from our ASM interrupt handler stub.
void irq_handler(registers_t regs)
{
#if DEBUG(E_NOTICE, ES_IDT)
    if (regs.int_no != 32){
        printk_syslog_timestamp();
        printk_syslog("irq interrupt: ");
        printk_syslog_number(regs.int_no,'d');
        printk_syslog("\n");
    }
#endif

    // Send an EOI (end of interrupt) signal to the PICs.
    // If this interrupt involved the slave.
    if (regs.int_no >= 40)
    {
        // Send reset signal to slave.
        outb(0xA0, 0x20);
    }
    // Send reset signal to master. (As well as slave, if necessary).
    outb(0x20, 0x20);

    if (interrupt_handlers[regs.int_no] != 0)
    {
        call_t handler = interrupt_handlers[regs.int_no];
        handler(&regs);
    }

}

void idt_dump_state(registers_t *regs){
    printk_syslog("Dump state registers:\n");
    printk_syslog("RAX: "); printk_syslog_numberInFormat(regs->rax, 'h', 16); printk_syslog("\t");
    printk_syslog("RBX: "); printk_syslog_numberInFormat(regs->rbx, 'h', 16); printk_syslog("\t");
    printk_syslog("RCX: "); printk_syslog_numberInFormat(regs->rcx, 'h', 16); printk_syslog("\t");
    printk_syslog("RDX: "); printk_syslog_numberInFormat(regs->rdx, 'h', 16); printk_syslog("\r");

    printk_syslog("RSI: "); printk_syslog_numberInFormat(regs->rsi, 'h', 16); printk_syslog("\t");
    printk_syslog("RDI: "); printk_syslog_numberInFormat(regs->rdi, 'h', 16); printk_syslog("\t");
    printk_syslog("RBP: "); printk_syslog_numberInFormat(regs->rbp, 'h', 16); printk_syslog("\t");
    printk_syslog("RSP: "); printk_syslog_numberInFormat(regs->rsp, 'h', 16); printk_syslog("\r");

    printk_syslog("CS:  "); printk_syslog_numberInFormat(regs->cs, 'h', 4); printk_syslog("\t");
    printk_syslog("DS:  "); printk_syslog_numberInFormat(regs->ds, 'h', 4); printk_syslog("\t");
    printk_syslog("SS:  "); printk_syslog_numberInFormat(regs->ss, 'h', 4); printk_syslog("\r");

    printk_syslog("IP: "); printk_syslog_numberInFormat(regs->rip, 'h', 16); printk_syslog("\t");
    printk_syslog("INT:  "); printk_syslog_numberInFormat(regs->int_no, 'h', 16); printk_syslog("\t");
    printk_syslog("ERROR:  "); printk_syslog_numberInFormat(regs->err_code, 'h', 16); printk_syslog("\t");
    printk_syslog("EFLAGS:  "); printk_syslog_numberInFormat(regs->eflags, 'h', 16); printk_syslog("\r");
}

static void idt_set_gate(u1 num, u8 base, u2 sel, u1 flags)
{
    idt_entries[num].base_lo   = base & 0xFFFF;
    idt_entries[num].base_hi   = (base >> 16) & 0xFFFF;
    idt_entries[num].base_long = (base >> 32) & 0xFFFFFFFF;

    idt_entries[num].sel    = sel;
    idt_entries[num].ist    = 0;
    idt_entries[num].flags  = flags ;//| 0x60;
}

static void idt_flush(u8 idr_ptr){
    asm volatile("lidt %0" :: "m" (idt_ptr));
}

void init_idt(){
    // strange, but 'packet' not worked as we need
    idt_ptr.limit = (sizeof(idt_entry_t) * 256 -1) + (((u8)&idt_entries)<<16);
    //idt_ptr.base  = ((u4)&idt_entries);

    memset(&idt_entries, 0, sizeof(idt_entry_t)*256);

    // Remap the irq table.
    outb(0x20, 0x11);
    outb(0xA0, 0x11);
    outb(0x21, 0x20);
    outb(0xA1, 0x28);
    outb(0x21, 0x04);
    outb(0xA1, 0x02);
    outb(0x21, 0x01);
    outb(0xA1, 0x01);
    outb(0x21, 0x0);
    outb(0xA1, 0x0);

    // divide
    idt_set_gate( 0, (u8)isr0 , 0x08, 0x8E);
    // debug
    idt_set_gate( 1, (u8)isr1 , 0x08, 0x8E);
    // NMI
    idt_set_gate( 2, (u8)isr2 , 0x08, 0x8E);
    // breakpoint
    idt_set_gate( 3, (u8)isr3 , 0x08, 0x8E);
    // overflow
    idt_set_gate( 4, (u8)isr4 , 0x08, 0x8E);
    // BOUND
    idt_set_gate( 5, (u8)isr5 , 0x08, 0x8E);
    // invalid opcode
    idt_set_gate( 6, (u8)isr6 , 0x08, 0x8E);
    // device not available
    idt_set_gate( 7, (u8)isr7 , 0x08, 0x8E);
    // double fault
    idt_set_gate( 8, (u8)isr8 , 0x08, 0x8E);
    // coprocessor segment overrun
    idt_set_gate( 9, (u8)isr9 , 0x08, 0x8E);
    // invalid TSS
    idt_set_gate(10, (u8)isr10, 0x08, 0x8E);
    // segment not present
    idt_set_gate(11, (u8)isr11, 0x08, 0x8E);
    // stack-segment fault
    idt_set_gate(12, (u8)isr12, 0x08, 0x8E);
    // general protection
    idt_set_gate(13, (u8)isr13, 0x08, 0x8E);
    // page fault
    idt_set_gate(14, (u8)isr14, 0x08, 0x8E);
    // reserved by intel
    idt_set_gate(15, (u8)isr15, 0x08, 0x8E);
    // floating point
    idt_set_gate(16, (u8)isr16, 0x08, 0x8E);
    // aligment check
    idt_set_gate(17, (u8)isr17, 0x08, 0x8E);
    // machine check
    idt_set_gate(18, (u8)isr18, 0x08, 0x8E);
    idt_set_gate(19, (u8)isr19, 0x08, 0x8E);
    idt_set_gate(20, (u8)isr20, 0x08, 0x8E);
    idt_set_gate(21, (u8)isr21, 0x08, 0x8E);
    idt_set_gate(22, (u8)isr22, 0x08, 0x8E);
    idt_set_gate(23, (u8)isr23, 0x08, 0x8E);
    idt_set_gate(24, (u8)isr24, 0x08, 0x8E);
    idt_set_gate(25, (u8)isr25, 0x08, 0x8E);
    idt_set_gate(26, (u8)isr26, 0x08, 0x8E);
    idt_set_gate(27, (u8)isr27, 0x08, 0x8E);
    idt_set_gate(28, (u8)isr28, 0x08, 0x8E);
    idt_set_gate(29, (u8)isr29, 0x08, 0x8E);
    idt_set_gate(30, (u8)isr30, 0x08, 0x8E);
    idt_set_gate(31, (u8)isr31, 0x08, 0x8E);
    idt_set_gate(128, (u8)isr128, 0x08, 0x8E);

// IRQ0 - Intel 8253 or Intel 8254 Programmable Interval Timer, aka the system timer
    idt_set_gate(32, (u8)irq0, 0x08, 0x8E);
// IRQ1 - Intel 8042 keyboard controller
    idt_set_gate(33, (u8)irq1, 0x08, 0x8E);
// IRQ2 - not assigned in PC/XT; cascaded to slave 8259 INT line in PC/AT
    idt_set_gate(34, (u8)irq2, 0x08, 0x8E);
// IRQ3 - 8250 UART serial port COM2 and COM4
    idt_set_gate(35, (u8)irq3, 0x08, 0x8E);
// IRQ4 - 8250 UART serial port COM1 and COM3
    idt_set_gate(36, (u8)irq4, 0x08, 0x8E);
// IRQ5 - hard disk controller in PC/XT; Intel 8255 parallel port LPT2 in PC/AT
    idt_set_gate(37, (u8)irq5, 0x08, 0x8E);
// IRQ6 - Intel 82072A floppy disk controller
    idt_set_gate(38, (u8)irq6, 0x08, 0x8E);
// IRQ7 - Intel 8255 parallel port LPT1 / spurious interrupt
    idt_set_gate(39, (u8)irq7, 0x08, 0x8E);

// IRQ8 - real-time clock (RTC)
    idt_set_gate(40, (u8)irq8, 0x08, 0x8E);
// IRQ9 - no common assignment
    idt_set_gate(41, (u8)irq9, 0x08, 0x8E);
// IRQ10 - no common assignment
    idt_set_gate(42, (u8)irq10, 0x08, 0x8E);
// IRQ11 - no common assignment
    idt_set_gate(43, (u8)irq11, 0x08, 0x8E);
// IRQ12 - Intel 8042 PS/2 mouse controller
    idt_set_gate(44, (u8)irq12, 0x08, 0x8E);
// IRQ13 - math coprocessor
    idt_set_gate(45, (u8)irq13, 0x08, 0x8E);
// IRQ14 - hard disk controller 1
    idt_set_gate(46, (u8)irq14, 0x08, 0x8E);
// IRQ15 - hard disk controller 2
    idt_set_gate(47, (u8)irq15, 0x08, 0x8E);

    idt_flush((u8)&idt_ptr);
    asm volatile("sti");

    printk_syslog_timestamp();
    printk_syslog("IDT init done.\n");

}
