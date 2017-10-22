#include "types.h"
#include "vsys.h"
#include "task.h"

struct PE_header_struct{
  u8  pe_sign;
  u2  pe_cputype;
  u2  pe_objnum;
  u8  pe_time;
  u8  pe_cofftbl_off;
  u8  pe_cofftbl_size;
  u2  pe_nthdr_size;
  u2  pe_flags;
  u2  pe_magic;
  u2  pe_link_ver;
  u8  pe_code_size;
  u8  pe_idata_size;
  u8  pe_udata_size;
  u8  pe_entry;
  u8  pe_code_base;
  u8  pe_data_base;
  u8  pe_image_base;
  u8  pe_obj_align;
  u8  pe_file_align;
} __attribute__((packed));
typedef struct PE_header_struct PE_header_t;

struct PE_oheader_struct{
  u1 o_name[8];
  u8 o_vsize;
  u8 o_vaddr;
  u8 o_psize;
  u8 o_poff;
  u1 o_reserved[12];
  u8 o_flags;
} __attribute__((packed));
typedef struct PE_oheader_struct PE_oheader_t;

#define SF_16BIT_OFFSET 0x00000004
#define SF_CODE         0x00000020
#define SF_IDATA        0x00000040
#define SF_UDATA        0x00000080
#define SF_COMMENTS     0x00000200
#define SF_OVERLAY      0x00000400
#define SF_NOPART       0x00000800
#define SF_DATA         0x00001000
#define SF_DEFAULT_ALIGN 0x00500000
#define SF_UNLOADABLE   0x02000000
#define SF_UNCACHED     0x04000000
#define SF_UNPAGABLE    0x08000000
#define SF_DIVIDABLE    0x10000000
#define SF_EXECUTABLE   0x20000000
#define SF_READABLE     0x40000000
#define SF_WRITABLE     0x80000000

#define PE_PTR_OFFSET   0x3c
#define PE_HEADER_SIZE  248

#define STACK_SIZE 1024


void load_pe(vnode_t *file, task_t *task){
    u8 real_PE_offset;
    vread(file, PE_PTR_OFFSET, 4, &real_PE_offset);

    PE_header_t *header = (PE_header_t*)kmalloc(PE_HEADER_SIZE);
    vread(file, real_PE_offset, PE_HEADER_SIZE, header);

#ifdef DEBUG_PE
    printk_syslog("SIGN: "); printk_syslog(&header->pe_sign);
    printk_syslog("\tCPU-TYPE: "); printk_syslog_number(header->pe_cputype,'h');
    printk_syslog("\tOBJ-COUNT: "); printk_syslog_number(header->pe_objnum,'h'); printk_syslog("\n");
    printk_syslog("Code_base: "); printk_syslog_number(header->pe_code_base,'h');
    printk_syslog("\tCode_size: "); printk_syslog_number(header->pe_code_size,'h'); printk_syslog("\n");
    printk_syslog("Data_base: "); printk_syslog_number(header->pe_data_base,'h');
    printk_syslog("\tiData_size: "); printk_syslog_number(header->pe_idata_size,'h');
    printk_syslog("\tuData_size: "); printk_syslog_number(header->pe_udata_size,'h'); printk_syslog("\n");
    printk_syslog("Image_base: "); printk_syslog_number(header->pe_image_base,'h'); printk_syslog("\n");
#endif

    u2 i;
    PE_oheader_t *oheader = (PE_oheader_t*)kmalloc(sizeof(PE_oheader_t));
#ifdef DEBUG_PE
    printk_syslog("Section name\tvSize\t\tvAddr\t\tpSize\t\tpOffset\t\tFlags\n");
#endif

    u8 code_vaddr=0, data_vaddr;
    u8 max_vaddr=0, size;

    u8 exec_addr = 0;

    // read all objects into mem
    for( i=0; i < header->pe_objnum; i++){
        // read oheader
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

        // check for execution point
        if ((oheader->o_flags & SF_EXECUTABLE) == SF_EXECUTABLE){
            if(exec_addr == 0){
                exec_addr = header->pe_image_base+oheader->o_vaddr;
            }
        }

    }
    // set execution pointer
    if (header->pe_code_base != 0){
        exec_addr = header->pe_image_base+header->pe_code_base;
    }
    task->stack.rip = exec_addr;

//    u8 *pdir = make_user_pd();
//    task->pdir = pdir;

#ifdef DEBUG_PE
    printk_syslog("Reading program to PD: ");
    printkdn_bochs(pdir,'h',8);
    printk_syslog("\n");
#endif

    u8 pdir = task->pdir;
    u8 old_pdir;

    for( i=0; i < header->pe_objnum; i++){
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

//        make_user_area(pdir, header->pe_image_base+oheader->o_vaddr, oheader->o_vsize);

#ifdef DEBUG_PE
    printk_syslog("Made userarea: ");
    printkdn_bochs(header->pe_image_base+oheader->o_vaddr,'h',8);
    printk_syslog("\n");
#endif

        // get mem for loading place


        // load file
//    asm("xchg %bx, %bx");
        asm("movq %%cr3, %0" : "=r" (old_pdir));
        asm("movq %0, %%cr3" :: "r" (pdir));
        vread(file, oheader->o_poff, oheader->o_psize, header->pe_image_base+oheader->o_vaddr);
        asm("movq %0, %%cr3" :: "r" (old_pdir));

    }

#ifdef DEBUG_PE
    printk_syslog("Image EIP: ");
    printkdn_bochs(exec_addr,'h',8);
    printk_syslog(" physical addr: ");
    u8 p = pdir[0];
    printkdn_bochs(p,'h',8);
    printk_syslog("\n");
#endif

    kfree(oheader);
    kfree(header);


    u1 *stack = (u1*)kmalloc(STACK_SIZE);
//    make_user_area(pdir, stack+STACK_SIZE-1, );
    task->stack.rsp = stack+STACK_SIZE-1;
    task->stack.rbp = stack+STACK_SIZE-1;


    task->state = TS_NORMAL;
/*    for( i=0; i < header->pe_objnum; i++){
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);
        if ((exec_addr == 0) && (oheader->o_flags & SF_EXECUTABLE)){
            exec_addr = header->pe_image_base+oheader->o_vaddr;
        }
#ifdef DEBUG_PE
        printk_syslog(&oheader->o_name);
        printk_syslog("\t\t");
        printkdn_bochs(oheader->o_vsize,'h',8);
        printk_syslog("\t");
        printkdn_bochs(oheader->o_vaddr,'h',8);
        printk_syslog("\t");
        printkdn_bochs(oheader->o_psize,'h',8);
        printk_syslog("\t");
        printkdn_bochs(oheader->o_poff,'h',8);
        printk_syslog("\t");
        printkdn_bochs(oheader->o_flags,'h',8);
        printk_syslog("\n");
#endif

    }
    // set execution pointer
    if (header->pe_code_base != 0){
        exec_addr = header->pe_image_base+header->pe_code_base;
    }
    task->eip = exec_addr;

    u8 *pdir = make_user_pd();
    task->pdir = pdir;

#ifdef DEBUG_PE
    printk_syslog("Reading program to PD: ");
    printkdn_bochs(pdir,'h',8);
    printk_syslog("\n");
#endif

    u8 old_pdir;

    for( i=0; i < header->pe_objnum; i++){
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

        make_user_area(pdir, header->pe_image_base+oheader->o_vaddr, oheader->o_vsize);

#ifdef DEBUG_PE
    printk_syslog("Made userarea: ");
    printkdn_bochs(header->pe_image_base+oheader->o_vaddr,'h',8);
    printk_syslog("\n");
#endif

        // load file
        asm("movl %%cr3, %0" : "=r" (old_pdir));
        asm("movl %0, %%cr3" :: "r" (pdir));
        vread(file, oheader->o_poff, oheader->o_psize, header->pe_image_base+oheader->o_vaddr);
        asm("movl %0, %%cr3" :: "r" (old_pdir));

    }

#ifdef DEBUG_PE
    printk_syslog("Image EIP: ");
    printkdn_bochs(exec_addr,'h',8);
    printk_syslog(" physical addr: ");
    u8 p = pdir[0];
    printkdn_bochs(p,'h',8);
    printk_syslog("\n");
#endif

    kfree(oheader);
    kfree(header);


    u1 *stack = kmalloc(STACK_SIZE);
//    make_user_area(pdir, stack+STACK_SIZE-1, );
    task->esp = stack+STACK_SIZE-1;
    task->ebp = stack+STACK_SIZE-1;


    task->state = TS_NORMAL;
    */
}
