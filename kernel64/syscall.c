#include "types.h"
#include "idt.h"
#include "task.h"
#include "objects.h"

typedef u8 (*method_of_object)(GUID, u8*);

u8 syscall_run(u8 meth, GUID guid, u8 *params){
    method_of_object method = meth;
    t_object *obj = obj_find(guid);
    u8 old_pdir;
    u8 result = 0;
    if ((obj->pdir == objects_main_tree->pdir) || (obj->pdir == current_task->pdir)){
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("SYSCALL: call local in '");
            printk_syslog_number(obj->pdir,'h');
            printk_syslog("' ");
            printk_syslog(obj->name);
            printk_syslog(".");
            printk_syslog(params[1]);
            printk_syslog("(");
            u8 i;
            for(i=2; i<=params[0]; i++){
                if(i!=2){
                    printk_syslog(", ");
                }
                printk_syslog(params[i]);
            }
            printk_syslog(")\n");
#endif
        result = method(guid, params);
    }else{
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("SYSCALL: call switched in '");
            printk_syslog_number(obj->pdir,'h');
            printk_syslog("'\n");
#endif
        // switch to object PD
        asm("movq %%cr3, %0" : "=r" (old_pdir));
        asm("movq %0, %%cr3" :: "r" (obj->pdir));
        result = method(guid, params);
        // switch back to
        asm("movq %0, %%cr3" :: "r" (old_pdir));
    }
    return result;
}

u8 syscall_callback(registers_t *regs){
    CLI

    // copy guid
    u8 len;
    u1 *gstr;
    if (regs->rax != 0){
        len = strlen(regs->rax);
        gstr = (u1*)kmalloc(len+1);
        strcpy(gstr, regs->rax);
        gstr[len] = 0;
    }
    // copy params
    len = strlen(regs->rbx);
    u1 *cstr = (u1*)kmalloc(len+1);
    strcpy(cstr, regs->rbx);
    cstr[len] = 0;
    STI
    u8 *earr = explode(" ", cstr, "\"'");

    // run method with params
    GUID obj;
    if (regs->rax == 0){
        obj = str2GUID(GUID_baseobject);
    }else{
        obj = str2GUID(gstr);
    }

#ifdef DEBUG_LEVEL & E_NOTICE
    t_object *d = obj_find(obj);
    printk_syslog("SYSCALL: We has a call task ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog(" '");
    printk_syslog(cstr);
    printk_syslog("' rax: '");
    printk_syslog(d->name);
    printk_syslog("' PML4E at: ");
    printk_syslog_numberInFormat(d->pdir,'h',16);
    printk_syslog("\n");
#endif


    u8 result = 0;
    u8 meth = obj_method_get(obj, earr[1]);
    if (meth != 0){
        result = syscall_run(meth, obj, earr);
    }else{
        // try to lookup in class
        t_object *tobj = obj_find(obj);
        while (tobj->sup != 0){
            tobj = tobj->sup;
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("SYSCALL: try to get method in '");
            printk_syslog(tobj->name);
            printk_syslog("'\n");
#endif
            meth = obj_method_get(tobj->guid, earr[1]);
            if (meth != 0)
                break;
        }
        if (meth != 0){
            result = syscall_run(meth, obj, earr);
        }else{
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("SYSCALL: Method '");
            printk_syslog(earr[1]);
            printk_syslog("' not found.\n");
#endif
        }
    }

    free_explode_array(earr);
    kfree(cstr);
    if (regs->rax != 0){
        kfree(gstr);
    }

    // just change RAX as return
    // return result;
    regs->rax = result;
}

void init_syscall(){
    register_interrupt_handler(128, &syscall_callback);

    printk_syslog("SYSCALL init done.\n");
}
