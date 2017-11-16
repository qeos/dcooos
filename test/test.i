# 1 "D:\\WORK\\BUILD\\OS\\dcooos\\test\\test.c"
# 1 "D:\\WORK\\BUILD\\OS\\dcooos\\test//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "D:\\WORK\\BUILD\\OS\\dcooos\\test\\test.c"
# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/types.h" 1



typedef unsigned char u1;
typedef unsigned short u2;
typedef unsigned long u4;
typedef unsigned long long u8;
# 2 "D:\\WORK\\BUILD\\OS\\dcooos\\test\\test.c" 2
# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1



u8 syscall(void *object, char *func);
u8 syscall(void *object, char *func){
    u8 ret;
    asm volatile("int $0x80":"=a" (ret):"a"(object), "b"(func));
    return ret;
}
# 3 "D:\\WORK\\BUILD\\OS\\dcooos\\test\\test.c" 2
# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/objects.h" 1



# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/task.h" 1



# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/objects.h" 1
# 5 "D:/WORK/BUILD/OS/dcooos/kernel64/task.h" 2
# 1 "D:/WORK/BUILD/OS/dcooos/kernel64/idt.h" 1



typedef struct registers
{
   u8 ds;

   u8 rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi;
   u8 int_no, err_code;
   u8 rip, cs, eflags, useresp, ss;
} registers_t;




extern u8 clisti;
# 6 "D:/WORK/BUILD/OS/dcooos/kernel64/task.h" 2
# 16 "D:/WORK/BUILD/OS/dcooos/kernel64/task.h"
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

task_t *current_task;
task_t *tasks;

void sleep();
# 5 "D:/WORK/BUILD/OS/dcooos/kernel64/objects.h" 2


typedef struct {
    u4 data1;
    u2 data2;
    u2 data3;
    u2 data4;
    u4 data5;
} GUID;

GUID str2GUID(u1 *guid);



struct property{
    u1 *name;
    u8 type;
    u8 size;
    u8 pointer;
    struct property *prev;
    struct property *next;
};
typedef struct property t_property;

struct method{
    u1 *name;
    u8 pointer;
    struct method *prev;
    struct method *next;
};
typedef struct method t_method;




struct heap{
    u8 pointer;
    u8 size;
    u8 state;
};
typedef struct heap t_heap;


struct object{
    GUID guid;
    u1 *name;
    u8 pdir;
    t_property *property;
    t_method *method;
    t_heap *heap;
    u8 is_class;
    struct object *prev;
    struct object *next;
    struct object *sub;
    struct object *sup;
};
typedef struct object t_object;

struct guid_array{
    GUID guid;
    t_object *object;
    struct guid_array *next;
};
typedef struct guid_array t_guid_array;

t_object *objects_main_tree;
# 100 "D:/WORK/BUILD/OS/dcooos/kernel64/objects.h"
GUID obj_create(u1 *name, GUID classof);
# 4 "D:\\WORK\\BUILD\\OS\\dcooos\\test\\test.c" 2

void initialize_object(){

    u1 *log = syscall(0, "find_object " "log" "");;

    syscall(log, "print \"OBJECT VIDEO EXECUTE\"");;

    while(1==1);

}
