/* rammap */
MEMORY
{
    ram : ORIGIN = 0x82000000, LENGTH = 0x10000
}

SECTIONS
{
    .text : { *(.text*) } > ram
}
