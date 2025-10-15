# 7 Generar en Google Colab, con la IA, la misma versión de problema, pero resuelto en C

%%shell
# Guarda el código C en un archivo
cat > prime_check.c <<EOF
#include <stdio.h>
#include <stdbool.h>
#include <math.h>

int main() {
    int num;

    // Solicitar al usuario que ingrese un número
    printf("Ingrese un numero para verificar si es primo: ");
    scanf("%d", &num);

    // Verificar si el número es primo
    bool isPrime = true;

    if (num < 2) {
        isPrime = false;
    } else if (num == 2) {
        isPrime = true; // 2 es el único número primo par
    } else if (num % 2 == 0) {
        isPrime = false; // Los números pares mayores que 2 no son primos
    } else {
        // Verificar divisores impares desde 3 hasta la raíz cuadrada de num
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) {
                isPrime = false;
                break; // No es primo, podemos salir del bucle
            }
        }
    }

    // Mostrar el resultado
    if (isPrime) {
        printf("El numero %d ES primo.\n", num);
    } else {
        printf("El numero %d NO es primo.\n", num);
    }

    return 0;
}
EOF

# Compila el código C
gcc prime_check.c -o prime_check -lm

# Ejecuta el programa compilado
./prime_check
