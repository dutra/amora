ARMGNU = arm-none-eabi

ASFLAGS =  -mcpu=cortex-a8
ALLFLAGS = --warn --fatal-warnings
CFLAGS = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=cortex-a8 -mno-unaligned-access -marm -fno-builtin -fno-stack-protector -Iinclude/
LDFLAGS = -m armelf -nostdlib -nostdinc -nodefaultlibs -nostartfiles -T linker.ld -Iinclude/
OCFLAGS = --target elf32-littlearm --set-section-flags .bss=contents,alloc,load

SRCDIR = src
OBJDIR = obj

C_SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJS = $(C_SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

.PHONY: clean

all: $(OBJDIR)/kernel.bin

$(OBJDIR)/boot.o: boot.S
	$(ARMGNU)-gcc $(CFLAGS) -E $< > $(OBJDIR)/boot.s
	$(ARMGNU)-as $(ASFLAGS) -c $(OBJDIR)/boot.s -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(ARMGNU)-gcc $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

$(OBJDIR)/kernel.bin: $(OBJS) $(OBJDIR)/boot.o

	$(ARMGNU)-ld -dn $(LDFLAGS) $(OBJDIR)/boot.o $(OBJS) -o $(OBJDIR)/kernel.elf
	$(ARMGNU)-objdump -D $(OBJDIR)/kernel.elf > $(OBJDIR)/kernel.list
	$(ARMGNU)-objcopy $(OBJDIR)/kernel.elf -O srec $(OBJDIR)/kernel.srec
	$(ARMGNU)-objcopy $(OCFLAGS) -O binary $(OBJDIR)/kernel.elf $(OBJDIR)/kernel.bin

clean:
	rm -rf $(OBJDIR)/*
