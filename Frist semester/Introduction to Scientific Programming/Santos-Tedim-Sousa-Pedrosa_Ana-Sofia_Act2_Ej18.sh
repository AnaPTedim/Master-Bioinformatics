#!/bin/bash
#Este script comprueba si un fichero existe en la ruta indicada como argumento

# 1. Definimos la ruta del fichero en la variable FILE como pide el enunciado
FILE="/home/anaptedim/curso2024/plasmids.txt"

# 2. Comprobamos si el fichero existe (-e verifica la existencia)
if [ -e "$FILE" ]; then
	# Si existe, imprimimos el mensaje con la ruta según la variable FILE
	echo "El fichero $FILE existe" 
else 
	# si no existe, imprimimos el mensaje de error
	echo "El fichero $FILE no existe"
fi


