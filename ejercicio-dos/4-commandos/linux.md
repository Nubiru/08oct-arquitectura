### Comandos de Compilación y Ejecución

## Para compilar en Linux:

```bash
# 1. Ensamblar: Convertir .asm a .o (archivo objeto)
nasm -f elf64 factorial_64bit.asm -o factorial_64bit.o

# Explicación de flags:
#   -f elf64  : Formato de salida ELF de 64 bits (Linux)
#   -o        : Especifica el nombre del archivo de salida

# 2. Linkear: Crear el ejecutable
ld factorial_64bit.o -o factorial_64bit

# Explicación:
#   ld : Linker, une el archivo objeto con las bibliotecas necesarias
#   -o : Nombre del ejecutable final

# 3. Ejecutar el programa
./factorial_64bit

# 4. Verificar que el archivo es ejecutable de 64 bits
file factorial_64bit
# Output esperado: factorial_64bit: ELF 64-bit LSB executable, x86-64...
```

## Para compilar en Colab:

%%bash

# Write the assembly file

cat > factorial_64bit.asm << 'EOF'
[***PEGAR CONTENIDO DE factorial_64bit.asm AQUI***]
EOF

# Install NASM if needed

apt-get update && apt-get install -y nasm

# Compile and run

nasm -f elf64 factorial_64bit.asm -o factorial_64bit.o
ld factorial_64bit.o -o factorial_64bit
echo "5" | ./factorial_64bit
