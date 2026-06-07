#!/bin/zsh

GENOMES_DIR="genomes"
OUT_DIR="results_plasmid"

DB_PLASMID="/Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Genomas/reads/plasmidfinder_db"

mkdir -p "$OUT_DIR"

for genome in "$GENOMES_DIR"/*.fasta; do
    name=$(basename "$genome" .fasta)

    echo "Procesando $name..."

    python -m plasmidfinder \
        -i "$genome" \
        -o "$OUT_DIR/$name" \
        -p "$DB_PLASMID" \
        -l 0.6 -t 0.8 \
        > "$OUT_DIR/${name}.log" 2>&1

    if [ $? -eq 0 ]; then
        echo "OK: $name"
    else
        echo "ERROR: $name"
        tail -n 10 "$OUT_DIR/${name}.log"
    fi
done
