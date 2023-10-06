# fibonacci_asm
Fibonacci code in assembler compatible with nasm compiler.

## Dependencies:
nasm: http://www.nasm.us

## To install nasm
Use your package management system, for archlinux:
```bash
sudo yay -S nasm
```
If you have problems, check nasm.us documentation

## Compile and build
To compile in linux or wsl, follow the instructions bellow. It can be compiled for windows, osx and many others systems. Check nasm documentation for details.
```bash
nasm -f elf32 fibi.asm
ld -m elf_i386 -o fibi fibi.o
```
