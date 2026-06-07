import os, glob

# Buscamos todos los archivos de genomas
archivos = glob.glob("*.fasta") + glob.glob("*.fas")

for archivo in archivos:
    if archivo == "todos_alelos.fasta":
        continue
        
    # Extraemos el nombre limpio de la cepa (ej: M918981VVE)
    id_cepa = os.path.basename(archivo).replace(".fasta", "").replace(".fas", "")
    print(f"Renombrando contigs de la cepa: {id_cepa}...")
    
    lineas_nuevas = []
    contador_contigs = 1
    
    with open(archivo, "r") as f:
        for linea in f:
            # Si la línea es una cabecera, la cambiamos por el nuevo formato
            if linea.startswith(">"):
                lineas_nuevas.append(f">{id_cepa}_contig{contador_contigs}\n")
                contador_contigs += 1
            else:
                lineas_nuevas.append(linea)
                
    # Sobreescribimos el archivo original con las cabeceras perfectas
    with open(archivo, "w") as f:
        f.writelines(lineas_nuevas)
'