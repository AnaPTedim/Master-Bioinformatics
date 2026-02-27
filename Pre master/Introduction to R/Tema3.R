#Tema 3
##Ejercicio 1
###1.Construye un vector con las primeras 15 letras MAYÚSCULAS usando el vector constante LETTERS de R.
A<-LETTERS[1:15]
A

###2. Construye una matriz de 10 x 10 con los primero 100 números pares positivos.
B<-matrix(seq(from=2, to=200, by=2), nrow = 10)
B

###3.Construye una matriz identidad de orden 5.
C<-diag(5)
C

###4. Construye una lista con los objetos creados en los ítems anteriores.
D<-list(A, B, C)
D

###5. Construye un data frame con las respuestas de 3 personas a las preguntas: (a) ¿Cuál es su edad en años? (b) ¿Tipo de música que más le gusta? (c) ¿Practica algún deporte regularmente?
edad<-c(40, 45, 65)
musica<-c("Classica", "Electronica", "Rock")
deporte<-c("Si", "No", "No")
E<-data.frame(edad, musica, deporte)
E

##Ejercicio 2
###1. ¿Cuál es el error en el siguiente código? ¿Por qué ocurre?
####La funcion a usar para obtener la matiz con estas caracteristicas no puede ser matrix() pero si cbind()
###2. Arregla el código anterior para obtener una matriz cuyas columnas sean los vectores edad, deporte y cuidad.
edad <- c(15, 19, 13, NA, 20)
deporte <- c('SI', 'NO', 'SI', 'SI', 'NO')
ciudad <- c("NA", 'Madrid', 'Quito', 'Santa Fe', 'Medellin')
F<-cbind(edad, deporte, ciudad)
class(F)

##Ejercicio 3
###Pon a prueba tu conocimiento de las reglas de coerción de vectores prediciendo el resultado de los siguientes usos de la función c():
G<-c(1,'dos') #crea un vector con dos valores del tipo character
H<-c(1,FALSE) #crea un vector con dos valores del tipo numeric
I<-c(TRUE,1L) #crea un vector con dos valores del tipo numeric pero intriger
J<-c(TRUE,'false') #crea un vector con dos valores del tipo character

##Ejercicio 4
###En el siguiente ejercicio deberás trabajar con el datasets mtcars, contenido en el paquete {datasets} que trae R incorporado con su instalación básica. Corrige cada uno de los siguientes errores frecuentes en la creación de subconjuntos de data frames:
K<-subset(mtcars, mtcars$cyl == 4)
K
L<-subset(mtcars, select = -c(1:4))
L
M<-subset(mtcars, mtcars$cyl <= 5)
M
N<-subset (mtcars, mtcars$cyl ==4 | mtcars$cyl ==6)
N

##Ejercicio 5
###En cada una de las siguientes expresiones, explica el resultado que devuelve R:
O<-1 == "1" #es verdadero (TRUE) R transforma el 1 numerico en character y por lo tanto dos 1 en character son iguales.
O1<--1 < FALSE #es verdadero (TRUE) R transforma el FALSE (valor logico) en O que es su valor numerico y por lo tanto los puede compara y -1 es efectivamente menos que cero.
O2<-"one" < 2 #es falso (FALSE) R transforma el 2 numerico en chacracter sin embargo como "one" es una palabra R no lo interpreta como 1 y por eso el valor que devuelve es falso.

##Ejercicio 6
###Si df es un data frame, ¿qué puedes decir acerca t(df) y de t(t(df))? Realiza algunos experimentos, asegurándote de considerar diferentes tipos de columnas en tu data frame. Debería prestar especial atención al tipo de estructura del resultado, el tipo de cada columna (original y del resultado), las dimensiones (del data frame original y del resultado).
####La funcion t() se usa para transponer matrices o data frames. 
P<-t(E) #Si usas t() en un data frame te pasa las filas a columnas y las columnas a filas. 
P1<-t(t(E)) # Si usas t(t()) te devuelve el data frame original. En data frames en que el numero de lineas y columnas es el mismo.


altura <- c(167, 192, 173, 174, 172, 167, 171, 185, 163, 170) # en cm
peso <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55) # en Kg
fuma <- c("No", "Si", "No", "Si", "No", "No", "Si", "Si", "Si", "No") # habito de fumador
sexo <- c("M", "M", "F", "M", "M", "M", "F", "M", "F", "F")
Q<-data.frame(Altura=altura, Peso=peso, Habito=fuma, Sexo=sexo)

R<-t(Q) #Si usas t() en un data frame te pasa las filas a columnas y las columnas a filas. 
R1<-t(t(Q)) # Si usas t(t()) te devuelve el data frame original. Esto es cierto indepedentemente del si usas un data frame como el mismo numero de lineas y columnas. Te mantiene en nombre que tienen las columnas para las filas pero las columnas las nombras V1, V2, etc. Mantiene el orden de las columnas en las lineas y vice-versa.

