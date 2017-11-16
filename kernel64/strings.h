#ifndef STRINGS_H_INCLUDED
#define STRINGS_H_INCLUDED

void memcpy(s1 *dest, const s1 *src, u8 len);
void memset(s1 *dest, s1 val, u8 len);
u8 strcmp(s1 *str1, s1 *str2);
s1 *strcpy(s1 *dest, const s1 *src);
s1 *strncpy(s1 *dest, const s1 *src, u8 len);
s1 *strcat(s1 *dest, const s1 *src);
u8 strchr(s1 *str, s1 ch);
u8 strlen(s1 *src);
u8 str2int(s1 *str);
u8 str2hex(s1 *str);

void printk_syslog(s1 *text);
void printk_syslog_number(const u8 n, u1 type);
s1 *sprintk_syslog_numberInFormat(const u8 n, u1 type, u8 len);
void printk_syslog_numberInFormat(const u8 n, u1 type, u8 len);

#endif // STRINGS_H_INCLUDED
