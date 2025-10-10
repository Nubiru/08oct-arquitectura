### 08oct-arquitectura

Proyecto de programación en Assembly para el curso de Arquitectura de Computadoras. Implementación de ejercicios en múltiples arquitecturas (16-bit DOS y 64-bit Linux) con análisis comparativos.

---

## 📖 Documentación Completa

**Para documentación detallada y exhaustiva, visita el [Wiki del Proyecto](../../wiki).**

### 📚 Páginas del Wiki

- **[Home](../../wiki/Home)** - Descripción general, estructura, conceptos clave, recursos
- **[Ejercicio 2: Factorial](../../wiki/Ejercicio-2-Factorial)** - Documentación completa de todas las 13 tareas
- **[Guía de Navegación](../../wiki/Guia-de-Navegacion)** - Índice completo y búsqueda por temas

El Wiki contiene:

- ✅ 15,000+ palabras de documentación técnica
- ✅ 40+ ejemplos de código comentado
- ✅ 15+ tablas comparativas
- ✅ Análisis profundo de Assembly vs C
- ✅ Problemas y soluciones documentados
- ✅ Recursos y referencias completas

---

## 👥 Integrantes

| Integrante           | Ejercicio Asignado      |
| -------------------- | ----------------------- |
| **Mariano Capella**  | Ejercicio 1 - Fibonacci |
| **Gabriel Osemberg** | Ejercicio 2 - Factorial |
| **Eric Velazquez**   | Ejercicio 3 - Primo     |
| **Bruno Velazquez**  | Ejercicio 4 - Suma      |

---

## 📂 Estructura del Repositorio

```
08oct-arquitectura/
├── ejercicio-uno/          # Ejercicio 1 - Fibonacci
├── ejercicio-dos/          # Ejercicio 2 - Factorial
│   ├── 1-archivos-assembler/
│   ├── 2-imagenes/
│   ├── 3-archivos-compilados/
│   ├── 4-commandos/
│   └── README.md
├── ejercicio-tres/         # Ejercicio 3 - Primo
├── ejercicio-cuatro/       # Ejercicio 4 - Suma
├── ejercicio-cinco/        # Ejercicio 5
├── wiki/                   # Archivos fuente del Wiki
│   ├── Home.md
│   ├── Ejercicio-2-Factorial.md
│   ├── Guia-de-Navegacion.md
│   └── _Sidebar.md
└── README.md               # Este archivo
```

---

## 🎯 Ejercicios

### Ejercicio 2: Cálculo del Factorial ✅

**Responsable:** Gabriel Osemberg  
**Estado:** Completado
**Colab:** https://colab.research.google.com/drive/1VY7ymPgDaFlETu_Sm0A8k3461iWCI0bc#scrollTo=P1LO_-fOh8eB

Implementación completa del algoritmo factorial en:

- Assembly 16-bit para DOS (TASM)
- Assembly 64-bit para Linux (NASM)
- Versión en C (iterativa y recursiva)
- Comparación Assembly manual vs generado por GCC

**[Ver documentación completa](../../wiki/Ejercicio-2-Factorial)**

---

## 🛠️ Tecnologías Utilizadas

- **TASM 4.1** - Turbo Assembler (16-bit DOS)
- **NASM** - Netwide Assembler (64-bit Linux)
- **GCC** - GNU Compiler Collection
- **DOSBox** - Emulador DOS
- **Google Colab** - Entorno Linux online
- **Git/GitHub** - Control de versiones

---

## 🚀 Inicio Rápido

### Clonar el Repositorio

```bash
git clone https://github.com/[usuario]/08oct-arquitectura.git
cd 08oct-arquitectura
```

### Compilar Assembly (Linux)

```bash
# Ensamblar
nasm -f elf64 programa.asm -o programa.o

# Enlazar
ld programa.o -o programa

# Ejecutar
./programa
```

### Compilar C

```bash
gcc programa.c -o programa
./programa
```

Para más comandos y detalles, consulta el [Wiki](../../wiki/Home#-cómo-usar-este-repositorio).

---

## 📊 Estado del Proyecto

| Ejercicio   | Responsable(s)       | Estado        |
| ----------- | -------------------- | ------------- |
| Ejercicio 1 | Mariano, Eric, Bruno | ⏳ Pendiente  |
| Ejercicio 2 | Gabriel Osemberg     | ✅ Completado |
| Ejercicio 3 | Mariano, Eric, Bruno | ⏳ Pendiente  |
| Ejercicio 4 | Mariano, Eric, Bruno | ⏳ Pendiente  |
| Ejercicio 5 | Mariano, Eric, Bruno | ⏳ Pendiente  |

---

## 🎓 Información Académica

**Universidad:** UPC Capilla del Monte
**Curso:** Arquitectura de Computadoras  
**Profesor:** Narciso Perez
**Período:** Octubre 2024

---

## 📞 Contacto

- **Issues:** [Abrir un Issue](../../issues)
- **Pull Requests:** [Contribuir](../../pulls)
- **Wiki:** [Documentación completa](../../wiki)

---

## 📄 Licencia

Este proyecto es material académico desarrollado para fines educativos.

---

**Última actualización:** Octubre 10, 2024
