#!/bin/zsh

# Crear directorio de salida
mkdir -p filogenia_snippy/ela

while read -r cepa; do
    # Limpiar caracteres invisibles
    cepa=$(echo "$cepa" | tr -d '\r' | xargs)
    
    # Si la línea está vacía, saltar
    [[ -z "$cepa" ]] && continue

    if [[ "$cepa" == "Ela_HB-1" ]]; then
        echo "Saltando referencia Ela_HB-1..."
        continue
    fi

    if [[ -f "${cepa}.fasta" ]]; then
        echo "------------------------------------------------"
        echo "Snippy Ela: Procesando $cepa contra Ela_HB-1"
        # Usamos la carpeta creada arriba: filogenia_snippy/efm
        snippy --outdir "filogenia_snippy/ela/${cepa}" \
               --ref "referencias/Ela_HB-1.fasta" \
               --ctgs "${cepa}.fasta" \
               --cpus 4
    else
        echo "ERROR: No se encuentra el archivo ${cepa}.fasta"
    fi
done < muestras_ela.txt