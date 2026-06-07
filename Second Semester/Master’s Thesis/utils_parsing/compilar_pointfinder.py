import os
import pandas as pd

# 1. Configurar rutas
base_dir = "results_resfinder_efm" 
output_file = "resumen_pointfinder_total_txt.csv"

all_results = []

print("Procesando archivos de texto de PointFinder...")

# 2. Recorrer las subcarpetas de aislados
if not os.path.exists(base_dir):
    print(f"Error: La carpeta '{base_dir}' no existe.")
else:
    for isolate_name in os.listdir(base_dir):
        isolate_path = os.path.join(base_dir, isolate_name)
        
        if os.path.isdir(isolate_path):
            # Buscamr los archivos de texto que contengan resultados de PointFinder
            files = [f for f in os.listdir(isolate_path) if "PointFinder" in f and f.endswith('.txt')]
            
            for f_name in files:
                file_path = os.path.join(isolate_path, f_name)
                
                try:
                    # Leer el archivo usando tabulador como separador (PointFinder suele usar \t para separar columnas)
                    df = pd.read_csv(file_path, sep='\t')
                    
                    if not df.empty:
                        # Añadir la columna del Aislado al principio
                        df.insert(0, 'Aislado', isolate_name)
                        all_results.append(df)
                    else:
                        # Registrar los aislados sin mutaciones
                        vacio = pd.DataFrame([{'Aislado': isolate_name, 'Mutation': 'No mutations'}])
                        all_results.append(vacio)
                        
                except Exception as e:
                    print(f"Error leyendo {f_name} en {isolate_name}: {e}")

# 3. Consolidar y Guardar
if all_results:
    # Unir todas las tablas encontradas en una sola
    df_final = pd.concat(all_results, ignore_index=True)
    
    # Guardar el CSV con todas las columnas (Mutation, Nucleotide change, etc.)
    df_final.to_csv(output_file, index=False)
    
    print(f"¡Hecho! Se han compilado todas las mutaciones.")
    print(f"Archivo generado: {output_file}")
    
    #Crear matriz de presencia/ausencia de mutaciones específicas
    if 'Mutation' in df_final.columns:
        matriz = df_final.pivot_table(index='Aislado', columns='Mutation', aggfunc='size', fill_value=0)
        if 'No mutations' in matriz.columns:
            matriz = matriz.drop(columns=['No mutations'])
        matriz.to_csv("matriz_mutaciones_pointfinder.csv")
        print("Matriz binaria generada: matriz_mutaciones_pointfinder.csv")
else:
    print("No se encontraron archivos de texto con resultados.")