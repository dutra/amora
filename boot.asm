	#UART base locations from the Reference Manual
	# UART0 is connected to the Serial Port
	.equ UART0.BASE,			0x44E09000
	.equ UART0.LCR,   		     0x44E0900C
	.equ UART0.LSR_UART,    0x44E09014
	.equ UART0.SSR,    			 0x44E09044

	.global _start

	# ARM mode
	.arm

_start:
	ldr r0, =UART0.BASE
	mov r1, #'!'
	strb r1, [r0]

_loop:
	ldr r0, =UART0.SSR
	ldrb r2, [r0]
	# Bit 0 is set when TX FIFO is FULL
	and r2, r2, #0x01
	cmp r2, #0x01
	# Branch when Z is set, Bit 1 set
	beq _loop

	# Check if data in RX FIFO
	# First need to clear LCR[7] to access LSR_UART
	ldr r0, =UART0.LCR
	ldrb r1, [r0]
	and r1, r1, #0xFFFFFF7F
	strb r1, [r0]

	# Then read LSR_UART
	ldr r0, =UART0.LSR_UART
	ldrb r1, [r0]
	and r1, r1, #0x01
	# LSR_UART[0] is high when data is available in RX FIFO
	cmp r1, #0x01
	# Branch if LSR_UART[0] is low
	bne _loop

	ldr r0, =UART0.BASE
	# Need to read RHR to pop FIFO
	ldrb r1, [r0]
	#mov r1, #'e'
	strb r1, [r0]
	b _loop

_hang:
	b _hang
