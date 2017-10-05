#include "types.h"

// Copy len bytes from src to dest.
void memcpy(u1 *dest, const u1 *src, u8 len)
{
    u1 *tmp = dest;
    const u1 *s = src;

    while(len--)
        *tmp++ = *s++;
}

// Write len copies of val into dest.
void memset(u1 *dest, u1 val, u8 len)
{
    u1 *xs = dest;
    while(len--)
        *xs++ = val;
}

// Compare two strings. Should return -1 if
// str1 < str2, 0 if they are equal or 1 otherwise.
u8 strcmp(u1 *str1, u1 *str2)
{
      u8 i = 0;
      u8 failed = 0;
      while(str1[i] != '\0' && str2[i] != '\0')
      {
          if(str1[i] != str2[i])
          {
              failed = 1;
              break;
          }
          i++;
      }
      // why did the loop exit?
      if( (str1[i] == '\0' && str2[i] != '\0') || (str1[i] != '\0' && str2[i] == '\0') )
          failed = 1;

      return failed;
}
// Copy the NULL-terminated string src into dest, and
// return dest.
u1 *strcpy(u1 *dest, const u1 *src)
{
    do
    {
      *dest++ = *src++;
    }
    while (*src != 0);
    *dest++ = 0;
}
// Copy the NULL-terminated string src into dest, and
// return dest.
u1 *strncpy(u1 *dest, const u1 *src, u8 len)
{
    u8 i=len-1;
    while(i>=0){
        dest[i] = src[i];
        i--;
    }
}
// Concatenate the NULL-terminated string src onto
// the end of dest, and return dest.
u1 *strcat(u1 *dest, const u1 *src)
{
    while (*dest != 0)
    {
        *dest = *dest++;
    }

    do
    {
        *dest++ = *src++;
    }
    while (*src != 0);
    return dest;
}
// Search first position of char in string
u8 strchr(u1 *str, u1 ch)
{
    u8 i=0;
    while(str[i]!=0){
        if(str[i]==ch){
            return i;
        }
        i++;
    }
    return 0;
}

u8 strlen(u1 *src)
{
    u8 i = 0;
    while (*src++)
        i++;
    return i;
}

u8 str2int(u1 *str){
    u8 i=0, j=0, k=1;
    while( ((str[i]>='0') && (str[i]<='9')) ){
        i++;
    }
    i--;
    while( i>=0 ){
        j = j + (str[i] - '0') * k;
        k *= 10;
        i--;
    }
    return j;
}


u8 str2hex(u1 *str){
    u8 i=0, j=0, k=1;
    while( ((str[i]>='0') && (str[i]<='9')) || ((str[i]>='a') && (str[i]<='f')) || ((str[i]>='A') && (str[i]<='F')) ){
        i++;
    }
    i--;
    while( i>=0 ){
        if  ((str[i]>='a') && (str[i]<='f')){
            j = j + (str[i] - 'a' + 10) * k;
        }else if  ((str[i]>='A') && (str[i]<='F')){
            j = j + (str[i] - 'A' + 10) * k;
        }else if  ((str[i]>='0') && (str[i]<='9')){
            j = j + (str[i] - '0') * k;
        }
        k *= 16;
        i--;
    }
    return j;
}

