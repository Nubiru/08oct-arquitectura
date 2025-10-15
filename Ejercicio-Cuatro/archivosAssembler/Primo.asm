#2.- Implementar en linux. De no tener uno, usar Google Colab

.MODEL SMALL
.STACK 100h
.DATA
    num         DW 17        ; Número a verificar
    isPrime     DB 1         ; 1 = primo, 0 = no primo
    msgPrime    DB 13,10,'El numero ES primo.$'
    msgNotPrime DB 13,10,'El numero NO es primo.$'
    msgNumber   DB 13,10,'Numero a verificar: $'
.CODE

; --- PROCEDIMIENTO PARA IMPRIMIR N?MERO ---
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    ; Convertir número a ASCII
    MOV CX, 0
    MOV BX, 10

DIV_LOOP:
    MOV DX, 0
    DIV BX              ; DX:AX / 10
    PUSH DX             ; Guardar d?gito
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

    ; Imprimir dígitos
PRINT_LOOP:
    POP DX
    ADD DL, '0'         ; Convertir a ASCII
    MOV AH, 02h
    INT 21h
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

main PROC
    ; --- INICIALIZAR SEGMENTO DE DATOS ---
    MOV AX, DGROUP      ;  CORRECCIÓN: Usar DGROUP en lugar de @DATA
    MOV DS, AX

    ; --- MOSTRAR NÚMERO A VERIFICAR ---
    MOV AH, 09h
    LEA DX, msgNumber
    INT 21h

    MOV AX, [num]
    CALL PRINT_NUMBER

    ; --- VERIFICACIÓN INICIAL PARA N?MEROS MENORES QUE 2 ---
    MOV AX, [num]
    CMP AX, 2
    JL NOT_PRIME         ; Si es menor que 2, no es primo

    ; --- CASO ESPECIAL: NÚMERO 2 ES PRIMO ---
    CMP AX, 2
    JE IS_PRIME_FINAL    ; 2 es primo

    ; --- INICIALIZAR BUCLE DE VERIFICACI?N ---
    MOV CX, 2            ; Empezar con divisor 2

CHECK_LOOP:
    ; --- PREPARAR DIVISI?N ---
    MOV DX, 0            ; Limpiar DX para divisi?n
    MOV AX, [num]        ; Cargar número original
    DIV CX               ; DX:AX / CX Cociente AX, Residuo DX

    ; --- VERIFICAR SI ES DIVISIBLE ---
    CMP DX, 0
    JE NOT_PRIME         ; Si residuo = 0, no es primo

    ; --- PREPARAR SIGUIENTE ITERACI?N ---
    INC CX               ; Siguiente divisor

    ; --- VERIFICAR SI LLEGAMOS AL L?MITE ---
    MOV AX, [num]
    SHR AX, 1            ; AX = num/2
    CMP CX, AX
    JLE CHECK_LOOP       ; Continuar si CX <= num/2

    ; --- SI LLEGAMOS AQU?, ES PRIMO ---
    JMP IS_PRIME_FINAL

NOT_PRIME:
    MOV [isPrime], 0

    ; --- MOSTRAR MENSAJE NO PRIMO ---
    MOV AH, 09h
    LEA DX, msgNotPrime
    INT 21h
    JMP EXIT_PROGRAM

IS_PRIME_FINAL:
    MOV [isPrime], 1

    ; --- MOSTRAR MENSAJE PRIMO ---
    MOV AH, 09h
    LEA DX, msgPrime
    INT 21h

EXIT_PROGRAM:
    ; --- FINALIZAR PROGRAMA ---
    MOV AH, 4Ch
    INT 21h
main ENDP

END main                 ; Punto de entrada main