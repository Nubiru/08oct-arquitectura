    .file	"factorial.c"
    .intel_syntax noprefix
    .text
    .globl	calcular_factorial
    .type	calcular_factorial, @function

calcular_factorial:
.LFB6:
.cfi_startproc
endbr64
push rbp
.cfi_def_cfa_offset 16
.cfi_offset 6, -16
mov rbp, rsp
.cfi_def_cfa_register 6
mov DWORD PTR -20[rbp], edi
mov QWORD PTR -8[rbp], 1
cmp DWORD PTR -20[rbp], 1
jg .L2
mov eax, 1
jmp .L3
.L2:
mov DWORD PTR -12[rbp], 2
jmp .L4
.L5:
mov eax, DWORD PTR -12[rbp]
cdqe
mov rdx, QWORD PTR -8[rbp]
imul rax, rdx
mov QWORD PTR -8[rbp], rax
add DWORD PTR -12[rbp], 1
.L4:
mov eax, DWORD PTR -12[rbp]
cmp eax, DWORD PTR -20[rbp]
jle .L5
mov rax, QWORD PTR -8[rbp]
.L3:
pop rbp
.cfi_def_cfa 7, 8
ret
.cfi_endproc
.LFE6:
.size calcular_factorial, .-calcular_factorial
.section .rodata
.LC0:
.string "Error\n"
.LC1:
.string "El factorial de %d es: %lu\n"
.text
.globl main
.type main, @function
main:
.LFB7:
.cfi_startproc
endbr64
push rbp
.cfi_def_cfa_offset 16
.cfi_offset 6, -16
mov rbp, rsp
.cfi_def_cfa_register 6
sub rsp, 32
mov DWORD PTR -20[rbp], edi
mov QWORD PTR -32[rbp], rsi
cmp DWORD PTR -20[rbp], 1
jle .L7
mov rax, QWORD PTR -32[rbp]
add rax, 8
mov rax, QWORD PTR [rax]
mov rdi, rax
call atoi@PLT
jmp .L8
.L7:
mov eax, 5
.L8:
mov DWORD PTR -12[rbp], eax
cmp DWORD PTR -12[rbp], 0
js .L9
cmp DWORD PTR -12[rbp], 20
jle .L10
.L9:
mov rax, QWORD PTR stderr[rip]
mov rcx, rax
mov edx, 6
mov esi, 1
lea rax, .LC0[rip]
mov rdi, rax
call fwrite@PLT
mov eax, 1
jmp .L11
.L10:
mov eax, DWORD PTR -12[rbp]
mov edi, eax
call calcular_factorial
mov QWORD PTR -8[rbp], rax
mov rdx, QWORD PTR -8[rbp]
mov eax, DWORD PTR -12[rbp]
mov esi, eax
lea rax, .LC1[rip]
mov rdi, rax
mov eax, 0
call printf@PLT
mov eax, 0
.L11:
leave
.cfi_def_cfa 7, 8
ret
.cfi_endproc
.LFE7:
.size main, .-main
.ident "GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
.section .note.GNU-stack,"",@progbits
.section .note.gnu.property,"a"
.align 8
.long 1f - 0f
.long 4f - 1f
.long 5
0:
.string "GNU"
1:
.align 8
.long 0xc0000002
.long 3f - 2f
2:
.long 0x3
3:
.align 8
4:
