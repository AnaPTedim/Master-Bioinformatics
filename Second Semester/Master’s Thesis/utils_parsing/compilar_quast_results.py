import os
import pandas as pd

# 1. Configurar las rutas
base_dir = "quality"  
output_dir = "quality" 
output_file = os.path.join(output_dir, "resumen_calidad_quast.csv")

# Parámetros que se pretende extraer
params_interes = [
    'Assembly', 
    '# contigs', 
    'Largest contig', 
    'Total length', 
    'N50', 
    'L50', 
    'GC (%)'
]

resumen_datos = []

# Asegurar que la carpeta de destino existe
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
    print(f"Creada la carpeta de destino: {output_dir}")

print("Extrayendo estadísticas de QUAST...")

# 2. Recorrer las subcarpetas de calidad
if not os.path.exists(base_dir):
    print(f"Error: La carpeta de entrada '{base_dir}' no existe.")
else:
    for folder in os.listdir(base_dir):
        report_path = os.path.join(base_dir, folder, "report.tsv")
        
        if os.path.isfile(report_path):
            try:
                # Leer el archivo TSV
                df_quast = pd.read_csv(report_path, sep='\t', index_col=0)
                
                for column in df_quast.columns:
                    datos_aislado = {"Carpeta": folder, "Aislado": column}
                    for p in params_interes:
                        if p in df_quast.index:
                            datos_aislado[p] = df_quast.loc[p, column]
                    resumen_datos.append(datos_aislado)
                    
            except Exception as e:
                print(f"Error procesando {report_path}: {e}")

# 3. Guardar el archivo final
if resumen_datos:
    df_final = pd.DataFrame(resumen_datos)
    
    # Columnas deseadas
    cols_presentes = [c for c in ["Carpeta", "Aislado", "N50", "L50", "# contigs", "Total length", "Largest contig", "GC (%)"] if c in df_final.columns]
    df_final = df_final[cols_presentes]
    
    df_final.to_csv(output_file, index=False)
    print(f"¡Hecho! Tabla de calidad guardada en: {output_file}")
else:
    print("No se encontraron archivos report.tsv.")