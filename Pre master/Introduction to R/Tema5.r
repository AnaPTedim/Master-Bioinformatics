#Importar TXT desde la web a R
url <- "http://www.biostatisticien.eu/springeR/imcenfant.txt"
datos3 <- read.table(url, header = TRUE)

#Descargar los archivos desde R
url <- "http://www.biostatisticien.eu/springeR/imcenfant.txt"
download.file(url, destfile = 'IMCenfant.txt')

url1 <- "https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-04-24/gapminder_es.csv"
download.file(url1, destfile = 'gapminder_es.csv')
datos5 <- read.csv("gapminder_es.csv")
head(datos5)

#ler datos en excel
##instalar readxl
library(readxl)
direccion <- "https://www.lock5stat.com/datasets3e/NutritionStudy.xlsx"
destino <- "NutritionStudy.xlsx"
download.file(
  url = direccion,
  destfile = destino,
  mode = "wb"
)

datos6 <- read_excel(destino)
head(datos6)

direccion1 <- "https://www.mapa.gob.es/es/alimentacion/temas/consumo-tendencias/2021datosanualesdelpaneldeconsumoalimentarioenhogaresv2_tcm30-623605.xlsx"
destino1 <- "datos_consumo.xlsx"
download.file(
  url = direccion1,
  destfile = destino1,
  mode = "wb"
)
excel_sheets(destino1)

datos7 <- read_excel(destino1, sheet = "PRECIO")
head(datos7)

datos7 <- read_excel(destino1, sheet = "PRECIO", skip = 2)
head(datos7)

#Datos de R
load("./data/hatco.RData")
load("./data/mice_pot.rda")

#datos de otros programas estadisticos
library(haven)

#cargar datos desdes un paquete de R
#Datasets de base
data(package='datasets')
data()
dim(InsectSprays)
str(InsectSprays)
class(InsectSprays)

#Guardar datos (data.frames)
altura <- c(167, 192, 173, 174, 172, 167, 171, 185, 163, 170)
peso <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55)
fuma <- c("No", "Si", "No", "Si", "No", "No", "Si", "Si", "Si", "No")
sexo <- c("M", "M", "F", "M", "M", "M", "F", "M", "F", "F")
df <- data.frame(altura, peso, habito=fuma, sexo)
write.table(x=df, file = "df.txt", sep = ";", row.names = FALSE, col.names = TRUE)
write.csv(x=df, file = "df.csv", row.names = FALSE) #separador son comas y punto como separador decimal
df_from_csv <- read.csv(file = "df.csv")
write.csv2(x=df, file = "df_2.csv", row.names = FALSE) #separador es punto y coma y coma como separador decimal
df2_from_csv <- read.csv2(file = "df_2.csv")

#Guardar listas usando saveRDS
v <- runif(10,2,10)
m <- matrix(1:4, ncol = 2)
df3 <- data.frame("Nombres" = c('Lucia', 'Bianca', 'Fernando','Carlos'), "edad" = c(19,20,34,56))
lista1 <- list(v, m, df3)
saveRDS(object = lista1, file = "mi_lista.rds")
mi_lista_imp <- readRDS("mi_lista.rds")

#Manipulación de datos
AirPassengers
ChickWeight

##tidyverse y su operador %>%
library(tidyverse)
x <- 1:10
logx <- log(x)
meanlogx <- mean(logx)
sqrt(meanlogx)

y <-1:10 %>% log() %>% mean() %>% sqrt()
y

##manipular con dplyr
