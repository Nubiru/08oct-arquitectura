; ============================================================================
; Programa: Cálculo del factorial de un número (16-bit DOS)
; ============================================================================
; Descripción: Calcula n! = n * (n-1) * (n-2) * ... * 1
; Consideramos n pequeño para evitar desbordamiento (máximo 8 para 16-bit)
; 
; Modos de direccionamiento utilizados:
;   - Inmediato: MOV AX, 1
;   - Por registro: MOV DS, AX
;   - Directo a memoria: MOV CX, [num]
;   - Directo a memoria: MOV [result], AX
; ============================================================================

.MODEL SMALL ; Define el modelo de memoria (código y datos < 64KB)
.STACK 100h ; Reserva 256 bytes para la pila

.DATA  ; Sección de datos
    num     DW 5 ; DW = Define Word (16 bits). Número a calcular factorial
    result  DD ? ; DD = Define Doubleword (32 bits). Almacena resultado
    
    ; Mensajes para entrada/salida
    msgInput  DB 'Ingrese un numero (0-8): $'
    msgResult DB 0Dh, 0Ah, 'El factorial es: $'
    newline   DB 0Dh, 0Ah, '$'

.CODE ; Sección de código
START:
; ========================================
; Inicialización del segmento de datos
; ========================================
    MOV AX, DGROUP              ; DGROUP es el grupo de datos (Data Group)
; Direccionamiento inmediato: carga dirección en AX
    MOV DS, AX                  ; DS = AX. Inicializa registro de segmento de datos
; Direccionamiento por registro
    
; ========================================
; Solicitar entrada del usuario
; ========================================
    MOV AH, 09h ; Función 09h de INT 21h: mostrar cadena
; Direccionamiento inmediato
    LEA DX, msgInput ; LEA = Load Effective Address
; Carga la dirección de msgInput en DX
; Direccionamiento directo
    INT 21h ; Llamada al DOS para imprimir
    
; Leer un carácter del teclado
    MOV AH, 01h ; Función 01h: leer carácter con eco
    INT 21h ; AL contiene el carácter ASCII leído
    
    SUB AL, 30h ; Convertir ASCII a número (resta '0')
; Direccionamiento por registro
    MOV CL, AL ; Guardar el número en CL
    MOV CH, 0 ; CX = número ingresado (CH=0, CL=valor)
    MOV [num], CX ; Guardar en variable num
; Direccionamiento directo a memoria
    
; ========================================
; Cálculo del factorial
; ========================================
    MOV AX, 1 ; AX = 1 (acumulador del resultado)
; Direccionamiento inmediato
    MOV CX, [num] ; CX = valor de num (contador del loop)
; Direccionamiento directo a memoria
    
    CMP CX, 0 ; Comparar CX con 0
; Direccionamiento inmediato y por registro
    JE FACT_DONE ; Si CX = 0, saltar a FACT_DONE (0! = 1)
; JE = Jump if Equal
    
FACT_LOOP:
    MUL CX ; AX = AX * CX (multiplicación sin signo)
; Direccionamiento por registro
; Resultado en DX:AX (32 bits)
    LOOP FACT_LOOP              
; Decrementa CX y salta si CX != 0
; LOOP combina DEC CX + JNZ
    
FACT_DONE:
    MOV WORD PTR [result], AX   ; Almacenar parte baja del resultado (16 bits)
; Direccionamiento directo a memoria con cast
    MOV WORD PTR [result+2], DX ; Almacenar parte alta del resultado (16 bits)
; Direccionamiento con desplazamiento
    
    ; ========================================
    ; Mostrar mensaje de resultado
    ; ========================================
    MOV AH, 09h                 ; Función para imprimir cadena
    LEA DX, msgResult           ; Cargar dirección del mensaje
    INT 21h                     ; Imprimir mensaje
    
    ; ========================================
    ; Convertir número a ASCII y mostrar
    ; ========================================
    MOV AX, WORD PTR [result]   ; Cargar resultado en AX
    CALL PRINT_NUM              ; Llamar procedimiento para imprimir
    
    ; Imprimir newline
    MOV AH, 09h
    LEA DX, newline
    INT 21h
    
    ; ========================================
    ; Finalización del programa
    ; ========================================
    MOV AH, 4Ch ; Función 4Ch: terminar programa
; Direccionamiento inmediato
    INT 21h ; Llamada al DOS para salir
; Retorna control al sistema operativo

; ============================================================================
; Procedimiento: PRINT_NUM
; ============================================================================
; Convierte un número en AX a ASCII y lo muestra en pantalla
; Entrada: AX = número a imprimir (0-65535)
; Salida: Ninguna
; Modifica: AX, BX, CX, DX
; ============================================================================
PRINT_NUM PROC
    PUSH AX ; Guardar registros en la pila
    PUSH BX ; PUSH = direccionamiento implícito a pila
    PUSH CX
    PUSH DX
    
    MOV CX, 0 ; CX = contador de dígitos
    MOV BX, 10 ; BX = divisor (base 10)
    
    ; Caso especial: si AX = 0
    CMP AX, 0 ; Comparar con 0
    JNE DIVIDE_LOOP ; Si no es 0, continuar
    
; Imprimir '0' y salir
    MOV DL, '0' ; DL = carácter '0'
    MOV AH, 02h ; Función 02h: imprimir carácter
    INT 21h
    JMP PRINT_DONE ; Saltar al final
    
DIVIDE_LOOP:
    ; Dividir AX entre 10
    XOR DX, DX ; Limpiar DX (parte alta del dividendo)
; XOR = operación lógica
    DIV BX ; AX = AX / BX, DX = AX % BX
; Direccionamiento por registro
    
    ADD DL, '0' ; Convertir resto a ASCII
; Direccionamiento por registro
    PUSH DX ; Guardar dígito en pila
; Uso de la pila para invertir orden
    INC CX ; Incrementar contador de dígitos
    
    CMP AX, 0 ; ¿Quedan más dígitos?
    JNE DIVIDE_LOOP ; Si AX != 0, continuar dividiendo
    
PRINT_LOOP:
    POP DX ; Recuperar dígito de la pila
; POP = direccionamiento implícito a pila
    MOV AH, 02h ; Función 02h de INT 21h: imprimir carácter
; Direccionamiento inmediato
    INT 21h ; Imprimir carácter en DL
    LOOP PRINT_LOOP ; Repetir CX veces (LOOP decrementa CX)
    
PRINT_DONE:
    POP DX ; Restaurar registros desde la pila
    POP CX
    POP BX
    POP AX
    RET ; Retornar al punto de llamada
; RET usa la pila para obtener dirección
PRINT_NUM ENDP

END START ; Indica el punto de entrada del programa

