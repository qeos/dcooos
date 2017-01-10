#include "main.h"
#include "types.h"
#include "time.h"

void printk_syslog(u1 *text){
    int i=0;

    while(text[i] != 0){
        serial_out(text[i]);
        i++;
    }

}

u1 *kbuf_number = "###############################";

void printk_syslog_number(const u8 n, u1 type){
    u8 i=30;
    u1 *hh = "0123456789ABCDEF";
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
}

u1 *kbuf_numberInFormat = "###############################";

u1 *printk_syslog_numberInFormat(const u8 n, u1 type, u8 len){
    u8 i=254, j=0;
    u1 *hh = "0123456789ABCDEF";
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
        while(254-i<len){
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
        while(254-i<len){
            kbuf_numberInFormat[i]='0';
            i--;
        }
    }else{
        printk_syslog("unknown type\n\r");
    }
    printk_syslog(&kbuf_numberInFormat[i+1]);
}

