#ifndef TASK_H_INCLUDED
#define TASK_H_INCLUDED

#include "objects.h"
#include "idt.h"

#define TS_NORMAL   0x00
#define TS_CREATE   0x01
#define TS_SLEEP    0x02
#define TS_KILL     0x03
#define TS_CRASH    0x04

#define TT_FUNCTION 0x00
#define TT_MESSAGE  0x01

typedef struct task{
    u8 id;

    u1 state;
    u8 wakeup_time;

    u8 pdir;
    u8 task_pdir;

    u8 timer_tick;
    u8 switch_count;

    char *name;


    u1 task_interrupted;
    registers_t stack;

    struct task *next;

}task_t;

extern task_t *current_task;
extern task_t *tasks;

extern u8 ticks_per_process;

void sleep();

// Global Critical section routines

#define GCS_CREATE(critical_name)\
    u1 GCSUF_##critical_name = true;

#define GCS_IN_USE(critical_name)\
    !GCSUF_##critical_name

#define GCS_WAIT(critical_name)\
    while(GCS_IN_USE(critical_name)){\
        switch_task(0);\
    }

#define GCS_WAIT_TIMEOUT(critical_name, ticks_count)\
    u8 GCSTC_##critical_name = ticks_count;\
    while((!GCSUF_##critical_name) && (GCSTC_##critical_name--)){\
        switch_task(0);\
    }


#define GCS_BEGIN(critical_name)\
    GCSUF_##critical_name = false;

#define GCS_DONE(critical_name)\
    GCSUF_##critical_name = true;

#endif // TASK_H_INCLUDED


