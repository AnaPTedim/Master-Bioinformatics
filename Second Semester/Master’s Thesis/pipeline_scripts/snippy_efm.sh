#!/bin/zsh

# Crear directorio de salida
mkdir -p filogenia_snippy/efm

while read -r cepa; do
    # Limpiar caracteres invisibles
    cepa=$(echo "$cepa" | tr -d '\r' | xargs)
    
    # Si la línea está vacía, saltar
    [[ -z "$cepa" ]] && continue

    if [[ "$cepa" == "Efm_DO" ]]; then
        echo "Saltando referencia Efm_DO..."
        continue
    fi

    if [[ -f "${cepa}.fasta" ]]; then
        echo "------------------------------------------------"
        echo "Snippy Efm: Procesando $cepa contra Efm_DO"
        # Usamos la carpeta creada arriba: filogenia_snippy/efm
        snippy --outdir "filogenia_snippy/efm/${cepa}" \
               --ref "referencias/Efm_DO.fasta" \
               --ctgs "${cepa}.fasta" \
               --cpus 4
    else
        echo "ERROR: No se encuentra el archivo ${cepa}.fasta"
    fi
done < muestras_efm.txt