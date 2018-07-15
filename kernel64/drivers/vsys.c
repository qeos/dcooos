#include "../types.h"
#include "../vsys.h"
#include "../strings.h"

vnode_t *vroot;
vnode_t *log_file;

// ******************************************************************************************

u4 vread(vnode_t *node, u4 offset, u4 size, u1 *buffer)
{
    // Has the node got a read callback?
    if (node->read != 0)
        return node->read(node, offset, size, buffer);
    else
        return 0;
}

u4 vwrite(vnode_t *node, u4 offset, u4 size, u1 *buffer)
{
    // Has the node got a write callback?
    if (node->write != 0)
        return node->write(node, offset, size, buffer);
    else
        return 0;
}

void vopen(vnode_t *node, u1 read, u1 write)
{
    // Has the node got an open callback?
    if (node->open != 0)
        return node->open(node);
}

void vclose(vnode_t *node)
{
    // Has the node got a close callback?
    if (node->close != 0)
        return node->close(node);
}

u1 *vreaddir(vnode_t *node, u4 index, u1 *name)
{
    // Is the node a directory, and does it have a callback?
    if ( ((node->flags&FS_DIRECTORY) == FS_DIRECTORY) &&
         (node->readdir != 0) )
        return node->readdir(node, index, name);
    else
        return 0;
}

vnode_t *vfinddir(vnode_t *node, char *name)
{
    // Is the node a directory, and does it have a callback?
    if ( ((node->flags&0x7) == FS_DIRECTORY) &&
         (node->finddir != 0) )
        return node->finddir(node, name);
    else
        return 0;
}

vnode_t *vfindnode(char *path){
    vnode_t *node = vroot;
    u1 *dirname = (u1*)kmalloc(255);
    u4 i=1, pos=1, ppos;
    if (path[0] == '/'){
        while((pos!=0) || (node!=0)){
            pos = strchr(path+i, '/');
            if (pos==0){
                ppos = strlen(path+i);
            }else{
                ppos = pos;
            }
            memcpy(dirname, path+i, ppos);
            dirname[ppos]=0;
            node = vfinddir(node, dirname);
/*            printk_syslog(node->name);
            printk_syslog(" - \n\r");*/
            i += ppos+1;
            if (pos==0)
                break;
        };
        kfree(dirname);
/*        printk_syslog("vfindnode: ");
        printkd_bochs(node, 'h');
        printk_syslog("\n");*/
        if(node==0){
            printk_syslog_timestamp();
            printk_syslog("VSYS: file '");
            printk_syslog(path);
            printk_syslog("' not found\n");
            return 0;
        }
        return node;
    }else{
        printk_syslog("Relative path while not implemented.\n\r");
        kfree(dirname);
        return 0;
    }
}

//extern printk_buffer;
//extern system_init;
//extern pos;
void vflash_log(){
//#ifdef VMWARE
//    #ifndef PRINTK_INTO_SERIAL
//    if(system_init){
//
//        vwrite(log_file, log_file->length, strlen(printk_buffer), printk_buffer);
//        pos = 0;
//    }
//    #endif // PRINTK_INTO_SERIAL
//#endif // VMWARE
}

void init_vsys(){

    vroot = init_l3fs();

    // initialize log file
#ifdef VMWARE
    #ifndef PRINTK_INTO_SERIAL
    //log_file = (vnode_t*)kmalloc(sizeof(vnode_t));
    log_file = vfindnode("/syslog");
//    u1 *first = "This test string.\n\
//    0 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    2 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    3 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    4 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    5 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    6 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    7 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    8 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    9 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
//    \n";
//    vwrite(log_file, log_file->length, strlen(first), first);
    #endif // PRINTK_INTO_SERIAL
#endif // VMWARE

    printk_syslog_timestamp();
    printk_syslog("VSYS init done.\n");

}
