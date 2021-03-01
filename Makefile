arch ?= x86_64
kernel := target/kernel-$(arch).bin
iso := target/os-$(arch).iso

linker_script := src/$(arch)/linker.ld
grub_cfg := src/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/$(arch)/*.asm)
assembly_object_files := $(patsubst src/$(arch)/%.asm, \
	target/$(arch)/%.o, $(assembly_source_files))

.PHONY: all clean run iso

all: $(kernel)

clean:
	@-rm -r target

run: $(iso)
	@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p target/isofiles/boot/grub
	@cp $(kernel) target/isofiles/boot/kernel.bin
	@cp $(grub_cfg) target/isofiles/boot/grub
	@grub-mkrescue -o $(iso) target/isofiles 2> /dev/null
	@rm -r target/isofiles

$(kernel): $(assembly_object_files) $(linker_script)
	@ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)

# compile assembly files
target/$(arch)/%.o: src/$(arch)/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -felf64 $< -o $@
