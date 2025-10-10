#!/usr/bin/env python3
"""
Factorial Calculator - Python script for Google Colab
Creates, compiles, and executes a C program to calculate factorials
"""

import subprocess
import os

# C code as a string
c_code = """
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint64_t calcular_factorial(int n) {
    uint64_t resultado = 1;
    if (n <= 1) {
        return 1;
    }
    for (int i = 2; i <= n; i++) {
        resultado *= i;
    }
    return resultado;
}

uint64_t calcular_factorial_recursivo(int n) {
    if (n <= 1) {
        return 1;
    }
    return n * calcular_factorial_recursivo(n - 1);
}

int main(int argc, char *argv[]) {
    int numero;
    
    if (argc > 1) {
        numero = atoi(argv[1]);
    } else {
        numero = 5;
    }
    
    if (numero < 0 || numero > 20) {
        fprintf(stderr, "Error: numero debe estar entre 0 y 20\\n");
        return 1;
    }
    
    uint64_t resultado = calcular_factorial(numero);
    printf("El factorial de %d es: %lu\\n", numero, resultado);
    printf("Verificacion recursiva: %lu\\n", calcular_factorial_recursivo(numero));
    printf("Resultado en hexadecimal: 0x%lX\\n", resultado);
    
    return 0;
}
"""

def main():
    print("="*60)
    print("FACTORIAL - Generador y Compilador de Codigo C")
    print("="*60)
    
    # Step 1: Write C code to file
    print("\n[1] Creando archivo factorial.c...")
    with open('factorial.c', 'w') as f:
        f.write(c_code)
    print("    ✓ Archivo factorial.c creado exitosamente")
    
    # Step 2: Compile C code
    print("\n[2] Compilando con GCC...")
    compile_result = subprocess.run(
        ['gcc', 'factorial.c', '-o', 'factorial'],
        capture_output=True,
        text=True
    )
    
    if compile_result.returncode != 0:
        print("    ✗ Error en compilacion:")
        print(compile_result.stderr)
        return
    print("    ✓ Compilacion exitosa")
    
    # Step 3: Execute with different test values
    print("\n[3] Ejecutando programa con diferentes valores:")
    print("-"*60)
    
    test_values = [0, 1, 5, 8, 10]
    
    for val in test_values:
        print(f"\n--- Factorial de {val} ---")
        run_result = subprocess.run(
            ['./factorial', str(val)],
            capture_output=True,
            text=True
        )
        print(run_result.stdout)
    
    print("="*60)
    print("Proceso completado exitosamente")
    print("="*60)

if __name__ == "__main__":
    main()

