#!/bin/zsh

# Configuración de rutas relativas desde 'assembly'
REF_DIR="genomes"
BAM_DIR="genomes/genome_mapping/sorted"
OUT_DIR="genomes/genome_mapping/variants"
FINAL_DIR="${OUT_DIR}/variants/final"

mkdir -p "$FINAL_DIR"

while read -r ref muestra; do
    echo "------------------------------------------------"
    echo "Procesando: Referencia $ref vs Muestra $muestra (Modo Haploide)"
    
    # 1. Generar mpileup
    bcftools mpileup -f "${REF_DIR}/${ref}.fasta" "${BAM_DIR}/mapeo_${muestra}_sorted.bam" > "temp_${muestra}.mpileup" 
    
    # 2. Llamada de variantes (Ploidía 1 para bacterias)
    bcftools call --ploidy 1 -mv -Ob -o "${OUT_DIR}/variantes_${muestra}.bcf" "temp_${muestra}.mpileup" 
    
    # 3. Filtrado por calidad (QUAL > 30)
    bcftools view -i 'QUAL>30' "${OUT_DIR}/variantes_${muestra}.bcf" > "${FINAL_DIR}/variantes_finales_${muestra}.vcf" 
    
    # Limpieza de temporales
    rm "temp_${muestra}.mpileup"
done < parejas.txt

