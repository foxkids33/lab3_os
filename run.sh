#!/bin/bash

# Step 1: Assemble the kernel.asm file
echo "Assembling kernel.asm..."
nasm -f elf32 kernel.asm -o kasm.o
if [ $? -ne 0 ]; then
    echo "Assembly failed."
    exit 1
fi

# Step 2: Compile the kernel.c file
echo "Compiling kernel.c..."
gcc -m32 -c kernel.c -o kc.o
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Step 3: Link the object files using the linker script
echo "Linking object files..."
ld -m elf_i386 -T link.ld -o kernel kasm.o kc.o
if [ $? -ne 0 ]; then
    echo "Linking failed."
    exit 1
fi

# Step 4: Run the kernel using QEMU
echo "Running the kernel with QEMU..."
qemu-system-i386 -kernel kernel

# Exit the script
exit 0
