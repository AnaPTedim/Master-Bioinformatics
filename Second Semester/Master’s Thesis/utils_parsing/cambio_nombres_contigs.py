import os, glob

# Buscar todos los archivos de genomas
archivos = glob.glob("*.fasta") + glob.glob("*.fas")

for archivo in archivos:
    if archivo == "todos_alelos.fasta":
        continue
        
    # Extraer el nombre limpio de la cepa (ej: M918981VVE)
    id_cepa = os.path.basename(archivo).replace(".fasta", "").replace(".fas", "")
    print(f"Renombrando contigs de la cepa: {id_cepa}...")
    
    lineas_nuevas = []
    contador_contigs = 1
    
    with open(archivo, "r") as f:
        for linea in f:
            # Si la línea es una cabecera, la cambiamos por el nuevo formato con el nombre del aislado
            if linea.startswith(">"):
                lineas_nuevas.append(f">{id_cepa}_contig{contador_contigs}\n")
                contador_contigs += 1
            else:
                lineas_nuevas.append(linea)
                
    # Sobreescribir el archivo original con las cabeceras con el nombre del aislado
    with open(archivo, "w") as f:
        f.writelines(lineas_nuevas)
'