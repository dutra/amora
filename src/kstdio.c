
#include <armv7a.h>
#include <types.h>
#include <kstdio.h>

/* kprintc
* Writes a character into the serial line. Supervisor use only since it stalls CPU until the
    transmission FIFO is empty.
* @c: Character to be sent
*/
void kprintc(char c) {

    /* check if THX FIFO is full */
    volatile uint32_t *uart0_lsr = (uint32_t *) UART0_LSR_UART;
    while((*uart0_lsr & (UART0_LSR_TEMT)) == 0);

    /* write to THX register */
    volatile uint8_t *uart0_base =  (uint8_t *) UART0_BASE;

    *uart0_base = c;

}

/* kprints
* Writes a string into the serial line. Supervisor use only since it stalls CPU until the
    transmission FIFO is empty.
* @s: Pointer to string to be send
*/
void kprints(const char *s) {
    while(*s != 0) {
        kprintc(*s);
        s++;
    }
}
