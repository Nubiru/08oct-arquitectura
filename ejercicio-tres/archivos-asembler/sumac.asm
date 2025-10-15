.MODEL SMALL
.STACK 100h
.DATA
    array       DW 2, 4, 6, 8, 10          ; Array original de words
    count       DW 5                        ; Número de elementos (precalculado)
    sum         DW 0                        ; Variable para almacenar la suma

    ; Mensajes para la salida
    mensaje     DB 'La suma de los elementos del array es: $'
    resultado   DB 6 DUP(' ')               ; Buffer para el número convertido a string
                DB '$'                      ; Terminador para DOS

.CODE
START:
    ; === INICIALIZACIÓN DEL SEGMENTO DE DATOS ===
    MOV AX, @DATA
    MOV DS, AX

    ; === INICIALIZACIÓN DE REGISTROS PARA EL BUCLE ===
    MOV CX, [count]      ; CX = contador del bucle (5 elementos)
    MOV SI, 0            ; SI = índice del array (equivalente a int i = 0)
    MOV AX, 0            ; AX = acumulador de suma (equivalente a int sum = 0)

SUM_LOOP:
    ; === SUMAR ELEMENTO ACTUAL === (equivalente a sum += array[i])
    ADD AX, [array+SI]   ; Suma el elemento actual del array a AX

    ; === INCREMENTAR ÍNDICE === (equivalente a i++)
    ADD SI, 2            ; Avanza al siguiente elemento (2 bytes por word)

    ; === CONTROL DEL BUCLE === (equivalente a i < count)
    LOOP SUM_LOOP        ; Decrementa CX y salta si CX != 0

    ; === GUARDAR RESULTADO ===
    MOV [sum], AX        ; Almacena el resultado final

    ; === PREPARAR PARA CONVERSIÓN A STRING ===
    MOV AX, [sum]        ; Carga la suma en AX para convertir
    LEA DI, [resultado+5] ; DI apunta al final del buffer
    MOV BYTE PTR [DI], '$' ; Coloca terminador al final

    ; === CONVERTIR NÚMERO A STRING ===
    MOV CX, 10           ; Base decimal para la conversión
    MOV BX, 0            ; Contador de dígitos

CONVERTIR:
    DEC DI               ; Mueve al carácter anterior en el buffer
    XOR DX, DX           ; Limpia DX para la división
    DIV CX               ; AX = AX/10, DX = resto (dígito)
    ADD DL, '0'          ; Convierte dígito a ASCII
    MOV [DI], DL         ; Almacena el carácter
    INC BX               ; Incrementa contador de dígitos
    CMP AX, 0            ; ¿Ya procesamos todos los dígitos?
    JNE CONVERTIR        ; Si no, continuar conversión

    ; === IMPRIMIR MENSAJE === (equivalente a printf)
    MOV AH, 09h          ; Función DOS para imprimir string
    LEA DX, mensaje      ; Carga dirección del mensaje
    INT 21h              ; Imprime mensaje

    ; === IMPRIMIR NÚMERO ===
    MOV AH, 09h          ; Función DOS para imprimir string
    MOV DX, DI           ; Carga dirección del número convertido
    INT 21h              ; Imprime el número

    ; === IMPRIMIR SALTO DE LÍNEA ===
    MOV AH, 02h          ; Función DOS para imprimir carácter
    MOV DL, 0Dh          ; Carácter retorno de carro
    INT 21h
    MOV DL, 0Ah          ; Carácter salto de línea
    INT 21h

    ; === TERMINAR PROGRAMA === (equivalente a return 0)
    MOV AH, 4Ch          ; Función DOS para terminar programa
    MOV AL, 0            ; Código de salida 0
    INT 21h

END START