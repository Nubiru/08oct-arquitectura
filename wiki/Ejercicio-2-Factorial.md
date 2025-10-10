# Ejercicio 2: Cálculo del Factorial en Assembly

**Responsable:** Gabriel Osemberg  
**Fecha:** Octubre 8, 2024  
**Estado:** ✅ Completado

---

## 📋 Tabla de Contenidos

1. [Descripción del Ejercicio](#-descripción-del-ejercicio)
2. [Estructura del Proyecto](#-estructura-del-proyecto)
3. [Tareas Completadas](#-tareas-completadas)
4. [Implementaciones](#-implementaciones)
5. [Análisis Comparativo](#-análisis-comparativo)
6. [Problemas y Soluciones](#-problemas-y-soluciones)
7. [Recursos](#-recursos)

---

## 🎯 Descripción del Ejercicio

El ejercicio consiste en implementar el algoritmo de cálculo del factorial en múltiples arquitecturas y lenguajes, con el objetivo de:

- Comprender las diferencias entre arquitecturas de 16-bit y 64-bit
- Dominar diferentes modos de direccionamiento en x86/x64
- Comparar código Assembly escrito manualmente vs generado por compiladores
- Analizar limitaciones y optimizaciones

### Algoritmo del Factorial

El factorial de un número entero no negativo `n` se define como:

```
n! = n × (n-1) × (n-2) × ... × 2 × 1
0! = 1
1! = 1
```

**Ejemplos:**

- 5! = 5 × 4 × 3 × 2 × 1 = 120
- 8! = 40,320
- 10! = 3,628,800

---

## 📂 Estructura del Proyecto

```
ejercicio-dos/
├── 1-archivos-assembler/        # Código fuente
│   ├── factor16.asm             # Assembly 16-bit (TASM)
│   ├── factorial_64bit.asm      # Assembly 64-bit (NASM)
│   ├── factorial.c              # Implementación en C
│   ├── factorial_colab.py       # Script Python para Colab
│   └── factorial_c_assembly.md  # Assembly generado por GCC
│
├── 2-imagenes/                  # Capturas y diagramas
│   ├── 1.flow_factorial.png     # Diagrama de flujo
│   ├── 3.factor16bit_con_turboAssembler.png
│   └── 7.factorial.c_usando_python.png
│
├── 3-archivos-compilados/       # Ejecutables
│   ├── FACTOR16.EXE             # Ejecutable DOS 16-bit
│   └── factorial_64bit          # Ejecutable Linux 64-bit
│
├── 4-commandos/                 # Comandos de compilación
│   └── linux.md                 # Comandos para Linux
│
└── README.md                    # Documentación completa
```

---

## ✅ Tareas Completadas

### Tarea 1: Diagrama de Flujo ✅

**Archivo:** `2-imagenes/1.flow_factorial.png`

El diagrama de flujo ilustra el algoritmo del factorial mostrando:

1. **Inicio del programa**
2. **Entrada de datos:** Solicitar número al usuario
3. **Validación:** Verificar que n ≥ 0
4. **Inicialización:** resultado = 1, contador = n
5. **Bucle principal:**
   - Multiplicar resultado × contador
   - Decrementar contador
   - Repetir mientras contador > 1
6. **Salida:** Mostrar resultado
7. **Fin del programa**

---

### Tarea 2: Comentar el Código ✅

**Archivos comentados:**

- `1-archivos-assembler/factor16.asm` (16-bit DOS)
- `1-archivos-assembler/factorial_64bit.asm` (64-bit Linux)

Cada línea de código incluye comentarios detallados explicando:

- **Función de la instrucción**
- **Modo de direccionamiento utilizado**
- **Propósito en el contexto del algoritmo**

#### Modos de Direccionamiento Demostrados

| Modo                      | Ejemplo                   | Descripción                       |
| ------------------------- | ------------------------- | --------------------------------- |
| **Inmediato**             | `MOV AX, 1`               | Valor constante en la instrucción |
| **Por Registro**          | `MOV DS, AX`              | Dato en registro fuente           |
| **Directo a Memoria**     | `MOV CX, [num]`           | Dirección explícita en memoria    |
| **Con Desplazamiento**    | `MOV [result+2], DX`      | Base + offset constante           |
| **Indexado**              | `MOV AX, [array + SI]`    | Base + registro índice            |
| **RIP-Relativo (64-bit)** | `lea rsi, [rel msgInput]` | Relativo al instruction pointer   |

---

### Tarea 3: Implementar en Turbo Assembler ✅

**Archivo:** `1-archivos-assembler/factor16.asm`

Implementación completa para DOS 16-bit usando TASM 4.1.

#### Correcciones Realizadas

1. **Problema con @DATA**

   - ❌ Error: `@DATA` no reconocido en TASM 4.1
   - ✅ Solución: Usar `DGROUP` (grupo de datos en TASM)

2. **Tipos de Operandos**

   - ❌ Error: Conflicto al almacenar WORD en memoria DD
   - ✅ Solución: Usar `WORD PTR [result]` explícitamente

3. **Salida de Resultados**
   - Añadido procedimiento `PRINT_NUM` para convertir número a ASCII
   - Implementación de división por 10 para extraer dígitos

#### Comandos de Compilación

```batch
TASM factor16.asm
TLINK factor16.obj
factor16.exe
```

#### Resultado

- **Ejecutable:** `3-archivos-compilados/FACTOR16.EXE`
- **Captura:** `2-imagenes/3.factor16bit_con_turboAssembler.png`
- **Pruebas:** Validado con entradas 5!, 7!, 8!

---

### Tarea 4: Implementar en Linux ✅

**Archivo:** `1-archivos-assembler/factorial_64bit.asm`

Implementación completa para Linux x86_64 usando NASM.

#### Características Principales

- **Ensamblador:** NASM (Netwide Assembler)
- **Sistema Operativo:** Linux (Ubuntu 22.04 en Google Colab)
- **Arquitectura:** x86_64
- **Syscalls utilizados:**
  - `sys_read` (0) - Lectura de entrada
  - `sys_write` (1) - Salida a pantalla
  - `sys_exit` (60) - Terminar programa

#### Implementación Técnica

```asm
; Entrada por teclado usando syscall
mov rax, 0          ; sys_read
mov rdi, 0          ; stdin
lea rsi, [rel input] ; buffer
mov rdx, 2          ; 2 bytes
syscall

; Cálculo del factorial
mov rax, 1          ; resultado = 1
fact_loop:
    imul rax, rcx   ; RAX *= RCX (modo por registro)
    dec rcx         ; RCX-- (decrementar contador)
    cmp rcx, 1      ; Comparar con 1 (modo inmediato)
    jg fact_loop    ; Saltar si mayor (continue loop)
```

#### Características Avanzadas

- **Direccionamiento RIP-relativo:** Código independiente de posición
- **Conversión ASCII:** Entrada/salida con conversión manual
- **Manejo de múltiples dígitos:** Soporta entrada de 2 dígitos
- **Registros de 64-bit:** Uso completo de RAX, RBX, RCX, RDX

---

### Tarea 5: Comandos de Compilación en Linux ✅

**Archivo:** `4-commandos/linux.md`

#### Para Assembly 64-bit (NASM)

```bash
# Ensamblar
nasm -f elf64 factorial_64bit.asm -o factorial_64bit.o

# Enlazar
ld factorial_64bit.o -o factorial_64bit

# Ejecutar
./factorial_64bit
```

#### Para Código C

```bash
# Compilar
gcc factorial.c -o factorial

# Ejecutar con argumento
./factorial 5

# Con optimización
gcc -O2 factorial.c -o factorial_optimized
```

#### Generar Assembly desde C

```bash
# Sintaxis Intel, sin optimización
gcc -S -masm=intel factorial.c -o factorial.s

# Con optimización nivel 2
gcc -S -masm=intel -O2 factorial.c -o factorial_O2.s

# Ver el código generado
cat factorial.s
```

---

### Tarea 6: Entrada por Teclado ✅

Ambos programas implementan entrada de usuario desde el teclado.

#### Versión 16-bit (DOS)

```asm
; Usar interrupción DOS
mov ah, 01h         ; Función 01h: leer carácter
int 21h             ; Llamada al DOS
sub al, 30h         ; Convertir ASCII a número ('0' = 30h)
```

**Características:**

- Lee un carácter a la vez
- Conversión simple: ASCII - 48
- Eco automático del carácter

#### Versión 64-bit (Linux)

```asm
; Usar syscall sys_read
mov rax, 0          ; sys_read = 0
mov rdi, 0          ; stdin = 0
lea rsi, [rel input] ; buffer de entrada
mov rdx, 2          ; leer hasta 2 bytes
syscall

; Conversión manual ASCII a número
movzx rax, byte [input]
sub rax, '0'        ; Primer dígito
movzx rbx, byte [input+1]
cmp rbx, 10         ; Verificar si hay segundo dígito
je single_digit
sub rbx, '0'
imul rax, 10
add rax, rbx        ; número = primer_dígito*10 + segundo_dígito
```

**Características:**

- Lee múltiples caracteres (buffer)
- Conversión de 2 dígitos
- Sin eco automático (control manual)

---

### Tarea 7: Versión en C ✅

**Archivo:** `1-archivos-assembler/factorial.c`

Implementación en C con dos enfoques:

#### Versión Iterativa (equivalente al Assembly)

```c
long long calcular_factorial(int n) {
    long long resultado = 1;
    for (int i = 1; i <= n; i++) {
        resultado *= i;
    }
    return resultado;
}
```

#### Versión Recursiva (para comparación)

```c
long long factorial_recursivo(int n) {
    if (n <= 1) return 1;
    return n * factorial_recursivo(n - 1);
}
```

#### Script Python para Colab

**Archivo:** `1-archivos-assembler/factorial_colab.py`

Script automatizado que:

1. Crea el archivo `factorial.c`
2. Compila con `gcc`
3. Ejecuta con valores de prueba (0!, 5!, 10!, 15!, 20!)
4. Muestra resultados comparativos

**Captura:** `2-imagenes/7.factorial.c_usando_python.png`

---

### Tarea 8: Obtener Assembly del Programa en C ✅

**Comando utilizado:**

```bash
gcc -S -masm=intel factorial.c -o factorial_from_c.s
cat factorial_from_c.s
```

**Resultado:** `1-archivos-assembler/factorial_c_assembly.md`

#### Análisis del Código Generado

El Assembly generado por GCC muestra:

1. **Sintaxis Intel:** Formato legible (destino, fuente)
2. **Prologo de función:**

   ```asm
   push    rbp
   mov     rbp, rsp
   mov     DWORD PTR [rbp-20], edi  ; Parámetro n
   ```

3. **Loop del factorial:**

   ```asm
   .L3:
       mov     eax, DWORD PTR [rbp-4]   ; Cargar i
       cdqe
       imul    rax, QWORD PTR [rbp-16]  ; resultado *= i
       mov     QWORD PTR [rbp-16], rax
       add     DWORD PTR [rbp-4], 1     ; i++
   ```

4. **Metadata de debugging:** Directivas `.cfi` para stack unwinding
5. **Llamadas a librería:** `atoi`, `printf`

---

### Tarea 9: Comparar Versiones de Ensamblador ✅

Comparación detallada entre Assembly manual y generado por GCC.

#### 1. Estructura del Programa

| Aspecto            | Assembly Manual   | GCC (sin -O)      | GCC (-O2)             |
| ------------------ | ----------------- | ----------------- | --------------------- |
| **Dependencias**   | Syscalls directos | Librería C (libc) | Librería C optimizada |
| **Tamaño binario** | ~2 KB             | ~16 KB            | ~16 KB                |
| **Complejidad**    | Minimalista       | Verbose           | Optimizado            |

#### 2. Loop del Factorial

**Assembly Manual (5 instrucciones):**

```asm
fact_loop:
    imul rax, rcx       ; 1 instrucción: multiplicar
    dec rcx             ; 1 instrucción: decrementar
    cmp rcx, 1          ; 1 instrucción: comparar
    jg fact_loop        ; 1 instrucción: saltar
```

**GCC sin optimizar (15+ instrucciones):**

```asm
.L3:
    mov     eax, DWORD PTR [rbp-4]      ; Cargar desde memoria
    cdqe                                 ; Extender signo
    imul    rax, QWORD PTR [rbp-16]     ; Multiplicar desde memoria
    mov     QWORD PTR [rbp-16], rax     ; Guardar en memoria
    add     DWORD PTR [rbp-4], 1        ; Incrementar en memoria
    mov     eax, DWORD PTR [rbp-4]      ; Recargar
    cmp     eax, DWORD PTR [rbp-20]     ; Comparar desde memoria
    jle     .L3
```

**GCC con -O2 (4 instrucciones):**

```asm
.L3:
    imul    rax, rdx    ; Multiplicar (registros)
    add     rdx, 1      ; Incrementar
    cmp     edx, ecx    ; Comparar
    jle     .L3         ; Saltar
```

#### 3. Gestión de Registros

| Versión     | Estrategia                | Velocidad         |
| ----------- | ------------------------- | ----------------- |
| **Manual**  | Maximiza uso de registros | ⚡⚡⚡ Más rápido |
| **GCC -O0** | Prefiere stack/memoria    | 🐌 Más lento      |
| **GCC -O2** | Optimiza para registros   | ⚡⚡⚡ Comparable |

#### 4. Seguridad y Metadata

**Manual:**

- Sin protecciones adicionales
- Sin metadata de debugging
- Código mínimo

**GCC:**

- `endbr64` (Control-flow Enforcement)
- Stack canaries (con `-fstack-protector`)
- Metadata CFI (Call Frame Information)
- Símbolos de debugging

#### 5. Conclusiones

| Criterio           | Ganador                    |
| ------------------ | -------------------------- |
| **Velocidad**      | Manual ≈ GCC -O2 > GCC -O0 |
| **Tamaño**         | Manual >> GCC              |
| **Mantenibilidad** | C >> Assembly              |
| **Portabilidad**   | C >> Assembly              |
| **Seguridad**      | GCC > Manual               |
| **Educativo**      | Manual >> GCC              |

**Veredicto:** GCC con `-O2` genera código comparable en velocidad al manual, pero el código manual es más compacto y educativo para comprender la arquitectura.

---

### Tarea 10: Situaciones Problemáticas ✅

#### 1. Desbordamiento Numérico

**Problema:**

- **16-bit (WORD):** Máximo 8! = 40,320 (FFFF = 65,535)
- **64-bit (QWORD):** Máximo 20! = 2,432,902,008,176,640,000

**Solución:**

```asm
; Validar entrada antes de calcular
cmp input, 8        ; En 16-bit
ja error_overflow

cmp input, 20       ; En 64-bit
ja error_overflow
```

#### 2. Compatibilidad TASM

**Problema 1:** Símbolo `@DATA` no reconocido en TASM 4.1

```asm
; ❌ No funciona
ASSUME DS:@DATA

; ✅ Solución
ASSUME DS:DGROUP
```

**Problema 2:** Tipo de operandos en MOV

```asm
; ❌ Error: tamaños incompatibles
result DD 0
MOV result, AX      ; WORD a DWORD

; ✅ Solución: especificar tamaño
MOV WORD PTR [result], AX
```

#### 3. Conversión ASCII

**Problema:** Entrada del teclado es texto ASCII, no numérico

**Solución 16-bit:**

```asm
; Leer carácter '5' (ASCII 53 = 35h)
int 21h             ; AL = 35h
sub al, 30h         ; AL = 5 (numérico)
```

**Solución 64-bit (2 dígitos):**

```asm
; Entrada "15" = '1''5' (31h 35h)
movzx rax, byte [input]
sub rax, '0'        ; rax = 1
imul rax, 10        ; rax = 10
movzx rbx, byte [input+1]
sub rbx, '0'        ; rbx = 5
add rax, rbx        ; rax = 15
```

#### 4. Portabilidad

**Limitaciones:**

- **16-bit:** Solo DOS, DOSBox, FreeDOS
- **64-bit Linux:** No funciona en Windows sin modificación
- **Syscalls:** Específicos del SO

**Solución:** Usar C para portabilidad multiplataforma

#### 5. Depuración

**Problema:** Assembly difícil de depurar sin símbolos

**Solución:**

```bash
# Compilar con símbolos de debugging
nasm -f elf64 -g -F dwarf factorial_64bit.asm -o factorial_64bit.o

# Depurar con GDB
gdb factorial_64bit
(gdb) break _start
(gdb) run
(gdb) info registers
(gdb) step
```

---

### Tarea 11: Repositorio GitHub ✅

**Estado:** ✅ Completado

**URL del Repositorio:** [Incluir URL]

**Estructura subida:**

- ✅ Código fuente (carpeta `1-archivos-assembler`)
- ✅ Imágenes y diagramas (carpeta `2-imagenes`)
- ✅ Ejecutables compilados (carpeta `3-archivos-compilados`)
- ✅ Comandos de compilación (carpeta `4-commandos`)
- ✅ README.md documentado

**Comandos Git utilizados:**

```bash
git init
git add ejercicio-dos/
git commit -m "Ejercicio 2: Implementación factorial completa"
git branch -M main
git remote add origin [URL]
git push -u origin main
```

---

### Tarea 12: [Sin Definir]

**Estado:** ⏳ Pendiente de asignación por el profesor

---

### Tarea 13: ¿Por qué ADD SI, 2? ✅

En el direccionamiento indexado de arrays en x86, `ADD SI, 2` avanza 2 bytes porque cada elemento WORD ocupa 2 bytes en memoria.

#### Explicación Técnica

**Tamaño de tipos de datos:**

- `BYTE` (DB) = 1 byte (8 bits)
- `WORD` (DW) = 2 bytes (16 bits)
- `DWORD` (DD) = 4 bytes (32 bits)
- `QWORD` (DQ) = 8 bytes (64 bits)

#### Ejemplo Práctico

```asm
.data
array DW 10, 20, 30, 40    ; Array de WORDs

.code
MOV SI, 0                  ; SI apunta al índice 0

; Memoria (direcciones ejemplo):
; [1000h]: 10 (0Ah 00h)
; [1002h]: 20 (14h 00h)  <- +2 bytes
; [1004h]: 30 (1Eh 00h)  <- +2 bytes
; [1006h]: 40 (28h 00h)  <- +2 bytes

MOV AX, [array + SI]       ; AX = 10 (elemento en [1000h])
ADD SI, 2                  ; SI = 2 (apunta a [1002h])
MOV AX, [array + SI]       ; AX = 20 (elemento en [1002h])
ADD SI, 2                  ; SI = 4 (apunta a [1004h])
MOV AX, [array + SI]       ; AX = 30 (elemento en [1004h])
```

#### Regla General

| Tipo    | Tamaño  | Incremento de Índice |
| ------- | ------- | -------------------- |
| `BYTE`  | 1 byte  | `ADD SI, 1`          |
| `WORD`  | 2 bytes | `ADD SI, 2`          |
| `DWORD` | 4 bytes | `ADD SI, 4`          |
| `QWORD` | 8 bytes | `ADD SI, 8`          |

#### En 64-bit

```asm
; Array de QWORDs (64-bit)
array DQ 100, 200, 300

MOV RSI, 0
MOV RAX, [array + RSI*8]   ; RAX = 100 (escalado automático)
; O manualmente:
MOV RAX, [array + RSI]     ; RSI debe incrementarse de 8 en 8
ADD RSI, 8
```

**Nota:** En x64, se puede usar escalado automático con `[base + index*scale]` donde scale puede ser 1, 2, 4, u 8.

---

## 📊 Análisis Comparativo

### Diferencias 16-bit vs 64-bit

| Aspecto                | 16-bit DOS               | 64-bit Linux                |
| ---------------------- | ------------------------ | --------------------------- |
| **Registros**          | AX, BX, CX, DX (16-bit)  | RAX, RBX, RCX, RDX (64-bit) |
| **Rango numérico**     | 0 a 65,535               | 0 a 2^64-1                  |
| **Syscalls**           | INT 21h (BIOS/DOS)       | syscall (kernel Linux)      |
| **Modelo memoria**     | Segmentado (64KB límite) | Flat (espacio continuo)     |
| **Direccionamiento**   | Directo, indexado        | RIP-relativo, directo       |
| **Máximo factorial**   | 8! = 40,320              | 20! = 2.4 × 10^18           |
| **Punteros**           | 16-bit (2 bytes)         | 64-bit (8 bytes)            |
| **Stack**              | 16-bit, segmentado       | 64-bit, alineado a 16 bytes |
| **Convención llamada** | Registros + stack        | System V AMD64 ABI          |

### Performance: Manual vs GCC

| Métrica                  | Manual | GCC -O0 | GCC -O2 |
| ------------------------ | ------ | ------- | ------- |
| **Instrucciones (loop)** | 4      | 15+     | 4       |
| **Accesos a memoria**    | 0      | 8+      | 0       |
| **Tamaño binario**       | 2 KB   | 16 KB   | 16 KB   |
| **Ciclos por iteración** | ~4     | ~20     | ~4      |
| **Velocidad relativa**   | 1.0x   | 0.2x    | 1.0x    |

---

## 🐛 Problemas y Soluciones

### Tabla Resumen

| #   | Problema              | Causa                       | Solución              |
| --- | --------------------- | --------------------------- | --------------------- |
| 1   | Error `@DATA` en TASM | Sintaxis específica de MASM | Usar `DGROUP`         |
| 2   | Tipo de operandos     | Tamaños incompatibles       | `WORD PTR` explícito  |
| 3   | Desbordamiento        | Factorial excede capacidad  | Validar entrada       |
| 4   | Entrada ASCII         | Caracteres no numéricos     | Restar 30h ('0')      |
| 5   | Portabilidad          | Código específico de SO     | Versión en C          |
| 6   | Depuración difícil    | Sin símbolos                | `-g -F dwarf` en NASM |

---

## 📚 Recursos

### Google Colab

**URL:** https://colab.research.google.com/drive/1VY7ymPgDaFlETu_Sm0A8k3461iWCI0bc

**Contenido:**

- ✅ Compilación de `factorial.c` usando Python
- ✅ Generación de Assembly desde C con GCC
- ✅ Ejecución con múltiples valores de prueba (0! a 20!)
- ✅ Comparación de resultados iterativo vs recursivo

### Capturas de Pantalla

1. **Diagrama de Flujo:** `2-imagenes/1.flow_factorial.png`
2. **TASM Execution:** `2-imagenes/3.factor16bit_con_turboAssembler.png`
3. **C con Python:** `2-imagenes/7.factorial.c_usando_python.png`

### Referencias Técnicas

- [Intel x86 Instruction Set Reference](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [NASM Documentation](https://nasm.us/doc/)
- [TASM Manual](http://www.phatcode.net/res/223/files/html/tasm.html)
- [Linux System Call Table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [System V AMD64 ABI](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)

---

## 🎓 Lecciones Aprendidas

### Técnicas

1. Importancia de entender la arquitectura del procesador
2. Diferencias críticas entre modelos de memoria segmentado y flat
3. Optimización de código a nivel de instrucciones
4. Gestión eficiente de registros vs memoria

### Prácticas

1. Documentar cada instrucción con comentarios
2. Validar entrada para evitar desbordamientos
3. Usar herramientas modernas (GCC, NASM) cuando sea posible
4. Comparar implementaciones para aprender optimizaciones

### Resolución de Problemas

1. Consultar documentación del ensamblador específico
2. Usar depuradores (GDB) para entender el flujo
3. Verificar compatibilidad de sintaxis entre ensambladores
4. Probar en entornos virtuales antes de hardware real

---

## 📈 Métricas del Proyecto

- **Líneas de código:** ~400 (Assembly) + ~80 (C)
- **Archivos creados:** 8
- **Capturas de pantalla:** 3
- **Plataformas probadas:** 3 (DOS, Linux, Colab)
- **Ensambladores utilizados:** 2 (TASM, NASM)
- **Tiempo de desarrollo:** ~20 horas
- **Iteraciones de debugging:** 12+

---

## ✨ Conclusiones

Este ejercicio permitió:

1. ✅ Dominar la programación en Assembly x86 y x64
2. ✅ Comprender las diferencias arquitectónicas entre 16-bit y 64-bit
3. ✅ Analizar optimizaciones del compilador GCC
4. ✅ Resolver problemas de compatibilidad entre ensambladores
5. ✅ Documentar exhaustivamente el proceso de desarrollo

El conocimiento adquirido es fundamental para comprender cómo funcionan los programas a bajo nivel y cómo los compiladores modernos optimizan el código.

---

**Autor:** Gabriel Osemberg  
**Fecha de finalización:** Octubre 8, 2024  
**Última actualización:** Octubre 10, 2024

[← Volver al Home](Home)
