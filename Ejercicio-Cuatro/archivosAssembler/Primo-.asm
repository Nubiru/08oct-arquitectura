#6 Investigar y agregar sentencias para ingresar valores por teclado en un par de ejercicios.

.MODEL SMALL
.STACK 100h

.DATA
    numero      DW 0
    isPrime     DB 1
    msgPrime    DB 13,10,'El numero ES primo.$'
    msgNotPrime DB 13,10,'El numero NO es primo.$'
    msgInput    DB 13,10,'Ingrese un numero (1-65535): $'
    msgError    DB 13,10,'Error: Numero invalido!$'
    buffer      DB 7, 0, 7 DUP('$')  ; Buffer para entrada

.CODE

; PROCEDIMIENTO PARA LEER NÚMERO DESDE TECLADO
LEER_NUMERO PROC
    ; Mostrar mensaje de entrada
    MOV AH, 09h
    LEA DX, msgInput
    INT 21h

    ; Leer cadena desde teclado
    MOV AH, 0Ah
    LEA DX, buffer
    INT 21h

    ; Convertir ASCII a número
    MOV SI, OFFSET buffer + 2  ; Apuntar al inicio de los dígitos
    MOV AX, 0                  ; Inicializar resultado
    MOV CX, 10                 ; Base 10
    MOV BL, 0                  ; Bandera de número negativo

    ; Verificar si es negativo
    CMP BYTE PTR [SI], '-'
    JNE CONVERSION_LOOP
    MOV BL, 1                  ; Marcar como negativo
    INC SI                     ; Saltar el signo '-'

CONVERSION_LOOP:
    MOV DL, [SI]               ; Obtener carácter actual
    CMP DL, 13                 ; ¿Es Enter?
    JE CONVERSION_DONE
    CMP DL, '0'
    JL ERROR_CONVERSION
    CMP DL, '9'
    JG ERROR_CONVERSION

    ; Convertir dígito ASCII a número
    SUB DL, '0'

    ; AX = AX * 10 + DL
    PUSH DX
    MUL CX                     ; AX = AX * 10
    POP DX
    JC ERROR_CONVERSION        ; Overflow?

    ADD AL, DL
    ADC AH, 0
    JC ERROR_CONVERSION        ; Overflow?

    INC SI
    JMP CONVERSION_LOOP

ERROR_CONVERSION:
    ; Mostrar mensaje de error
    MOV AH, 09h
    LEA DX, msgError
    INT 21h
    MOV AX, 0                  ; Retornar 0 en caso de error
    RET

CONVERSION_DONE:
    ; Aplicar signo si es negativo
    CMP BL, 1
    JNE GUARDAR_NUMERO
    NEG AX                     ; Convertir a negativo

GUARDAR_NUMERO:
    MOV [numero], AX
    RET
LEER_NUMERO ENDP

; --- PROCEDIMIENTO PARA IMPRIMIR NÚMERO ---
IMPRIMIR_NUMERO PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0
    MOV BX, 10

    ; Manejar número negativo
    CMP AX, 0
    JGE POSITIVO
    NEG AX                     ; Convertir a positivo
    PUSH AX
    MOV DL, '-'
    MOV AH, 02h
    INT 21h
    POP AX

POSITIVO:
    ; Extraer dígitos
DIV_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

    ; Imprimir dígitos
IMPRIMIR_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP IMPRIMIR_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
IMPRIMIR_NUMERO ENDP

; --- PROGRAMA PRINCIPAL ---
main PROC
    ; Inicializar segmento de datos
    MOV AX, @data
    MOV DS, AX

    ; Leer número desde teclado
    CALL LEER_NUMERO

    ; Mostrar número ingresado
    MOV AH, 09h
    LEA DX, msgInput
    INT 21h

    MOV AX, [numero]
    CALL IMPRIMIR_NUMERO

    ; --- ALGORITMO PARA VERIFICAR SI ES PRIMO ---
    MOV AX, [numero]

    ; Verificar números menores que 2
    CMP AX, 2
    JL NO_PRIMO

    ; Caso especial: número 2 es primo
    CMP AX, 2
    JE SI_PRIMO

    ; Verificar números negativos
    CMP AX, 0
    JL NO_PRIMO

    ; Inicializar bucle de verificación
    MOV CX, 2

VERIFICAR_LOOP:
    ; Preparar división
    MOV DX, 0
    MOV AX, [numero]    ; Cargar número original
    DIV CX              ; DX:AX / CX

    ; Verificar si es divisible
    CMP DX, 0
    JE NO_PRIMO         ; Si residuo = 0, no es primo

    ; Preparar siguiente iteración
    INC CX              ; Siguiente divisor

    ; Verificar si llegamos al límite (hasta √n optimizado)
    MOV AX, [numero]
    SHR AX, 1           ; AX = num/2
    CMP CX, AX
    JLE VERIFICAR_LOOP  ; Continuar si CX <= num/2

    ; Si llegamos aquí, ES PRIMO
    JMP SI_PRIMO

NO_PRIMO:
    MOV [isPrime], 0
    MOV AH, 09h
    LEA DX, msgNotPrime
    INT 21h
    JMP SALIR

SI_PRIMO:
    MOV [isPrime], 1
    MOV AH, 09h
    LEA DX, msgPrime
    INT 21h

SALIR:
    ; Esperar tecla para continuar
    MOV AH, 09h
    LEA DX, msgInput
    INT 21h

    MOV AH, 01h
    INT 21h

    ; Terminar programa
    MOV AH, 4Ch
    INT 21h
main ENDP

END main