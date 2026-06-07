#!/bin/zsh

# 1. Configuración
DIRECTORIO_REPORTES="kraken"
TABLA_FINAL="especies_mayor_10porciento_kraken.tsv"
UMBRAL=10

# 2. Crear cabecera de la tabla
echo "Muestra\tEspecie\tPorcentaje\tLecturas_Clado\tLecturas_Taxon" > "$TABLA_FINAL"

echo " Filtrando especies con > $UMBRAL% en: $DIRECTORIO_REPORTES"

# 3. Obtener lista de archivos .report
archivos=($DIRECTORIO_REPORTES/*.report(N))

if [ ${#archivos[@]} -eq 0 ]; then
    echo "ERROR: No se encontraron archivos .report"
    exit 1
fi

# 4. Procesamiento
for reporte in $archivos[@]; do
    muestra=$(basename "$reporte" .report)
    
    # Explicación del filtro awk:
    # $4 == "S"   : Solo nivel especie.
    # $1 > UMBRAL : Solo si el porcentaje (columna 1) es mayor a 10.
    awk -F$'\t' -v limit="$UMBRAL" '$4 == "S" && $1 > limit {print $1, $2, $3, $6}' "$reporte" | while read -r porc clado tax nom; do
        
        # Limpiar el nombre de la especie
        nombre_limpio=$(echo "$nom" | xargs)
        
        # Guardar en la tabla
        echo "${muestra}\t${nombre_limpio}\t${porc}\t${clado}\t${tax}" >> "$TABLA_FINAL"
    done

    echo "✅ Procesado: $muestra"
done

echo "--------------------------------------------"
echo " TABLA GENERADA (Filtro > 10%): $TABLA_FINAL"
echo "--------------------------------------------"

# Vista previa
column -t -s $'\t' "$TABLA_FINAL"