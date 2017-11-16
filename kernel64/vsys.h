#ifndef VSYS_H_INCLUDED
#define VSYS_H_INCLUDED

struct vnode;

// These typedefs define the type of callbacks - called when read/write/open/close
// are called.
typedef struct fs_node * (*finddir_type_t)(struct fs_node*,char *name);
typedef u4 (*read_type_t)(struct fs_node*,u4,u4,u1*);
typedef u4 (*write_type_t)(struct fs_node*,u4,u4,u1*);
typedef void (*open_type_t)(struct fs_node*);
typedef void (*close_type_t)(struct fs_node*);
typedef u1 * (*readdir_type_t)(struct fs_node*,u4,u1*);
typedef u1 (*fs_get_param)(struct fs_node*, u1*, u1*);

typedef struct vnode
{
    u1 *node_name;     // The filename.
    u4 mask;        // The permissions mask.
    u4 uid;         // The owning user.
    u4 gid;         // The owning group.
    u4 flags;       // Includes the node type. See #defines above.
    u4 inode;       // This is device-specific - provides a way for a filesystem to identify files.
    u4 length;      // Size of the file, in bytes.
    u4 impl;        // An implementation-defined number.
    read_type_t read;
    write_type_t write;
    open_type_t open;
    close_type_t close;
    readdir_type_t readdir;
    finddir_type_t finddir;
    struct vnode *ptr; // Used by mountpoints and symlinks.
} vnode_t;

typedef struct
{
    u4 descr;
    u4 data;
    u4 cache;
}l3fs_fpointer_t;

typedef struct
{
//    u8int magic;     // Magic number, for error checking.
//    s8int name[64];  // Filename.
    l3fs_fpointer_t place;
    // in future there be buffer
    u4 buffered_sector;
    u1 *buffer;
}l3fs_file_pointer_t;



#define FS_FILE        0x01
#define FS_DIRECTORY   0x02
#define FS_CHARDEVICE  0x03
#define FS_BLOCKDEVICE 0x04
#define FS_PIPE        0x05
#define FS_SYMLINK     0x06
#define FS_MOUNTPOINT  0x08 // Is the file an active mountpoint?

extern vnode_t *vroot;


#endif // VSYS_H_INCLUDED
