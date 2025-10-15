# Save the assembly code to a file
%%writefile sum_array.asm
.MODEL SMALL
.STACK 100h
.DATA
    array   DW 2, 4, 6, 8, 10
    count   DW 5
    sum     DW 0
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, [count]
    MOV SI, 0
    MOV AX, 0

SUM_LOOP:
    ADD AX, [array+SI]  ; Direccionamiento base + índice
    ADD SI, 2
    LOOP SUM_LOOP

    MOV [sum], AX

    MOV AH, 4Ch
    INT 21h
END START

# Install NASM if not already installed
!apt-get update && apt-get install -y nasm

# Assemble the code
!nasm -f elf sum_array.asm -o sum_array.o

# Link the object file
!ld -m elf_i386 sum_array.o -o sum_array

# Execute the program
!./sum_array