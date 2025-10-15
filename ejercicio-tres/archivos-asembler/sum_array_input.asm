%%writefile sum_array_input.asm
section .data
    prompt db "Ingrese los %d elementos del array, separados por espacio: ", 0
    input_buffer db "          ", 0 ; Buffer para leer la entrada (suficientemente grande para 5 números de 2 dígitos + espacios)
    array dw 5 dup(0) ; Array para almacenar los números ingresados
    array_size dw 5
    sum dw 0
    newline db 10, 0 ; Carácter de nueva línea

section .text
    global _start

_start:
    ; === PEDIR AL USUARIO QUE INGRESE LOS ELEMENTOS ===
    ; Imprimir el mensaje
    mov eax, 4         ; sys_write syscall number (i386)
    mov ebx, 1         ; file descriptor 1 (stdout)
    mov ecx, prompt    ; message to write
    mov edx, 44        ; message length (approx) - ajusta si el mensaje cambia
    int 80h            ; call kernel

    ; === LEER LA ENTRADA DEL USUARIO ===
    mov eax, 3         ; sys_read syscall number (i386)
    mov ebx, 0         ; file descriptor 0 (stdin)
    mov ecx, input_buffer ; buffer to read into
    mov edx, 100       ; max bytes to read
    int 80h            ; call kernel

    ; === PROCESAR LA ENTRADA Y ALMACENAR EN EL ARRAY ===
    ; Simplificado: Asume que los números son de 2 dígitos y están separados por espacio
    ; En un programa real, se necesitaría un análisis más robusto de la cadena de entrada
    mov esi, input_buffer
    mov edi, array
    mov ecx, [array_size] ; Loop counter

read_loop:
    ; Saltar espacios iniciales
skip_spaces:
    mov al, [esi]
    cmp al, ' '
    je advance_esi
    cmp al, 10 ; Newline
    je advance_esi
    cmp al, 0 ; Null terminator
    je end_read_loop

    ; Convertir 2 dígitos ASCII a número
    movzx eax, byte [esi]
    sub eax, '0'
    mov ebx, 10
    mul ebx ; EAX = primer dígito * 10

    inc esi
    movzx ebx, byte [esi]
    sub ebx, '0'
    add eax, ebx ; EAX = (primer dígito * 10) + segundo dígito

    ; Almacenar en el array (DW = 2 bytes)
    mov [edi], ax

    add esi, 2 ; Saltar el número (asumimos 2 dígitos)
    add edi, 2 ; Mover al siguiente elemento del array (DW)

    loop read_loop

end_read_loop:

    ; === SUMAR ELEMENTOS DEL ARRAY ===
    mov ecx, [array_size]  ; Carga el valor de 'array_size' (5) en CX
    mov esi, 0             ; Inicializa SI (Source Index) a 0 - índice para recorrer el array
    mov eax, 0             ; Inicializa EAX a 0 - acumulador de la suma

SUM_LOOP:
    add eax, [array+esi]  ; SUMA: Agrega el elemento actual del array a EAX
    add esi, 2            ; INCREMENTA ÍNDICE: Suma 2 a SI (porque usamos DW - Define Word)
    loop SUM_LOOP         ; DECREMENTA CX y salta si CX != 0

    ; === ALMACENAR RESULTADO (Opcional, para futuros usos) ===
    ; mov [sum], eax ; No se usa para imprimir aquí directamente, pero se podría guardar

    ; === IMPRIMIR EL RESULTADO (Simplificado: solo imprime el valor en EAX como si fuera un número) ===
    ; Para imprimir un número real, se necesitaría convertir el valor numérico en EAX a una cadena de caracteres ASCII.
    ; Esto es complejo en ensamblador. Por ahora, solo terminaremos el programa.
    ; En un escenario real, usaríamos una rutina de conversión a ASCII y sys_write.

    ; === TERMINAR PROGRAMA ===
    mov eax, 1         ; sys_exit syscall number (i386)
    mov ebx, 0         ; exit code 0 (success)
    int 80h            ; call kernel

advance_esi:
    inc esi
    jmp skip_spaces