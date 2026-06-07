import os
import json
import pandas as pd

# 1. Configuración de rutas
base_dir = "results_resfinder_efm" 
output_file = "resumen_resistencias_completo.csv"

final_data = []

print("📂 Procesando archivos JSON de ResFinder (todas las columnas)...")

# 2. Recorrer las subcarpetas
if not os.path.exists(base_dir):
    print(f"❌ Error: La carpeta '{base_dir}' no existe.")
else:
    for isolate_name in os.listdir(base_dir):
        isolate_path = os.path.join(base_dir, isolate_name)
        
        if os.path.isdir(isolate_path):
            # Buscamos archivos .json
            json_files = [f for f in os.listdir(isolate_path) if f.endswith('.json')]
            
            for j_file in json_files:
                json_path = os.path.join(isolate_path, j_file)
                
                try:
                    with open(json_path, 'r') as f:
                        data = json.load(f)
                    
                    hits = data.get('seq_regions', {})
                    
                    if hits:
                        for hit in hits.values():
                            # Creamos una copia del hit para no modificar el original
                            row = hit.copy()
                            # Añadimos el nombre del aislado al principio
                            row['Aislado'] = isolate_name
                            
                            # Tratamiento especial para 'phenotypes' porque es una lista
                            if isinstance(row.get('phenotypes'), list):
                                row['phenotypes'] = ", ".join(row['phenotypes'])
                            
                            # Tratamiento para 'ref_database' si es una lista
                            if isinstance(row.get('ref_database'), list):
                                row['ref_database'] = ", ".join(row['ref_database'])
                                
                            final_data.append(row)
                    else:
                        # Si no hay hits, registramos el aislado como negativo
                        final_data.append({"Aislado": isolate_name, "name": "Negativo"})
                        
                except Exception as e:
                    print(f"⚠️ Error procesando {j_file} en {isolate_name}: {e}")

# 3. Crear el CSV final
if final_data:
    df = pd.DataFrame(final_data)
    
    # Reordenar para que 'Aislado' y 'name' (el gen) salgan primero
    cols = ['Aislado', 'name'] + [c for c in df.columns if c not in ['Aislado', 'name']]
    df = df[cols]
    
    df.to_csv(output_file, index=False)
    print(f"✅ ¡Hecho! Tabla completa con todas las columnas en: {output_file}")
    
    # Matriz binaria (se basa en la columna 'name' que es el estándar de ResFinder)
    matriz = df.pivot_table(index='Aislado', columns='name', values='identity', fill_value=0)
    matriz_binaria = matriz.applymap(lambda x: 1 if x > 0 else 0)
    if 'Negativo' in matriz_binaria.columns:
        matriz_binaria = matriz_binaria.drop(columns=['Negativo'])
    matriz_binaria.to_csv("matriz_binaria_resistencias.csv")
    print("📊 Matriz binaria generada correctamente.")
else:
    print("❌ No se encontraron datos para procesar.")