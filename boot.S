
#include <armv7a.h>

.data
str_hello:
	.asciz "Hello World!\r\n"

.text
	.global _start
	.arm
	.align

_start:
	ldr r1, =str_hello
	bl _puts
	bl _enable_cache

_loop:
	b _loop

/*--------------------------------------------------------------------------------------
* ENABLE L2 INSTRUCTION CACHE
*/
_enable_cache:
	push {r0, r1, r2, lr}
	mrc	p15, 0, r0, c1, c0, 0
	orr r0, r0, #C1CTL_I
	orr r0, r0, #C1CTL_Z
	orr r0, r0, #C1CTL_C
	mcr	p15, 0, r0, c1, c0, 0
	pop {r0, r1, r2, pc}

/*------------------------------------------------------------------------------
* PUTS
* R1: Address of null-terminated string to be printed
*/
_puts:
	push {r0, r1, r2, lr}
	mov r0, r1
_puts_loop:
	ldrb r1, [r0], #1
	cmp r1, #0
	beq _puts_end
	bl _putc
	b _puts_loop
_puts_end:
	pop {r0, r1, r2, pc}

/*------------------------------------------------------------------------------
* PUTC
* R1: Character to be printed
*/
_putc:
	push {r0, r1, r2, lr}
	ldr r0, =UART0_SSR
	ldrb r2, [r0]
	/* Bit 0 is set when TX FIFO is FULL */
	and r2, r2, #0x01
	cmp r2, #0x01
	/* Branch when Z is set, Bit 1 set */
	beq _putc

	ldr r0, =UART0_BASE
	strb r1, [r0]

	pop {r0, r1, r2, pc}

/*--------------------------------------------------------------------------------
* PUT HEX
* R1: Hexadecimal value to print
*/
_puthex:
	push {r0, r1, r2, lr}
	mov r3, #32
	mov r2, r1
_puthex_loop:
	cmp r3, #0
	beq _puthex_end
	sub r3, r3, #4
	lsr r1, r2, r3
	and r1, r1, #0xF
	cmp r1, #0xA
	addhs r1, r1, #0x37
	addlo r1, r1, #0x30
	bl _putc

	b _puthex_loop
_puthex_end:
	pop {r0, r1, r2, pc}
