#include <stdio.h>

int main() {
    // Definimos el array (similar al .DATA en ensamblador)
    int array[] = {2, 4, 6, 8, 10};
    int count = sizeof(array) / sizeof(array[0]); // Calculamos el número de elementos
    int sum = 0; // Inicializamos la suma

    // Bucle para sumar los elementos (similar al SUM_LOOP en ensamblador)
    for (int i = 0; i < count; i++) {
        sum += array[i]; // Sumamos el elemento actual al total
    }

    // Imprimimos el resultado (esto no se hizo en la versión simple de ensamblador)
    printf("La suma de los elementos del array es: %d\n", sum);

    return 0; // Terminamos el programa (similar a INT 21h / AH=4Ch o sys_exit)
}