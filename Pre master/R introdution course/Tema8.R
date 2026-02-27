#R y bases de datos

##Conexión de R con diferentes bases de datos
# Instalación y carga del paquete RSQLite
install.packages("RSQLite")
library(RSQLite)
# Creación de una conexión a una base de datos SQLite
con <- dbConnect(SQLite(), dbname = "mi_base_de_datos.sqlite")
# Creación de una tabla e inserción de datos
dbWriteTable(con, "empleados", data.frame(id = 1:3, nombre = c("Ana", "Luis", "María"), salario = c(50000, 60000, 55000)))
# Consulta de los datos de la tabla
empleados <- dbReadTable(con, "empleados")
print(empleados)
# Cierre de la conexión
dbDisconnect(con)

# Instalación y carga del paquete RMySQL
install.packages("RMySQL")
library(RMySQL)
# Conexión a la base de datos MySQL *
con <- dbConnect(MySQL(), user = "anspedrosa@gmail.com", password = "FARmacia_01!", dbname = "mi_base_de_datos", host = "localhost")
# Consulta de una tabla
resultado <- dbGetQuery(con, "SELECT * FROM clientes")
print(resultado)
# Cierre de la conexión
dbDisconnect(con)

# Instalación y carga del paquete mongolite
install.packages("mongolite")
library(mongolite)
# Conexión a la base de datos MongoDB *
con <- mongo(collection = "mi_coleccion", db = "mi_base_de_datos", url = "mongodb://localhost:27017")
# Inserción de un documento JSON en la colección
con$insert('{ "nombre": "Juan", "edad": 30, "profesion": "Ingeniero" }')
# Recuperación de los datos de la colección
datos <- con$find()
print(datos)
# Cierre de la conexión
con$disconnect()

# * Configura la conexión para usar la base de datos de tu conveniencia.
