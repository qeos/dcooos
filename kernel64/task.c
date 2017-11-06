#include "types.h"
#include "main.h"
#include "vsys.h"
#include "idt.h"
#include "task.h"
#include "objects.h"

u8 tick=0;
u8 tick_count=0;
u8 next_pid=0;

#define STACK_SIZE 1024*2
#define BINARY_FILE_START   0x400000

task_t* make_new_user_task(){
    task_t *new_task = (task_t*)kmalloc(sizeof(task_t));

    // fill new task params
    task_t *last_task = tasks;
    while (last_task->next != 0)
        last_task = last_task->next;
    new_task->id = next_pid++;
    new_task->timer_tick = 0;
    new_task->switch_count = 0;
    new_task->state = TS_CREATE;
    new_task->next = 0;
    last_task->next = new_task;

    // now we need make and copy pdir
    new_task->pdir = copy_pdir();
    new_task->task_pdir = 0;


}

void exec(u1 *fname){
    vnode_t *file;// = (vnode_t*)kmalloc(sizeof(vnode_t));
    file = vfindnode(fname);

    l3fs_file_pointer_t *inode = (l3fs_file_pointer_t*)file->inode;

    u1 *type = l3fs_get_param(file, "Type");
    if(type){


        task_t *new_task = make_new_user_task();

        // set name of task
        u8 len = strlen(fname);
        u1 *n = (u1*)kmalloc(len+2);
        strcpy(n, fname);
        n[len] = 0;
        new_task->name = n;

        if(strcmp(type, "CBC") == 0){
            u8 *pdir = make_user_pd();
            make_user_area(pdir, BINARY_FILE_START+0x1000, file->length); // +0x1000 for stack

            // load file
            u8 old_pdir;
            asm("movq %%cr3, %0" : "=r" (old_pdir));
            asm("movq %0, %%cr3" :: "r" (pdir));
            vread(file, 0, file->length, BINARY_FILE_START+0x1000);
            asm("movq %0, %%cr3" :: "r" (old_pdir));

            u1 *stack = (u1*)kmalloc(STACK_SIZE);
            new_task->stack.rsp = stack+STACK_SIZE-1;
            new_task->stack.rbp = stack+STACK_SIZE-1;
            new_task->stack.rip = BINARY_FILE_START+0x1000;
            new_task->pdir = pdir;
            new_task->state = TS_NORMAL;

        }else if(strcmp(type, "CPE") == 0){
            load_pe(file, new_task);
        }

        kfree(type);
    }

}

u8* s = 0x10000;
u1* screen;

void putpoint(u8 pos, u1 r, u1 g, u1 b){
    screen[pos] = r;
    screen[pos+1] = g;
    screen[pos+2] = b;
}

void putbigpoint(u8 pos, u1 r, u1 g, u1 b){
    u8 x,y;
    for (y=0; y<3; y++)
        for (x=0; x<6; x++)
            putpoint(pos+(x*3+800*3*y),r,g,b);
}

void show_tasks_state(){


    screen = s[0];

    if (screen !=0){
        task_t *taskm = tasks;
        while (taskm != 0){
            u8 pos=(800*(30+taskm->id*4)+770)*3;
            if (taskm->state == TS_CREATE){
                putbigpoint(pos,255,255,0);
            }else if (taskm->state == TS_NORMAL){
                putbigpoint(pos,0,255,0);
            }else if (taskm->state == TS_SLEEP){
                putbigpoint(pos,255,0,255);
            }else if (taskm->state == TS_KILL){
                putbigpoint(pos,255,0,0);
            }
            if (taskm == current_task){
                putbigpoint(pos,155,155,155);
            }
            taskm = taskm->next;
        }
    }

}

u1 switching = 0;
extern read_rip();

// use 0 as parameter for non interruptible call
void switch_task(registers_t *regs){
    if (tasks == 0)
        return;

#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: switching task\n");
#endif

    //show_tasks_state();
    current_task->switch_count += 1;

    task_t *new_task = current_task;
    do{
        if (new_task->next == 0)
            new_task = tasks;
        else
            new_task = new_task->next;

        if(new_task->state == TS_NORMAL){
            break;
        }
        u8 gticks = get_globalticks();
        if(new_task->state == TS_SLEEP){
            if(new_task->wakeup_time < gticks){
                break;
            }
        }
    }while(true);

    if (new_task == current_task){
/*        asm("movl %0, %%cr3" :: "r" (old_pdir));*/
        return;
    }
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: found task to switch ID = ");
    printk_syslog_number(new_task->id, 'd');
    printk_syslog("\n");
#endif

    switching = true;

//    if((u8)regs == 0){
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: program task switch \n");
#endif
        u8 rsp, rbp, rip, pdir;
        asm volatile("movq %%rsp, %0" : "=m"(rsp));
        asm volatile("movq %%rbp, %0" : "=m"(rbp));
        asm volatile("movq %%cr3, %0" : "=r"(pdir));
        //asm volatile("cli");
        rip = _read_rip();
        if(rip == 0x12345){
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: switch back \n");
#endif
            switching = false;
            return;
        }

        current_task->stack.rsp = rsp;
        current_task->stack.rbp = rbp;
        current_task->stack.rip = rip;
        current_task->task_pdir = pdir;
//    }else{
//#if DEBUG(E_NOTICE, ES_TASK)
//    printk_syslog("TASK: hardware task switch \n");
//#endif
//        current_task->stack.rsp = regs->rsp;
//        current_task->stack.rbp = regs->rbp;
//        current_task->stack.rip = regs->rip;
//    }

#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: from/to: ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog(" -> ");
#endif

    current_task = new_task;
    current_task->state = TS_NORMAL;

#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog_number(current_task->id,'d');
    printk_syslog("\n");
    printk_syslog("TASK: switch into RIP: ");
    printk_syslog_numberInFormat(current_task->stack.rip, 'h', 16);
    if(regs != 0){
        printk_syslog(" from RIP: ");
        printk_syslog_numberInFormat(regs->rip, 'h', 16);
    }
    printk_syslog("\n");
#endif

    if(current_task->task_pdir == 0){
        current_task->task_pdir = current_task->pdir;
    }

    asm volatile("         \
        cli;                 \
        movq %0, %%rcx;       \
        movq %1, %%rsp;       \
        movq %2, %%rbp;       \
        movq %3, %%cr3;       \
        movq $0x12345, %%rax; \
        sti;                 \
        jmp *%%rcx           "
            : : "r"(current_task->stack.rip), "r"(current_task->stack.rsp), "r"(current_task->stack.rbp), "r" (current_task->task_pdir));

    switching = false;
}

extern u8 clisti;

void timer_callback(registers_t *regs){
    tick++;
    current_task->timer_tick++;
    if(tick > tick_count){
        tick_count = tick + 10;
        if(!clisti){
            switch_task(regs);
        }
    }
}

u8 switch_pdir(u8 pdir){

    CLI
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: switch_pdir\n");
#endif // DEBUG_TASK

    u8 old_pdir;
    asm volatile("movq %%cr3, %0" : "=r"(old_pdir));
    asm("movq %0, %%cr3" :: "r" (pdir));
    current_task->pdir = pdir;
    STI

#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: Switch pdir ");
    printk_syslog_numberInFormat(old_pdir,'h',8);
    printk_syslog(" >>> ");
    printk_syslog_numberInFormat(pdir,'h',8);
    printk_syslog("\n");
#endif

    return pdir;
}

void sleep(u8 sleep_time){
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: Task ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog(" now sleeping. Working time: ");
    if(current_task->timer_tick == 0)
        printk_syslog("<10");
    else
        printk_syslog_number(current_task->timer_tick*10, 'd');
    printk_syslog(" ms\n");
#endif
    u8 gticks = get_globalticks();
    current_task->state = TS_SLEEP;
    current_task->wakeup_time = gticks + sleep_time;
    switch_task(0);
}

u8 sleep_callback(GUID guid, u8 *params){
    t_object *obj_d = obj_find(guid);
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: Sleep to task ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog("\n");
#endif
    u8 ticks = str2int(params[2]);
    sleep(ticks);
    return 0;
}

u8 wait_callback(GUID guid, u8 *params){
    t_object *obj_d = obj_find(guid);
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: Wait for task ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog("\n");
#endif
    u8 ticks = str2int(params[2]);
    u8 cur = current_task->timer_tick;
    while (cur - current_task->timer_tick < ticks){
        switch_task(0);
    }
    return 0;
}

u8 exit_callback(GUID guid, u8 *params){
    t_object *obj_d = obj_find(guid);
#if DEBUG(E_NOTICE, ES_TASK)
    printk_syslog("TASK: Exit for task ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog("\n");
#endif
    current_task->state = TS_KILL;
    switch_task(0);
    return 0;
}

void show_tasks(){
    task_t *t = tasks;
    printk_syslog("---- TASK LIST ----\n");
    while(t != 0){
        printk_syslog("ID: ");
        printk_syslog_number(t->id, 'd');
        printk_syslog("\tPD: ");
        printk_syslog_numberInFormat(t->pdir, 'h', 8);
        printk_syslog("\tState: ");
        if(t->state == TS_NORMAL){
            printk_syslog("TS_NORMAL");
        }else if(t->state == TS_CREATE){
            printk_syslog("TS_CREATE");
        }else if(t->state == TS_SLEEP){
            printk_syslog("TS_SLEEP");
        }else if(t->state == TS_KILL){
            printk_syslog("TS_KILL");
        }else if(t->state == TS_CRASH){
            printk_syslog("TS_CRASH");
        }
        printk_syslog("  \tTimer: ");
        printk_syslog_number(t->timer_tick, 'd');
        printk_syslog("  \tSwitches: ");
        printk_syslog_number(t->switch_count, 'd');
        printk_syslog("  \tName: ");
        printk_syslog(t->name);
        printk_syslog("\n");
        t = t->next;
    }
    printk_syslog("-------------------\n");
}

void init_task(){
    // make kernel as current task #1
    current_task = (task_t*)kmalloc(sizeof(task_t));
    tasks = current_task;
    tasks->id = next_pid++;
    tasks->timer_tick = 0;
    tasks->switch_count = 0;
    tasks->name = "KERNEL\0";

    asm("movq %%cr3, %0" : "=r" (tasks->pdir));
    tasks->state = TS_NORMAL;
    tasks->next = 0;

    register_interrupt_handler(32, &timer_callback);

    printk_syslog("TASK init done.\n");
    s[0] = 0;
}
