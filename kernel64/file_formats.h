#ifndef FILE_FORMATS_H_INCLUDED
#define FILE_FORMATS_H_INCLUDED

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

#define STACK_SIZE 1024*2

#define IMAGE_FILE_MACHINE_AMD64 0x8664

void loading_pe_file(vnode_t *file, task_t *task);

#endif // FILE_FORMATS_H_INCLUDED
