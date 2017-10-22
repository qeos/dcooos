#ifndef OBJECTS_H_INCLUDED
#define OBJECTS_H_INCLUDED

#include "task.h"

// GUID
typedef struct {
    u4 data1;
    u2 data2;
    u2 data3;
    u2 data4;
    u4 data5;
} GUID;

GUID str2GUID(u1 *guid);

// Objects

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

// Object Heap State
#define OHS_NONE    0x00
#define OHS_READY   0x01
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

#define GUID_baseobject "{C8283DA0-87A6-69CF-AF16-48616423}"

#define GUID_system "{F008F9AB-8C85-3318-F71B-2F5A07A7}"

#define _OBJ_CREATE(baseobject, objname)\
    u1 *objname = syscall(0, "create " #objname " "baseobject"");

#define _OBJ_INIT(baseobject, objname)\
    u1 *objname = syscall(baseobject, "find_object " #objname "");

#define _OBJ_INIT_GLOBAL(baseobject, objname)\
    objname = syscall(baseobject, "find_object " #objname "");

#define _OBJ_CALL(object, str) object ? syscall(object, str) : 0;

#define _OBJ_NEW_PROPERTY_U4(object, propname)\
    u4 *object##_##propname = _OBJ_CALL(object, "new_property " #propname " 4")

#define _OBJ_GLOBAL_PROPERTY(object, propname)\
    u4 *object##_##propname;

#define _OBJ_NEW_PROPERTY_U4_GLOBAL(object, propname)\
    object##_##propname = _OBJ_CALL(object, "new_property " #propname " 4")

#define _OBJ_SET_PROPERTY_U4(object, propname, val)\
    object##_##propname[0] = val;

GUID obj_create(u1 *name, GUID classof);

#endif // OBJECTS_H_INCLUDED
