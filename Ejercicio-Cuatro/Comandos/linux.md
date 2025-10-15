#5 Pegar las sentencias usadas en linux para compilar y linkear

nasm -f elf64 your_assembly_file.asm -o your_object_file.o

ld -m elf_i386 your_object_file.o -o your_executable_file

chmod +x your_executable_file