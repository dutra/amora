
#include <sysinit.h>
#include <armv7a_watchdog.h>

void sysinit() {
    
    // stop watchdog timer in order to prevent cpu from resetting
    watchdog_stop();
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
