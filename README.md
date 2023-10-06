# fibonacci_asm
Fibonacci code in assembler compatible with nasm compiler.

# Dependencies:
nasm: nasm.us

# To install nasm
Use your packaga management system, for archlinux:
```bash
sudo yay -S nasm
```
If you have problem, check nasm.us documentation

# Compile and build
To compile in linux or wsl, follow the instructions bellow. It can be compiled for windows, osx and many others. Check nasm documentation for more information

```bash
nasm -f elf32 fibi.asm
ld -m elf_i386 -o fibi fibi.o
```
