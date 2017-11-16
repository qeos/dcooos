#include "types.h"
#include "strings.h"

// Copy len bytes from src to dest.
void memcpy(s1 *dest, const s1 *src, u8 len)
{
    s1 *tmp = dest;
    const s1 *some_var = src;

    while(len--)
        *tmp++ = *some_var++;
}

// Write len copies of val into dest.
void memset(s1 *dest, s1 val, u8 len)
{
    s1 *xs = dest;
    while(len--)
        *xs++ = val;
}

// Compare two strings. Should return -1 if
// str1 < str2, 0 if they are equal or 1 otherwise.
u8 strcmp(s1 *str1, s1 *str2)
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
s1 *strcpy(s1 *dest, const s1 *src)
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
s1 *strncpy(s1 *dest, const s1 *src, u8 len)
{
    int i=len-1;
    while(i>=0){
        dest[i] = src[i];
        i--;
    }
}
// Concatenate the NULL-terminated string src onto
// the end of dest, and return dest.
s1 *strcat(s1 *dest, const s1 *src)
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
u8 strchr(s1 *str, s1 ch)
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

u8 strlen(s1 *src)
{
    u8 i = 0;
    while (*src++)
        i++;
    return i;
}

u8 str2int(s1 *str){
    int i=0;
    u8 j=0, k=1;
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


u8 str2hex(s1 *str){
    int i=0;
    u8 j=0, k=1;
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

