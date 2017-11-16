#include "types.h"
#include "objects.h"

void print_callback(GUID guid, u8 *params){
    u1 *val = params[2];
    if (val[0] == '$'){
        val = obj_property_get_value_u8(guid, val+1);
    }
    printk_syslog("SYSLOG: '");
    printk_syslog(val);
    printk_syslog("'\n");
}

void init_object_log(){
    GUID bo = str2GUID(GUID_baseobject);
    GUID log_sys = obj_create("log", bo);

    obj_method_add(log_sys, "print", &print_callback);

    _OBJ_INIT(0, log);
    _OBJ_CALL(log, "print \"OBJECT_LOG: initialized.\"");
}
