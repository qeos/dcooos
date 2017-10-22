#include "main.h"
#include "types.h"
#include "time.h"

t_time startup_time;

void getTime(){
    u1 options;

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
    asm("rdtsc":"=a"(startupTime.lo_tick), "=d"(startupTime.hi_tick));

}

u8 get_globalticks(){
    getTime();
    return startup_time.hi_tick<<32+startup_time.lo_tick;
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
    printk_syslog_numberInFormat(startupTime.hi_tick,'d',2);
    printk_syslog(", ");
    printk_syslog_numberInFormat(startupTime.lo_tick,'d',2);
    printk_syslog(")\n");
}

void init_time(){

    getTime();
#if DEBUG_LEVEL & E_NOTICE
    printk_syslog_currentTime();
#endif

#if DEBUG_LEVEL & E_NOTICE
    printk_syslog("TIMER init done.\n");
#endif // DEBUG_LEVEL
}
