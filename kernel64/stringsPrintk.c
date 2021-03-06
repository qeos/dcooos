#include "main.h"
#include "types.h"
#include "time.h"
#include "task.h"

GCS_CREATE(printk_syslog);

void printk_syslog(s1 *text){

    CLI

    GCS_WAIT(printk_syslog);

    GCS_BEGIN(printk_syslog);

    int i=0;
    u8 j=0;

    while(text[i] != 0){
        serial_out(text[i]);
        i++;
        // need pause for com buffers to be free
        for(j=0;j<1000;j++){
            asm volatile("nop");
        }
    }

    GCS_DONE(printk_syslog);

    STI

}

s1 *kbuf_number = "###############################";

void printk_syslog_number(const u8 n, u1 type){

    CLI

    u8 i=30;
    s1 *hh = "0123456789ABCDEF";
    u8 nn=n;
    kbuf_number[i+1]=0;

    if(type=='d'){
        if(nn==0){
            kbuf_number[i]='0';
            i--;
        }
        while(nn>0){
            kbuf_number[i] = nn % 10 + '0';
            nn = nn / 10;
            i--;
        }
    }else if(type=='h'){
        if(nn==0){
            kbuf_number[i]='0';
            i--;
        }
        while(nn>0){
            kbuf_number[i] = hh[nn % 16];
            nn = nn / 16;
            i--;
        }
    }else{
        printk_syslog("unknown type\n\r");
    }
    printk_syslog(&kbuf_number[i+1]);

    STI
}

s1 *kbuf_numberInFormat = "################################";
int kbuf_numberInFormatLen = 30;

s1 *sprintk_syslog_numberInFormat(const u8 n, u1 type, u8 len){

    CLI

    u8 i=kbuf_numberInFormatLen;
    s1 *hh = "0123456789ABCDEF";
    u8 nn=n;
    kbuf_numberInFormat[i+1]=0;

    if(type=='d'){
        if(nn==0){
            kbuf_numberInFormat[i]='0';
            i--;
        }
        while(nn>0){
            kbuf_numberInFormat[i] = nn % 10 + '0';
            nn = nn / 10;
            i--;
        }
    }else if(type=='h'){
        if(nn==0){
            kbuf_numberInFormat[i]='0';
            i--;
        }
        while(nn>0){
            kbuf_numberInFormat[i] = hh[nn % 16];
            nn = nn / 16;
            i--;
        }
        while(kbuf_numberInFormatLen-i<len){
            kbuf_numberInFormat[i]='0';
            i--;
        }
    }else if(type=='b'){
        if(nn==0){
            kbuf_numberInFormat[i]='0';
            i--;
        }
        while(nn>0){
            if((nn & 1) == 0){
                kbuf_numberInFormat[i]='0';
            }else{
                kbuf_numberInFormat[i]='1';
            }
            nn=nn>>1;
            i--;
        }
        while(kbuf_numberInFormatLen-i<len){
            kbuf_numberInFormat[i]='0';
            i--;
        }
    }else{
        printk_syslog("unknown type\n\r");
    }
    STI

    return &kbuf_numberInFormat[i+1];
}

void printk_syslog_numberInFormat(const u8 n, u1 type, u8 len){
    printk_syslog(sprintk_syslog_numberInFormat(n, type, len));
}
