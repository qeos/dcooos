void _main(){
    // *********************************************************************
    // INITIALIZATION
    // *********************************************************************

    char *scr = 0xb8000;

    char *s = "Hello world from kernel under x64";

    do{
        *scr++ = *s++;
        *scr++ = 0xff;
    }while(*s != 0);

    while(1==1);

}
