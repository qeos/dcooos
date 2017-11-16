#include "types.h"
#include "strings.h"

// exploding string where element 0 has contrained count of elements
// strgroup - group chars like strings: explode(" ", "str1 str2 'str3 str4' str5", "'") = ["str1","str2","str3 str4", "str5"]
u8 *explode(u1 *delim, u1 *str, u1 *strgroup){
#ifdef DEBUG_SYSCALL
#ifdef DEBUG_LEVEL_0
        printk_syslog("SYSCALL: function explode('");
        printk_syslog(delim);
        printk_syslog("', '");
        printk_syslog(str);
        printk_syslog("', '");
        printk_syslog(strgroup);
        printk_syslog("')\n");
#endif
#endif
    u8 i=0, j;
    u8 len_str = strlen(str);
    u8 *big_array = (u8*)kmalloc(len_str/2*4);
    u8 big_array_index = 0;
    u8 isstr = -1;
    u1 *tmpstr = (u1*)kmalloc(len_str);
    u8 tmpstr_index = 0;
    u1 *new_str;
    while (str[i] != 0){
//#ifdef DEBUG_SYSCALL
//#ifdef DEBUG_LEVEL_0
//        printk_syslog("str[i] != 0, tmpstr='");
//        printk_syslog(tmpstr);
//        printk_syslog("'\n");
//#endif
//#endif
        // check for strings
        j = 0;
        while (strgroup[j] != 0){
            if (str[i] == strgroup[j]){
                isstr = -isstr;
                // skip string char
//#ifdef DEBUG_SYSCALL
//#ifdef DEBUG_LEVEL_0
//                printk_syslog("  This is string char.\n");
//#endif
//#endif
                i++;
                continue;
            }
            j++;
        }

        if (isstr == -1){
            if (delim[0] == str[i]){
                j = 0;
                while ((delim[j] != 0) && (delim[j] == str[i+j])){
                    j++;
                }
                if (delim[j] == 0){
//#ifdef DEBUG_SYSCALL
//#ifdef DEBUG_LEVEL_0
//                    printk_syslog("    This is delimiter.\n");
//#endif
//#endif
                    // add new str to array
                    tmpstr[tmpstr_index] = 0;
                    new_str = (u1*)kmalloc(tmpstr_index+1);
                    strcpy(new_str, tmpstr);
                    new_str[tmpstr_index] = 0;
#ifdef DEBUG_SYSCALL
#ifdef DEBUG_LEVEL_0
                    printk_syslog("SYSCALL:\tAdd string '");
                    printk_syslog(new_str);
                    printk_syslog("'\n");
#endif
#endif
                    big_array[big_array_index] = new_str;
                    big_array_index++;
                    tmpstr_index = 0;
                    i+=j;
                    continue;
                }
            }
        }

        tmpstr[tmpstr_index] = str[i];
        tmpstr_index++;
        i++;
    }

    // add new str to array
    tmpstr[tmpstr_index] = 0;
    new_str = (u1*)kmalloc(tmpstr_index+1);
    strcpy(new_str, tmpstr);
    new_str[tmpstr_index] = 0;
#ifdef DEBUG_SYSCALL
#ifdef DEBUG_LEVEL_0
                    printk_syslog("SYSCALL:\tAdd string '");
                    printk_syslog(new_str);
                    printk_syslog("'\n");
#endif
#endif
    big_array[big_array_index] = new_str;
    big_array_index++;
    tmpstr_index = 0;

    u8 *out_array = (u8*)kmalloc((big_array_index+1)*4);
    for (j=0; j<big_array_index; j++){
        out_array[j+1] = big_array[j];
    }
    out_array[0] = big_array_index;

    kfree(tmpstr);
    kfree(big_array);

    return out_array;
}

void free_explode_array(u8 *array){
    u8 i = array[0];
    for (;i>0; i--){
        kfree(array[i]);
    }
    kfree(array);
}


