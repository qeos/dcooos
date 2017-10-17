#include "../types.h"
#include "../vsys.h"

#define SIZE_OF_SECTOR  512
#define SIZE_OF_SUPERBLOCK 1

typedef u4 (*t_boot_drive_read_sector)(u1*, u4);
t_boot_drive_read_sector boot_drive_read_sector;
typedef u4 (*t_boot_drive_write_sector)(u1*, u4);
t_boot_drive_write_sector boot_drive_write_sector;

static struct superblock{
    u4 sig; // need 0xFCB0

    u4 total_blocks; // total blocka on this drive
    u4 block_size; // 0 - 512, 1 - 1024, n - 512*n bytes on sector

    u4 at_size;
    u4 at_sector;

    u4 root_descr;
    u4 root_data;
    u4 root_cache;

    u4 second_stage_loader; // sector where we find kernel
    u4 second_stage_loader_size; //in bytes
} __attribute__((packed));
typedef struct superblock superblock_t;

// allocation table
u4 *allocationtable_rec;
superblock_t *superblock_rec;

//*********************************************************************************************************

static void l3fs_check_buffer(l3fs_file_pointer_t *inode, u4 sector)
{
    if(sector == inode->buffered_sector){
        return;
    }
    if(-1 == inode->buffered_sector){
        inode->buffer = (u1*)kmalloc(SIZE_OF_SECTOR);
    }
    inode->buffered_sector = sector;
    //floppy_read_sector(inode->buffer, sector);
    boot_drive_read_sector(inode->buffer, sector);
}

#define USE_DESCR 0
#define USE_DATA 1
#define USE_CACHE 2

static u4 l3fs_get_sizeof_data(l3fs_file_pointer_t *inode, u1 layer)
{
/*    printk("l3pv1_get_sizeof_data: ");
    printkd(inode->place.descr,'h');
    printk("\n\r");*/
    u4 sector;

    if(layer == USE_DESCR){
        sector = inode->place.descr;
    }
    if(layer == USE_DATA){
        sector = inode->place.data;
    }
    if(layer == USE_CACHE){
        sector = inode->place.cache;
    }

    if(sector == 0){
        return 0;
    }
    l3fs_check_buffer(inode, sector);

    sector = inode->buffer[3]*0x1000000 + inode->buffer[2]*0x10000 + inode->buffer[1]*0x100 + inode->buffer[0];
//    sector = (u32int)((u32int*)inode->buffer[0]);

    return sector;
}

static u4 l3fs_get_next_sector(u4 current_sector)
{
    return allocationtable_rec[current_sector];
}

static void l3fs_flush_AT(u4 sector){
    u4 at_sector = sector * 4 / SIZE_OF_SECTOR;
    boot_drive_write_sector(at_sector*SIZE_OF_SECTOR+((u4)allocationtable_rec), at_sector+superblock_rec->at_sector);
}

static u4 l3fs_get_sector(u4 start_sector, u4 sector_count)
{
    u4 i = 0, n = start_sector;
    while (i<sector_count){
        n = l3fs_get_next_sector(n);
        if (n == -1){
            return -1;
        }
        i++;
    }
    return n;
}


static u4 l3fs_syswrite(l3fs_file_pointer_t *inode, u4 offset, u4 size, u1 *buffer, u1 layer)
{

    u4 fsize = l3fs_get_sizeof_data(inode, layer);

//    if (offset > fsize){
//        return 0;
//    }
//
//    if (offset+size > fsize){
//        size = fsize - offset;
//    }

    offset += 4;

    u4 dpos = 0;
    u4 fpos = offset % SIZE_OF_SECTOR;
    u4 lpos;
    u4 start_sector, start;
    if (layer == USE_DESCR)
        start = inode->place.descr;
    if (layer == USE_DATA)
        start = inode->place.data;
    if (layer == USE_CACHE)
        start = inode->place.cache;

    start_sector = start;

    u4 new_size = offset + size;

    u4 reading_sector = l3fs_get_sector(start_sector, offset / SIZE_OF_SECTOR);
    u4 writing_sector;
#ifdef DEBUG_L3FS
//    PD("l3fs_syswrite")
    printk_syslog("Need sector ");
    printkd_bochs(offset / SIZE_OF_SECTOR,'d');
    printk_syslog(" from ");
    printkd_bochs(start_sector,'h');
    printk_syslog(", returned ");
    printkd_bochs(reading_sector,'h');
    printk_syslog("\n");
    printkd_bochs(l3fs_get_next_sector(reading_sector),'h');
    printk_syslog("\n");
#endif
    while (size > 0){
#ifdef DEBUG_L3FS
        printk_syslog("get sector ");
        printkd_bochs(reading_sector,'h');
        printk_syslog("\n");
#endif
        if (size+fpos > SIZE_OF_SECTOR)
            lpos = SIZE_OF_SECTOR - fpos;
        else
            lpos = size;
        l3fs_check_buffer(inode, reading_sector);

        memcpy(inode->buffer+fpos, buffer+dpos, lpos);

        writing_sector = reading_sector;
        boot_drive_write_sector(inode->buffer, writing_sector);
        //
//        break;
//
//        memcpy(buffer + dpos, inode->buffer + fpos, lpos);
        size -= lpos;
        fpos = 0;
        dpos += lpos;
        reading_sector = l3fs_get_next_sector(reading_sector);
        // reading_sector may be = 0xffffffff
        if ((reading_sector == -1) && (size > 0)){
            // so we need create new
            u4 i;
            for(i=0; i<superblock_rec->total_blocks; i++){
                if(allocationtable_rec[i] == 0x8888)
                    break;
            }
            if(allocationtable_rec[i] != 0x8888){
                printk_syslog("No free space on boot disk.");
                while(1);
            }
            allocationtable_rec[writing_sector] = i;
            allocationtable_rec[i] = -1;
            l3fs_flush_AT(writing_sector);
            l3fs_flush_AT(i);
            reading_sector = i;
        }
    }

    l3fs_check_buffer(inode, start);
    u4 *hsize = (u4)inode->buffer;
    hsize[0] = new_size;
    boot_drive_write_sector(inode->buffer, start);

    /*printk_syslog("l3pv1_sysread: ");
    printkd_bochs(dpos,'h');
    printk_syslog("\n\r");*/

    return new_size;
}

static u4 l3fs_write(vnode_t *node, u4 offset, u4 size, u1 *buffer)
{
    l3fs_file_pointer_t *inode = node->inode;

    // u[date statistics for node
    u4 new_length = l3fs_syswrite(inode, offset, size, buffer, USE_DATA);
    node->length = new_length;

    return new_length;
}


static u4 l3fs_sysread(l3fs_file_pointer_t *inode, u4 offset, u4 size, u1 *buffer, u1 layer)
{

    u4 fsize = l3fs_get_sizeof_data(inode, layer);

    if (offset > fsize){
        return 0;
    }

    if (offset+size > fsize){
        size = fsize - offset;
    }

    offset += 4;

    u4 dpos = 0;
    u4 fpos = offset % SIZE_OF_SECTOR;
    u4 lpos;
    u4 start_sector;
    if (layer == USE_DESCR)
        start_sector = inode->place.descr;
    if (layer == USE_DATA)
        start_sector = inode->place.data;
    if (layer == USE_CACHE)
        start_sector = inode->place.cache;


    u4 reading_sector = l3fs_get_sector(start_sector, offset / SIZE_OF_SECTOR);
#ifdef DEBUG_L3FS
//    PD("l3fs_sysread")
    printk_syslog("Need sector ");
    printkd_bochs(offset / SIZE_OF_SECTOR,'d');
    printk_syslog(" from ");
    printkd_bochs(start_sector,'h');
    printk_syslog(", returned ");
    printkd_bochs(reading_sector,'h');
    printk_syslog("\nl3fs_get_next_sector() = ");
    printkd_bochs(l3fs_get_next_sector(reading_sector),'h');
    printk_syslog("\n");
#endif
    while (size > 0){
#ifdef DEBUG_L3FS
        printk_syslog("get sector ");
        printkd_bochs(reading_sector,'h');
        printk_syslog("\n");
#endif
        if (size+fpos > SIZE_OF_SECTOR)
            lpos = SIZE_OF_SECTOR - fpos;
        else
            lpos = size;
        l3fs_check_buffer(inode, reading_sector);
        memcpy(buffer + dpos, inode->buffer + fpos, lpos);
        size -= lpos;
        fpos = 0;
        dpos += lpos;
        reading_sector = l3fs_get_next_sector(reading_sector);
        // reading_sector may be = 0xffffffff
        if (reading_sector == -1)
            break;
    }

    /*printk_syslog("l3pv1_sysread: ");
    printkd_bochs(dpos,'h');
    printk_syslog("\n\r");*/

    return dpos;
}

static u4 l3fs_read(vnode_t *node, u4 offset, u4 size, u1 *buffer)
{
    l3fs_file_pointer_t *inode = node->inode;

    return l3fs_sysread(inode, offset, size, buffer, USE_DATA);
}


static void l3fs_readdirnodes(vnode_t *node);

static u1 l3fs_readdir(vnode_t *node, const u4 index, char *str)
{
    if(!node->ptr)
        l3fs_readdirnodes(node);

    vnode_t *nodes = node->ptr;

    if (index >= node->length)
        return 0;

//    strcpy(str, nodes[index].name);
//    str[strlen(nodes[index].name)] = 0;

    return 1;
}

static vnode_t *l3fs_finddir(vnode_t *node, char *name)
{
    if(!node->ptr)
        l3fs_readdirnodes(node);

    vnode_t *root_nodes = node->ptr;

    int i;
    for (i = 0; i < node->length; i++)
        if (!strcmp(name, root_nodes[i].node_name))
            return &root_nodes[i];
    return 0;
}

u1 *l3fs_get_param(vnode_t *node, u1 *name)
{
    l3fs_file_pointer_t *inode = (l3fs_file_pointer_t*)node->inode;

    u4 size = l3fs_get_sizeof_data(inode, USE_DESCR);

    u1 *buf = (u1*)kmalloc(size);

    l3fs_sysread(inode, 0, size, buf, USE_DESCR);

    u1 *str = (u1*)kmalloc(256);
    u4 i=0, j, jj;
    while (i < size){
        // skip spaces
        while ((i < size) && ((buf[i] == ' ') || (buf[i] == '\t')))
            i++;
        jj = j = strchr(buf+i, '=');
        if (j != 0){
            //skip space at end
            while ((buf[i+j-1] == ' ') || (buf[i+j-1] == '\t'))
                j--;

            buf[i+j] = 0;
            strcpy(str, buf+i);
            str[j]=0;

            j = jj+1;
            if(strcmp(str, name)==0){
                //skip space
                while((i+j < size) && ((buf[i+j] == ' ') || (buf[i+j] == '\t')))
                    j++;

                u4 len = strlen(buf+i+j);
                u1 *res = (u1*)kmalloc(len+1);
                strcpy(res, buf+i+j);
                res[len]=0;

                kfree(str);
                kfree(buf);
                return res;
            }
        }
        i=i+j+1;
    }

    kfree(str);
    kfree(buf);

    return 0;
}


static void l3fs_readdirnodes(vnode_t *node)
{
    int i;
    l3fs_file_pointer_t *inode;
    // use length for node counter
    node->length = l3fs_get_sizeof_data(node->inode, USE_DATA) / 3/4;
    // use ptr us pointer to array
    node->ptr = (vnode_t*)kmalloc(sizeof(vnode_t) * (node->length+1));
    vnode_t *nodes = (vnode_t*)node->ptr;
    u1 *dtype;
    // read directory
    for (i=0; i<node->length; i++){
        nodes[i].inode = kmalloc(sizeof(l3fs_file_pointer_t));
        inode = (l3fs_file_pointer_t*)nodes[i].inode;
        inode->buffered_sector = -1;
        l3fs_read(node, i*4*3, 4, &inode->place.descr);
        l3fs_read(node, i*4*3+4, 4, &inode->place.data);
        l3fs_read(node, i*4*3+8, 4, &inode->place.cache);
#ifdef DEBUG_L3FS
#ifdef DEBUG_LEVEL_0
        printk_syslog("rec ("); printkd_bochs(i,'d'); printk_syslog(") inode->place.descr = "); printkd_bochs(inode->place.descr,'h'); printk_syslog("\n");
        printk_syslog("rec ("); printkd_bochs(i,'d'); printk_syslog(") inode->place.data = "); printkd_bochs(inode->place.data,'h'); printk_syslog("\n");
        printk_syslog("rec ("); printkd_bochs(i,'d'); printk_syslog(") inode->place.cache = "); printkd_bochs(inode->place.cache,'h'); printk_syslog("\n");
#endif
#endif
        // Create a new file node.
        nodes[i].node_name = l3fs_get_param(nodes+i, "Name");
        dtype = l3fs_get_param(nodes+i, "Type");
        if(dtype){
            if(strcmp(dtype, ""))
    #ifdef DEBUG_L3FS
    #ifdef DEBUG_LEVEL_0
            printk_syslog("This is directory? = !"); printkd_bochs(strcmp(dtype, "Directory"),'d'); printk_syslog("'\n");
            printk_syslog("Name = '"); printk_syslog(nodes[i].node_name); printk_syslog("'\n");
            printk_syslog("Type = '"); printk_syslog(dtype); printk_syslog("'\n");
    #endif
    #endif
            if (strcmp(dtype, "Directory") == 0){
                nodes[i].mask = nodes[i].uid = nodes[i].gid = 0;
                nodes[i].length = 0;
                nodes[i].flags = FS_DIRECTORY;
                nodes[i].read = 0;
                nodes[i].write = 0;
                nodes[i].readdir = &l3fs_readdir;
                nodes[i].finddir = &l3fs_finddir;
                nodes[i].open = 0;
                nodes[i].close = 0;
                nodes[i].impl = 0;
                nodes[i].ptr = 0;
            }else{
                nodes[i].mask = nodes[i].uid = nodes[i].gid = 0;
                nodes[i].length = l3fs_get_sizeof_data(inode, USE_DATA);
                nodes[i].flags = FS_FILE;
                nodes[i].read = &l3fs_read;
                nodes[i].write = &l3fs_write;
                nodes[i].readdir = 0;
                nodes[i].finddir = 0;
                nodes[i].open = 0;
                nodes[i].close = 0;
                nodes[i].impl = 0;
                nodes[i].ptr = 0;
            }
            kfree(dtype);
        }
    }
}


vnode_t *init_l3fs(){
    u1 *b = (u1*)kmalloc(SIZE_OF_SECTOR);
    boot_drive_read_sector(b, 0);
    u4 sbsect = b[0x10];
    kfree(b);

    superblock_rec = (superblock_t*)kmalloc(SIZE_OF_SECTOR*SIZE_OF_SUPERBLOCK);
    boot_drive_read_sector(superblock_rec, sbsect);
    if (superblock_rec->sig != 0xFCB0){
        printk_syslog("L3FS: Bad signature.\n");
    }

#ifdef DEBUG_L3FS
    PD("init l3fs")
    printk_syslog("\nSuperBlock.SIG = ");
    printkd_bochs(superblock_rec->sig,'h');
    printk_syslog("\nVolume size = ");
    printkd_bochs(superblock_rec->total_blocks*SIZE_OF_SECTOR/1024,'d');
    printk_syslog(" Kb\n");
#endif

    allocationtable_rec = (u4*)kmalloc(superblock_rec->total_blocks*4);
    u4 i;
    for (i=0; i<(superblock_rec->total_blocks * 4 / SIZE_OF_SECTOR); i++){
        //floppy_read_sector(i*SIZE_OF_SECTOR+((u4)at), i+sb->at_sector);
        boot_drive_read_sector(i*SIZE_OF_SECTOR+((u4)allocationtable_rec), i+superblock_rec->at_sector);
    }
    vnode_t *root = (vnode_t*)kmalloc(sizeof(vnode_t));
    root->node_name = (u1*)kmalloc(2);
    root->node_name[0] = '/';
    root->node_name[1] = 0;
    root->mask = root->uid = root->gid = root->inode = root->length = 0;
    root->flags = FS_DIRECTORY;
    root->read = 0;
    root->write = 0;
    root->open = 0;
    root->close = 0;
    root->readdir = &l3fs_readdir;
    root->finddir = &l3fs_finddir;
    root->ptr = 0;
    root->impl = 0;
    root->inode = kmalloc(sizeof(l3fs_file_pointer_t));
    l3fs_file_pointer_t *inode = (l3fs_file_pointer_t*)root->inode;
    inode->place.descr = superblock_rec->root_descr;
    inode->place.data = superblock_rec->root_data;
    inode->place.cache = superblock_rec->root_cache;
    inode->buffered_sector = -1; // unbuffered
#ifdef DEBUG_L3FS
    PD("init l3fs")
    printk_syslog("\nRoot.inode.place.descr = ");
    printkd_bochs(inode->place.descr,'h');
    printk_syslog("\nRoot.inode.place.data = ");
    printkd_bochs(inode->place.data,'h');
    printk_syslog("\nRoot.inode.place.cache = ");
    printkd_bochs(inode->place.cache,'h');
    printk_syslog("\n");
#endif
    //kfree(sb);
    return root;
}
