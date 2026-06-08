# --------------------------
# Análisis de resultados TFM
# --------------------------

############################
# 1. Directorio de trabajo #
############################

setwd("~/Master_UNIR/Segundo_trimestre/TFM/Resultados")

############################
# 2. Librarías             #
############################

library(tidyverse)
library(ggplot2)
library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
library(svglite)
library(stringr)
library(ggrepel)
library(ggtext)
library(ggVennDiagram)

#################################################
# 3. Análisis de resistencia a los antibióticos #
#################################################

# 1. Cargar de datos 
data_abr <- read.csv("results_ABR.csv", header = TRUE, sep = ";", check.names = FALSE, na = c("", " ", "NA")) 

# 2. Transformar a formato largo y agrupar
tabla_resumen_antibioticos <- data_abr %>%
  pivot_longer(                                                # Pasamos los antibióticos de columnas a filas
    cols = AMP:TIG, 
    names_to = "Antibiotico", 
    values_to = "Susceptibilidad"
  ) %>%
  filter(!is.na(Susceptibilidad) & Susceptibilidad != "") %>%  # Eliminamos valores vacíos si los hay
  group_by(Antibiotico, Susceptibilidad) %>%                   # Agrupamos por antibiótico y el resultado (S/R/I)
  tally(name = "Frecuencia") %>%
  mutate(Porcentaje = round((Frecuencia / sum(Frecuencia)) * 100, 2)) %>%   # Calculamos el porcentaje 
  arrange(Antibiotico, desc(Frecuencia))

# 3. Guardar los resultados como un archivo e texto
write.csv(tabla_resumen_antibioticos, "resumen_ABR.csv")

# 4. Definir una paleta de colores académica y clara (estilo semáforo suave)
colores_sir <- c(
  "S" = "#7570b3", # Un tono azul/morado agradable
  "R"  = "#d95f02"  # Naranja/rojo oscuro
)

# 4. Generar el gráfico
grafico_susceptibilidad <- ggplot(tabla_resumen_antibioticos, aes(x = Porcentaje, y = Antibiotico, fill = Susceptibilidad)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) +   
  geom_text(   
    aes(label = ifelse(Porcentaje > 5, paste0(Porcentaje, "%"), "")), 
    position = position_stack(vjust = 0.5),
    color = "white",
    fontface = "bold",
    size = 3.5
  ) +
  scale_fill_manual(values = colores_sir) +   
  scale_x_continuous(labels = scales::percent_format(scale = 1), expand = c(0, 0)) + # Ahora la escala numérica es X
  theme_minimal(base_size = 13) +
  theme(
    axis.title.y     = element_text(face = "bold", margin = margin(t = 10)),
    axis.title.x     = element_text(face = "bold", margin = margin(t = 10)),
    legend.position  = "bottom",
    legend.title     = element_blank(),
    panel.grid.major.y = element_blank(), 
    panel.grid.minor = element_blank()
  ) +
  labs(
    x = "Porcentaje de aislados (%)",
    y = "Antibióticos testados"
  )

# 6. Mostrar el gráfico en pantalla
print(grafico_susceptibilidad)

# 7. Guardar el gráfico como PNG
ggsave(
filename = "ABR_plot.png", 
plot = grafico_susceptibilidad,
width = 8, 
height = 6, 
dpi = 300 
)

##############################
# 4. Cualidad del ensamblado #
##############################

# 1. Cargar los datos 
tabla_quast <- read.csv("resumen_calidad_quast.csv", header = TRUE)
tabla_quast <- tabla_quast[ ,-2]
colnames(tabla_quast) <- c("Aislado", "N50", "L50", "Contigs", "Longitude_total", "Contig_mayor_longitud", "Contenido_GC")
tabla_tecnologia <- read.csv("sec_tec.csv", header = TRUE, sep = "\t")
colnames(tabla_tecnologia) <- c("Aislado", "Tecnologia")

datos_quast <- full_join(tabla_tecnologia, tabla_quast, by = "Aislado")
datos_quast <- datos_quast[-34, ]
datos_quast <- datos_quast[-34, ]

# 2. Gráfico de Dispersión: N50 vs Número de Contigs
graph_n50 <- ggplot(datos_quast, aes(x = Contigs, y = N50, color = Tecnologia, shape = Tecnologia)) +
             geom_point(size = 4, alpha = 0.8) +
             scale_y_log10(labels = scales::comma) + # Escala logarítmica para el N50
             scale_color_manual(values = c("Illumina" = "#3498db", "Nanopore" = "#2ecc71")) +
             labs(x = "Número de Contigs",
                  y = "N50 (bp)",
                  color = "Tecnología",
                  shape = "Tecnología") +
             theme_minimal() +
             theme(legend.position = "bottom")

# 3. Mostrar el gráfico en pantalla
print(graph_n50)

# 4. Guardar el gráfico como PNG
ggsave(
  filename = "graph_N50_L50.png", 
  plot = graph_n50,
  width = 6, 
  height = 6, 
  dpi = 300 
)

# 5. Gráfico de Cajas (Boxplot) para comparar distribuciones
graph_n50_2 <- ggplot(datos_quast, aes(x = Tecnologia, y = N50, fill = Tecnologia)) +
               geom_boxplot(alpha = 0.7) +
               geom_jitter(width = 0.2, alpha = 0.5) + # Añadir los puntos individuales
               scale_y_log10(labels = scales::comma) +
               scale_fill_manual(values = c("Illumina" = "#3498db", "Nanopore" = "#2ecc71")) +
               labs(x = "Tecnología de Secuenciación",
                    y = "N50 (bp) - Escala Log") +
               theme_classic() +
               theme(legend.position = "none")

# 6. Mostrar el gráfico en pantalla
print(graph_n50_2)

# 7. Guardar el gráfico como PNG
ggsave(
  filename = "graph_N50_L50_2.png", 
  plot = graph_n50_2,
  width = 6, 
  height = 6, 
  dpi = 300 
)

######################################
# 5. Clasificación taxonómica y MLST #
######################################

tabla_taxonomia_mlst <- read.csv("resultados_taxonomia_MLST.csv", header = TRUE, sep = ";", check.names = FALSE)
tabla_mlst_bezdicek <- read.csv("MLST_Bezdicek.csv", header = TRUE, sep = ";", check.names = FALSE)
tabla_mlst_bezdicek <- tabla_mlst_bezdicek %>% select("ID", "ST B")
colnames(tabla_mlst_bezdicek) <- c("Aislado", "ST_B")
tabla_taxonomia_mlst <- full_join(tabla_taxonomia_mlst, tabla_mlst_bezdicek, by = "Aislado")
colnames(tabla_taxonomia_mlst) <- c("Aislado", "Resultados_Kraken", "Variante_gluP", "ID_coverage", "Especie", "ST", "ST_Bezdicek")

tabla_results_mlst <- tabla_taxonomia_mlst %>% group_by(Especie, ST, ST_Bezdicek) %>% summarise(n_aislados = n()) %>% arrange(desc(n_aislados))
write.csv(tabla_results_mlst, "results_MSLT_summary.csv")

#######################################
# 6. Heatmap presencia/ausencia genes #
#######################################

# 1. Crear Tabla final con Metadatos y Matriz de presencia/ausencia
## 1.1 Cargar tabla de aislados, mlst y matrices de presencia/ausencia de genes (usamos check.names=FALSE para evitar que cambien los nombres de las columnas)
tabla = read.csv("20260415_Tabla_variantes.csv", header = TRUE, sep = ";", check.names = FALSE)
tabla_pointfinder = read.csv("matriz_mutaciones_pointfinder.csv", header = TRUE, check.names = FALSE)
tabla_plasmidfinder = read.csv("matriz_binaria_plasmidos.csv", header = TRUE, check.names = FALSE)
tabla_resfinder = read.csv("matriz_binaria_resistencias.csv", header = TRUE, check.names = FALSE)
tabla_virulencefinder = read.csv("matriz_binaria_virulencia.csv", header = TRUE, check.names = FALSE)
tabla_bac = read.csv("matriz_binaria_bacteriocinas.csv", header = TRUE, check.names = FALSE)
tabla_mlst <- tabla_taxonomia_mlst %>% select("Aislado", "ST", "ST_Bezdicek")

## 1.2. Cambiar el nombre de aislados
colnames(tabla_pointfinder)[1] = "Genome_names"
colnames(tabla_resfinder)[1] = "Genome_names"
colnames(tabla_plasmidfinder) = c("Genome_names", "Rep3_rep11a", "Rep_trans_rep14a", "Rep_trans_rep14b", "RepA_N_rep17",	"Rep3_rep18a",	"Rep3_rep18b",	"Inc18_rep2",	"Rep3_rep33",	"RepA_N_rep8b",	"RepA_N_rep9a",	"RepA_N_rep9b",	"Inc18_repUS11",	"Rep1_repUS12",	"RepA_N_repUS15",	"Rep_trans_repUS43",	"Rep1_repUS57",	"Inc18_repUS7")
colnames(tabla_virulencefinder)[1] = "Genome_names"
colnames(tabla_bac) = c("Genome_names", "ClyLs", "bacAS11",	"bacAS32",	"bac41",	"bacAS5",	"bac51",	"bacAS3",	"bac43",	"bacAS12",	"bacAS9",	"entA",	"bac32")
colnames(tabla_mlst)[1] = "Genome_names"

## 1.3. Juntar todas las tablas
tabla_completa = tabla %>% full_join(tabla_mlst, by = "Genome_names") %>%
  full_join(tabla_resfinder, by = "Genome_names") %>%
  full_join(tabla_pointfinder, by = "Genome_names") %>%
  full_join(tabla_virulencefinder, by = "Genome_names") %>%
  full_join(tabla_plasmidfinder, by = "Genome_names") %>%
  full_join(tabla_bac, by = "Genome_names") 

## 1.4. Filtrar la tabla para aislados que han sido eliminados del estudio
tabla_completa <- tabla_completa %>% filter(!row_number() %in% c(33, 34, 35))

## 1.5. Recodificar algunos nombres de aislados
tabla_completa <- tabla_completa %>%
  mutate(Genome_names = recode(Genome_names,
                               "HPH46A" = "HPH46_A",
                               "HPH90B1" = "HPH90_B1",
                               "M918981VVE" = "M918981_VSE", 
                               "M918981VRE" = "M918981_VRE",
                               .default    = Genome_names          
  ))

## 1.6. Escribir la tabla en txt para colocar en excel       
write_csv(tabla_completa, "Matriz_binaria_results_all.csv")

# 2. Crear tablas con la identidad de los genes analizados y con la localización de los genes en contigs
## 2.1. Extraer las columnas de resultados - Bacteriocinas
### 2.1.1. Cargar los datos (usamos check.names=FALSE para evitar que los % se conviertan en puntos)
tabla_bac_completa <- read.csv("results_bac.txt", header = TRUE, sep = "\t", check.names = FALSE)

### 2.1.2. Renombrar y seleccionar
colnames(tabla_bac_completa)[1] <- "Genome_names"

### 2.1.3. Eliminar filas donde la primera columna sea exactamente "#FILE"
tabla_bac_completa <- tabla_bac_completa %>% filter(Genome_names != "#FILE")

### 2.1.4. Seleccionar las columnas para la tabla final
temp_select <- tabla_bac_completa %>% select(Genome_names, GENE, SEQUENCE, '%IDENTITY')

### 2.1.5 Limpiar el nombre del genoma (quitar .fasta)
temp_select$Genome_names <- gsub(".fasta", "", tabla_bac_completa$Genome_names)

### 2.1.6. Crear un identificador para cada copia del gen dentro de cada genoma
temp_con_copias <- temp_select %>%
  group_by(Genome_names, GENE) %>%
  mutate(copy_number = row_number()) %>% # Asigna 1 si es la primera vez que se ve el gen, 2 si es la segunda, etc.
  ungroup()

### 2.1.7. Pivotar para tener un genoma por fila
# Crear para cada GENE las columnas de SEQUENCE e IDENTITY
tabla_bac_final <- temp_con_copias %>%
  pivot_wider(
    names_from = c(GENE, copy_number), 
    values_from = c('%IDENTITY', SEQUENCE),
    names_glue = "{GENE}_copy{copy_number}_{.value}"
  )

### 2.1.8. Reordenar columnas para que cada gen tenga sus dos datos juntos
tabla_bac_final <- tabla_bac_final %>% select(Genome_names, order(colnames(.)))

### 2.1.9. Borrar tablas temporales 
rm(temp_con_copias)
rm(temp_select)

## 2.2. Extraer las columnas de resultados - Resistencia antibióticos (RAM)
### 2.2.1. Cargar los datos (usamos check.names=FALSE para evitar que los % se conviertan en puntos)
tabla_RAM_completa <- read.csv("resumen_resistencias_completo.csv", header = TRUE, sep = ",", check.names = FALSE)

### 2.2.2. Renombrar y seleccionar
colnames(tabla_RAM_completa)[1] <- "Genome_names"

### 2.2.3. Seleccionar solo las colunmas que queremos
temp_select <- tabla_RAM_completa %>% select(Genome_names, name, identity, query_id)

### 2.2.4. Crear un identificador para cada copia del gen dentro de cada genoma
temp_con_copias <- temp_select %>%
  group_by(Genome_names, name) %>%
  mutate(copy_number = row_number()) %>% # Asigna 1 si es la primera vez que se ve el gen, 2 si es la segunda, etc.
  ungroup()

### 2.2.5. Pivotar para tener un genoma por fila
# Crear para cada Gen(name) las columnas de identity y query_id
tabla_RAM_final <- temp_con_copias %>%
  pivot_wider(
    names_from = c(name, copy_number), 
    values_from = c(identity, query_id),
    names_glue = "{name}_copy{copy_number}_{.value}"
  )

### 2.2.6. Reordenar columnas para que cada gen tenga sus dos datos juntos
tabla_RAM_final <- tabla_RAM_final %>% select(Genome_names, order(colnames(.)))

### 2.2.7. Borrar tablas temporales
rm(temp_con_copias)
rm(temp_select)

## 2.3. Extraer las columnas de resultados - Virulencia
### 2.3.1. Cargar los datos (usamos check.names=FALSE para evitar que los % se conviertan en puntos)
tabla_vir_completa <- read.csv("resumen_virulencia_completo.csv", header = TRUE, sep = ",", check.names = FALSE)

### 2.3.2. Renombrar y seleccionar
colnames(tabla_vir_completa)[1] <- "Genome_names"

### 2.3.3. Eliminar filas donde la primera columna sea exactamente "#FILE"
tabla_vir_completa <- tabla_vir_completa %>% filter(name != "Negativo")

### 2.3.4. Seleccionar solo las colunmas que queremos
temp_select <- tabla_vir_completa %>% select(Genome_names, name, identity, query_id)

### 2.3.5. Crear un identificador para cada copia del gen dentro de cada genoma
temp_con_copias <- temp_select %>%
  group_by(Genome_names, name) %>%
  mutate(copy_number = row_number()) %>% # Asigna 1 si es la primera vez que se ve el gen, 2 si es la segunda, etc.
  ungroup()

### 2.3.6. Pivotar para tener un genoma por fila
# Crear para cada Gen(name) las columnas de identity y query_id
tabla_vir_final <- temp_con_copias %>%
  pivot_wider(
    names_from = c(name, copy_number), 
    values_from = c(identity, query_id),
    names_glue = "{name}_copy{copy_number}_{.value}"
  )

### 2.3.7. Reordenar columnas para que cada gen tenga sus dos datos juntos
tabla_vir_final <- tabla_vir_final %>% select(Genome_names, order(colnames(.)))

### 2.3.8. Borrar tablas temporales
rm(temp_con_copias)
rm(temp_select)

## 2.4. Extraer las columnas de resultados - Plásmidos
### 2.4.1. Cargar los datos (usamos check.names=FALSE para evitar que los % se conviertan en puntos)
tabla_plasmid_completa <- read.csv("resumen_plasmidos_completo.csv", header = TRUE, sep = ",", check.names = FALSE)

### 2.4.2. Renombrar y seleccionar
colnames(tabla_plasmid_completa)[1] <- "Genome_names"

### 2.4.3. Seleccionar solo las colunmas que queremos
temp_select <- tabla_plasmid_completa %>% select(Genome_names, identity, query_id, ref_id, ref_database)

### 2.4.4. Renombrar y seleccionar
colnames(temp_select)[5] <- "ref_database:family"

### 2.4.5. Separar columna con la familia de la proteina de replicación
temp_select <- temp_select %>%
  separate_wider_delim(
    cols = "ref_database:family",                # La columna que se quiere dividir
    delim = ":",                                 # El carácter que separa los datos
    names = c("ref_database", "Plasmid_family"), # Los nombres de las nuevas columnas
    too_few = "align_start"                 
  )

### 2.4.6. Juntar columa 
temp_select <- temp_select %>%
  unite(
    col = "rep_plasmid",           # Nombre de la nueva columna que se creará
    Plasmid_family, ref_id,        # Columnas que quiero juntar
    sep = "_",                     # Carácter que los separará 
    remove = TRUE                  # elimina las columnas originales
  )

### 2.4.7. Crear un identificador para cada copia del gen dentro de cada genoma
temp_con_copias <- temp_select %>%
  group_by(Genome_names, rep_plasmid) %>%
  mutate(copy_number = row_number()) %>% # Asigna 1 si es la primera vez que se ve el gen, 2 si es la segunda, etc.
  ungroup()

### 2.4.8. Eliminar la columnas ref_database original
temp_con_copias <- temp_con_copias[,-5]

### 2.4.9. Pivotar para tener un genoma por fila
# Crear para cada rep_plasmid las columnas de identity y query_id
tabla_plasmid_final <- temp_con_copias %>%
  pivot_wider(
    names_from = c(rep_plasmid, copy_number), 
    values_from = c(identity, query_id),
    names_glue = "{rep_plasmid}_copy{copy_number}_{.value}"
  )

### 2.4.10. Reordenar columnas para que cada gen tenga sus dos datos juntos
tabla_plasmid_final <- tabla_plasmid_final %>% select(Genome_names, order(colnames(.)))

### 2.4.11. Borrar tablas temporales
rm(temp_con_copias)
rm(temp_select)


## 2.5. Juntar todas las tablas
tabla_id_final <- tabla %>% full_join(tabla_mlst, by = "Genome_names") %>%
  full_join(tabla_RAM_final, by = "Genome_names") %>%
  full_join(tabla_plasmid_final, by = "Genome_names") %>%
  full_join(tabla_vir_final, by = "Genome_names") %>%
  full_join(tabla_bac_final, by = "Genome_names")

## 2.6. Escribir la tabla a txt
write_csv(tabla_id_final, "Tabla_ID_Final.csv")

# 3. Hacer el heatmap en función de grupos de cepas

## 3.1. Separar los metadatos y la matriz de presencia/ausencia de la tabla completa
matriz_genes <- tabla_completa %>% select(-c("Name", "Sequencing type", "Species (Kraken2)", "Especie", "ST", "ST_Bezdicek")) %>% column_to_rownames("Genome_names") 

df_anotacion <- tabla_completa %>% select("Genome_names", "Especie", "ST", "ST_Bezdicek") %>% column_to_rownames("Genome_names")
colnames(df_anotacion) <- c("Especies", "ST_Homan", "ST_Bezdicek")

## 3.2. Garantizar que todo está en binario (1 presencia, 0 ausencia)
matriz_bin_genes <- matriz_genes %>%
  mutate(across(everything(), ~if_else(.x == "0" | .x == "." | is.na(.x), 0, 1)))

## 3.4. Crear variable de grupos (Parejas/Tríadas)
# Extraer el prefijo (ej: HPH18 de HPH18a1)
grupos <- data.frame(Muestra = rownames(matriz_bin_genes)) %>%
  mutate(Grupo = str_extract(Muestra, "^[A-Z0-9]+(?=[a-z]|_|$)")) %>%
  column_to_rownames("Muestra")

## 3.5. Filtrar genes constantes 
# Solo nos quedamos con genes que varían en al menos una cepa
mat_filt <- matriz_bin_genes[, colSums(matriz_bin_genes) > 0 & colSums(matriz_bin_genes) < nrow(matriz_bin_genes)]

## 3.6. Anotaciones

### 3.6.1. Definir colores específicos por especie
col_especies = c("E. faecium" = "#E41A1C", "E. faecalis" = "#377EB8", "E. lactis" = "#4DAF4A")

### 3.6.2. Convertir STs a factor para asegurar que R lo trate como categoría
df_anotacion$ST_Homan <- as.factor(df_anotacion$ST_Homan)
df_anotacion$ST_Bezdicek <- as.factor(df_anotacion$ST_Bezdicek)

### 3.6.3.Obtener los STs únicos
unique_sts_H <- levels(df_anotacion$ST_Homan)
unique_sts_B <- levels(df_anotacion$ST_Bezdicek)

##### 3.6.3.1. Creamos una paleta de colores (usando RColorBrewer)
colores_st_lista_H <- setNames(brewer.pal(length(unique_sts_H), "Set3"), unique_sts_H)
colores_st_lista_B <- setNames(brewer.pal(length(unique_sts_B), "Paired"), unique_sts_B)

## 3.7. Definir colores para la anotación de grupo (genes en el heatmap)
col_fun = colorRamp2(c(0, 1), c("white", "steelblue"))

## 3.8. Crear la anotación lateral con la nueva paleta discreta
ha_lateral = rowAnnotation(
  Especies = df_anotacion$Especies,
  ST_Homan = df_anotacion$ST_Homan,
  ST_Bezdicek = df_anotacion$ST_Bezdicek,
  col = list(
    Especies = col_especies, 
    ST_Homan = colores_st_lista_H,
    ST_Bezdicek = colores_st_lista_B
  ),
  show_annotation_name = TRUE,
  annotation_name_side = "top",
  annotation_name_gp = gpar(fontsize = 8, fontface = "bold")
)

## 3.9. Generar el Heatmap final
p <- Heatmap(as.matrix(mat_filt), 
             name = "Presencia/Ausencia",
             col = col_fun,
             left_annotation = ha_lateral, 
             row_split = grupos$Grupo,        
             row_title_rot = 0,               
             cluster_rows = FALSE,            
             cluster_columns = TRUE,          
             row_names_gp = gpar(fontsize = 5),      
             column_names_gp = gpar(fontsize = 4),   
             show_row_names = TRUE,
             row_title_gp = gpar(fontsize = 8, fontface = "bold"),
             rect_gp = gpar(col = "gray", lwd = 0.1))

## 3.10. Renderizar
draw(p, merge_legends = TRUE)

## 3.11. Guardar el heatmap como PNG
png(
  filename = "heatmap_grupos_cepas.png", 
  width = 14, 
  height = 8, 
  units = "in", 
  res = 300
)
draw(p, merge_legends = TRUE)
dev.off()

# 4. Hacer el heatmap sin definir grupos
q <- Heatmap(as.matrix(mat_filt), 
             name = "Presencia/Ausencia",
             col = col_fun,
             left_annotation = ha_lateral, 
             cluster_rows = TRUE,          
             cluster_columns = TRUE,       
             row_names_gp = gpar(fontsize = 5),      
             column_names_gp = gpar(fontsize = 4),   
             show_row_names = TRUE,
             rect_gp = gpar(col = "gray", lwd = 0.1))
## 4.1. Renderizar
draw(q, merge_legends = TRUE)

## 4.2. Guardar el heatmap como PNG
png(filename = "heatmap_especies.png", width = 16, height = 8, units = "in", res = 300)
draw(q, merge_legends = TRUE)
dev.off()


##############################
# 7. Mapeo de SNPs y FastANI #
##############################

# 1. Ler tablas de mapeo con minimap2, SNPs y fastANI
tabla_ANI <- read.table("Tabla_ANI_Final.tsv", header = TRUE)
tabla_ANI <- tabla_ANI %>% separate(ID_Muestra, c(NA, "Genome_names"), sep = "/") %>%
  separate(ID_Referencia, c(NA, "Referencia"), sep = "/")

tabla_bcftools <- read.csv("resumen_snps_bcftools.txt", header = TRUE, sep = "|")
tabla_bcftools <- tabla_bcftools %>% separate(Muestra, c(NA, NA, "Sample_names"), sep = "_", extra = "merge") 
tabla_bcftools <- tabla_bcftools %>% separate(Sample_names, c("Genome_names", NA), sep = "\\.")

tabla_minimap2 <- read.csv("resumen_mapeo_minimap2.csv", header = TRUE)
colnames(tabla_minimap2)[1] <- "Genome_names"

tabla_SNPs_final <- tabla_ANI %>% full_join(tabla_minimap2, by = "Genome_names") %>%
  full_join(tabla_bcftools, by = "Genome_names")
tabla_SNPs_final$Grupo <- ifelse(tabla_SNPs_final$SNPs_Filtrados < 100, 
                                 "Clonales", 
                                 "No Clonales")

tabla_SNPs_final <- tabla_SNPs_final %>%
  mutate(Genome_names = recode(Genome_names,
                               "HPH46A" = "HPH46_A",
                               "M918981VVE" = "M918981_VSE", 
                               .default    = Genome_names          
  ))

tabla_SNPs_final <- tabla_SNPs_final %>%
  mutate(Referencia = recode(Referencia,
                               "M918981VRE" = "M918981_VRE", 
                               .default    = Referencia          
  ))

write_csv(tabla_SNPs_final, "Tabla_SNPs_FINAL.csv")

# 2. Figura SNPs
SNP_graph <- ggplot(tabla_SNPs_final, aes(x = SNPs_Filtrados, y = Porcentaje_Mapeo, color = Grupo)) +
             geom_point(size = 4, alpha = 0.8) +
             scale_x_log10() + 
             theme_minimal() +
             labs(x = "SNPs Filtrados (Escala Log10)", y = "Porcentaje de Mapeo (%)") +
             geom_text_repel(aes(label = paste(Genome_names, "vs", Referencia)), size = 2, max.overlaps = 15)

# 3. Mostrar el gráfico en pantalla
print(SNP_graph)

# 4. Guardar el gráfico como PNG
ggsave(
  filename = "SNPs_groups.png", 
  plot = SNP_graph,
  width = 6, 
  height = 4, 
  dpi = 300 
)

#################################
# 8. Resultados Panaroo general #
#################################

# 1. Crear una función interna para parsear de forma automática el srchivo summary de Panaroo
parsear_summary_panaroo <- function(ruta_archivo, nombre_especie) {
  # Leer el archivo línea por línea
  lineas <- readLines(ruta_archivo)
  # Buscar las líneas de las categorías usando expresiones regulares
  core_line  <- lineas[str_detect(lineas, "^Core genes")]
  soft_line  <- lineas[str_detect(lineas, "^Soft core genes")]
  shell_line <- lineas[str_detect(lineas, "^Shell genes")]
  cloud_line <- lineas[str_detect(lineas, "^Cloud genes")]
  # Extraer el último número de cada línea (el conteo absoluto)
  extraer_conteo <- function(linea) {
    as.numeric(str_extract(linea, "\\d+$"))
  }
  # Construir un data.frame limpio por especie
  data.frame(
    Especie = nombre_especie,
    Componente = c("Core", "Soft core", "Shell", "Cloud"),
    Genes = c(extraer_conteo(core_line), 
              extraer_conteo(soft_line), 
              extraer_conteo(shell_line), 
              extraer_conteo(cloud_line)),
    stringsAsFactors = FALSE
  )
}

# 2. Leer y procesar los archivos de Panaroo
datos_efc <- parsear_summary_panaroo("summary_statistics_Efc.txt", "E. faecalis (n=3)")
datos_ela <- parsear_summary_panaroo("summary_statistics_Ela.txt", "E. lactis (n=2)")
datos_efm <- parsear_summary_panaroo("summary_statistics_Efm.txt", "E. faecium (n=27)")

# 3. Combinar todos los datos en una única tabla
df_pangenomas_completo <- bind_rows(datos_efc, datos_ela, datos_efm)

# 4. Configurar factores para mantener el orden  (de Core en la base a Cloud en la punta)
df_pangenomas_completo$Componente <- factor(df_pangenomas_completo$Componente, 
                                            levels = c("Cloud", "Shell", "Soft core", "Core"))

# 5. Calcular porcentajes para las barras apiladas al 100%
df_grafico <- df_pangenomas_completo %>%
  group_by(Especie) %>%
  mutate(
    Total = sum(Genes),
    Porcentaje = (Genes / Total) * 100
  ) %>%
  ungroup()

# 6. Generar el gráfico con ggplot2
m <- ggplot(df_grafico, aes(x = Porcentaje, y = Especie, fill = Componente)) +
  geom_bar(stat = "identity", position = "stack", width = 0.55, color = "white", lwd = 0.8) +
  geom_text(aes(label = ifelse(Porcentaje > 1.5, 
                               paste0(sprintf("%.1f", Porcentaje), "%\n(n=", Genes, ")"), 
                               "")), 
            position = position_stack(vjust = 0.5), 
            color = ifelse(df_grafico$Componente == "Cloud", "black", "white"), 
            fontface = "bold", size = 3.5) +
  coord_cartesian(xlim = c(0, 102)) +
  scale_fill_manual(
    values = c("Core" = "#1A365D", 
               "Soft core" = "#2B6CB0", 
               "Shell" = "#E28743", 
               "Cloud" = "#ECC94B"),
    labels = c("Core" = "*Core*", 
               "Soft core" = "*Soft core*", 
               "Shell" = "*Shell*", 
               "Cloud" = "Cloud") 
  ) +
  scale_x_continuous(labels = function(x) paste0(x, "%"), expand = c(0,0)) +
  labs(x = "Porcentaje de Grupos de Genes (%)",
       y = NULL,
       fill = "Componente del Pangenoma:"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.title.x = element_text(face = "bold", margin = margin(t = 11)),
    axis.text.y = element_text(face = "italic", color = "black", size = 11),
    axis.text.x = element_text(color = "black"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 10),

    legend.text = element_markdown(size = 10), 
    legend.background = element_rect(fill = "#F7FAFC", color = "#E2E8F0")
  ) +
  guides(fill = guide_legend(reverse = TRUE))

# 7. Renderizar el gráfico en pantalla
print(m)

# 8. Guardar la imagen PNG
ggsave(
  filename = "Pangenoma_all.png", 
  plot = m,
  width = 8, 
  height = 6, 
  dpi = 300 
)

#############################
# 9. Resultados Panaroo Efc #
#############################


# 1. Leer el archivo de Panaroo 
datos <- read.csv("gene_presence_absence_efc.csv", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)

# 2. Extraer los genes presentes en cada cepa 
# Filtrar para seleccionar  las filas donde la celda NO esté vacía ("") ni sea NA
genes_HPH204a <- datos$Gene[datos$HPH204a != "" & !is.na(datos$HPH204a)]
genes_HPH204b <- datos$Gene[datos$HPH204b != "" & !is.na(datos$HPH204b)]
genes_HPH90B1 <- datos$Gene[datos$HPH90B1 != "" & !is.na(datos$HPH90B1)]

# 3. Crear la lista con los tres conjuntos de genes
lista_venn <- list(
  "HPH204a" = genes_HPH204a,
  "HPH204b" = genes_HPH204b,
  "HPH90B1" = genes_HPH90B1
)

# 4. Generar el gráfico estilo ggplot
n <- ggVennDiagram(lista_venn, label_alpha = 0, edge_size = 0.8) +
  scale_fill_gradient(low = "#F4FAFF", high = "#4682B4") +
  theme(legend.position = "none")

# 5. Mostrar el gráfico en RStudio
print(n)

# 6. Guardar imagen en PNG
ggsave(
  filename = "Venn_Pangenoma_Efc.png", 
  plot = n,
  width = 7, 
  height = 7, 
  dpi = 300 
)

#############################
# 10. Resultados Panaroo Ela #
#############################

# 1. Definir los datos del análisis de Panaroo para Ela
genes_core <- 2263

# Contar genes shell exclusivos para cada cepa de Ela
datos_ela <- read.csv("gene_presence_absence_Ela.csv", header = TRUE, stringsAsFactors = FALSE)

# Un gen es exclusivo si está en una cepa pero NO en la otra
exclusivos_HPH355_B <- sum(datos_ela$HPH355_B != "" & !is.na(datos_ela$HPH355_B) & (datos_ela$HPH442_2 == "" | is.na(datos_ela$HPH442_2)))
exclusivos_HPH442_2 <- sum(datos_ela$HPH442_2 != "" & !is.na(datos_ela$HPH442_2) & (datos_ela$HPH355_B == "" | is.na(datos_ela$HPH355_B)))

# 2. Estructurar la tabla de datos para ggplot
df_grafico <- data.frame(
  Cepa = c("HPH355_B", "HPH355_B", "HPH442_2", "HPH442_2"),
  Categoria = c("Shell", "Core", "Shell", "Core"),
  Genes = c(exclusivos_HPH355_B, genes_core, exclusivos_HPH442_2, genes_core)
)

df_grafico <- df_grafico %>%
  mutate(Categoria = factor(Categoria, levels = c("Shell", "Core")))

# 3. Generar el gráfico definitivo
o <- ggplot(df_grafico, aes(x = Cepa, y = Genes, fill = Categoria)) +
  geom_bar(stat = "identity", width = 0.55, color = "white", lwd = 0.6) +
  geom_text(aes(label = scales::comma(Genes)), 
            position = position_stack(vjust = 0.5), 
            color = "white", 
            fontface = "bold", 
            size = 4) +
  scale_fill_manual(
    values = c("Core" = "#1A365D",  # Azul oscuro abajo
               "Shell" = "#E28743"), # Naranja arriba
    labels = c("Core" = "*Core*", 
               "Shell" = "*Shell*") 
  ) +
  labs(
    x = "Aislados Clínicos",
    y = "N. de Grupos de Genes",
    fill = "Componente:"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.title.x = element_text(face = "bold", margin = margin(t = 15)),
    axis.title.y = element_text(face = "bold", margin = margin(r = 15)),
    axis.text = element_text(color = "black", face = "bold"), 
    panel.grid.major.x = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.text = element_markdown(size = 11), 
    legend.title = element_text(face = "bold", size = 11),
    legend.background = element_rect(fill = "#F9F9F9", color = "gray90"),
    legend.margin = margin(t = 5, r = 10, b = 5, l = 10)
  ) +
  guides(fill = guide_legend(reverse = FALSE))

# 4. Mostrar el gráfico en el panel de RStudio
print(o)

# 5. Exportar automáticamente en calidad de publicación (300 DPI) para tu memoria
ggsave(
  filename = "Pangenoma_E_lactis_Barras.png", 
  plot = o, 
  width = 8, 
  height = 8, 
  dpi = 300
)

