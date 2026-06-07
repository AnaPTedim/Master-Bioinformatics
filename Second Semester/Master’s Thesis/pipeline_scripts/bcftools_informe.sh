#!/bin/zsh

echo "Muestra | SNPs_Filtrados" > /Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Resultados/resumen_snps_bcftools.txt
for vcf in genomes/genome_mapping/variants/final/*.vcf; do
    nombre=$(basename "$vcf")
    count=$(grep -v "^#" "$vcf" | wc -l)
    echo "$nombre | $count" >> /Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Resultados/resumen_snps_bcftools.txt
done



