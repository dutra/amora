
#include <kstdio.h>
#include <sysinit.h>


int main() {

    kprints("Starting Amora...\r\n\r\n");

    sysinit();

    kprints("System Initialized...\r\n");

    while(1);


}
