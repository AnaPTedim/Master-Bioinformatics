#!/bin/zsh

GENOMES_DIR="genomes"
OUT_DIR="results_virulence"
DB_VIR="/Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Genomas/reads/virulencefinder_db"

mkdir -p "$OUT_DIR"

for genome in "$GENOMES_DIR"/*.fasta; do
    name=$(basename "$genome" .fasta)

    echo "Procesando $name..."

    # Comando limpio sin el parámetro -s
    python3 -m virulencefinder \
        -ifa "$genome" \
        -o "$OUT_DIR/$name" \
        -p "$DB_VIR" \
        -l 0.6 -t 0.8 \
        > "$OUT_DIR/${name}.log" 2>&1

    if [ $? -eq 0 ]; then
        echo "OK: $name"
    else
        echo "ERROR: $name (Revisa el log)"
        tail -n 5 "$OUT_DIR/${name}.log"
    fi
done
