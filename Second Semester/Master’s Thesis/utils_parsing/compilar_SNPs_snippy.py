import pandas as pd
import os

# 1. Configurar de rutas (Ejecutando desde 'assembly')
DIRECTORIOS_SNIPPY = {
    "Enterococcus_faecium": "genomes/filogenia_snippy/efm",
    "Enterococcus_faecalis": "genomes/filogenia_snippy/efc",
    "Enterococcus_lactis": "genomes/filogenia_snippy/ela"
}

# Archivos de resumen generados por snippy-core
ARCHIVOS_CORE = {
    "Enterococcus_faecium": "genomes/filogenia_snippy/efm/core_efm.txt",
    "Enterococcus_faecalis": "genomes/filogenia_snippy/efc/core_efc.txt",
    "Enterococcus_lactis": "genomes/filogenia_snippy/ela/core_ela.txt"
}

OUTPUT_GLOBAL = "tabla_matriz_snps_total.csv"

def procesar_core(path, especie):
    """Leer el archivo core de snippy y devuelver un DataFrame limpio."""
    try:
        if not os.path.exists(path):
            return None
        
        # Snippy-core genera archivos delimitados por tabulaciones (TSV)
        df = pd.read_csv(path, sep='\t')
        
        # Renombrar y seleccionar columnas clave para la matriz
        # Columnas estándar de snippy-core: ID, SNPS, INS, DEL, MNP, COMPLEX, TOTAL
        resumen = pd.DataFrame()
        resumen['Muestra'] = df['ID']
        resumen['Especie'] = especie
        resumen['SNPs'] = df.get('SNPS', 0)
        resumen['Inserciones'] = df.get('INS', 0)
        resumen['Deleciones'] = df.get('DEL', 0)
        resumen['Complejas'] = df.get('COMPLEX', 0)
        resumen['Total_Variantes'] = df.get('TOTAL', df.get('SNPS', 0) + df.get('INS', 0) + df.get('DEL', 0))
        
        return resumen
    except Exception as e:
        print(f"Error procesando {path}: {e}")
        return None

def main():
    todas_las_especies = []
    
    print("Compilando matrices de SNPs para el TFM...")

    for especie, path in ARCHIVOS_CORE.items():
        print(f"Buscando resultados para {especie}...")
        df_especie = procesar_core(path, especie)
        
        if df_especie is not None:
            # Guardar una matriz individual por especie 
            nombre_individual = f"matriz_snps_{especie.lower()}.csv"
            df_especie.to_csv(nombre_individual, index=False)
            print(f"Matriz individual generada: {nombre_individual}")
            
            todas_las_especies.append(df_especie)
        else:
            print(f"No se encontró el archivo core para {especie}")

    if todas_las_especies:
        # Unificar los archivos obtenidos para cada especies
        matriz_maestra = pd.concat(todas_las_especies, ignore_index=True)
        
        # Ordenar por especie y luego por número de SNPs (descendente)
        matriz_maestra = matriz_maestra.sort_values(by=['Especie', 'SNPs'], ascending=[True, False])
        
        # Guardar el archivo principal
        matriz_maestra.to_csv(OUTPUT_GLOBAL, index=False)
        
        print("\n" + "="*50)
        print(f"ÉXITO: Se ha generado la tabla maestra: {OUTPUT_GLOBAL}")
        print(f"Muestras totales procesadas: {len(matriz_maestra)}")
        print("="*50)
        
        # Mostrar un adelanto de la matriz en consola
        print("\nVista previa de la matriz (Top 10):")
        print(matriz_maestra.head(10).to_string(index=False))
    else:
        print("\n No se pudo generar ninguna tabla. Verifica que los archivos 'core_*.txt' existan.")

if __name__ == "__main__":
    main()