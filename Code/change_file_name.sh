#!/bin/zsh

# Este codigo sirve para cambiar los nombre de los temas de cada signatura automaticamente

i=1
for f in $(ls -1 *.pdf | sort); do # primero ordena los temas por nombre (numero esta en el nombre)
  mv "$f" "Tema$i.pdf" # cambia el nombre 
  ((i++))
done


