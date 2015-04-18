ARMGNU = arm-none-eabi

ASFLAGS =  -mcpu=cortex-a8
ALLFLAGS = --warn --fatal-warnings
CFLAGS = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=cortex-a8 -mno-unaligned-access -marm -fno-builtin -fno-stack-protector -Iinclude/
LDFLAGS = -m armelf -nostdlib -nostdinc -nodefaultlibs -nostartfiles -T linker.ld -Iinclude/
OCFLAGS = --target elf32-littlearm --set-section-flags .bss=contents,alloc,load
OBJDIR = obj

.PHONY: clean

all: boot.bin

boot.bin: boot.S
	$(ARMGNU)-gcc $(CFLAGS) -E boot.S > $(OBJDIR)/boot.s
	$(ARMGNU)-as $(ASFLAGS) -c $(OBJDIR)/boot.s -o $(OBJDIR)/boot.o
	$(ARMGNU)-ld -dn $(LDFLAGS) $(OBJDIR)/boot.o -o $(OBJDIR)/boot.elf
	$(ARMGNU)-objdump -D $(OBJDIR)/boot.elf > $(OBJDIR)/boot.list
	$(ARMGNU)-objcopy $(OBJDIR)/boot.elf -O srec $(OBJDIR)/boot.srec
	$(ARMGNU)-objcopy $(OCFLAGS) -O binary $(OBJDIR)/boot.elf $(OBJDIR)/boot.bin

clean:
	rm -rf $(OBJDIR)/*
