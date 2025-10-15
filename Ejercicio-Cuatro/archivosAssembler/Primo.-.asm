#8.- Ejecutar y obtener el programa en lenguaje ensamblador del item 7.

%%shell
# Genera el archivo de ensamblador (.s) a partir del código C
gcc -S prime_check.c -o prime_check.s

# Muestra el contenido del archivo .s
cat prime_check.s
