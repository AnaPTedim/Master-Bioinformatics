#!/bin/zsh

# Crear el archivo maestro 
{
    echo -e "ID_Muestra\tID_Referencia\tANI_Identidad\tFrag_Alineados\tTotal_Frag"
    cat genomes/genome_mapping/results_fastANI/ani_*.txt | sed 's/\.fasta//g'
} > /Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Resultados/Tabla_ANI_Final.tsv