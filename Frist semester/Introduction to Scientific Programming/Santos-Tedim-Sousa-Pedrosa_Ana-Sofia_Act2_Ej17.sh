#!/bin/bash
#Actividad 2 - Pregunta 17
#Descripción: Permite convertir la clasificación numérica de una signatura en una clasificación alfabética

# 1. Capturamos el argumento proporcionado al ejecutar el script
# Se utiliza la variable especial $1 que representa el primer parámetro
NOTA=$1

# 2. Evaluación de la nota mediante estructura condicional if/elif/else
# Usamos (( )) con bc para permitir el manejo de decimales si fuera necesario.

if (( $(echo "$NOTA < 5" | bc -l) )); then
    # Si la nota es menor a 5, es suspenso 
    echo "Suspenso"

elif (( $(echo "$NOTA >= 5 && $NOTA < 7" | bc -l) )); then
    # Si está entre 5 (incluido) y 7, es aprobado 
    echo "Aprobado"

elif (( $(echo "$NOTA >= 7 && $NOTA < 9" | bc -l) )); then
    # Si está entre 7 (incluido) y 9, es notable 
    echo "Notable"

elif (( $(echo "$NOTA >= 9 && $NOTA <= 10" | bc -l) )); then
    # Si está entre 9 (incluido) y 10 (incluido), es sobresaliente 
    echo "Sobresaliente"

else
    # En caso de introducir un valor fuera del rango 0-10
    echo "Nota no válida. Introduzca un valor entre 0 y 10."
fi
