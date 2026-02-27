##Operadores logicos en R
x<-1:3
y<-1:3
z<-c(1,2,4)

x|y
x&z
!z

x==y
identical(x, y)
all(x==y)
any(x==y)
identical(x, z)
all(x==z)
any(x==z)

10->a

sqrt(16)
sqrt(16)-16^(1/2)

exp(1)
exp(2)
log(exp(2))

sin(90)
sin(90*pi/180)

round(2.3465, digits =2)
floor(2.3465) 
floor(-2.3465) 
ceiling(2.3465)
ceiling(-2.3465)
trunc(2.3465)

#Estructuras de control
##Estructuras condicionales
###if
x<-4
if(x<0){
  x<- -x
}

###if else
a<-5.24
a_ent <- trunc(a)
dec <- a-a_ent

if (dec >= 0.5){
  b <-a_ent+1
} else{
  b<-a_ent
}

###if else if com 3casos
a<-1
b<-1
if (a>b){
  print("a gana!")
} else if (a<b){
  print("b gana!")
} else {
  print("Esto es un empate :(")
}

###ejemplo
n <- 8.9
if (n >= 5){
  print("Aprobado!")
} else {
  print("Reprobado")
}

##ifelse
x<-c(5,3,2,8,-4,1)
ifelse(x%%2 == 0, "Es par", "Es impar")
ifelse(x%%2 == 0,
       ifelse(x%%4 == 0, "es múltiplo de 4", "es múltiplo de 2 pero no de 4"), "es impar")

#ejemplo
set.seed(15)
sexo =sample(c("hombre", "mujer"), 10, replace=T)
edad = sample(13:45, 10, replace = T)
datos<-data.frame(Sexo=sexo, Edad=edad)
datos$clasif <- with(datos, ifelse(Sexo=="hombre", 
                     ifelse(Edad>=18, "hombre adulto", "hombre menor de edad"), 
                     ifelse(Edad>=18, "mujer adulta", "mujer menos de edad")
                     ))
###Estructuras interactivas
#for
for(i in 1:3){
  print(2*i)
}

v<- c(-2, 1, 4, sqrt(55), -11, 2.3)
seq_along(v)
for(i in seq_along(v)){
  cat(i, "--", v[i], "\n")
}

for (i in 1:10) {
  print(i^2)
}

cuadrados <- rep(NA, 10)
for (i in 1:10) {
  cuadrados[i]<-i^2
}
sum(cuadrados)
d<-(1:10)^2

#while
set.seed(67)
dado<-sample(1:6, 1)
tiradas <- dado
while (dado!=6) {
  dado <-sample(1:6, 1)
  tiradas <- c(tiradas, dado)
}

set.seed(67)
dado <- sample(1:6, 1)   # primera tirada
tiradas <- dado

contador_6 <- ifelse(dado == 6, 1, 0)  # empieza en 1 si la primera tirada fue 6, en 0 si no

while (contador_6 < 2) {   # seguimos hasta que salgan 2 seises
  dado <- sample(1:6, 1)
  tiradas <- c(tiradas, dado)
  
  if (dado == 6) {
    contador_6 <- contador_6 + 1
  }
}

set.seed(67)
dado <- sample(1:6, 1)
tiradas <- dado

while (!any(tiradas == 6) || sum(tiradas == 6) < 2) {
  dado <- sample(1:6, 1)
  tiradas <- c(tiradas, dado)
}

#repeat
valor<-10
res <- valor
repeat{
  valor <-valor/2
  res <- c(res, valor)
  
  if(valor <0.5){
    break
  }
}

# break y next
for (i in 1:10) {
  if (i %% 2 != 0) {
    next
  }
  print(i)
  if (i >= 8) {
    break
  }
}

#Familia apply()
apply(X=iris[, -5], MARGIN=2, FUN = sum)

a1<-array(data=1:24, dim = c(3, 4, 2))
apply(a1, MARGIN=2, FUN=sum)
apply(a1[, , 1], MARGIN = 2, FUN = sum)
apply(a1[, , 2], MARGIN = 2, FUN = sum)

suma.filas <- apply(iris[, -5], MARGIN = 1, FUN = sum)
class(suma.filas)
length(suma.filas)
suma.filas[1:4]
cbind(iris[1:4, -5], suma.filas[1:4])

apply(X=iris, MARGIN = 2, FUN = mean, na.rm=TRUE)

## tapply
tapply(iris$Petal.Length, iris$Species, mean)
set.seed(45)
vector <- rnorm(n=30, mean = 1, sd=5)
grupos1 <- as.factor(sample(1:5, size=30, replace = TRUE))
grupos2 <- as.factor(sample(c("A", "B", "C"), size=30, replace=TRUE))
tapply(vector, list(grupos1, grupos2), length)
tapply(vector, list(grupos1, grupos2), length, default = 0)

##lapply
g<-c(10, 25, 30)
l1<-lapply(g, log)
class(l1)
v1<-log(g)
class(v1)

#Crear funciones
df<-data.frame(
  a=rnorm(10),
  b=rnorm(10, mean = 0, sd = 2),
  c=rnorm(10, mean = 0, sd = 0.5),
  d=rnorm(10, mean = -1, sd = 1)
)

df$a.new <- (df$a - mean(df$a))/sd(df$a)
df$b.new <- (df$b - mean(df$b))/sd(df$b)
df$c.new <- (df$c - mean(df$c))/sd(df$c)
df$d.new <- (df$d - mean(df$d))/sd(df$d)

#función maximo
maximo<-function(a, b){
  if(a>b){
    m<-a
  } else{
    m<-b
  }
  m
}

maximo(-7, 2)
y<-18
maximo(20, y+7)
formals(maximo)
body(maximo)

#return
maximo3<- function(a, b) {
  if(a>b) {
    return(a)
  } else {
    return(b)
  }
}

maximo3(2,7)
maximo3(9, -6)

#ejemplo
mi_descr<-function(datos){
  if(!is.numeric(datos)){
    return("datos debe ser numérico")
  }
  med <- mean(datos)
  des <- sd(datos)
  mini <- min(datos)
  maxi <- max(datos)
  n <- length(datos)
  return(list(
    media = med,
    desvio = des,
    minimo = mini,
    máximo = maxi,
    n = n
  ))
}

set.seed(78)
x <- runif(50, 0, 1)
resultado <- mi_descr(x)
y <- c(x, "hola")
resultado1 <- mi_descr(y)

#variables locales y globales
f <- function(v){
  n<- length(v)
  acum <- rep(NA, n)
  s <- 0
  for (i in seq_along(v)) {
    s <- s+ v[i]
    acum[i] <- s
  }
  return(list(
    suma = s,
    acumuladas = acum,
    n=n
  ))
}

v <- c(0.25, 0.15, 0.10, 0.35, 0.10, 0.05)
f(v)

#argumentos predeterminados
maximo2<-function(a, b=1){
  if(a>b){
    m<-a
  } else{
    m<-b
  }
  m
}

##Ejercicios
#Ejercicio 1
Clasificacion<- function(x){
ifelse(x<5, "suspenso",
      ifelse(x<7, "Aprobado",
                ifelse(x<9, "Notable", "Sobresaliente")))
}

