; ============================================================================
; Programa: Cálculo del factorial de un número (64-bit Linux)
; ============================================================================
; Descripción: Calcula n! = n * (n-1) * (n-2) * ... * 1
; Usa syscalls de Linux (sys_read, sys_write, sys_exit)
; Compilar: nasm -f elf64 factorial_64bit.asm -o factorial_64bit.o
; Linkear:  ld factorial_64bit.o -o factorial_64bit
; Ejecutar: ./factorial_64bit
;
; Modos de direccionamiento utilizados:
;   - Inmediato: mov rax, 1
;   - Por registro: mov rdi, rax
;   - Directo a memoria: mov rcx, [num]
;   - RIP-relativo (64-bit): lea rsi, [rel msgInput]
; ============================================================================

section .data                   ; Sección de datos inicializados
    ; Mensajes para entrada/salida
    msgInput:  db 'Ingrese un numero (0-12): ', 0
    lenInput:  equ $ - msgInput
    
    msgResult: db 10, 'El factorial es: ', 0
    lenResult: equ $ - msgResult
    
    newline:   db 10, 0

section .bss                    ; Sección de datos no inicializados
    num:       resq 1           ; Reserva 1 quadword (64 bits) para el número
    result:    resq 1           ; Reserva 1 quadword para el resultado
    input:     resb 3           ; Buffer para entrada (2 dígitos + newline)
    outputBuf: resb 20          ; Buffer para conversión a string

section .text                   ; Sección de código
    global _start               ; Punto de entrada para el linker

_start:
    ; ========================================
    ; Solicitar entrada del usuario
    ; ========================================
    ; syscall write(stdout, msgInput, lenInput)
    mov rax, 1                  ; syscall number: sys_write = 1
                                ; Direccionamiento inmediato
    mov rdi, 1                  ; file descriptor: stdout = 1
                                ; Direccionamiento inmediato
    lea rsi, [rel msgInput]     ; Dirección del mensaje (RIP-relativo)
                                ; Modo de direccionamiento RIP-relativo (64-bit)
    mov rdx, lenInput           ; Longitud del mensaje
                                ; Direccionamiento inmediato
    syscall                     ; Invocar syscall del kernel Linux
    
    ; ========================================
    ; Leer entrada del usuario
    ; ========================================
    ; syscall read(stdin, input, 3)
    mov rax, 0                  ; syscall number: sys_read = 0
    mov rdi, 0                  ; file descriptor: stdin = 0
    lea rsi, [rel input]        ; Buffer para almacenar entrada
                                ; Direccionamiento RIP-relativo
    mov rdx, 3                  ; Leer hasta 3 bytes
    syscall                     ; Llamar al kernel
    
    ; ========================================
    ; Convertir ASCII a número
    ; ========================================
    lea rsi, [rel input]        ; Cargar dirección del buffer de entrada
    movzx rax, byte [rsi]       ; Cargar primer carácter (zero-extend)
                                ; Direccionamiento indirecto por registro
    sub rax, '0'                ; Convertir ASCII a número
                                ; Direccionamiento inmediato
    
    ; Verificar si hay segundo dígito
    movzx rbx, byte [rsi + 1]   ; Cargar segundo carácter
                                ; Direccionamiento con desplazamiento
    cmp rbx, 10                 ; ¿Es newline?
    je .single_digit            ; Si es newline, solo un dígito
    
    ; Procesar segundo dígito
    imul rax, 10                ; Multiplicar primer dígito por 10
    sub rbx, '0'                ; Convertir segundo dígito
    add rax, rbx                ; Sumar ambos dígitos
    
.single_digit:
    mov [rel num], rax          ; Guardar número en memoria
                                ; Direccionamiento RIP-relativo a memoria
    
    ; ========================================
    ; Cálculo del factorial
    ; ========================================
    mov rax, 1                  ; RAX = 1 (acumulador del resultado)
                                ; Direccionamiento inmediato
    mov rcx, [rel num]          ; RCX = número ingresado (contador)
                                ; Direccionamiento RIP-relativo desde memoria
    
    cmp rcx, 0                  ; Comparar con 0
                                ; Direccionamiento inmediato y por registro
    je .fact_done               ; Si es 0, factorial es 1 (0! = 1)
    
.fact_loop:
    ; RAX = RAX * RCX
    imul rax, rcx               ; Multiplicación con signo (64-bit)
                                ; Direccionamiento por registro
                                ; imul permite resultado en un solo registro
    dec rcx                     ; Decrementar contador
                                ; Direccionamiento por registro
    cmp rcx, 1                  ; ¿Llegamos a 1?
    jg .fact_loop               ; Si RCX > 1, continuar loop
                                ; JG = Jump if Greater
    
.fact_done:
    mov [rel result], rax       ; Almacenar resultado en memoria
                                ; Direccionamiento RIP-relativo a memoria
    
    ; ========================================
    ; Mostrar mensaje de resultado
    ; ========================================
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    lea rsi, [rel msgResult]    ; Mensaje de resultado
    mov rdx, lenResult          ; Longitud
    syscall
    
    ; ========================================
    ; Convertir resultado a ASCII y mostrar
    ; ========================================
    mov rax, [rel result]       ; Cargar resultado
                                ; Direccionamiento RIP-relativo
    lea rdi, [rel outputBuf]    ; Buffer de salida
    call print_number           ; Llamar procedimiento de conversión
    
    ; Imprimir newline
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    lea rsi, [rel newline]      ; Newline
    mov rdx, 1                  ; 1 byte
    syscall
    
    ; ========================================
    ; Finalización del programa
    ; ========================================
    mov rax, 60                 ; syscall number: sys_exit = 60
                                ; Direccionamiento inmediato
    mov rdi, 0                  ; exit code = 0 (éxito)
                                ; Direccionamiento inmediato
    syscall                     ; Salir del programa

; ============================================================================
; Procedimiento: print_number
; ============================================================================
; Convierte un número en RAX a ASCII y lo imprime
; Entrada: RAX = número a imprimir
;          RDI = dirección del buffer de salida
; Modifica: RAX, RBX, RCX, RDX, RSI, RDI
; ============================================================================
print_number:
    push rbp                    ; Guardar base pointer (convención de llamada)
    mov rbp, rsp                ; Establecer nuevo frame
    
    mov rbx, 10                 ; Divisor = 10
    mov rcx, 0                  ; Contador de dígitos
    
    ; Caso especial: si RAX = 0
    test rax, rax               ; Verificar si RAX = 0
    jnz .convert_loop           ; Si no es 0, continuar
    
    mov byte [rdi], '0'         ; Si es 0, escribir '0'
    mov rcx, 1                  ; Un dígito
    jmp .print_digits
    
.convert_loop:
    ; Dividir RAX entre 10
    xor rdx, rdx                ; Limpiar RDX (parte alta del dividendo)
    div rbx                     ; RAX = RAX / 10, RDX = RAX % 10
                                ; Direccionamiento por registro
    
    add rdx, '0'                ; Convertir dígito a ASCII
    push rdx                    ; Guardar dígito en la pila
                                ; Uso de la pila (PUSH)
    inc rcx                     ; Incrementar contador
    
    test rax, rax               ; ¿RAX = 0?
    jnz .convert_loop           ; Si no, continuar
    
.print_digits:
    mov rsi, rdi                ; RSI = dirección del buffer
    mov rbx, 0                  ; Índice en el buffer
    
.pop_loop:
    pop rdx                     ; Recuperar dígito de la pila
                                ; Uso de la pila (POP)
    mov [rsi + rbx], dl         ; Escribir en buffer
                                ; Direccionamiento base + índice
    inc rbx                     ; Siguiente posición
    loop .pop_loop              ; Repetir RCX veces
    
    ; Imprimir el buffer
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    ; RSI ya apunta al buffer
    mov rdx, rbx                ; Longitud = número de dígitos
    syscall
    
    pop rbp                     ; Restaurar base pointer
    ret                         ; Retornar (RET)

