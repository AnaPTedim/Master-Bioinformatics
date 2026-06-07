import pandas as pd
import glob
import os

# 1. Parámetros de entrada
input_file = 'results_bac.txt'
output_prefix = 'bacteriocinas'

# 2. Cargar los datos ignorando las cabeceras repetidas del bucle
# Usamos sep='\t' y comment='#' para que sea robusto
try:
    # Leemos el archivo. Al estilo de tu otro script, dejamos que pandas 
    # identifique las columnas pero saltamos los comentarios
    df = pd.read_csv(input_file, sep='\t', comment='#', header=None)
    
    # Asignamos nombres manuales (14 columnas según tus resultados reales)
    df.columns = [
        "FILE", "SEQUENCE", "START", "END", "STRAND", "GENE", 
        "COVERAGE", "COVERAGE_MAP", "GAPS", "PERCENT_COVERAGE", 
        "PERCENT_IDENTITY", "DATABASE", "ACCESSION", "PRODUCT", "RESISTANCE"
    ]
except Exception as e:
    print(f"Error al abrir el archivo: {e}")
    exit()

# 3. Limpieza y Transformación (Estilo Resfinder)
# Quitamos la extensión .fasta de la columna FILE
df['FILE'] = df['FILE'].astype(str).str.replace('.fasta', '', regex=False)

# Aseguramos que la cobertura sea numérica para las operaciones
df['PERCENT_COVERAGE'] = pd.to_numeric(df['PERCENT_COVERAGE'], errors='coerce')

# --- GENERACIÓN DE MATRICES ---

# Tabla A: Resumen de Cobertura (Equivalente al summary de Resfinder)
# Esta tabla muestra el % de identidad o cobertura (según prefieras)
resumen_cobertura = df.pivot_table(
    index='FILE', 
    columns='GENE', 
    values='PERCENT_COVERAGE', 
    aggfunc='max', 
    fill_value=0
)

# Tabla B: Matriz de Presencia/Ausencia (Binaria 0/1)
# Convertimos cualquier valor > 0 en 1
matriz_binaria = (resumen_cobertura > 0).astype(int)

# 4. Guardar archivos con formato limpio
resumen_cobertura.to_csv(f'resumen_{output_prefix}.csv')
matriz_binaria.to_csv(f'matriz_binaria_{output_prefix}.csv')

print(f"Tablas de {output_prefix} generadas con éxito.")
print(f"- Muestras procesadas: {len(resumen_cobertura)}")
print(f"- Genes encontrados: {len(resumen_cobertura.columns)}")
