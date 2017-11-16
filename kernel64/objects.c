#include "main.h"
#include "types.h"
#include "objects.h"
#include "task.h"
#include "idt.h"
#include "strings.h"


GUID EmptyGUID = {0,0,0,0,0};

// ------------------------------------------------------------------------------------------
// randomizer
static unsigned long x=123456789;

void randomize(){
    x = x*get_globalticks();
}

u8 random(){
    static unsigned long y=362436069,
    z=77465321,
    ac=13579;
    unsigned long long t;
    t=916905990LL*x+ac;
    x=y;
    y=z;
    ac=(t>>32);
    return z=(t&0xffffffff);
}

// ------------------------------------------------------------------------------------------

GUID made_GUID(){
    GUID guid;
    guid.data1 = random();
    guid.data2 = random();
    guid.data3 = random();
    guid.data4 = random();
    guid.data5 = random();
    return guid;
}

#define GUID_LEN 34
u1 *GUID2str(GUID guid){
    u1 *str = (u1*)kmalloc(GUID_LEN);
    str[0] = '{';
    strcpy(str+1, sprintk_syslog_numberInFormat(guid.data1,'h',8));
    str[9] = '-';
    strcpy(str+10, sprintk_syslog_numberInFormat(guid.data2,'h',4));
    str[14] = '-';
    strcpy(str+15, sprintk_syslog_numberInFormat(guid.data3,'h',4));
    str[19] = '-';
    strcpy(str+20, sprintk_syslog_numberInFormat(guid.data4,'h',4));
    str[24] = '-';
    strcpy(str+25, sprintk_syslog_numberInFormat(guid.data5,'h',8));
    str[33]='}';
    str[34]=0;
    return str;
}

GUID str2GUID(u1 *guid){
    u1 *cp = (u1*)kmalloc(GUID_LEN);
    strcpy(cp, guid);
    cp[9]=0;
    cp[14]=0;
    cp[19]=0;
    cp[24]=0;
    cp[33]=0;
    GUID g;
    g.data1 = str2hex(cp+1);
    g.data2 = str2hex(cp+10);
    g.data3 = str2hex(cp+15);
    g.data4 = str2hex(cp+20);
    g.data5 = str2hex(cp+25);
    kfree(cp);
    return g;
}

u1 GUIDcmp(GUID *src, GUID *dst){
    if ((src->data1 == dst->data1) && (src->data2 == dst->data2) && (src->data3 == dst->data3)
            && (src->data4 == dst->data4) && (src->data5 == dst->data5)){
        return 0;
    }else{
        return -1;
    }
}

// ------------------------------------------------------------------------------------------
t_guid_array *guids;

// ------------------------------------------------------------------------------------------
t_object *obj_find(GUID guid){
//#if DEBUG(E_NOTICE, ES_OBJECTS)
//    printk_syslog("OBJECTS: Find object ");
//    printk_syslog(GUID2str(guid));
//    printk_syslog("\n");
//#endif
    t_guid_array *gar = guids;
    while(GUIDcmp(&gar->guid, &guid) != 0){
        if (gar->next == 0){
            return 0;
        }
        gar = gar->next;
    }
    return gar->object;
}

u1 *obj_findguid_callback(GUID guid, u8 *params){
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Object find guid, params '");
    printk_syslog_number(params[0],'d');
    printk_syslog("'\n");
#endif
    t_object *obj;
    u8 wait=0;
    if (params[0]>2){
        if (strcmp(params[3], "wait") == 0){
            wait=1;
        }
    }
    u8 times=15;
    while (times>0){
        obj = obj_find(guid);
        obj = obj->sub;
        while (obj != 0){
            if (strcmp(params[2], obj->name) == 0){
                u1 *str = GUID2str(obj->guid);
                return str;
            }
            obj = obj->next;
        }
        if (wait==0){
            return 0;
        }
        //printk_syslog("waiting of object..\n");
//        switch_task(0);
        times--;
    }
    return 0;
}

t_object *obj_getlast(t_object *objclass){
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Get last object ");
    printk_syslog(GUID2str(objclass->guid));
    printk_syslog("\n");
#endif
    t_object *obj = objclass->sub;
    if (obj == 0)
        return 0;
    while(obj->next != 0){
        obj = obj->next;
    }
    return obj;
}

GUID obj_create(s1 *name, GUID classof){
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Create new object '");
    printk_syslog(name);
    printk_syslog("'\n");
#endif
    GUID cobj = made_GUID();

    t_object *obj_c = obj_find(cobj);
    if (obj_c != 0){
        printk_syslog("!!! Object with GUID already exists.\n");
        return EmptyGUID;
    }
    t_object *obj_class = obj_find(classof);
    if (obj_class == 0){
        printk_syslog("!!! Class object not found.\n");
        return EmptyGUID;
    }
    CLI
    obj_c = (t_object*)kmalloc(sizeof(t_object));
    obj_c->next = 0;
    obj_c->sub = 0;
    obj_c->sup = obj_class;
    obj_c->guid = cobj;
    obj_c->name = (u1*)kmalloc(strlen(name)+1);
    strcpy(obj_c->name, name);
    obj_c->name[strlen(name)] = 0;
    obj_c->pdir = current_task->pdir;
    obj_c->property = 0;
    obj_c->method = 0;
    t_heap *oheap = (t_heap*)kmalloc(sizeof(t_heap));
    oheap->state = OHS_NONE;
    obj_c->heap = oheap;
    obj_c->is_class = 0;
    t_object *last = obj_getlast(obj_class);
    if (last == 0){
        obj_c->prev = 0;
        obj_class->sub = obj_c;
    }else{
        obj_c->prev = last;
        last->next = obj_c;
    }
    obj_class->is_class++;

    // add to array of guids
    t_guid_array *guid_a;
    guid_a = (t_guid_array*)kmalloc(sizeof(t_guid_array));
    guid_a->guid = cobj;
    guid_a->object = obj_c;
    guid_a->next = 0;
    t_guid_array *guid_last = guids;
    while (guid_last->next != 0)
        guid_last = guid_last->next;
    guid_last->next = guid_a;

    STI
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Object crated '");
    printk_syslog(name);
    printk_syslog("' ");
    printk_syslog(GUID2str(obj_c->guid));
    printk_syslog("\n");
#endif

    return cobj;
}
u8 obj_create_callback(GUID guid, u8 *params){
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Create new object, params '");
    printk_syslog_number(params[0],'d');
    printk_syslog("'\n");
#endif

    u1 *result = GUID2str(obj_create(params[2], str2GUID(params[3])));
    return result;
}

void obj_destroy(GUID obj){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Destroy object '");
    printk_syslog(obj_d->name);
    printk_syslog("'\n");
#endif
    // destroy all subobjects
    if(obj_d->sub != 0){
        t_object *sub = obj_d->sub;
        while (sub != 0){
            obj_destroy(sub->guid);
            sub = sub->next;
        }
    }

    // destroy all properties
    CLI
    t_property *pkill, *prop = obj_d->property;
    while (prop != 0){
        kfree(prop->name);
        if (prop->pointer != 0){
            kfree(prop->pointer);
        }
        pkill = prop;
        prop = prop->next;
        kfree(pkill);
    }

    // destroy all methods
    t_method *mkill, *meth = obj_d->method;
    while (meth != 0){
        kfree(meth->name);
        mkill = meth;
        meth = meth->next;
        kfree(mkill);
    }

    // destroy current object
    kfree(obj_d->name);
    t_object *prev = obj_d->prev;
    t_object *next = obj_d->next;
    if (prev != 0){
        prev->next = next;
        next->prev = prev;
    }else{
        prev = obj_d->sup;
        prev->sub = next;
        next->prev = 0;
    }
    t_object *sup = obj_d->sup;
    sup->is_class--;



    // del from array of guids
    t_guid_array *guid_last, *guid_cur = guids;
    while (guid_cur != 0){
        GUID f = guid_cur->guid;
        if(GUIDcmp(&f, &obj) == 0){
            guid_last->next = guid_cur->next;
            kfree(guid_cur);
            break;
        }
        guid_last = guid_cur;
        guid_cur = guid_cur->next;
    }
    STI
}
u8 obj_destroy_callback(GUID guid, u8 *params){
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Destroy object, params '");
    printk_syslog_number(params[0],'d');
    printk_syslog("'\n");
#endif

    obj_destroy(str2GUID(params[2]));
    return 0;
}

void obj_property_add(GUID obj, u1 *propname){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Adding property '");
    printk_syslog(obj_d->name);
    printk_syslog("'.'$");
    printk_syslog(propname);
    printk_syslog("'\n");
#endif

    // check name & find last
    t_property *prop = obj_d->property;
    if (prop != 0){
        while (prop->next != 0){
            if (strcmp(prop->name, propname) == 0){
                printk_syslog("property '");
                printk_syslog(propname);
                printk_syslog("' already exists.\n");
                return 0;
            }
            prop = prop->next;
        }
        if (strcmp(prop->name, propname) == 0){
            printk_syslog("property '");
            printk_syslog(propname);
            printk_syslog("' already exists.\n");
            return 0;
        }
    }

    // add new property
    CLI
    t_property *newprop = (t_property*)kmalloc(sizeof(t_property));
    u8 l = strlen(propname);
    newprop->name = (u1*)kmalloc(l+1);
    strcpy(newprop->name, propname);
    newprop->name[l] = 0;
    newprop->type = 0;
    newprop->size = 0;
    newprop->pointer = 0;
    newprop->next = 0;
    newprop->prev = prop;
    if (prop == 0){
        obj_d->property = newprop;
    }else{
        prop->next = newprop;
    }
    STI
}
u8 obj_property_malloc(GUID obj, u1 *propname, u8 size){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: kmalloc('");
    printk_syslog(obj_d->name);
    printk_syslog("'.'$");
    printk_syslog(propname);
    printk_syslog("', ");
    printk_syslog_number(size, 'd');
    printk_syslog(")\n");
#endif

    // check name & find last
    t_property *prop = obj_d->property;
    if (prop != 0){
        while (prop->next != 0){
            if (strcmp(prop->name, propname) == 0){
                break;
            }
            prop = prop->next;
        }
        if (strcmp(prop->name, propname) != 0){
            printk_syslog("property not exists.\n");
            return 0;
        }
    }else{
        printk_syslog("property not exists.\n");
        return 0;
    }

    if (prop->pointer != 0){
        kfree(prop->pointer);
    }

    prop->pointer = kmalloc(size);

    return prop->pointer;
}
u8 obj_property_add_callback(GUID guid, u8 *params){
//#if DEBUG(E_NOTICE, ES_OBJECTS)
//    printk_syslog("OBJECTS: Object property add, params '");
//    printk_syslog_number(params[0],'d');
//    printk_syslog("'\n");
//#endif

    obj_property_add(guid, params[2]);
    u8 result = 0;
    if (params[0] > 2){
        u8 size = str2int(params[3]);
        result = obj_property_malloc(guid, params[2], size);
    }
    return result;
}

t_property *obj_property_get(GUID obj, u1 *propname){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Geting properties '");
    printk_syslog(propname);
    printk_syslog("' to object '");
    printk_syslog(obj_d->name);
    printk_syslog("'\n");
#endif

    // check name & find last
    t_property *prop = obj_d->property;
    if (prop != 0){
        while (prop != 0){
            if (strcmp(prop->name, propname) == 0){
                return prop;
            }
            prop = prop->next;
        }
    }
    return 0;
}

u8 obj_property_get_value_u8(GUID obj, u1 *propname){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Object '");
    printk_syslog(obj_d->name);
    printk_syslog("' get value of property '");
    printk_syslog(propname);
    printk_syslog("' at ");
    printk_syslog_number(current_task->pdir,'h');
    printk_syslog(" in ");
    printk_syslog_number(current_task->id,'d');
    printk_syslog("\n");
#endif
    t_property *p;
    u8 old_pdir;
    if (obj_d->pdir != current_task->pdir){
        old_pdir = current_task->pdir;
//        switch_pdir(obj_d->pdir);
        p = obj_property_get(obj, propname);
//        switch_pdir(old_pdir);
    }else{
        p = obj_property_get(obj, propname);
    }
    if (p != 0){
        u8 *pp = p->pointer;
        if (pp != 0){
            u8 result = pp[0];
            return result;
        }
    }
    return 0;
}

void obj_method_add(GUID obj, u1 *methname, u8 pointer){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Adding method '");
    printk_syslog(methname);
    printk_syslog("' to object '");
    printk_syslog(obj_d->name);
    printk_syslog("'\n");
#endif

    // check name and find last
    t_method *meth = obj_d->method;
    if (meth != 0){
        while (meth->next != 0){
            if (strcmp(meth->name, methname) == 0){
                printk_syslog("method already exists.\n");
                return 0;
            }
            meth = meth->next;
        }
        if (strcmp(meth->name, methname) == 0){
            printk_syslog("method already exists.\n");
            return 0;
        }
    }

    // add new method
    CLI
    t_method *newmeth = (t_method*)kmalloc(sizeof(t_method));
    u8 l = strlen(methname);
    newmeth->name = (u1*)kmalloc(l+1);
    strcpy(newmeth->name, methname);
    newmeth->name[l] = 0;
    newmeth->pointer = pointer;
    newmeth->next = 0;
    newmeth->prev = meth;
    if (meth == 0){
        obj_d->method = newmeth;
    }else{
        meth->next = newmeth;
    }
    STI
}
u8 obj_method_add_callback(GUID guid, u8 *params){
    t_object *obj_d = obj_find(guid);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Object method add, params '");
    printk_syslog_number(params[0],'d');
    printk_syslog("'\n");
#endif

    t_property *prop;
    u1 *p = params[3];
    if (p[0] == '$'){
        prop = obj_property_get(guid, params[3]+1);
        if (prop == 0){
//            PD("property not found");
            printk_syslog("OBJECTS: property '");
            printk_syslog(params[3]+1);
            printk_syslog("' in '");
            printk_syslog(obj_d->name);
            printk_syslog("'\n");
            return 0;
        }
        u8 *pp = prop->pointer;
        obj_method_add(guid, params[2], pp[0]);
    }
    return 0;
}

u8 obj_method_get(GUID obj, u1 *methname){
    t_object *obj_d = obj_find(obj);
#if DEBUG(E_NOTICE, ES_OBJECTS)
    printk_syslog("OBJECTS: Getting pointer for method '");
    printk_syslog(methname);
    printk_syslog("' in object '");
    printk_syslog(obj_d->name);
    printk_syslog("'\n");
#endif

    t_method *meth = obj_d->method;
    while (meth != 0){
        if (strcmp(meth->name, methname) == 0){
            return meth->pointer;
        }
        meth = meth->next;
    }
    return 0;
}

#define OBJ_LEVEL_2

void show_obj(t_object *cur_obj, t_object *main_obj, u8 tab){
    t_object *obj = cur_obj;
    t_object *main_class = main_obj;
    u8 i;
    while (obj != 0){
        for(i=0;i<tab;i++) printk_syslog("  ");
        printk_syslog("OBJECT ");
//        printk_syslog(GUID2str(obj->guid));
        printk_syslog(" (");
        printk_syslog(obj->name);
        printk_syslog(") CLASS_OF '");
        printk_syslog(main_class->name);
        printk_syslog("' (");
        printk_syslog_number(obj->is_class,'d');
        printk_syslog(")\n");

#ifdef OBJ_LEVEL_2
        // show propertyes
        t_property *prop = obj->property;
#if DEBUG(E_NOTICE, ES_OBJECTS)
        if (prop != 0){
            for(i=0;i<tab;i++) printk_syslog("  ");
            printk_syslog("_____propertyes_____\n");
        }
#endif
        while (prop != 0){
            for(i=0;i<tab+1;i++) printk_syslog("  ");
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("'$");
#endif
            printk_syslog(prop->name);
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("'");
#endif
            printk_syslog("\n");
            prop = prop->next;
        }

        // show methods
        t_method *meth = obj->method;
#ifdef DEBUG_LEVEL & E_NOTICE
        if (meth != 0){
            for(i=0;i<tab;i++) printk_syslog("  ");
            printk_syslog("_____methods_____\n");
        }
#endif
        while (meth != 0){
            for(i=0;i<tab+1;i++) printk_syslog("  ");
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("'");
#endif
            printk_syslog(meth->name);
#ifdef DEBUG_LEVEL & E_NOTICE
            printk_syslog("'\tat 0x");
            printk_syslog_numberInFormat(meth->pointer,'h',8);
            printk_syslog("()");
#endif
            printk_syslog("\n");
            meth = meth->next;
        }
#endif
        if (obj->sub != 0){
            for(i=0;i<tab;i++) printk_syslog("  ");
#if DEBUG(E_NOTICE, ES_OBJECTS)
            printk_syslog("_____subobjects_____\n");
#endif
            show_obj(obj->sub, obj, tab+1);
        }

        obj = obj->next;
    }
}

void show_objects(){
    printk_syslog("====== object list =======\n");
    show_obj(objects_main_tree, objects_main_tree,0);
    printk_syslog("====== list done   =======\n");
}

extern void sleep_callback(GUID guid, u8 *params);
extern void wait_callback(GUID guid, u8 *params);
extern void exit_callback(GUID guid, u8 *params);
extern u8 kmalloc_callback(GUID guid, u8 *params);
extern u8 kfree_callback(GUID guid, u8 *params);
extern u8 require_video_memory(GUID guid, u8 *params);

void cli_callback(GUID guid, u8 *params){
    CLI
}
void sti_callback(GUID guid, u8 *params){
    STI
}

t_heap kheap;

void init_objects(){
//    init_object_memory();

    randomize();

    // initialize base objects
    objects_main_tree = (t_object*)kmalloc(sizeof(t_object));
    objects_main_tree->next = 0;
    objects_main_tree->prev = 0;
    objects_main_tree->sub = 0;
    objects_main_tree->guid = str2GUID(GUID_baseobject);
    objects_main_tree->name = "base atom object";
    objects_main_tree->pdir = current_task->pdir;
    objects_main_tree->property = 0;
    objects_main_tree->method = 0;
    kheap.pointer = KERNEL_HEAP;
    kheap.size = KERNEL_HEAP_SIZE;
    kheap.state = OHS_READY;
    objects_main_tree->heap = &kheap;
    objects_main_tree->is_class = 0;
    guids = (t_guid_array*)kmalloc(sizeof(t_guid_array));
    guids->guid = objects_main_tree->guid;
    guids->object = objects_main_tree;
    guids->next = 0;

    GUID bo = str2GUID(GUID_baseobject);
    obj_method_add(bo, "create", &obj_create_callback);
    obj_method_add(bo, "destroy", &obj_destroy_callback);
    obj_method_add(bo, "new_property", &obj_property_add_callback);
    obj_method_add(bo, "new_method", &obj_method_add_callback);
    obj_method_add(bo, "find_object", &obj_findguid_callback);
    obj_method_add(bo, "cli", &cli_callback);
    obj_method_add(bo, "sti", &sti_callback);

    // memory
    GUID memo = obj_create("memory", bo);
    obj_method_add(memo, "malloc", &kmalloc_callback);
    obj_method_add(memo, "free", &kfree_callback);
    obj_method_add(memo, "get_video_mem", &require_video_memory);

    // system
    GUID system = obj_create("system", bo);
    obj_method_add(system, "sleep", &sleep_callback);
    obj_method_add(system, "wait", &wait_callback);
    obj_method_add(system, "exit", &exit_callback);

    // memory
    init_object_memory();

    // log
    init_object_log();

    // file
    init_object_fs();

    //keyboard
    init_object_keyboard();

#if DEBUG(E_NOTICE, ES_OBJECTS)
/*
    GUID d;
    d = obj_create("temp", str2GUID(GUID_baseobject));
    GUID s = obj_create("tester", str2GUID(GUID_baseobject));
    obj_create("tester1", d);
    obj_create("tester2", d);
    //obj_destroy(d);

    obj_property_add(s, "default_property");
    obj_property_add(d, "default_property1");
    obj_property_add(d, "texte3421234v");
*/
#endif

    printk_syslog("OBJECTS init done.\n");
}

