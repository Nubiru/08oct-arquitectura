# Ejercicio Dos - Factorial

Gabriel Osemberg

---

## Estructura del Proyecto

```
ejercicio-dos/
├── 1-archivos-assembler/     Código fuente (.asm, .c)
├── 2-imagenes/                Capturas y diagramas
├── 3-archivos-compilados/     Ejecutables (.exe, .obj)
├── 4-commandos/               Comandos de compilación
└── README.md                  Este archivo
```

---

## Respuestas a las Tareas

### Tarea 1: Diagrama de Flujo

**Archivo:** `2-imagenes/1.flow_factorial.png`

Diagrama de flujo del algoritmo del factorial mostrando:

- Entrada de datos
- Inicialización de variables (resultado = 1)
- Bucle de multiplicación
- Condición de salida
- Salida del resultado

### Tarea 2: Comentar el Código

**Archivos:**

- `1-archivos-assembler/factor16.asm` (16-bit DOS)
- `1-archivos-assembler/factorial_64bit.asm` (64-bit Linux)

Cada línea de código incluye comentarios explicando:

- Función de la instrucción
- Modo de direccionamiento utilizado
- Propósito en el contexto del programa

Modos de direccionamiento demostrados:

- Inmediato: `MOV AX, 1`
- Por registro: `MOV DS, AX`
- Directo a memoria: `MOV CX, [num]`
- Con desplazamiento: `MOV [result+2], DX`
- RIP-relativo (64-bit): `lea rsi, [rel msgInput]`

### Tarea 3: Implementar en Turbo Assembler

**Archivo:** `1-archivos-assembler/factor16.asm`

**Correcciones realizadas para TASM 4.1:**

- Cambio de `@DATA` a `DGROUP` (grupo de datos en TASM)
- Uso de `WORD PTR` para especificar tamaño al almacenar en memoria DD
- Añadido procedimiento `PRINT_NUM` para mostrar el resultado

**Comandos de compilación:**

```
TASM factor16.asm
TLINK factor16.obj
factor16.exe
```

**Resultado:** `3-archivos-compilados/FACTOR16.EXE`

**Captura:** `2-imagenes/3.factor16bit_con_turboAssembler.png`

### Tarea 4: Implementar en Linux

**Archivo:** `1-archivos-assembler/factorial_64bit.asm`

Implementación completa para Linux x86_64 usando:

- NASM como ensamblador
- Syscalls del kernel (sys_read, sys_write, sys_exit)
- Direccionamiento RIP-relativo
- Entrada por teclado
- Conversión ASCII a número y viceversa

**Sistema utilizado:** Google Colab (Ubuntu 22.04)

### Tarea 5: Comandos de Compilación en Linux

**Archivo:** `4-commandos/linux.md`

**Para ensamblar 64-bit:**

```bash
nasm -f elf64 factorial_64bit.asm -o factorial_64bit.o
ld factorial_64bit.o -o factorial_64bit
./factorial_64bit
```

**Para compilar C:**

```bash
gcc factorial.c -o factorial
./factorial 5
```

### Tarea 6: Entrada por Teclado

Ambos programas implementan entrada por teclado:

**16-bit (factor16.asm):**

- Usa interrupción DOS INT 21h, función 01h
- Lee un carácter ASCII
- Convierte restando 30h ('0')

**64-bit (factorial_64bit.asm):**

- Usa syscall sys_read (número 0)
- Lee hasta 2 dígitos
- Conversión manual de ASCII a número

### Tarea 7: Versión en C

**Archivo:** `1-archivos-assembler/factorial.c`

Implementa dos versiones:

- **Iterativa:** Usando bucle for (equivalente al assembly)
- **Recursiva:** Usando llamadas recursivas (para comparación)

**Archivo para Colab:** `1-archivos-assembler/factorial_colab.py`

Script Python que:

1. Crea el archivo factorial.c
2. Lo compila con gcc
3. Lo ejecuta con múltiples valores de prueba

**Captura:** `2-imagenes/7.factorial.c_usando_python.png`

### Tarea 8: Obtener Assembly del Programa en C

**Comando utilizado en Colab:**

```bash
gcc -S -masm=intel factorial.c -o factorial_from_c.s
cat factorial_from_c.s
```

**Resultado:** `1-archivos-assembler/factorial_c_assembly.md`

El archivo generado muestra:

- Sintaxis Intel
- Funciones calcular_factorial y main
- Uso de stack frame (push rbp, mov rbp, rsp)
- Llamadas a funciones de librería (atoi, printf)
- Metadata de debugging (.cfi directives)

### Tarea 9: Comparar Versiones de Ensamblador

**Comparación: Assembly Manual vs Generado por GCC**

**Diferencias principales:**

1. **Estructura:**

   - Manual: Usa syscalls directos, sin dependencias
   - GCC: Usa funciones de librería C (printf, atoi)

2. **Loop del factorial:**

   - Manual (5 instrucciones):
     ```asm
     imul rax, rcx
     dec rcx
     cmp rcx, 1
     jg .fact_loop
     ```
   - GCC sin optimizar (15+ instrucciones): Usa memoria stack
   - GCC con -O2 (4 instrucciones): Similar al manual

3. **Gestión de registros:**

   - Manual: Maximiza uso de registros (más rápido)
   - GCC: Prefiere memoria para compatibilidad

4. **Tamaño del binario:**

   - Manual: aproximadamente 2 KB
   - GCC: aproximadamente 16 KB (8x más grande)

5. **Seguridad:**
   - Manual: Sin protecciones adicionales
   - GCC: Incluye endbr64, stack canaries, metadata

**Conclusión:** GCC con -O2 genera código comparable al manual en velocidad, pero el código manual es más compacto y educativo.

### Tarea 10: Situaciones Problemáticas

**Problemas identificados:**

1. **Desbordamiento numérico:**

   - 16-bit: máximo 8! (40,320)
   - 64-bit: máximo 20! (2,432,902,008,176,640,000)
   - Solución: Validar entrada

2. **Compatibilidad TASM:**

   - Error con símbolo @DATA en TASM 4.1
   - Solución: Usar DGROUP en lugar de @DATA
   - Error con tipos de operandos
   - Solución: Usar WORD PTR explícitamente

3. **Conversión ASCII:**

   - En assembly se debe convertir manualmente
   - Solución: Procedimiento de división por 10

4. **Portabilidad:**

   - 16-bit solo funciona en DOS o DOSBox
   - 64-bit específico para Linux
   - C es portable entre plataformas

5. **Depuración:**
   - Assembly difícil sin símbolos
   - Solución: Usar flags -g -F dwarf en NASM

### Tarea 11: Repositorio GitHub

**Estado:** Pendiente

**Archivos a incluir:**

- Código fuente (carpeta 1-archivos-assembler)
- Imágenes (carpeta 2-imagenes)
- Ejecutables (carpeta 3-archivos-compilados)
- Comandos (carpeta 4-commandos)
- README.md

**Comandos Git:**

```bash
git init
git add .
git commit -m "Proyecto factorial completo"
git remote add origin [URL]
git push -u origin main
```

### Tarea 12: (Sin definir)

Pendiente de asignación por el profesor.

### Tarea 13: ¿Por qué ADD SI, 2?

En el direccionamiento indexado de arrays en x86, ADD SI, 2 avanza de 2 bytes porque:

**Explicación:**

- En x86, una WORD (DW) ocupa 2 bytes (16 bits)
- Cuando se define un array de palabras, cada elemento está en posiciones de memoria consecutivas separadas por 2 bytes
- Para apuntar al siguiente elemento, debemos sumar 2 al registro índice

**Ejemplo:**

```asm
array DW 10, 20, 30    ; Cada elemento = 2 bytes

; Memoria:
; [1000h]: 10
; [1002h]: 20  (1000h + 2)
; [1004h]: 30  (1002h + 2)

MOV SI, 0              ; Apunta al primer elemento
MOV AX, [array + SI]   ; AX = 10
ADD SI, 2              ; Ahora apunta al segundo elemento
MOV AX, [array + SI]   ; AX = 20
```

**Regla general:**

- BYTE (DB): ADD SI, 1
- WORD (DW): ADD SI, 2
- DWORD (DD): ADD SI, 4
- QWORD (DQ): ADD SI, 8

---

## Recursos y Enlaces

**Google Colab con implementación completa:**
https://colab.research.google.com/drive/1VY7ymPgDaFlETu_Sm0A8k3461iWCI0bc

**Contenido del Colab:**

- Compilación de factorial.c usando Python
- Generación de assembly desde C
- Ejecución con múltiples valores de prueba
- Comparación de resultados

---

## Notas Técnicas

### Diferencias 16-bit vs 64-bit

| Aspecto          | 16-bit DOS        | 64-bit Linux       |
| ---------------- | ----------------- | ------------------ |
| Registros        | AX, BX, CX, DX    | RAX, RBX, RCX, RDX |
| Syscalls         | INT 21h           | syscall            |
| Modelo memoria   | Segmentado        | Flat               |
| Direccionamiento | Directo, indexado | RIP-relativo       |
| Tamaño máximo    | 8!                | 20!                |

### Correcciones Importantes

1. **TASM @DATA:** Usar DGROUP en lugar de @DATA
2. **Tipos operandos:** Usar WORD PTR [result] explícitamente
3. **Comando GCC:** gcc -S -masm=intel (no -O0 por defecto)

---

**Fecha:** Octubre 8, 2024  
**Curso:** Arquitectura de Computadoras  
**Institución:** Universidad
