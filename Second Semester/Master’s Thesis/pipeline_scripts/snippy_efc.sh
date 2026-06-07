#!/bin/zsh

# Crear directorio de salida
mkdir -p filogenia_snippy/efc

while read -r cepa; do
    # Limpiar caracteres invisibles
    cepa=$(echo "$cepa" | tr -d '\r' | xargs)
    
    # Si la línea está vacía, saltar
    [[ -z "$cepa" ]] && continue

    if [[ "$cepa" == "Efc_T5" ]]; then
        echo "Saltando referencia Efc_T5..."
        continue
    fi

    if [[ -f "${cepa}.fasta" ]]; then
        echo "------------------------------------------------"
        echo "Snippy Efc: Procesando $cepa contra Efc_T5"
        # Usamos la carpeta creada arriba: filogenia_snippy/efc
        snippy --outdir "filogenia_snippy/efc/${cepa}" \
               --ref "referencias/Efc_T5.fasta" \
               --ctgs "${cepa}.fasta" \
               --cpus 4
    else
        echo "ERROR: No se encuentra el archivo ${cepa}.fasta"
    fi
done < muestras_efc.txt