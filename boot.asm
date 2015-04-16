	#UART base locations from the Reference Manual
	# UART0 is connected to the Serial Port
	.equ UART0.BASE,			0x44E09000
	.equ UART0.LCR,   		     0x44E0900C
	.equ UART0.LSR_UART,    0x44E09014
	.equ UART0.SSR,    			 0x44E09044

.text
	.global _start
	.arm
	.align

_start:
	ldr r1, =str_hello
	bl _puts
_loop:
	b _loop

###############################################
# PUTS
# R1: Address of null-terminated string to be printed
###############################################
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

###############################################
# PUTC
# R1: Character to be printed
###############################################
_putc:
	push {r0, r1, r2, lr}
	ldr r0, =UART0.SSR
	ldrb r2, [r0]
	# Bit 0 is set when TX FIFO is FULL
	and r2, r2, #0x01
	cmp r2, #0x01
	# Branch when Z is set, Bit 1 set
	beq _putc

	ldr r0, =UART0.BASE
	strb r1, [r0]

	pop {r0, r1, r2, pc}

	.data
str_hello:
	.asciz "Hello World!\r\n"
