ENTRY(_start)

/* rammap */
MEMORY
{
    RAM (wx) : ORIGIN = 0x82000000, LENGTH = 0x10000
}

SECTIONS
{
    .text : { *(.text*) } > RAM
    .data : { *(.data*) } > RAM
}
