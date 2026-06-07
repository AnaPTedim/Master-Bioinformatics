import pandas as pd
import glob
import os
import re

# 1. Configuración de rutas
# El script busca en la carpeta de estadísticas que definimos en el shell script
STATS_DIR = "genomes/genome_mapping/sorted/stats"
OUTPUT_FILE = "/Users/anasofia/Master_UNIR/Segundo_trimestre/TFM/Resultados/resumen_mapeo_minimap2.csv"

def parse_flagstat(filepath):
    """Extrae datos clave de un archivo flagstat de samtools."""
    data = {}
    sample_name = os.path.basename(filepath).replace("_flagstats.txt", "")
    data['Muestra'] = sample_name
    
    try:
        with open(filepath, 'r') as f:
            lines = f.readlines()
            for line in lines:
                # Extraer total de lecturas/contigs
                if "in total" in line:
                    data['Total_Secuencias'] = int(line.split()[0])
                
                # Extraer mapeados y porcentaje
                if "mapped (" in line:
                    parts = line.split()
                    data['Mapeados'] = int(parts[0])
                    # Usar regex para extraer el porcentaje dentro del paréntesis
                    percent_match = re.search(r'\((\d+\.\d+)%', line)
                    if percent_match:
                        data['Porcentaje_Mapeo'] = float(percent_match.group(1))
                    else:
                        data['Porcentaje_Mapeo'] = 0.0
    except Exception as e:
        print(f"Error procesando {filepath}: {e}")
        return None
        
    return data

def main():
    print(f"🔍 Buscando archivos flagstat en: {STATS_DIR}")
    
    # 2. Listar todos los archivos de estadísticas
    files = glob.glob(os.path.join(STATS_DIR, "*_flagstats.txt"))
    
    if not files:
        print("❌ No se encontraron archivos flagstats.txt. ¿Corriste el mapeo primero?")
        return

    # 3. Procesar cada archivo
    results = []
    for f in files:
        entry = parse_flagstat(f)
        if entry:
            results.append(entry)
            print(f"✅ Procesado: {entry['Muestra']}")

    # 4. Crear DataFrame y guardar
    df = pd.DataFrame(results)
    
    # Reordenar columnas para que se vea mejor
    column_order = ['Muestra', 'Total_Secuencias', 'Mapeados', 'Porcentaje_Mapeo']
    df = df[column_order]
    
    # Ordenar por muestra
    df = df.sort_values(by='Muestra')
    
    df.to_csv(OUTPUT_FILE, index=False)
    
    print("------------------------------------------------")
    print(f"📊 Tabla resumen generada: {OUTPUT_FILE}")
    print(df.to_string(index=False))

if __name__ == "__main__":
    main()