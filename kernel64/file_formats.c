#include "types.h"
#include "main.h"
#include "vsys.h"
#include "task.h"

struct PECOFF_header_struct{
  u4  pe_sign;
  u2  pe_cputype;
  u2  pe_objnum;
  u4  pe_time;
  u4  pe_cofftbl_off;
  u4  pe_cofftbl_size;
  u2  pe_nthdr_size;
  u2  pe_flags;

  u2  pe_magic;
  u2  pe_link_ver;
  u4  pe_code_size;
  u4  pe_idata_size;
  u4  pe_udata_size;
  u4  pe_entry;
  u4  pe_code_base;
  u4  pe_data_base;
  u4  pe_image_base;
  u4  pe_obj_align;
  u4  pe_file_align;
} __attribute__((packed));
typedef struct PECOFF_header_struct PECOFF_header_t;

struct PE_oheader_struct{
  u1 o_name[8];
  u4 o_vsize;
  u4 o_vaddr;
  u4 o_psize;
  u4 o_poff;
  u4 o_reloff;
  u4 o_lineoff;
  u2 o_relnum;
  u2 o_linenum;
  u4 o_flags;
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
#define PE_HEADER_SIZE  248+16

#define STACK_SIZE 1024

#define IMAGE_FILE_MACHINE_AMD64 0x8664

void load_pe(vnode_t *file, task_t *task){
    u8 real_PE_offset;
    vread(file, PE_PTR_OFFSET, 4, &real_PE_offset);

    PECOFF_header_t *header = (PECOFF_header_t*)kmalloc(PE_HEADER_SIZE);
    vread(file, real_PE_offset, PE_HEADER_SIZE, header);

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog("FILE FORMATS: load_pe\n");
    printk_syslog("\tSIGN: "); printk_syslog(&header->pe_sign);
    printk_syslog("\tCPU-TYPE: "); printk_syslog_number(header->pe_cputype,'h');
    printk_syslog("\tOBJ-COUNT: "); printk_syslog_number(header->pe_objnum,'h'); printk_syslog("\n");
    printk_syslog("\tCode_base: "); printk_syslog_number(header->pe_code_base,'h');
    printk_syslog("\tCode_size: "); printk_syslog_number(header->pe_code_size,'h'); printk_syslog("\n");
    printk_syslog("\tData_base: "); printk_syslog_number(header->pe_data_base,'h');
    printk_syslog("\tiData_size: "); printk_syslog_number(header->pe_idata_size,'h');
    printk_syslog("\tuData_size: "); printk_syslog_number(header->pe_udata_size,'h'); printk_syslog("\n");
    printk_syslog("\tImage_base: "); printk_syslog_number(header->pe_image_base,'h'); printk_syslog("\n");
#endif

    u2 i;
    PE_oheader_t *oheader = (PE_oheader_t*)kmalloc(sizeof(PE_oheader_t));
#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog("Section name\tvSize\t\tvAddr\t\tpSize\t\tpOffset\t\tlineNum\t\tlineOffset\trelNum\t\trelOffset\tFlags\n");
#endif

    u8 code_vaddr=0, data_vaddr;
    u8 max_vaddr=0, size;

    u8 exec_addr = 0;

    // read all objects into mem
    for( i=0; i < header->pe_objnum; i++){
        // read oheader
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog(oheader->o_name);
    printk_syslog("\t\t");
    printk_syslog_numberInFormat(oheader->o_vsize, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_vaddr, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_psize, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_poff, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_linenum, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_lineoff, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_relnum, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_reloff, 'h', 8);
    printk_syslog("\t");
    printk_syslog_numberInFormat(oheader->o_flags, 'h', 8);
    printk_syslog("\n");
#endif
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

    u8 pdir = task->pdir;
    u8 old_pdir;

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog("FILE FORMATS: Reading program to PD: ");
    printk_syslog_numberInFormat(pdir,'h',8);
    printk_syslog("\n");
#endif

    for( i=0; i < header->pe_objnum; i++){
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

//        make_user_area(pdir, header->pe_image_base+oheader->o_vaddr, oheader->o_vsize);

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog("FILE FORMATS: load data into: ");
    printk_syslog_numberInFormat(header->pe_image_base+oheader->o_vaddr,'h',8);
    printk_syslog(" size: ");
    printk_syslog_numberInFormat(oheader->o_psize,'h',8);
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

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog("FILE FORMATS: Image EIP: ");
    printk_syslog_numberInFormat(exec_addr,'h',8);
    printk_syslog(" pdir: ");
    printk_syslog_numberInFormat(pdir,'h',8);
    printk_syslog("\n");
#endif

    kfree(oheader);
    kfree(header);


    u1 *stack = (u1*)kmalloc(STACK_SIZE);
//    make_user_area(pdir, stack+STACK_SIZE-1, );
    task->stack.rsp = stack+STACK_SIZE-1;
    task->stack.rbp = stack+STACK_SIZE-1;


    task->state = TS_NORMAL;
}
