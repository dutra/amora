
#include <sysinit.h>
#include <armv7a_watchdog.h>
#include <armv7a.h>
#include <kstdio.h>

extern void init_ivt(void);
extern void enable_interrupts(void);
extern void software_interrupt(void);

void sysinit() {


    // stop watchdog timer in order to prevent cpu from resetting
    kprints("Stopping WatchDog\r\n");
//    kprintc('S');
    watchdog_stop();

    // initialize Interrupt Vector Table
    kprints("Initializing Interrupt Vector Table\r\n");
    init_ivt();

    // enable interrupts
    kprints("Enabling Interrupts\r\n");
    enable_interrupts();

    kprints("Calling SWI\r\n");
    software_interrupt();
    kprintc('Q');

}

void watchdog_stop() {

    // WatchDog register pointer
    struct watchdog_csreg *wdptr;
    wdptr = (struct watchdog_csreg *) WDTADDR;

    // To stop WatchDog, first write xxx AAAAh to WSPR
    wdptr->wspr = 0x0000AAAA;

    // Wait until Write-pending register for WSPR is empty
    while(wdptr->wwps & 0x00000010);

    // Then write xxxx 5555h to WSPR
    wdptr->wspr = 0x00005555;

    // Wait until Write-pending register for WSPR is empty
    while(wdptr->wwps & 0x00000010);

}
