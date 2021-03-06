#include "../main.h"
#include "../types.h"
#include "../idt.h"
#include "../ioport.h"
#include "../strings.h"
#include "../task.h"

#define HDD_PRIMARY_PORT    0x1f0
#define HDD_SECONDARY_PORT  0x170

#define HDD_STATE_BUSY      0x80    // Busy bit
#define HDD_STATE_DRDY      0x40    // Drive Ready bit
#define HDD_STATE_DWF       0x20    // Drive Write Fault bit
#define HDD_STATE_DSC       0x10    // Drive Seek Complete bit
#define HDD_STATE_DRQ       0x08    // Data Request bit
#define HDD_STATE_CORR      0x04    // Corrected Data bit
#define HDD_STATE_INDEX     0x02    // Index bit
#define HDD_STATE_ERROR     0x01    // Error bit

u2 hdd_port;


// ----------------------------------------------------------------------------------------
void hdd_reset(){
    outb(0x3f6, 0x04);
    outb(0x3f6, 0x00);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);

    u1 state = inb(0x3f6);
    //while ((state & 0xc0) != 0x40){
    while ((state & (HDD_STATE_BUSY | HDD_STATE_DRDY)) != HDD_STATE_DRDY){
        state = inb(0x3f6);
    }
}

u8 hdc_drive_busy(){
    u4 count = 0x400000;
    u1 state = inb(hdd_port+7);

    while((state & HDD_STATE_BUSY) == HDD_STATE_BUSY){
        count--;
        if(count < 2){
            printk_syslog_timestamp();
            printk_syslog("HDD: busy.\n");
            return true;
        }
        u1 c;
        for(c=0;c<10;c++); // delay need >400ms (50-100 clock)
        //switch_task(0); // make delay by switching a task
        state = inb(hdd_port+7);
    }

    return false;
}

u8 hdc_drive_ready(){
    u4 count = 0x400000;
    u1 state = inb(hdd_port+7);

    while((state & HDD_STATE_DRDY) != HDD_STATE_DRDY){
        count--;
        if(count < 2){
            printk_syslog_timestamp();
            printk_syslog("HDD: not ready.\n");
            return false;
        }
        u1 c;
        for(c=0;c<10;c++); // delay need >400ms (50-100 clock)
        //switch_task(0); // make delay by switching a task
        state = inb(hdd_port+7);
    }

    return true;
}

u8 hdc_drive_seek(){
    u4 count = 0x400000;
    u1 state = inb(hdd_port+7);

    while((state & HDD_STATE_DSC) != HDD_STATE_DSC){
        count--;
        if(count < 2){
            printk_syslog_timestamp();
            printk_syslog("HDD: seeking.\n");
            return true;
        }
        u1 c;
        for(c=0;c<10;c++); // delay need >400ms (50-100 clock)
        //switch_task(0); // make delay by switching a task
        state = inb(hdd_port+7);
    }

    return false;
}

u4 hdc_drive_data_ready(){
    u4 count = 0x400000;
    u1 state = inb(hdd_port+7);

    while((state & HDD_STATE_DRQ) != HDD_STATE_DRQ){
        count--;
        if(count < 2){
            printk_syslog_timestamp();
            printk_syslog("HDD: data not ready.\n");
            return false;
        }
        u1 c;
        for(c=0;c<10;c++); // delay need >400ms (50-100 clock)
        //switch_task(0); // make delay by switching a task
        state = inb(hdd_port+7);
    }

    return true;
}

u8 hdc_drive_error(){
    u1 state = inb(hdd_port+7);
    return (state & HDD_STATE_ERROR) == HDD_STATE_ERROR;
}

// ----------------------------------------------------------------------------------------
void hdd_read_sector_nosafe(u2 *buff, u8 sector){
//(!hdd_port & 0x80)>>4

    if(!hdc_drive_ready()){
        return;
    }
    if(hdc_drive_busy()){
        return;
    }

    if(hdc_drive_seek()){
        return;
    }

    if(hdc_drive_error()){
        printk_syslog_timestamp();
        printk_syslog("HDD: drive error\n");
        return;
    }

    // TODO: see how it work for long mode
    outb(hdd_port+2, 1);    // sector count
    outb(hdd_port+3, (sector&0x000000ff));
    outb(hdd_port+4, (sector&0x0000ff00)>>8);
    outb(hdd_port+5, (sector&0x00ff0000)>>16);
    outb(hdd_port+6,((sector&0x0f000000)>>24) | 0x40 | ((!hdd_port & 0x80)>>3));
    // mov     dx,01F1h                        ; Write Precompensation = 0...
    if(hdc_drive_busy()){
        return;
    }
    // read command
    outb(hdd_port+7, 0x20);

    if(hdc_drive_busy()){
        return;
    }
    if(!hdc_drive_data_ready()){
        return;
    }

    // ready to read
    u4 count;
    for (count=0; count<0x100; count++){
        buff[count] = inw(hdd_port);
//        state = inb(hdd_port+7);
    }

}

void hdd_write_sector_nosafe(u2 *buff, u8 sector){
//(!hdd_port & 0x80)>>4

    if(!hdc_drive_ready()){
        return;
    }
    if(hdc_drive_busy()){
        return;
    }

    if(hdc_drive_seek()){
        return;
    }

    if(hdc_drive_error()){
        printk_syslog_timestamp();
        printk_syslog("HDD: drive error\n");
        return;
    }

    outb(hdd_port+2, 1);    // sector count
    outb(hdd_port+3, (sector&0x000000ff));
    outb(hdd_port+4, (sector&0x0000ff00)>>8);
    outb(hdd_port+5, (sector&0x00ff0000)>>16);
    outb(hdd_port+6,((sector&0x0f000000)>>24) | 0x40 | ((!hdd_port & 0x80)>>3));
    // mov     dx,01F1h                        ; Write Precompensation = 0...
    if(hdc_drive_busy()){
        return;
    }
    // write command
    outb(hdd_port+7, 0x30);

    if(hdc_drive_busy()){
        return;
    }
    if(!hdc_drive_data_ready()){
        return;
    }

    // ready to write
    u4 count;
    for (count=0; count<0x100; count++){
        outw(hdd_port, buff[count]);
//        state = inb(hdd_port+7);
    }

}

GCS_CREATE(hdd_read);

void hdd_read_sector(unsigned char *buff, u8 sector){
#if DEBUG(E_NOTICE, ES_HDD)
    printk_syslog_timestamp();
    printk_syslog("HDD: read sector: ");
    printk_syslog_number(sector,'h');
    printk_syslog(" \n");
#endif

    GCS_WAIT_TIMEOUT(hdd_read, 1000);

    if(GCS_IN_USE(hdd_read)){
        printk_syslog_timestamp();
        printk_syslog("HDD: !!! Time out for waiting HDC...\n");
        return;
    }

    GCS_BEGIN(hdd_read);

    hdd_read_sector_nosafe((u2*)buff, sector);

    GCS_DONE(hdd_read);

    //switch_task();

}

void hdd_write_sector(unsigned char *buff, u4 sector){
#if DEBUG(E_NOTICE, ES_HDD)
    printk_syslog_timestamp();
    printk_syslog("HDD: write sector: ");
    printk_syslog_number(sector,'h');
    printk_syslog(" \n");
#endif

    GCS_WAIT_TIMEOUT(hdd_read, 1000);

    if(GCS_IN_USE(hdd_read)){
        printk_syslog_timestamp();
        printk_syslog("HDD: !!! Time out for waiting HDC...\n");
        return;
    }

    GCS_BEGIN(hdd_read);

    hdd_write_sector_nosafe((u2*)buff, sector);

    GCS_DONE(hdd_read);

    //switch_task();

}

void detect_hdd(){
    outb(0x3f6, 4);
    outb(0x3f6, 0);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);
    while((inb(0x3f6) & 0xc0) != 0x40);

    outb(0x1f6, 0xa0);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);
    inb(0x3f6);

    u1 cl = inb(0x1f4);
    u1 ch = inb(0x1f5);

    /* differentiate ATA, ATAPI, SATA and SATAPI */
#if DEBUG(E_NOTICE, ES_HDD)
    printk_syslog_timestamp();
    printk_syslog("HDD drive (primary master) is: ");
    if (cl==0x14 && ch==0xEB)
        printk_syslog("PATAPI");
    else if (cl==0x69 && ch==0x96)
        printk_syslog("SATAPI");
    else if (cl==0 && ch == 0)
        printk_syslog("PATA");
    else if (cl==0x3c && ch==0xc3)
        printk_syslog("SATA");
    else
    {
        printk_syslog("UNKNOWN: cl=0x");
        printk_syslog_number(cl, 'h');
        printk_syslog(" ch=0x");
        printk_syslog_number(ch, 'h');
    }
    printk_syslog("\n");
#endif
}

u1 buf[512];
extern boot_drive_read_sector;
extern boot_drive_write_sector;

void hdd_callback(registers_t *reg){

    GCS_DONE(hdd_read);

}

void init_hdd(u1 Boot_drive){

    if (Boot_drive == 0x80){
        hdd_port = HDD_PRIMARY_PORT;
    }else if (Boot_drive == 0x81){
        hdd_port = HDD_SECONDARY_PORT;
    }

    // detect
    detect_hdd();

    // 46 for primary
    register_interrupt_handler(46, &hdd_callback);

    hdd_reset();

    // TODO: what for?
//    hdd_read_sector(buf, 1942);
//    hdd_read_sector(buf, 1941);

    boot_drive_read_sector = &hdd_read_sector;
    boot_drive_write_sector = &hdd_write_sector;

    //register_interrupt_handler(0x2e, &hdd_callback);

    // Turning motor off
    //outb (0x3F2, 0xC);

    printk_syslog_timestamp();
    printk_syslog("HDD init done.\n");
}
