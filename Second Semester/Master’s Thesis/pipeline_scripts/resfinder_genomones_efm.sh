#!/bin/zsh

GENOMES_DIR="genomes"
OUT_DIR="results_resfinder_efm"

mkdir -p "$OUT_DIR"

export CGE_RESFINDER_RESGENE_DB=/Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Genomas/reads/resfinder_db/
export CGE_RESFINDER_RESPOINT_DB=/Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Genomas/reads/pointfinder_db/

for genome in "$GENOMES_DIR"/*.fasta; do
    name=$(basename "$genome" .fasta)

    echo "Procesando $name..."

    python -m resfinder \
        -ifa "$genome" \
        -o "$OUT_DIR/$name" \
        -s "enterococcus_faecium" \
        -acq -c \
        -l 0.6 -t 0.8 \
        > "$OUT_DIR/${name}.log" 2>&1

    if [ $? -eq 0 ]; then
        echo "OK: $name"
    else
        echo "ERROR: $name (ver log)"
    fi
done
