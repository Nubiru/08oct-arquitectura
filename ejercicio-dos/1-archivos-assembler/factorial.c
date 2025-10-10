/**
 * ============================================================================
 * Programa: Cálculo del factorial de un número (Versión en C)
 * ============================================================================
 * Descripción: Calcula n! = n * (n-1) * (n-2) * ... * 1
 * 
 * Compilar: gcc factorial.c -o factorial
 * Ejecutar: ./factorial
 * 
 * Para obtener el código ensamblador generado por el compilador:
 *   gcc -S factorial.c -o factorial.s        (AT&T syntax)
 *   gcc -S -masm=intel factorial.c -o factorial.s  (Intel syntax)
 * 
 * Para ver el código optimizado:
 *   gcc -S -O2 -masm=intel factorial.c -o factorial_optimized.s
 * ============================================================================
 */

#include <stdio.h>
#include <stdint.h>

/**
 * Función: calcular_factorial
 * ---------------------------
 * Calcula el factorial de un número usando iteración
 * 
 * n: número del cual calcular el factorial
 * 
 * returns: el factorial de n
 * 
 * Nota: Usamos uint64_t para soportar números grandes (hasta 20!)
 *       20! = 2,432,902,008,176,640,000
 *       21! ya causa overflow en 64 bits
 */
uint64_t calcular_factorial(int n) {
    uint64_t resultado = 1;
    
    // Caso base: 0! = 1, 1! = 1
    if (n <= 1) {
        return 1;
    }
    
    // Cálculo iterativo del factorial
    // Equivalente al loop en assembly
    for (int i = 2; i <= n; i++) {
        resultado *= i;
    }
    
    return resultado;
}

/**
 * Función: calcular_factorial_recursivo
 * -------------------------------------
 * Calcula el factorial usando recursión
 * (alternativa para comparar con versión iterativa)
 * 
 * n: número del cual calcular el factorial
 * 
 * returns: el factorial de n
 */
uint64_t calcular_factorial_recursivo(int n) {
    // Caso base
    if (n <= 1) {
        return 1;
    }
    
    // Caso recursivo: n! = n * (n-1)!
    return n * calcular_factorial_recursivo(n - 1);
}

/**
 * Función: main
 * -------------
 * Punto de entrada del programa
 * Solicita un número al usuario y calcula su factorial
 */
int main(void) {
    int numero;
    uint64_t resultado;
    
    // Solicitar entrada al usuario
    printf("Ingrese un numero (0-20): ");
    
    // Leer el número desde stdin
    // scanf retorna el número de elementos leídos exitosamente
    if (scanf("%d", &numero) != 1) {
        fprintf(stderr, "Error: entrada invalida\n");
        return 1;
    }
    
    // Validar el rango
    if (numero < 0) {
        fprintf(stderr, "Error: el numero debe ser no negativo\n");
        return 1;
    }
    
    if (numero > 20) {
        fprintf(stderr, "Advertencia: numeros mayores a 20 causan overflow\n");
        printf("Se calculara de todas formas...\n");
    }
    
    // Calcular factorial (versión iterativa)
    resultado = calcular_factorial(numero);
    
    // Mostrar resultado
    printf("\nEl factorial de %d es: %lu\n", numero, resultado);
    
    // Calcular también con versión recursiva para comparación
    uint64_t resultado_recursivo = calcular_factorial_recursivo(numero);
    printf("(Verificacion recursiva: %lu)\n", resultado_recursivo);
    
    // Información adicional sobre el tamaño del resultado
    printf("\nInformacion adicional:\n");
    printf("  Tamaño del resultado: %zu bytes\n", sizeof(resultado));
    printf("  Numero ingresado: %d\n", numero);
    printf("  Resultado en hexadecimal: 0x%lX\n", resultado);
    
    return 0;
}

/**
 * ============================================================================
 * COMPARACIÓN CON ASSEMBLY:
 * ============================================================================
 * 
 * 1. VARIABLES:
 *    C: int numero, uint64_t resultado
 *    ASM 16-bit: num DW, result DD
 *    ASM 64-bit: num resq 1, result resq 1
 * 
 * 2. LOOP:
 *    C: for (int i = 2; i <= n; i++) { resultado *= i; }
 *    ASM 16-bit: FACT_LOOP: MUL CX / LOOP FACT_LOOP
 *    ASM 64-bit: .fact_loop: imul rax, rcx / dec rcx / jg .fact_loop
 * 
 * 3. ENTRADA/SALIDA:
 *    C: scanf(), printf() - funciones de biblioteca
 *    ASM 16-bit: INT 21h - interrupciones DOS
 *    ASM 64-bit: syscall - llamadas al kernel Linux
 * 
 * 4. REGISTROS (Assembly) vs VARIABLES (C):
 *    El compilador de C asigna variables a registros automáticamente
 *    En assembly, nosotros controlamos explícitamente qué registros usar
 * 
 * 5. OPTIMIZACIONES:
 *    El compilador C con -O2 puede generar código más eficiente
 *    Assembly escrito a mano da control total pero requiere más experiencia
 * 
 * Para ver cómo GCC traduce este código a assembly, ejecutar:
 *   gcc -S -masm=intel -O0 factorial.c -o factorial_sin_optimizar.s
 *   gcc -S -masm=intel -O2 factorial.c -o factorial_optimizado.s
 * 
 * ============================================================================
 */

