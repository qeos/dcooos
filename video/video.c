#include "../kernel64/types.h"
#include "../kernel64/main.h"
#include "../kernel64/syscall.h"
#include "../kernel64/strings.c"
#include "../kernel64/objects.h"
#include "../kernel64/system_ll/ioport.c"
#include "video.h"

#define COLOR_TYPE_565
#define WIDTH 800
#define HEIGHT 600
#define BPP 2

#define DEBUG_VIDEO

u8 *vbe_lfb;

u1 *obj_memory;
u8 *memory_req_mem;

u8 initDone;

struct color{
    u1 rgb[BPP];
} __attribute__((packed));

typedef struct color t_color;

t_color *video_buffer;
t_color *video_bg_buffer;
t_color *video_tmp_buffer;

void put_pixel(u8 x, u8 y, t_color col){
/*    maxcol = 0x001f;//g
    maxcol = 0x03e0;//r
    maxcol = 0x7c00;//b*/
    u8 lfb_index = x+y*WIDTH;
    video_buffer[lfb_index] = col;
}

t_color get_pixel(u8 x, u8 y){
    u8 lfb_index;
    lfb_index = x+y*WIDTH;
    t_color ret;
    ret = video_buffer[lfb_index];
    return ret;
}

void put_line(int x1,int y1,int x2,int y2,t_color nState)
{
    unsigned int nTmp;
    unsigned int nAlt=0;
    int x,y;        // where is the current pixel.
    int dx;     // dx is the delta for x
    int dy;     // dy is the delta for y
    int StepVal=0;  // variable for figuring out when to increment the other axis.
    if (x1>x2 && y1>y2)
    {
        nTmp=x2;
        x2=x1;
        x1=nTmp;

        nTmp=y2;
        y2=y1;
        y1=nTmp;

        dx=x2-x1;   // dx is the delta for x
        dy=y2-y1;   // dy is the delta for y
    }else
    {
        dx=x2-x1;   // dx is the delta for x
        dy=y2-y1;   // dy is the delta for y

        if (dy<0)
        {
            dy=-dy;

            nTmp=y2;
            y2=y1;
            y1=nTmp;

            nAlt=1;
        }else
            if (dx<0)
            {
                dx=-dx;

                nTmp=x2;
                x2=x1;
                x1=nTmp;

                nAlt=1;
            }
    }

    if (nAlt)
    {

        if(dx>=dy)       // The slope is less than 45 degres
        {
            y=y2;
            for(x=x1; x<=x2; x++)
            {
                // Call your function to draw a pixel here.
                put_pixel(x,y,nState);
                StepVal+=dy;
                if(StepVal>=dx) // Increment y if enough x steps
                                // have been taken.
                {
                    y--;
                    StepVal-=dx;    // Reset StepVal, but
                    // not to 0.  This gives even slopes.
                }
            }
        }
        else    // The slope is greater than 45 degrees, just like
                // above, but with y instead of x.
        {
            x=x2;
            for(y=y1; y<=y2; y++)
            {
                // Call your function to draw a pixel here.
                put_pixel(x,y,nState);
                StepVal+=dx;
                if(StepVal>=dy)
                {
                    x--;
                    StepVal-=dy;
                }
            }
        }
        return;
    }

    if(dx>=dy)       // The slope is less than 45 degres
    {
        y=y1;
        for(x=x1; x<=x2; x++)
        {
            // Call your function to draw a pixel here.
            put_pixel(x,y,nState);
            StepVal+=dy;
            if(StepVal>=dx) // Increment y if enough x steps
                            // have been taken.
            {
                y++;
                StepVal-=dx;    // Reset StepVal, but
                // not to 0.  This gives even slopes.
            }
        }
    }
    else    // The slope is greater than 45 degrees, just like
            // above, but with y instead of x.
    {
        x=x1;
        for(y=y1; y<=y2; y++)
        {
            // Call your function to draw a pixel here.
            put_pixel(x,y,nState);
            StepVal+=dx;
            if(StepVal>=dy)
            {
                x++;
                StepVal-=dy;
            }
        }
    }
    return;
}

#ifdef COLOR_TYPE_565
#ifdef BPP eq 2

#define SET_RGB(_t_color_var, R, G, B)\
    _t_color_var.rgb[0] = (u1*)(((R & 0xf8) << 0x08) | ((G & 0xfc) << 5) | (B >> 3));

#endif // BPP
#endif // COLOR_TYPE_565

void put_char(u8 x, u8 y, u1 s){
    t_color textcolor;
    SET_RGB(textcolor, 0xff, 0xff, 0x00);

    u1 bit;
    u1 bitmask;

    u8 pos=s*13;
    u8 xx, yy=y*13;

    u8 i;
    u8 j;

    for (j=0;j<13;j++){
        bitmask=font[pos+j];
        xx=x*8;
        bit=0x80;
        for (i=0;i<8;i++){
            if ((bitmask&bit)==bit){
                put_pixel(xx,yy,textcolor);
            }
            xx++;
            bit=bit/2;
        }
        yy++;
    }
}

u8 curx=1,cury=1;
#define MAXX 80

void put_string(u1 *str){
    u8 i=0;
    while (str[i] != 0){
        if (str[i] == '\n'){
            cury++;
            i++;
            continue;
        }
        if (str[i] == '\r'){
            curx = 0;
            i++;
            continue;
        }
        put_char(curx,cury,str[i]);
        i++;
        curx++;
        if (cury>=MAXX){
            curx = 0;
            cury++;
        }
    }
}

u1 *memory;
_OBJ_GLOBAL_PROPERTY(memory, req_mem);

void put_number(const u8 n, char type){
    int i=254;
    char *hh = "0123456789ABCDEF";
    u8 nn=n;
//  u1 *kbuf = kmalloc(256);
    _OBJ_SET_PROPERTY_U8(memory, req_mem, 256);
    //mtmp[0] = 256;
    u1 *kbuf = _OBJ_CALL(memory, "malloc $req_mem");
    kbuf[i+1]=0;

    if(type=='d'){
        if(nn==0){
            kbuf[i]='0';
            i--;
        }
        while(nn>0){
            kbuf[i] = nn % 10 + '0';
            nn = nn / 10;
            i--;
        }
    }else if(type=='h'){
        if(nn==0){
            kbuf[i]='0';
            i--;
        }
        while(nn>0){
            kbuf[i] = hh[nn % 16];
            nn = nn / 16;
            i--;
        }
/*      kbuf[i]='x';
        i--;
        kbuf[i]='0';
        i--;*/
    }else{
        put_string("unknown type\n\r");
    }
    put_string(&kbuf[i+1]);
    //kfree(kbuf);
    _OBJ_SET_PROPERTY_U8(memory, req_mem, kbuf);
    //mtmp[0] = kbuf;
    _OBJ_CALL(memory, "free $req_mem");
}

void put_box(u8 x0, u8 y0, u8 x1, u8 y1, t_color col){
    put_line(x0,y0, x1,y0, col);
    put_line(x1,y0, x1,y1, col);
    put_line(x0,y0, x0,y1, col);
    put_line(x0,y1, x1,y1, col);
}

void put_pixel_callback(GUID guid, u8 *params){
    t_color r;
//    r.r = 0xff;
//    r.g = 0xff;
    SET_RGB(r, 0xff, 0xff, 0x00);
    put_box(200,200,400,400,r);
}

void make_blur(){
    u8 i;
    u8 *vb = (u8)video_buffer;
    u1 *m = "\1\1\1\1\1\1\1\1";
    asm("movq %0, %%mm0"::"m"(m[0]));
    u8 mm = WIDTH*HEIGHT*BPP/4;
    for (i=0; i<mm; i++){
        asm("movq   %0, %%mm1\n"
            "psubusb    %%mm0, %%mm1\n"
            "movq   %%mm1, %0"::"m"(vb[i]));
    }
}

void show_video_buffer(){
    u8 i;

    // copy bg_buffer to tmp_buffer
    u8 sizeofbuffer = WIDTH*HEIGHT*BPP;
    //BOCHS_BP
    u8 *vb_bg = (u8)video_bg_buffer;
    u8 *vb = (u8)video_buffer;
    u8 *vb_tmp = (u8)video_tmp_buffer;
    for (i=sizeofbuffer/4; i>0; i--){
        asm("movd   %1, %%mm0\n"
            "movd   %2, %%mm1\n"
//            "pcmpeqb    %%mm1, %%mm0\n"
            "paddusb  %%mm1, %%mm0\n"
            "movd   %%mm0, %0"
            :"=m"(vb_tmp[i]):"m"(vb[i]),"m"(vb_bg[i]));
    }

//    u2 *lfb = vbe_lfb;
//    for (i=0; i<WIDTH*HEIGHT; i++){
//        //lfb[i] = (video_tmp_buffer[i].r>>3<<11) | (video_tmp_buffer[i].g>>2<<5) | (video_tmp_buffer[i].b>>3);
//        lfb[i] = ((video_tmp_buffer[i].r & 0xf8)<<0x08) | ((video_tmp_buffer[i].g & 0xfc)<<0x03) | (video_tmp_buffer[i].b>>0x03);
//        //lfb[i] = (video_tmp_buffer[i].b/8) + (((video_tmp_buffer[i].g/4)&7)<<5);
//        //lfb[i+1] = ((video_tmp_buffer[i].g/4)>>3) + ((video_tmp_buffer[i].r/8)<<3);
//    }

    for(i=sizeofbuffer/4; i>0; i--){
        asm("movd   %1, %%mm0\n"
            "movd   %%mm0, %0"
            :"=m"(vbe_lfb[i]):"m"(vb_tmp[i]));
    }
}

/*
u8 video_test(GUID guid, u8 *params){
    u8 x, y;
    t_color col;
    for (x=0; x<32; x++){
//        col.r = 0xff;
//        col.g = 0xff;
//        col.b = 0xff;
        SET_RGB(col, 0xff, 0xff, 0xff);
        for (y=0; y<32; y++){
            col.g = (31-y)*8+(32-x)*8;
            col.b = (31-y)*8+x;
            put_pixel(x, y, col);
        }
        for (y=32; y<64; y++){
            col.r = (63-y)*8;
            col.g = (32-x)*8;
            put_pixel(x, y, col);
        }
    }

    col.r = 0xff;
    put_line(10, 50, 400, 50, col);
    //put_line(500, 100, 50, 250, col);
    //put_line(300, 350, 250, 50, col);
    col.g = 0xff;

    //for(x=0; x<100000000; x++)
        //y=x+y;
    col.r=0xff;
    col.g=0x00;
    col.b=0x00;
    put_box(2,2, 797,597, col);

    col.r=0x00;
    col.g=0x4f;
    col.b=0x20;
        col.b = x;
        for(y=60; y<580; y++){
            put_line(10, y, 780, y, col);
        }

    u8 x0=100,y0=100,x1=30,y1=200;
    u8 dx0=2,dy0=1,dx1=3,dy1=1;
    u8 i=0,j;
    t_color colw, colb;
    colb.r = colb.g = colb.b = 0;
    colw.r = colw.g = colw.b = 0xff;
        colb.g = 0xff;
    while (1){
        put_line(x0,y0,x1,y1,colb);
        if(x0>=800)
            dx0=-dx0;
        if(x1>=800)
            dx1=-dx1;
        if(x0<=0)
            dx0=-dx0;
        if(x1<=0)
            dx1=-dx1;
        if(y0>=600)
            dy0=-dy0;
        if(y1>=600)
            dy1=-dy1;
        if(y0<=0)
            dy0=-dy0;
        if(y1<=0)
            dy1=-dy1;

        x0+=dx0;
        y0+=dy0;
        x1+=dx1;
        y1+=dy1;
        put_line(x0,y0,x1,y1,colw);
        j++;
        if (j>100){
            j=0;
        }
        make_blur();
        show_video_buffer();
 //       i++;
    }

    _OBJ_INIT(0, log);
    _OBJ_CALL(log, "print \"test video in object\"");
    return 0;
}
*/


struct rect{
    u8 left, top, right, bottom;
};

typedef struct rect t_rect;

void copy_rect(t_rect dst_rect, u1 *dst, t_rect src_rect, u1 *src){
    u8 x,y, ci=0;
    for(y = 0; y <= src_rect.bottom - src_rect.top; y++){
        memcpy(dst[dst_rect.left*BPP+(dst_rect.top+y)*(dst_rect.right - dst_rect.left)*BPP],
            src[src_rect.left*BPP+(src_rect.top+y)*WIDTH*BPP],
            (src_rect.right - src_rect.left)*BPP );
    }
}

void video_print_callback(GUID guid, u8 *params){
    while(initDone != true){

    }

    put_string(params[2]);
    //put_string("\n\r");
    show_video_buffer();
}

void initialize_object(){
    initDone = false;

    _OBJ_INIT(0,log);
    _OBJ_CALL(log, "print \"OBJECT VIDEO EXECUTE\"");

    u8 i;
    //for (i=0; i<10000000; i++);
//    u1 *video;
//    //BOCHS_BP
//    video = syscall(0, "create video " GUID_baseobject);
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: making video object\"");
#endif // DEBUG_VIDEO

    _OBJ_CREATE(GUID_baseobject, video);
    //tmp = syscall(video, "new_property tmp 4");
    //tmp[0] = &video_test;
    _OBJ_NEW_PROPERTY_U8(video, tmp);
//    _OBJ_SET_PROPERTY_u8(video, tmp, &video_test);
//    syscall(video, "new_method test $tmp");
//    tmp[0] = &put_pixel_callback;
    _OBJ_SET_PROPERTY_U8(video, tmp, &put_pixel_callback);
    syscall(video, "new_method putpixel $tmp");
//    tmp[0] = &video_print_callback;
    _OBJ_SET_PROPERTY_U8(video, tmp, &video_print_callback);
    syscall(video, "new_method print $tmp");
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: added methods: test, putpixel, print\"");
#endif // DEBUG_VIDEO

    _OBJ_INIT_GLOBAL(0,memory);

//    mtmp = _OBJ_CALL(memory, "new_property tmp 4");
//    mtmp1 = _OBJ_CALL(memory, "new_property tmp1 4");
//    //mtmp[0] = VBE_DISPI_LFB_PHYSICAL_ADDRESS;
//    mtmp[0] = (u8)d[0];
//    mtmp1[0] = 1024*768*3*3;

    _OBJ_NEW_PROPERTY_U8_GLOBAL(memory, req_mem);
    //_OBJ_SET_PROPERTY_u8(memory, tmp, (u8)d[0]);
    //mtmp = _OBJ_CALL(memory, "new_property tmp 4");
    //mtmp1 = _OBJ_CALL(memory, "new_property tmp1 4");
//    mtmp[0] = VBE_DISPI_LFB_PHYSICAL_ADDRESS;
    //mtmp[0] = (u8)d[0];
    //mtmp[0] = 1024*768*3*3;
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: require video memory 1024x768\"");
#endif // DEBUG_VIDEO
    _OBJ_SET_PROPERTY_U8(memory, req_mem, 1024*768*3*3);

    vbe_lfb = _OBJ_CALL(memory, "get_video_mem $req_mem");
    //mtmp[0] = WIDTH*HEIGHT*BPP+100;
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: require memory for buffers...\"");
#endif // DEBUG_VIDEO
    _OBJ_SET_PROPERTY_U8(memory, req_mem, WIDTH*HEIGHT*BPP+100);
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: video_buffer\"");
#endif // DEBUG_VIDEO
    video_buffer = _OBJ_CALL(memory, "malloc $req_mem");
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: video_bg_buffer\"");
#endif // DEBUG_VIDEO
    video_bg_buffer = _OBJ_CALL(memory, "malloc $req_mem");
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: video_tmp_buffer\"");
#endif // DEBUG_VIDEO
    video_tmp_buffer = _OBJ_CALL(memory, "malloc $req_mem");
    u8* s = 0x10000;
    s[0] = video_buffer;

#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: printing hello message\"");
#endif // DEBUG_VIDEO
    put_string("PIXITALIPHINA Operation system (c) 2009-2016\n\r");
    t_color col = {0x00,0x00,0xff};
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: draw some elements\"");
#endif // DEBUG_VIDEO
    put_line(0,14,800,14,col);

#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: print test number 12345678\"");
#endif // DEBUG_VIDEO
    put_number(1234567890, 'd');
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: show buffer\"");
#endif // DEBUG_VIDEO
    show_video_buffer();
#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: print test number 12345678\"");
#endif // DEBUG_VIDEO
    put_number(1234567890, 'd');
    put_string("\n\r");

//    u2 *screen = (u2*)vbe_lfb;
//    for(i=0; i<=800*600*2; i++){
//        screen[i] = 0xffff;q
//    }

#ifdef DEBUG_VIDEO
    _OBJ_CALL(log, "print \"OBJECT VIDEO: now read background image..\"");
#endif // DEBUG_VIDEO
    _OBJ_INIT(0,fs);
    _OBJ_CALL(fs, "fopen /BG");
    u8 sizeoffile = _OBJ_CALL(fs, "fsize");
    u1 *fbuf;
    //mtmp[0] = sizeoffile;
    _OBJ_SET_PROPERTY_U8(memory, req_mem, sizeoffile+100);
    fbuf = _OBJ_CALL(memory, "malloc $req_mem");
//    mtmp1 = _OBJ_CALL(fs, "new_property data 4");
//    mtmp1[0] = f;
    _OBJ_NEW_PROPERTY_U8(fs, data);
    _OBJ_SET_PROPERTY_U8(fs, data, fbuf)
    asm("xchg %bx, %bx");
    _OBJ_CALL(fs, "fread $data");
    memset(video_bg_buffer,0,WIDTH*HEIGHT*BPP);
    u8 x,y,j=0x3d5;
//    for (y=60; y<60+480; y++){
//        for (x=80; x<80+640; x++){
//            i = x+y*800;
////            video_bg_buffer[i].r = f[j].g;
////            video_bg_buffer[i].g = f[j].b;
////            video_bg_buffer[i].b = f[j].r;
//            SET_RGB(video_bg_buffer[i], fbuf[j], )
//            j++;
//        }
//    }
//    memset(video_tmp_buffer,0,800*600*3);
    show_video_buffer();

    initDone = true;

    u8 d = _OBJ_CALL(log, "print \"TEST!!!\"");

/*    _OBJ_INIT(0, system);
    _OBJ_CALL(system, "sleep");*/

    u8 st = 0;
    u8 ii=0;

    t_rect dst = {0,0,100,100};
    t_rect dst1 = {100,100,200,200};
//    mtmp[0] = (dst.right-dst.left)*BPP*(dst.bottom-dst.top);
    _OBJ_SET_PROPERTY_U8(memory, req_mem, sizeoffile);
    u1 *mem = _OBJ_CALL(memory, "malloc $req_mem");

    put_box(0,0,100,100,(t_color){255,55,25});
    //copy_rect(dst, mem, dst, video_buffer);

    _OBJ_INIT(0, system);

    while(1){
//        if (ii>100){
    copy_rect(dst1, video_tmp_buffer, dst, mem);
            st++;
            put_string("\rcounter: ");
            put_number(st, 'd');
            show_video_buffer();
            ii=0;
//        }
//        ii++;
        _OBJ_CALL(system, "sleep 1")
    };
}
