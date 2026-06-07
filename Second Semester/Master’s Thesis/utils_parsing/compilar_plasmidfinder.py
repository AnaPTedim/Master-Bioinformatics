import os
import json
import pandas as pd

# 1. Configuración de rutas
# Carpeta donde están todos tus archivos .json directamente
base_dir = "results_plasmid" 
output_file = "resumen_plasmidos_completo.csv"
output_matrix = "matriz_binaria_plasmidos.csv"

final_data = []

print(f"📂 Procesando archivos JSON directamente en '{base_dir}'...")

# 2. Leer archivos JSON de la carpeta
if not os.path.exists(base_dir):
    print(f"❌ Error: La carpeta '{base_dir}' no existe.")
else:
    # Listamos todos los archivos .json en la carpeta
    json_files = [f for f in os.listdir(base_dir) if f.endswith('.json')]
    
    if not json_files:
        print("❓ No se encontraron archivos .json en la carpeta.")
    else:
        for j_file in json_files:
            # El nombre de la cepa es el nombre del archivo sin el .json
            isolate_name = j_file.replace("results_", "").replace(".json", "")
            json_path = os.path.join(base_dir, j_file)
            
            try:
                with open(json_path, 'r') as f:
                    data = json.load(f)
                
                # Buscamos los hits en 'seq_regions'
                hits = data.get('seq_regions', {})
                
                if hits:
                    for hit in hits.values():
                        # Copiamos todos los datos del hit (todas las columnas)
                        row = hit.copy()
                        row['Aislado'] = isolate_name
                        
                        # Convertimos listas/diccionarios a texto para Excel
                        for key in row.keys():
                            if isinstance(row[key], (list, dict)):
                                row[key] = str(row[key])
                                    
                        final_data.append(row)
                else:
                    # Si el archivo existe pero no hay plásmidos
                    final_data.append({"Aislado": isolate_name, "name": "Negativo", "identity": 0})
                        
            except Exception as e:
                print(f"⚠️ Error procesando {j_file}: {e}")

# 3. Crear los archivos de salida
if final_data:
    df = pd.DataFrame(final_data)
    
    # Ponemos 'Aislado' y 'name' (el plásmido) al principio
    cols = ['Aislado', 'name'] + [c for c in df.columns if c not in ['Aislado', 'name']]
    df = df[cols]
    
    # Guardar reporte completo
    df.to_csv(output_file, index=False)
    print(f"✅ Tabla completa generada: {output_file}")
    
    # --- GENERAR MATRIZ BINARIA ---
    # Pivotamos usando el nombre del plásmido
    matriz = df.pivot_table(index='Aislado', columns='name', values='identity', fill_value=0)
    matriz_binaria = matriz.applymap(lambda x: 1 if x > 0 else 0)
    
    if 'Negativo' in matriz_binaria.columns:
        matriz_binaria = matriz_binaria.drop(columns=['Negativo'])
        
    matriz_binaria.to_csv(output_matrix)
    print(f"📊 Matriz binaria generada: {output_matrix}")
else:
    print("❌ No se pudo extraer información de los archivos.")