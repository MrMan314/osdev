BOOT_SRC = $(wildcard src/boot/*.s)

BOOT_OBJ = $(subst src/,bin/,$(BOOT_SRC:.s=.o))
IMAGE = src/data/image.png

AS_FLAGS = -c $^ -o $@

BOOT_LD_FLAGS = $^ -o $@ -Ttext 0x7C00 --oformat=binary -v
QEMU_FLAGS = -drive file=$<,index=0,if=floppy,format=raw -serial stdio

AS = as
LD = ld
QEMU = qemu-system-i386

RGB = bin/data/image.rgb
BOOT = bin/boot/boot
DATA = bin/data/data
FLOPPY = floppy.img


run: $(FLOPPY)
	$(QEMU) $(QEMU_FLAGS)

clean:
	rm -rf $^ $(FLOPPY) bin/

$(FLOPPY): $(BOOT) $(DATA)
	mkdir -p $(@D)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=bin/boot/boot of=$@ bs=512 count=1 conv=notrunc
	dd if=bin/data/data of=$@ bs=512 seek=1 conv=notrunc

$(BOOT): $(BOOT_OBJ)
	mkdir -p $(@D)
	$(LD) $(BOOT_LD_FLAGS)

$(BOOT_OBJ): $(BOOT_SRC)
	mkdir -p $(@D)
	$(AS) $(AS_FLAGS)

$(RGB): $(IMAGE) src/data/papyrus.ttf
	mkdir -p $(@D)
	magick convert $^ -resize 320x200! -gravity Center -pointsize 36 -font src/data/papyrus.ttf -annotate 0 "i cant find\nthe os vro" -resize 320x200! $@

$(DATA): $(RGB) bin/data/rgb2vga
	mkdir -p $(@D)
	bin/data/rgb2vga < $(RGB) > $@

bin/data/rgb2vga: src/data/rgb2vga.c
	mkdir -p $(@D)
	g++ $^ -o $@

