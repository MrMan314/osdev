BOOT_SRC = $(wildcard src/boot/*.s)
KERNEL_SRC = $(wildcard src/kernel/*.s)

BOOT_OBJ = $(subst src/,bin/,$(BOOT_SRC:.s=.o))
KERNEL_OBJ = $(subst src/,bin/,$(KERNEL_SRC:.s=.o))

AS_FLAGS = -c $(subst bin/,src/,$(@:.o=.s)) -o $@

BOOT_LD_FLAGS = $^ -o $@ -Ttext 0x7C00 --oformat=binary
KERNEL_LD_FLAGS = $^ -o $@ -T src/kernel/link.ld --oformat=binary
QEMU_FLAGS = -drive file=$<,index=0,if=floppy,format=raw -serial stdio

AS = as
LD = ld
QEMU = qemu-system-i386

BOOT = bin/boot/boot
KERNEL = bin/kernel/kernel
FLOPPY = floppy.img

run: $(FLOPPY)
	$(QEMU) $(QEMU_FLAGS)

clean:
	rm -rf $^ $(FLOPPY) bin/

$(FLOPPY): $(BOOT) $(KERNEL)
	mkdir -p $(@D)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=bin/boot/boot of=$@ bs=512 count=1 conv=notrunc
	dd if=bin/kernel/kernel of=$@ bs=512 seek=1 conv=notrunc

$(BOOT): $(BOOT_OBJ)
	mkdir -p $(@D)
	$(LD) $(BOOT_LD_FLAGS)

$(BOOT_OBJ): $(BOOT_SRC)
	mkdir -p $(@D)
	$(AS) $(AS_FLAGS)

$(KERNEL): $(KERNEL_OBJ)
	mkdir -p $(@D)
	$(LD) $(KERNEL_LD_FLAGS)

$(KERNEL_OBJ): $(KERNEL_SRC)
	mkdir -p $(@D)
	$(AS) $(AS_FLAGS)

