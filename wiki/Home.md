# Arquitectura de Computadoras - Proyecto de Assembly

## 📚 Descripción del Proyecto

Este repositorio contiene el desarrollo práctico de ejercicios de programación en Assembly para el curso de Arquitectura de Computadoras. El proyecto abarca implementaciones en múltiples arquitecturas y paradigmas, desde sistemas de 16-bit (DOS) hasta sistemas modernos de 64-bit (Linux).

---

## 👥 Integrantes del Equipo

| Integrante       | Ejercicio Asignado      |
| ---------------- | ----------------------- |
| Gabriel Osemberg | Ejercicio 2 - Factorial |
| Mariano Capella  | Ejercicios 1, 3, 4, 5   |
| Eric Velazquez   | Ejercicios 1, 3, 4, 5   |
| Bruno Velazquez  | Ejercicios 1, 3, 4, 5   |

---

## 📂 Estructura del Repositorio

```
08oct-arquitectura/
├── ejercicio-uno/          # Ejercicio 1
├── ejercicio-dos/          # Ejercicio 2 - Factorial (Gabriel Osemberg)
│   ├── 1-archivos-assembler/
│   ├── 2-imagenes/
│   ├── 3-archivos-compilados/
│   ├── 4-commandos/
│   └── README.md
├── ejercicio-tres/         # Ejercicio 3
├── ejercicio-cuatro/       # Ejercicio 4
├── ejercicio-cinco/        # Ejercicio 5
└── README.md
```

---

## 🎯 Objetivos del Proyecto

### Objetivos Generales

- Comprender la arquitectura de computadoras a bajo nivel
- Dominar la programación en lenguaje ensamblador
- Analizar las diferencias entre arquitecturas de 16-bit y 64-bit
- Comparar código ensamblador escrito manualmente vs generado por compiladores

### Objetivos Específicos

- Implementar algoritmos en Assembly x86/x64
- Utilizar diferentes ensambladores (TASM, NASM)
- Trabajar con diferentes sistemas operativos (DOS, Linux)
- Comprender modos de direccionamiento de memoria
- Analizar optimizaciones del compilador

---

## 🛠️ Herramientas y Tecnologías

### Ensambladores

- **TASM 4.1** - Turbo Assembler (16-bit DOS)
- **NASM** - Netwide Assembler (64-bit Linux)

### Compiladores

- **GCC** - GNU Compiler Collection (C a Assembly)

### Entornos de Desarrollo

- **DOSBox** - Emulador DOS para pruebas de 16-bit
- **Google Colab** - Entorno Linux para desarrollo de 64-bit
- **WSL/Linux** - Para compilación y ejecución de código nativo

### Control de Versiones

- **Git** - Sistema de control de versiones
- **GitHub** - Repositorio remoto y colaboración

---

## 📋 Ejercicios

### [Ejercicio 2: Factorial en Assembly](Ejercicio-2-Factorial)

**Responsable:** Gabriel Osemberg

Implementación completa del algoritmo factorial en múltiples arquitecturas:

- Assembly 16-bit para DOS (TASM)
- Assembly 64-bit para Linux (NASM)
- Versión en C (iterativa y recursiva)
- Comparación de código ensamblador manual vs generado por GCC

**Estado:** ✅ Completado

---

## 📖 Conceptos Clave Cubiertos

### Arquitectura de Procesadores

- Registros de propósito general (AX, BX, CX, DX / RAX, RBX, RCX, RDX)
- Registros de segmento (CS, DS, ES, SS)
- Flags y banderas de estado
- Stack pointer y base pointer

### Modos de Direccionamiento

- **Inmediato:** `MOV AX, 1`
- **Por Registro:** `MOV BX, AX`
- **Directo a Memoria:** `MOV AX, [num]`
- **Con Desplazamiento:** `MOV [result+2], DX`
- **Indexado:** `MOV AX, [array + SI]`
- **RIP-Relativo (64-bit):** `lea rsi, [rel msgInput]`

### Llamadas al Sistema

- **DOS (16-bit):** Interrupciones `INT 21h`
- **Linux (64-bit):** Syscalls con instrucción `syscall`

### Convenciones de Llamada

- Paso de parámetros por registros vs stack
- Preservación de registros
- Valor de retorno en RAX/EAX

---

## 🔍 Diferencias Entre Arquitecturas

| Aspecto               | 16-bit DOS                     | 64-bit Linux                |
| --------------------- | ------------------------------ | --------------------------- |
| **Registros**         | 16-bit (AX, BX, CX, DX)        | 64-bit (RAX, RBX, RCX, RDX) |
| **Modelo de Memoria** | Segmentado (64KB por segmento) | Flat (espacio continuo)     |
| **Syscalls**          | INT 21h con función en AH      | syscall con número en RAX   |
| **Direccionamiento**  | Directo, indexado              | RIP-relativo, directo       |
| **Tamaño Puntero**    | 2 bytes (segmento:offset)      | 8 bytes                     |
| **Stack**             | Crece hacia abajo, 16-bit      | Crece hacia abajo, 64-bit   |
| **Alineación**        | 2 bytes                        | 16 bytes                    |

---

## 📚 Recursos Adicionales

### Documentación Técnica

- [Intel Software Developer's Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [AMD64 Architecture Programmer's Manual](https://www.amd.com/en/support/tech-docs)
- [NASM Documentation](https://nasm.us/docs.php)

### Tutoriales y Referencias

- [x86 Assembly Guide (Stanford)](https://cs.stanford.edu/people/eroberts/courses/soco/projects/risc/x86assembly/)
- [Linux System Call Table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [GCC Inline Assembly](https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html)

### Herramientas Online

- [Online x86 Assembler](https://defuse.ca/online-x86-assembler.htm)
- [Compiler Explorer (Godbolt)](https://godbolt.org/)
- [DOSBox Downloads](https://www.dosbox.com/download.php?main=1)

---

## 🚀 Cómo Usar Este Repositorio

### Clonar el Repositorio

```bash
git clone https://github.com/[usuario]/08oct-arquitectura.git
cd 08oct-arquitectura
```

### Compilar Código Assembly (Linux)

```bash
# Ensamblar con NASM
nasm -f elf64 programa.asm -o programa.o

# Enlazar
ld programa.o -o programa

# Ejecutar
./programa
```

### Compilar Código C

```bash
gcc programa.c -o programa
./programa
```

### Generar Assembly desde C

```bash
# Sintaxis Intel
gcc -S -masm=intel programa.c -o programa.s

# Con optimización
gcc -S -masm=intel -O2 programa.c -o programa_optimizado.s
```

---

## 📝 Metodología de Trabajo

1. **Análisis del Problema**

   - Comprender el algoritmo
   - Crear diagrama de flujo
   - Identificar estructuras de datos

2. **Implementación**

   - Escribir código en Assembly
   - Comentar cada instrucción
   - Documentar modos de direccionamiento

3. **Compilación y Pruebas**

   - Ensamblar el código
   - Enlazar ejecutable
   - Probar con casos de uso

4. **Análisis Comparativo**

   - Implementar versión en C
   - Generar Assembly desde C
   - Comparar eficiencia y tamaño

5. **Documentación**
   - Capturas de pantalla
   - README detallado
   - Problemas y soluciones

---

## 🐛 Problemas Comunes y Soluciones

### TASM: Error con @DATA

**Problema:** TASM 4.1 no reconoce el símbolo `@DATA`  
**Solución:** Usar `DGROUP` en lugar de `@DATA`

### Tipos de Operandos

**Problema:** Error al mover registros de 16-bit a memoria de 32-bit  
**Solución:** Usar `WORD PTR [variable]` explícitamente

### Desbordamiento Numérico

**Problema:** Factorial de números grandes excede capacidad del registro  
**Solución:** Validar entrada (máximo 8! en 16-bit, 20! en 64-bit)

### Conversión ASCII

**Problema:** La entrada del teclado es ASCII, no numérico  
**Solución:** Restar 30h ('0') para convertir de ASCII a número

---

## 📊 Estándares de Código

### Convenciones de Nomenclatura

- **Etiquetas:** snake_case o camelCase (`fact_loop`, `factLoop`)
- **Constantes:** UPPER_CASE (`MAX_VALUE`, `BUFFER_SIZE`)
- **Variables:** snake_case (`input_num`, `result_str`)

### Comentarios

```asm
; Comentario de una línea explicando la instrucción
mov rax, 1        ; RAX = 1 (modo inmediato)

; Bloque de comentario explicando
; una sección completa del código
```

### Estructura de Archivo

1. Comentario de encabezado (autor, fecha, descripción)
2. Sección de datos (`.data`, `.bss`)
3. Sección de código (`.text`, `_start`)
4. Procedimientos/funciones
5. Punto de entrada

---

## 🎓 Institución Académica

**Universidad:** [Nombre de la Universidad]  
**Curso:** Arquitectura de Computadoras  
**Profesor:** [Nombre del Profesor]  
**Período:** Octubre 2024  
**Carrera:** Ingeniería en Sistemas / Informática

---

## 📄 Licencia

Este proyecto es material académico desarrollado para fines educativos.

---

## 📞 Contacto y Colaboración

Para preguntas, sugerencias o colaboraciones sobre este proyecto:

- Abrir un [Issue](../../issues) en GitHub
- Contribuir mediante [Pull Request](../../pulls)
- Contactar a los integrantes del equipo

---

## 🔄 Actualizaciones

| Fecha      | Descripción                                           |
| ---------- | ----------------------------------------------------- |
| 08/10/2024 | Ejercicio 2 (Factorial) completado - Gabriel Osemberg |
| [Fecha]    | Ejercicio 1 completado                                |
| [Fecha]    | Ejercicio 3 completado                                |
| [Fecha]    | Ejercicio 4 completado                                |
| [Fecha]    | Ejercicio 5 completado                                |

---

**Última actualización:** Octubre 2024
