# 🧭 Guía de Navegación del Wiki

Bienvenido al Wiki del proyecto **Arquitectura de Computadoras - Assembly**.

---

## 📖 Estructura del Wiki

### Páginas Principales

1. **[Home](Home)** - Página principal del proyecto

   - Descripción general
   - Integrantes del equipo
   - Estructura del repositorio
   - Objetivos y tecnologías

2. **[Ejercicio 2: Factorial](Ejercicio-2-Factorial)** - Documentación completa

   - Todas las 13 tareas completadas
   - Implementaciones en Assembly 16-bit y 64-bit
   - Versión en C y análisis comparativo
   - Problemas y soluciones

3. **[Guía de Navegación](Guia-de-Navegacion)** - Esta página

---

## 🎯 ¿Qué estás buscando?

### Para Comenzar

- ¿Primera vez aquí? → [Home](Home)
- ¿Quieres ver el ejercicio completo? → [Ejercicio 2: Factorial](Ejercicio-2-Factorial)

### Conceptos Técnicos

- **Modos de direccionamiento** → [Ejercicio 2 - Tarea 2](Ejercicio-2-Factorial#tarea-2-comentar-el-código-)
- **Diferencias 16-bit vs 64-bit** → [Home - Diferencias Entre Arquitecturas](Home#-diferencias-entre-arquitecturas)
- **Syscalls en Linux** → [Ejercicio 2 - Tarea 4](Ejercicio-2-Factorial#tarea-4-implementar-en-linux-)

### Implementaciones

- **Assembly 16-bit (TASM)** → [Ejercicio 2 - Tarea 3](Ejercicio-2-Factorial#tarea-3-implementar-en-turbo-assembler-)
- **Assembly 64-bit (NASM)** → [Ejercicio 2 - Tarea 4](Ejercicio-2-Factorial#tarea-4-implementar-en-linux-)
- **Versión en C** → [Ejercicio 2 - Tarea 7](Ejercicio-2-Factorial#tarea-7-versión-en-c-)

### Compilación

- **Comandos de compilación** → [Ejercicio 2 - Tarea 5](Ejercicio-2-Factorial#tarea-5-comandos-de-compilación-en-linux-)
- **Generar Assembly desde C** → [Ejercicio 2 - Tarea 8](Ejercicio-2-Factorial#tarea-8-obtener-assembly-del-programa-en-c-)

### Análisis

- **Comparación Assembly vs GCC** → [Ejercicio 2 - Tarea 9](Ejercicio-2-Factorial#tarea-9-comparar-versiones-de-ensamblador-)
- **Problemas comunes** → [Ejercicio 2 - Tarea 10](Ejercicio-2-Factorial#tarea-10-situaciones-problemáticas-)

### Preguntas Específicas

- **¿Por qué ADD SI, 2?** → [Ejercicio 2 - Tarea 13](Ejercicio-2-Factorial#tarea-13-por-qué-add-si-2-)
- **Entrada por teclado** → [Ejercicio 2 - Tarea 6](Ejercicio-2-Factorial#tarea-6-entrada-por-teclado-)

---

## 🛠️ Recursos Rápidos

### Herramientas

- [Instalación de TASM](Home#herramientas-y-tecnologías)
- [Instalación de NASM](Home#herramientas-y-tecnologías)
- [Configurar DOSBox](Home#recursos-adicionales)

### Comandos Frecuentes

#### Compilar Assembly (Linux)

```bash
nasm -f elf64 programa.asm -o programa.o
ld programa.o -o programa
./programa
```

#### Compilar C

```bash
gcc programa.c -o programa
./programa
```

#### Generar Assembly desde C

```bash
gcc -S -masm=intel programa.c -o programa.s
```

---

## 📚 Por Nivel de Experiencia

### Principiantes

1. Comienza con el [Home](Home)
2. Lee los [Conceptos Clave](Home#-conceptos-clave-cubiertos)
3. Revisa el [Diagrama de Flujo](Ejercicio-2-Factorial#tarea-1-diagrama-de-flujo-)
4. Estudia los [Modos de Direccionamiento](Ejercicio-2-Factorial#modos-de-direccionamiento-demostrados)

### Intermedios

1. Analiza la [Implementación 16-bit](Ejercicio-2-Factorial#tarea-3-implementar-en-turbo-assembler-)
2. Compara con la [Implementación 64-bit](Ejercicio-2-Factorial#tarea-4-implementar-en-linux-)
3. Estudia los [Problemas y Soluciones](Ejercicio-2-Factorial#-problemas-y-soluciones)

### Avanzados

1. Revisa la [Comparación Assembly vs GCC](Ejercicio-2-Factorial#tarea-9-comparar-versiones-de-ensamblador-)
2. Analiza las [Optimizaciones](Ejercicio-2-Factorial#2-loop-del-factorial)
3. Estudia las [Diferencias Arquitectónicas](Ejercicio-2-Factorial#diferencias-16-bit-vs-64-bit)

---

## 🔍 Búsqueda por Tema

### Assembly x86 (16-bit)

- [Implementación factorial 16-bit](Ejercicio-2-Factorial#tarea-3-implementar-en-turbo-assembler-)
- [Correcciones TASM](Ejercicio-2-Factorial#correcciones-realizadas)
- [Interrupciones DOS](Ejercicio-2-Factorial#versión-16-bit-dos)

### Assembly x64 (64-bit)

- [Implementación factorial 64-bit](Ejercicio-2-Factorial#tarea-4-implementar-en-linux-)
- [Syscalls Linux](Ejercicio-2-Factorial#características-principales)
- [Direccionamiento RIP-relativo](Ejercicio-2-Factorial#características-avanzadas)

### Lenguaje C

- [Versión iterativa](Ejercicio-2-Factorial#versión-iterativa-equivalente-al-assembly)
- [Versión recursiva](Ejercicio-2-Factorial#versión-recursiva-para-comparación)
- [Assembly generado por GCC](Ejercicio-2-Factorial#tarea-8-obtener-assembly-del-programa-en-c-)

### Optimización

- [Comparación de performance](Ejercicio-2-Factorial#performance-manual-vs-gcc)
- [Análisis de instrucciones](Ejercicio-2-Factorial#2-loop-del-factorial)
- [Uso de registros vs memoria](Ejercicio-2-Factorial#3-gestión-de-registros)

### Debugging

- [Problemas comunes](Ejercicio-2-Factorial#tabla-resumen)
- [Desbordamiento numérico](Ejercicio-2-Factorial#1-desbordamiento-numérico)
- [Conversión ASCII](Ejercicio-2-Factorial#3-conversión-ascii)

---

## 📊 Índice Completo de Tareas

### Ejercicio 2: Factorial

| #   | Tarea                          | Estado | Link Directo                                                             |
| --- | ------------------------------ | ------ | ------------------------------------------------------------------------ |
| 1   | Diagrama de Flujo              | ✅     | [Ver](Ejercicio-2-Factorial#tarea-1-diagrama-de-flujo-)                  |
| 2   | Comentar el Código             | ✅     | [Ver](Ejercicio-2-Factorial#tarea-2-comentar-el-código-)                 |
| 3   | Implementar en Turbo Assembler | ✅     | [Ver](Ejercicio-2-Factorial#tarea-3-implementar-en-turbo-assembler-)     |
| 4   | Implementar en Linux           | ✅     | [Ver](Ejercicio-2-Factorial#tarea-4-implementar-en-linux-)               |
| 5   | Comandos de Compilación        | ✅     | [Ver](Ejercicio-2-Factorial#tarea-5-comandos-de-compilación-en-linux-)   |
| 6   | Entrada por Teclado            | ✅     | [Ver](Ejercicio-2-Factorial#tarea-6-entrada-por-teclado-)                |
| 7   | Versión en C                   | ✅     | [Ver](Ejercicio-2-Factorial#tarea-7-versión-en-c-)                       |
| 8   | Obtener Assembly desde C       | ✅     | [Ver](Ejercicio-2-Factorial#tarea-8-obtener-assembly-del-programa-en-c-) |
| 9   | Comparar Versiones             | ✅     | [Ver](Ejercicio-2-Factorial#tarea-9-comparar-versiones-de-ensamblador-)  |
| 10  | Situaciones Problemáticas      | ✅     | [Ver](Ejercicio-2-Factorial#tarea-10-situaciones-problemáticas-)         |
| 11  | Repositorio GitHub             | ✅     | [Ver](Ejercicio-2-Factorial#tarea-11-repositorio-github-)                |
| 12  | Sin Definir                    | ⏳     | [Ver](Ejercicio-2-Factorial#tarea-12-sin-definir)                        |
| 13  | ¿Por qué ADD SI, 2?            | ✅     | [Ver](Ejercicio-2-Factorial#tarea-13-por-qué-add-si-2-)                  |

---

## 🎓 Material Educativo

### Conceptos Fundamentales

- [Arquitectura de Procesadores](Home#arquitectura-de-procesadores)
- [Modos de Direccionamiento](Home#modos-de-direccionamiento)
- [Llamadas al Sistema](Home#llamadas-al-sistema)

### Tutoriales Paso a Paso

1. [Cómo compilar en TASM](Ejercicio-2-Factorial#comandos-de-compilación)
2. [Cómo compilar en NASM](Ejercicio-2-Factorial#para-assembly-64-bit-nasm)
3. [Cómo generar Assembly desde C](Ejercicio-2-Factorial#generar-assembly-desde-c)

### Ejemplos de Código

- [Loop factorial en Assembly](Ejercicio-2-Factorial#implementación-técnica)
- [Conversión ASCII a número](Ejercicio-2-Factorial#versión-64-bit-linux)
- [Llamadas a syscall](Ejercicio-2-Factorial#características-principales)

---

## 📞 Ayuda y Soporte

### Problemas Comunes

- Error `@DATA` → [Solución](Ejercicio-2-Factorial#problema-1-símbolo-data-no-reconocido-en-tasm-41)
- Desbordamiento → [Solución](Ejercicio-2-Factorial#1-desbordamiento-numérico)
- Conversión ASCII → [Solución](Ejercicio-2-Factorial#3-conversión-ascii)

### Contacto

- Abrir un [Issue en GitHub](../../issues)
- Contactar a los [Integrantes](Home#-integrantes-del-equipo)

---

## 🔗 Enlaces Externos

### Documentación Oficial

- [Intel Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [NASM Docs](https://nasm.us/doc/)
- [GCC Manual](https://gcc.gnu.org/onlinedocs/)

### Recursos de Aprendizaje

- [x86 Assembly Guide](https://cs.stanford.edu/people/eroberts/courses/soco/projects/risc/x86assembly/)
- [Linux Syscalls](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Compiler Explorer](https://godbolt.org/)

---

## 📅 Última Actualización

Esta guía fue actualizada por última vez: **Octubre 10, 2024**

---

[← Volver al Home](Home)
