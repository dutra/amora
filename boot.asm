	#UART base locations from the Reference Manual
	# UART0 is connected to the Serial Port
	.equ UART0.BASE,		0x44E09000

	.global _start

	# ARM mode
	.arm

_start:
	ldr r0, =UART0.BASE
	mov r1, #'!'
	strb r1, [r0]

_hang:
	b _hang
