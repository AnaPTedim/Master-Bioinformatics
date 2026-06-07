#!/bin/zsh

# Configuración de rutas relativas desde 'assembly'
GENOMES_DIR="genomes"
OUT_DIR="genomes/genome_mapping/results_fastANI"

mkdir -p "$OUT_DIR"

while read -r ref muestra; do
    echo "------------------------------------------------"
    echo "Calculando ANI: Referencia $ref vs Muestra $muestra"

    # Ejecutamos FastANI usando las variables del archivo parejas.txt 
    # -q: query (la muestra B o problema)
    # -r: referencia (la cepa A)
    # -o: nombre de salida específico para cada pareja
    fastani -q "${GENOMES_DIR}/${muestra}.fasta" \
            -r "${GENOMES_DIR}/${ref}.fasta" \
            -o "${OUT_DIR}/ani_${muestra}.txt"

done < parejas.txt
