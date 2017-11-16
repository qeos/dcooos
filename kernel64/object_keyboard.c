#include "types.h"
#include "objects.h"
#include "task.h"
#include "idt.h"
#include "syscall.h"
#include "strings.h"

u1 *keybuffer = "KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER_KEYBOARDBUFFER";
u1 buffer_index = 0;

static void keyboard_callback(registers_t *regs){
    u1 scancode = inb(0x60);

    keybuffer[buffer_index] = scancode;
    buffer_index++;

    u8 i;
    for (i=0; i<100; i++);
    /*printk_bochs("Has keypress '");
    printkd_bochs(scancode,'h');
    printk_bochs("'\n");*/
}

u8 readkey_callback(GUID guid, u8 *params){
    printk_syslog("need key press\n");
    buffer_index = 0;
    u8 i;
    while (buffer_index <= 0){
        for (i=0; i<100; i++);
        if (buffer_index <= 0){
            switch_task(0);
        }
    }
    u8 ret = keybuffer[buffer_index-1];
    if (keybuffer[buffer_index-1] == 0x03){
        show_tasks();
    }
    if (keybuffer[buffer_index-1] == 0x04){
        show_objects();
    }
    if (keybuffer[buffer_index-1] == 0x05){
        heap_print();
    }
    if (keybuffer[buffer_index-1] == 0x06){
        show_markup();
    }
    if (keybuffer[buffer_index-1] == 0x07){
        u1* fasm = syscall(0, "find_object fasm wait");
        if (fasm){
            syscall(fasm, "compile");
        }
    }
    return ret;
}


void init_object_keyboard(){
    register_interrupt_handler(33, &keyboard_callback);

    GUID bo = str2GUID(GUID_baseobject);
    GUID keyboard = obj_create("keyboard", bo);
    obj_method_add(keyboard, "readkey", &readkey_callback);
}
