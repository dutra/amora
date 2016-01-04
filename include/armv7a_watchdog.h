
/* WatchDog Timer Control and Status Registers */

#include <types.h>

struct	watchdog_csreg {
	volatile uint32_t widr;	/* Identification register	*/
	volatile uint32_t res1[3];/* Reserved space		*/
	volatile uint32_t	wdsc;	/* System control register	*/
	volatile uint32_t	wdst;	/* Status register		*/
	volatile uint32_t	wisr;	/* Interrupt status register	*/
	volatile uint32_t	wier;	/* Interrupt enable register	*/
	volatile uint32_t	res2;	/* Reserved space		*/
	volatile uint32_t	wclr;	/* Control register		*/
	volatile uint32_t	wcrr;	/* Counter register		*/
	volatile uint32_t	wldr;	/* Load register		*/
	volatile uint32_t	wtgr;	/* Trigger register		*/
	volatile uint32_t	wwps;	/* Write posting bits register	*/
	volatile uint32_t	res3[3];/* Reserved space		*/
	volatile uint32_t	wdly;	/* Delay configuration register	*/
	volatile uint32_t	wspr;	/* Start/stop register		*/
	volatile uint32_t	res4[2];/* Reserved space		*/
	volatile uint32_t	wirqstatraw;
				/* Raw interrupt status register*/
	volatile uint32_t	wirqstat;/* Interrupt status register	*/
	volatile uint32_t	wirqenset;
				/* Interrupt enable set register*/
	volatile uint32_t	wirqenclr;
				/* Interrupt enable clr register*/
};

#define	WDTADDR	0x44E35000
