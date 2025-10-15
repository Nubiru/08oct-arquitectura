.MODEL SMALL      ; Define el modelo de memoria como SMALL (código y datos en segmentos diferentes)
.STACK 100h       ; Reserva 256 bytes (100h en hexadecimal) para la pila

.DATA             ; Inicio del segmento de datos
    array   DW 2, 4, 6, 8, 10  ; Define un array de words (2 bytes cada uno) con valores iniciales
    count   DW 5                ; Define una variable que almacena el número de elementos en el array
    sum     DW 0                ; Define una variable para almacenar el resultado de la suma

.CODE             ; Inicio del segmento de código
START:            ; Etiqueta que marca el inicio del programa
    MOV AX, @DATA ; Carga la dirección del segmento de datos en AX
    MOV DS, AX    ; Copia la dirección de datos de AX al registro DS (Data Segment)
                  ; ¡ESTO ES ESENCIAL! Sin esto, el programa no podría acceder a las variables

    ; === INICIALIZACIÓN DE REGISTROS PARA EL BUCLE ===
    MOV CX, [count]  ; Carga el valor de 'count' (5) en CX para usarlo como contador del bucle
    MOV SI, 0        ; Inicializa SI (Source Index) a 0 - será nuestro índice para recorrer el array
    MOV AX, 0        ; Inicializa AX a 0 - aquí acumularemos la suma total

SUM_LOOP:           ; Etiqueta que marca el inicio del bucle de suma
    ADD AX, [array+SI]  ; SUMA: Agrega el elemento actual del array a AX
                      ; [array+SI] usa direccionamiento base + índice:
                      ; - 'array' es la dirección base del array
                      ; - 'SI' es el desplazamiento desde el inicio
                      ; Como cada elemento es DW (2 bytes), SI avanza de 2 en 2

    ADD SI, 2        ; INCREMENTA ÍNDICE: Suma 2 a SI para apuntar al siguiente elemento
                      ; (2 bytes porque usamos DW - Define Word)

    LOOP SUM_LOOP    ; DECREMENTA Y SALTA:
                      ; 1. Decrementa CX automáticamente (CX = CX - 1)
                      ; 2. Si CX ≠ 0, salta a la etiqueta SUM_LOOP
                      ; 3. Si CX = 0, continúa con la siguiente instrucción

    ; === ALMACENAR RESULTADO ===
    MOV [sum], AX    ; Guarda el resultado acumulado en AX en la variable 'sum'

    ; === TERMINAR PROGRAMA ===
    MOV AH, 4Ch      ; Carga 4Ch en AH - función de DOS para terminar programa
    INT 21h          ; Llama a la interrupción 21h de DOS para finalizar la ejecución

END START           ; Directiva que indica el fin del programa y su punto de entrada