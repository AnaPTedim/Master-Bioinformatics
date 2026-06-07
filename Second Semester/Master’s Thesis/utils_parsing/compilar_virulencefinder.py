import os
import json
import pandas as pd

# 1. Configurar rutas a los archivos
base_dir = "results_virulence"
output_file = "resumen_virulencia_completo.csv"

final_data = []

print("Procesando archivos JSON de VirulenceFinder (todas las columnas)...")

# 2. Recorrer las subcarpetas de aislados
if not os.path.exists(base_dir):
    print(f"Error: La carpeta '{base_dir}' no existe.")
else:
    for isolate_name in os.listdir(base_dir):
        isolate_path = os.path.join(base_dir, isolate_name)
        
        if os.path.isdir(isolate_path):
            # Buscar archivos .json dentro de la carpeta de cada aislado
            json_files = [f for f in os.listdir(isolate_path) if f.endswith('.json')]
            
            for j_file in json_files:
                json_path = os.path.join(isolate_path, j_file)
                
                try:
                    with open(json_path, 'r') as f:
                        data = json.load(f)
                    
                    # Los factores de virulencia están en 'seq_regions'
                    hits = data.get('seq_regions', {})
                    
                    if hits:
                        for hit in hits.values():
                            # Copiar todos los datos del hit (grade, identity, coverage, etc.)
                            row = hit.copy()
                            row['Aislado'] = isolate_name
                            
                            # Aplanar campos que suelen ser listas o diccionarios complejos
                            for key in ['phenotypes', 'ref_database', 'notes']:
                                if isinstance(row.get(key), list):
                                    row[key] = ", ".join(map(str, row[key]))
                                elif isinstance(row.get(key), dict):
                                    row[key] = str(row[key])
                                    
                            final_data.append(row)
                    else:
                        # Si no se detectan factores de virulencia
                        final_data.append({"Aislado": isolate_name, "name": "Negativo"})
                        
                except Exception as e:
                    print(f"Error procesando {j_file} en {isolate_name}: {e}")

# 3. Crear el CSV final
if final_data:
    df = pd.DataFrame(final_data)
    
    # Reordenar para que 'Aislado' y 'name' (nombre del gen) aparezcan primero
    cols = ['Aislado', 'name'] + [c for c in df.columns if c not in ['Aislado', 'name']]
    df = df[cols]
    
    df.to_csv(output_file, index=False)
    print(f"¡Hecho! Tabla de virulencia completa en: {output_file}")
    
    # Generar Matriz Binaria de Virulencia 
    matriz = df.pivot_table(index='Aislado', columns='name', values='identity', fill_value=0)
    matriz_binaria = matriz.applymap(lambda x: 1 if x > 0 else 0)
    if 'Negativo' in matriz_binaria.columns:
        matriz_binaria = matriz_binaria.drop(columns=['Negativo'])
    
    matriz_binaria.to_csv("matriz_binaria_virulencia.csv")
    print("Matriz binaria de virulencia generada correctamente.")
else:
    print("No se encontraron datos de virulencia.")