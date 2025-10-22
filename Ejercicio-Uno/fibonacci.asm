.MODEL SMALL
.STACK 100h
.DATA
fib DW 0, 1, 8 DUP(?)  ; Inicializar directamente los primeros dos valores
msg DB 'Fibonacci: $'
space DB ' $'

.CODE
START:
    ; Inicializar segmento de datos CORRECTAMENTE
    MOV AX, DGROUP
    MOV DS, AX
    
    ; Calcular secuencia Fibonacci (ya tenemos 0 y 1)
    MOV CX, 8          ; 8 n?meros m?s por calcular
    MOV SI, 4          ; Empezar desde la tercera posici?n (fib[2])
    
CALC_LOOP:
    MOV AX, [fib+SI-4] ; fib[n-2]
    ADD AX, [fib+SI-2] ; + fib[n-1]
    MOV [fib+SI], AX   ; fib[n] = fib[n-1] + fib[n-2]
    ADD SI, 2          ; Siguiente posici?n (cada n?mero son 2 bytes)
    LOOP CALC_LOOP
    
    ; Mostrar mensaje
    MOV AH, 09h
    LEA DX, msg
    INT 21h
    
    ; Mostrar la secuencia
    MOV CX, 10         ; 10 n?meros a mostrar
    MOV SI, 0          ; ?ndice inicial
    
SHOW_LOOP:
    MOV AX, [fib+SI]   ; Cargar n?mero Fibonacci
    CALL PRINT_NUM     ; Mostrarlo
    ADD SI, 2          ; Siguiente n?mero
    
    ; Mostrar espacio (excepto despu?s del ?ltimo)
    CMP CX, 1
    JE NO_SPACE
    MOV AH, 09h
    LEA DX, space
    INT 21h
    
NO_SPACE:
    LOOP SHOW_LOOP
    
    ; Salir al DOS
    MOV AH, 4Ch
    INT 21h

; Procedimiento para mostrar n?mero en AX
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX, 0          ; Contador de d?gitos
    MOV BX, 10         ; Divisor
    
    ; Caso especial para 0
    CMP AX, 0
    JNE CONVERT_DIGITS
    
    ; Mostrar 0 directamente
    MOV DL, '0'
    MOV AH, 02h
    INT 21h
    JMP END_PRINT
    
CONVERT_DIGITS:
    ; Convertir n?mero a d?gitos ASCII
DIVIDE:
    XOR DX, DX         ; Limpiar DX para divisi?n
    DIV BX             ; AX / 10, residuo en DX
    ADD DL, '0'        ; Convertir a ASCII
    PUSH DX            ; Guardar d?gito en pila
    INC CX             ; Contar d?gito
    CMP AX, 0          ; ?Terminamos?
    JNE DIVIDE         ; No, continuar
    
    ; Mostrar d?gitos desde la pila (en orden correcto)
SHOW_DIGITS:
    POP DX
    MOV AH, 02h
    INT 21h
    LOOP SHOW_DIGITS
    
END_PRINT:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END START