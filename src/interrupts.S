
#include <armv7a.h>

.data
str_irq:
	.asciz "R"

.text
	.global init_ivt
    .global enable_interrupts
    .global software_interrupt
    .extern _puts
	.arm
	.align

software_interrupt:
    swi 0
    mov pc, lr

enable_interrupts:
    cpsie i
    mov pc, lr

init_ivt:
    // Clear V bit, normal exception base address control in C1
    mrc p15, 0, r0, c1, c0, 0
    bic r0, r0, #C1CTL_V
    mcr p15, 0, r0, c1, c0, 0

    // Set C12 with Interrupt Vector Start Address
    ldr r0, =IVT_START
    mcr p15, 0, r0, c12, c0, 0

    // Load Interrupt Vector Table with relative jmp opcode,
    // jumping to address stored in table following IVT (IVH)
    ldr r0, =IVT_START
    ldr r1, =IVT_END
    ldr r2, =ivt_jmp_instr
    ldr r2, [r2]
set_ivt:
    str r2, [r0]
    add r0, r0, #4
    cmp r0, r1
    bne set_ivt

    // Fill IVH with address of Default IRQ Handler
    ldr r0, =IVH_START
    ldr r1, =IVH_END
    ldr r2, =def_irq_handler
set_def_irqh:
    str r2, [r0]
    add r0, r0, #4
    cmp r0, r1
    bne set_def_irqh

    // Set IRQ Entry in IVH with irq_handler
    ldr r0, =IRQH_ADDR
    ldr r1, =irq_handler
    str r1, [r0]
    mov pc, lr

ivt_jmp_instr:
    // IVT has 8 cells (32 bytes), 24 byte offset instead of 32 bytes because
    // PC points to two words beyond the instruction being executed
    ldr pc, [pc, #24]

irq_handler:
def_irq_handler:
    cpsid i
    ldr r1, =str_irq
    bl _puts
def_irq_handler_loop:
    b def_irq_handler_loop
