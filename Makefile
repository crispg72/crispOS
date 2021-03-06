arch ?= x86_64
build_folder := target
kernel := $(build_folder)/kernel-$(arch).bin
iso := $(build_folder)/os-$(arch).iso

linker_script := src/$(arch)/linker.ld
grub_cfg := src/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/$(arch)/*.asm)
assembly_object_files := $(patsubst src/$(arch)/%.asm, \
	$(build_folder)/$(arch)/%.asm.o, $(assembly_source_files))

CC := gcc
c_source_files := $(wildcard src/$(arch)/*.c)
c_object_files := $(patsubst src/$(arch)/%.c, \
	$(build_folder)/$(arch)/%.c.o, $(c_source_files))

.PHONY: all clean run iso

all: $(kernel)

clean:
	@-rm -r $(build_folder)

run: $(iso)
	@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p $(build_folder)/isofiles/boot/grub
	@cp $(kernel) $(build_folder)/isofiles/boot/kernel.bin
	@cp $(grub_cfg) $(build_folder)/isofiles/boot/grub
	@grub-mkrescue -o $(iso) $(build_folder)/isofiles 2> /dev/null
	@rm -r $(build_folder)/isofiles

$(kernel): $(assembly_object_files) $(c_object_files) $(linker_script)
	@ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files) $(c_object_files)

# run nasm on all assembler files
$(build_folder)/$(arch)/%.asm.o: src/$(arch)/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -felf64 $< -o $@

# compile all C files
$(build_folder)/$(arch)/%.c.o: src/$(arch)/%.c 
	$(CC) $(CFLAGS) -c $< -o $@

