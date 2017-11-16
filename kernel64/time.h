#ifndef TIME_H_INCLUDED
#define TIME_H_INCLUDED

typedef struct time{
    u8 gticks;
    u1 seconds;
    u1 minutes;
    u1 hours;
    u1 day;
    u1 month;
    u2 year;
}t_time;

#define RTCaddress  0x70
#define RTCdata     0x71

static t_time startupTime;

#endif // TIME_H_INCLUDED
