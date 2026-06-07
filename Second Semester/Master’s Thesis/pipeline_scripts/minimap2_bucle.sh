#!/bin/zsh

# 1. Configuración de directorios y archivos
INPUT_DIR="genomes"          
OUT_DIR="genomes/genome_mapping"      
SORTED_DIR="${OUT_DIR}/sorted"
STATS_DIR="${SORTED_DIR}/stats"
LISTA_PAREJAS="parejas.txt" # Nombre del archivo con tus parejas

# Crear la estructura de carpetas de salida
mkdir -p "$STATS_DIR"

# 2. Verificación del archivo de entrada
if [[ ! -f "$LISTA_PAREJAS" ]]; then
    echo "ERROR: No se encuentra el archivo '$LISTA_PAREJAS'"
    echo "Asegúrate de que el archivo existe y tiene el formato: Referencia Consulta"
    exit 1
fi

echo "Iniciando proceso de mapeo..."
echo "Origen de genomas: $INPUT_DIR"
echo "Destino de mapeo: $OUT_DIR"

# 3. Bucle de procesamiento (Lee línea a línea)
while read -r ref query; do
    
    # Limpiar posibles retornos de carro de Windows (\r) y espacios
    ref=$(echo "$ref" | tr -d '\r' | xargs)
    query=$(echo "$query" | tr -d '\r' | xargs)

    # Saltar líneas vacías o comentarios (que empiecen por #)
    [[ -z "$ref" || "$ref" == "#"* ]] && continue
    
    echo "------------------------------------------------"
    echo "Análisis: $query mapeado contra $ref"
    
    # Definir rutas completas a los archivos fasta
    REF_PATH="${INPUT_DIR}/${ref}.fasta"
    QUERY_PATH="${INPUT_DIR}/${query}.fasta"
    
    # Comprobar si los archivos fasta existen en la carpeta de entrada
    if [[ ! -f "$REF_PATH" || ! -f "$QUERY_PATH" ]]; then
        echo "ADVERTENCIA: No se encuentra $REF_PATH o $QUERY_PATH. Saltando..."
        continue
    fi

    # --- Paso A: Minimap2 (Generar SAM en la carpeta de salida) ---
    SAM_FILE="${OUT_DIR}/mapeo_${query}.sam"
    minimap2 -ax asm5 -t 8 "$REF_PATH" "$QUERY_PATH" > "$SAM_FILE"

    # --- Paso B: Samtools Sort (Convertir a BAM ordenado) ---
    BAM_SORTED="${SORTED_DIR}/mapeo_${query}_sorted.bam"
    samtools sort -@ 4 "$SAM_FILE" -o "$BAM_SORTED"

    # --- Paso C: Samtools Index (Indexar BAM) ---
    samtools index "$BAM_SORTED"

    # --- Paso D: Estadísticas (Flagstat e Idxstats) ---
    samtools flagstat "$BAM_SORTED" > "${STATS_DIR}/${query}_flagstats.txt"
    samtools idxstats "$BAM_SORTED" > "${STATS_DIR}/${query}_indexstats.txt"

    # --- Paso E: Limpieza ---
    # Eliminar el SAM para ahorrar espacio
    rm "$SAM_FILE"
    
    echo "Finalizado: $query"

done < "$LISTA_PAREJAS"

echo "------------------------------------------------"
echo "Proceso completado. Revisar la carpeta $OUT_DIR"