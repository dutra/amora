
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
    uint32_t *uart0_ssr = (uint32_t *) UART0_SSR;
    while(*uart0_ssr & 1);

    /* write to THX register */
    uint8_t *uart0_base =  (uint8_t *) UART0_BASE;

    *uart0_base = c;

}
