#!/bin/zsh

origen="/Users/anasofia/Master_UNIR/Segundo_trimestre/Programacion_python/10991459_esl-ES"
destino="/Users/anasofia/Master_UNIR/Segundo_trimestre/Programacion_python"

for f in "$origen"/*.pdf; do
  base=$(basename "$f" .pdf)
  mv "$f" "$destino/$base/"
done
