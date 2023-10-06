# fibonacci_asm
Fibonacci code in assembler compatible with nasm compiler.
This version is built for 32 bits, which limits results to 2^32 = 4.294.967.296, which will be fib(47) or fib(48).
I never had written assembler code for 64 bits, I will do later (someday, no promisses, I have few time available), which would increase the result limit a lot.
For the simplicity of code, I'm using registers to calc, but of course its possible to use another approach to solve this 32 bits limitation, but it would lead to a complex code, and this is for educational purposes.

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
