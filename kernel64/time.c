#include "main.h"
#include "types.h"
#include "time.h"
#include "strings.h"
#include "ioport.h"

static t_time startupTime;
//t_time startup_time;

void getTime(){

//    CLI
    do{
        outb(RTCaddress, 10);
    }while((inb(RTCdata)&0x80) != 0x80);

//            second = (second & 0x0F) + ((second / 16) * 10);
//            minute = (minute & 0x0F) + ((minute / 16) * 10);
//            hour = ( (hour & 0x0F) + (((hour & 0x70) / 16) * 10) ) | (hour & 0x80);
//            day = (day & 0x0F) + ((day / 16) * 10);
//            month = (month & 0x0F) + ((month / 16) * 10);
//            year = (year & 0x0F) + ((year / 16) * 10);


// think its minutes, need to check again
    outb(RTCaddress, 0);
    startupTime.seconds = inb(RTCdata);
    startupTime.seconds = (startupTime.seconds & 0x0F) + ((startupTime.seconds / 16) * 10);
    outb(RTCaddress, 2);
    startupTime.minutes = inb(RTCdata);
    startupTime.minutes = (startupTime.minutes & 0x0F) + ((startupTime.minutes / 16) * 10);
    outb(RTCaddress, 4);
    startupTime.hours = inb(RTCdata);
    startupTime.hours = ( (startupTime.hours & 0x0F) + (((startupTime.hours & 0x70) / 16) * 10) ) | (startupTime.hours & 0x80);
    outb(RTCaddress, 7);
    startupTime.day = inb(RTCdata);
    startupTime.day = (startupTime.day & 0x0F) + ((startupTime.day / 16) * 10);
    outb(RTCaddress, 8);
    startupTime.month = inb(RTCdata);
    startupTime.month = (startupTime.month & 0x0F) + ((startupTime.month / 16) * 10);
    outb(RTCaddress, 9);
    startupTime.year = inb(RTCdata);
    startupTime.year = (startupTime.year & 0x0F) + ((startupTime.year / 16) * 10) + 2000;
//    STI
//    asm volatile("rdtsc":"=a"(startupTime.lo_tick), "=d"(startupTime.hi_tick));
    asm volatile("rdtsc":"=a"(startupTime.gticks));

}

u8 get_globalticks(){
//    getTime();

//    asm volatile("rdtsc;\r\
//                 shlq $32, %%rdx;\r\
//                 orl %%eax, %%edx":"=d"(startupTime.gticks));

    asm volatile("rdtsc":"=a"(startupTime.gticks));

//#if DEBUG(E_NOTICE, ES_TIME)
//    printk_syslog("TIMER: get global ticks: ");
//    printk_syslog_number(startupTime.gticks, 'd');
//    printk_syslog("\n");
//#endif // DEBUG
    return startupTime.gticks;
}

void printk_syslog_timestamp(){
#if DEBUG(E_NOTICE, ES_TIME | ES_TIMESTAMP)
    u8 gt = get_globalticks();
    printk_syslog_numberInFormat(gt,'d',16);
    printk_syslog(": ");
#endif
}

void printk_syslog_currentTime(){
    getTime();
    printk_syslog("Current time is: ");
    printk_syslog_numberInFormat(startupTime.year,'d',4);
    printk_syslog("/");
    printk_syslog_numberInFormat(startupTime.month,'d',2);
    printk_syslog("/");
    printk_syslog_numberInFormat(startupTime.day,'d',2);
    printk_syslog(" ");
    printk_syslog_numberInFormat(startupTime.hours,'d',2);
    printk_syslog(":");
    printk_syslog_numberInFormat(startupTime.minutes,'d',2);
    printk_syslog(":");
    printk_syslog_numberInFormat(startupTime.seconds,'d',2);
    printk_syslog(" (");
    printk_syslog_numberInFormat(startupTime.gticks,'d',16);
    printk_syslog(")\n");
}

extern u8 ticks_per_process;

void init_time(){

    u8 ticks_per_process_before;
    u8 ticks_per_process_after;
    u8 ticks_per_process_delta;

    getTime();
    // calculate speed of system
    ticks_per_process_before = get_globalticks();

    u1 cursec = startupTime.seconds + 2;
    if(cursec > 59) cursec = 2;
    while(cursec != startupTime.seconds) getTime();

    ticks_per_process_after = get_globalticks();
    ticks_per_process_delta = ticks_per_process_after - ticks_per_process_before;
    ticks_per_process = ticks_per_process_delta >> 19;
    if(ticks_per_process > 100) ticks_per_process = 10;


#if DEBUG(E_NOTICE, ES_TIME)
    printk_syslog_currentTime();

    printk_syslog_timestamp();
    printk_syslog("TIMER: ticks: after - before = delta >> 19 = time: ");
    printk_syslog_number(ticks_per_process_after, 'd');
    printk_syslog(" - ");
    printk_syslog_number(ticks_per_process_before, 'd');
    printk_syslog(" = ");
    printk_syslog_number(ticks_per_process_delta, 'd');
    printk_syslog(" >> 19 = ");
    printk_syslog_number(ticks_per_process, 'd');
    printk_syslog("\n");
#endif

#if DEBUG(E_NOTICE, ES_TIME)
    printk_syslog_timestamp();
    printk_syslog("TIMER init done.\n");
#endif // DEBUG_LEVEL
}
