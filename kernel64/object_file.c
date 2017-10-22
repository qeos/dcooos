#include "types.h"
#include "objects.h"
#include "vsys.h"

vnode_t *file;

u8 fopen_callback(GUID guid, u8 *params){
    //file = (vnode_t*)kmalloc(sizeof(vnode_t));
    file = vfindnode(params[2]);
    return 1;
}

u8 fread_callback(GUID guid, u8 *params){
    u8 ptr;
    u1 *val = params[2];
    if (val[0] == '$'){
        ptr = obj_property_get_value_u8(guid, val+1);
    }
//    printk_bochs("fread_callback: read ");
//    printkd_bochs(file->length, 'd');
//    printk_bochs(" bytes to ");
//    printkdn_bochs(ptr, 'h', 8);
//    printk_bochs("\n");
    vread(file, 0, file->length, ptr);
}

u8 fsize_callback(GUID guid, u8 *params){
    return file->length;
}

void init_object_fs(){
    GUID bo = str2GUID(GUID_baseobject);
    GUID fs = obj_create("fs", bo);

    obj_method_add(fs, "fopen", &fopen_callback);
    obj_method_add(fs, "fread", &fread_callback);
    obj_method_add(fs, "fsize", &fsize_callback);
}
