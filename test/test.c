#include "../kernel64/types.h"
#include "../kernel64/syscall.h"
#include "../kernel64/objects.h"

void initialize_object(){

    _OBJ_INIT(0,log);

    _OBJ_CALL(log, "print \"OBJECT VIDEO EXECUTE\"");

    while(1==1);

}
