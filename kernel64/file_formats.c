#include "types.h"
#include "main.h"
#include "vsys.h"
#include "task.h"
#include "strings.h"
#include "file_formats.h"


void loading_pe_file(vnode_t *file, task_t *task){
    u8 real_PE_offset = 0;
    vread(file, PE_PTR_OFFSET, 4, &real_PE_offset);

    PECOFF_header_t *header = (PECOFF_header_t*)kmalloc(PE_HEADER_SIZE);
    vread(file, real_PE_offset, PE_HEADER_SIZE, header);

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog_timestamp();
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

    // try to change code base
    // we can do it because in 64x all data has relative aligns
    u8 exec_addr = USER_CODE;

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
                exec_addr = USER_CODE + header->pe_image_base+oheader->o_vaddr;
            }
        }

    }
    // set execution pointer
    if (header->pe_code_base != 0){
        exec_addr = USER_CODE + header->pe_image_base+header->pe_code_base;
    }

    task->stack.rip = exec_addr;

//    u8 *pdir = make_user_pd();
//    task->pdir = pdir;

    u8 pdir = task->pdir;
    u8 old_pdir;

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog_timestamp();
    printk_syslog("FILE FORMATS: Reading program to PD: ");
    printk_syslog_numberInFormat(pdir,'h',8);
    printk_syslog("\n");
#endif

    for( i=0; i < header->pe_objnum; i++){
        vread(file, real_PE_offset + PE_HEADER_SIZE + i*sizeof(PE_oheader_t), sizeof(PE_oheader_t), oheader);

//        make_user_area(pdir, header->pe_image_base+oheader->o_vaddr, oheader->o_vsize);

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog_timestamp();
    printk_syslog("FILE FORMATS: load data into: ");
    printk_syslog_numberInFormat(USER_CODE + header->pe_image_base+oheader->o_vaddr,'h',8);
    printk_syslog(" size: ");
    printk_syslog_numberInFormat(oheader->o_psize,'h',8);
    printk_syslog("\n");
#endif

        // get mem for loading place


        // load file
//    asm volatile("xchg %bx, %bx");
        asm volatile("movq %%cr3, %0" : "=r" (old_pdir));
        asm volatile("movq %0, %%cr3" :: "r" (pdir));
        vread(file, oheader->o_poff, oheader->o_psize, USER_CODE + header->pe_image_base+oheader->o_vaddr);
        asm volatile("movq %0, %%cr3" :: "r" (old_pdir));

    }

#if DEBUG(E_NOTICE, ES_FILEFORMATS)
    printk_syslog_timestamp();
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

