ARMGNU = arm-none-eabi

ASFLAGS =  -mcpu=cortex-a8
ALLFLAGS = --warn --fatal-warnings
CFLAGS = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=cortex-a8 -mno-unaligned-access -marm -fno-builtin -fno-stack-protector
LFLAGS = -m armelf -nostdlib -nostdinc -nodefaultlibs -nostartfiles -T linker.ld
OCFLAGS = --target elf32-littlearm --set-section-flags .bss=contents,alloc,load


boot.img: boot.asm
	$(ARMGNU)-as $(ASFLAGS) -c boot.asm -o boot.o
	$(ARMGNU)-ld -dn $(LDFLAGS) boot.o -o boot.elf
	$(ARMGNU)-objdump -D boot.elf > boot.list
	$(ARMGNU)-objcopy boot.elf -O srec boot.srec
	$(ARMGNU)-objcopy $(OCFLAGS) -O binary boot.elf boot.img
