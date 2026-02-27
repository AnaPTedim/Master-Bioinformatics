###Visualización de datos
##Función plot
x <- c(1, 3, -2, 0, 5, 4, 2.5, 1)
y <- c(0, 5, 7, 4, 1, -1, -3, 9)
plot(x, y)
plot(x)

f <- function(x) {x^2 + 1}
plot(f)
plot(f, -1, 4)

#Argumento type
x <- 0:10
y = dbinom(x, size = 10, p = 0.3)
par(mfrow = c(1, 3))
plot(x, y, type = "p", main = "type = 'p'")
plot(x, y, type = "l", main = "type = 'l'")
plot(x, y, type = "h", main = "type = 'h'")
plot(x, y, type = "o", main = "type = 'o'")
plot(x, y, type = "b", main = "type = 'b'")
plot(x, y, type = "c", main = "type = 'c'")
plot(x, y, type = "s", main = "type = 's'")
plot(x, y, type = "S", main = "type = 'S'")
plot(x, y, type = "n", main = "type = 'n'")
par(mfrow = c(1, 1))

#Modificar puntos del gráfico
r <- rep(seq(4, 28, by = 6), each = 5)
r <- c(r, 34)
t <- rep(seq(25, 5, -5), 5)
t <- c(t, 25)
plot(r, t, pch = 0:25, cex = 3, yaxt = "n", xaxt = "n",
     ann = FALSE, xlim = c(1, 36), ylim = c(3, 27), lwd = 1:3,
     bg = "grey")
text(r - 2.7, t, 0:25, cex = 0.9)

r <- r[-26]
t <- t[-26]
plot(r, t, pch = 21:25, cex = 3, yaxt = "n", xaxt = "n", lwd = 3,
     ann = FALSE, xlim = c(1, 30), ylim = c(3, 27), bg = 1:25,
     col = rainbow(25))

x1 <- c(1, 3, -2, 0, 5, 4, 2.5, 1)
y1 <- c(0, 5, 7, 4, 1, -1, -3, 9)
plot(x1, y1,
     pch = 21, # tipo de punto
     col = "#0098CD", # color de borde
     bg = "#B8E5F5", # color de fondo
     cex = 1.5, # tamaño del punto
     lwd = 2 # ancho del borde
)

library(colourpicker) #permite eligir colores con su nombre dedcimal usando addins y que si importan al script.

# tipos de líneas
par(mfrow = c(3,3))
# Línea solida (por defecto)
plot(1:10, 1:10, type="l", main = 'lty = 1')
# Línea discontinua
plot(1:10, 1:10, type="l", lty=2, main = 'lty = 2')
# Línea de puntos
plot(1:10, 1:10, type="l", lty=3, main = 'lty = 3')
# Línea de puntos y guiones cortos
plot(1:10, 1:10, type="l", lty=4, main = 'lty = 4')
# Línea de guiones largos
plot(1:10, 1:10, type="l", lty=5, main = 'lty = 5')
# Línea de guiones cortos y largos
plot(1:10, 1:10, type="l", lty=6, main = 'lty = 6')
# modificando el grosor
plot(1:10, 1:10, type="l", lty=1, lwd = 2, main = 'lty = 1 y lwd = 2')
# modificando el grosor
plot(1:10, 1:10, type="l", lty=1, lwd = 2.5, main = 'lty = 1 y lwd = 2.5')
# modificando el grosor
plot(1:10, 1:10, type="l", lty=1, lwd = 0.5, main = 'lty = 1 y lwd = 0.5')

#Titulo y nombre de los ejes
x <- seq(-4, 4, length.out = 101)
y <- sin(x)
plot(x, y, type = "l",
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'El título',
     col.main = "#0098CD"
)
?plotmath

#Función axis
par(mfrow = c(1,2))
x <- seq(-4, 4, length.out = 101)
y <- sin(x)
plot(x, y, type = "l",
     axes = FALSE,
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'axis(1)',
     col.main = "#0098CD"
)

# agregamos el eje x
axis(1)
plot(x, y, type = "l",
     axes = FALSE,
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'axis(2)',
     col.main = "#0098CD"
)
# agregamos el eje y
axis(2)

# Con las marcas por defecto:
par(mfrow = c(1,1))
x <- seq(-4, 4, length.out = 101)
y <- sin(x)
plot(x, y, type = "l",
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'El título',
     col.main = "#0098CD"
)

# Definiendo las marcas sobre el eje de abscisas:
plot(x, y, type = "l",
     xaxp=c(-4, 4, 8),
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'El título',
     col.main = "#0098CD"
)

# Definiendo las marcas sobre ambos ejes:
plot(x, y, type = "l",
     xaxp=c(-4, 4, 8),
     yaxp=c(-1, 1, 5),
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = 'El título',
     col.main = "#0098CD"
)

#Personalizar las marcas desde la función axis
# utilizando la función axis
plot(x, y, type = "l",
     axes = FALSE,
     ylab = expression(italic(sen) ~ '( ' * phi~')'),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = expression('Gráfico de la función'~italic(sen)~'('~phi~')'),
     col.main = "#0098CD"
)
# agregamos el eje x
axis(1, at = seq(-4, 4, length.out = 9))
# agregamos el eje y
axis(2, at = seq(-1, 1, length.out = 6))

#Eliminar etiquetas de las marcas de los ejes
# eliminar las marcas
par(mfrow = c(1,3))
plot(x, y,
     type = "l",
     xaxt = "n",
     ylab = expression(italic(sen) ~ "( " * phi ~ ")"),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = "Sin las marcas en eje X",
     col.main = "#0098CD"
)
plot(x, y,
     type = "l",
     yaxt = "n",
     ylab = expression(italic(sen) ~ "( " * phi ~ ")"),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = "Sin las marcas en eje Y",
     col.main = "#0098CD"
)
plot(x, y,
     type = "l",
     xaxt = "n",
     yaxt = "n",
     ylab = expression(italic(sen) ~ "( " * phi ~ ")"),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = "Sin las marcas en eje X e Y",
     col.main = "#0098CD"
)

#Cambiar etiquetas de las marcas de los ejes
par(mfrow = c(1,1))
plot(x, y,
     type = "l",
     xaxt = "n",
     yaxt = "n",
     ylab = expression(italic(sen) ~ "( " * phi ~ ")"),
     xlab = expression(paste("Angulo de fase ", phi)),
     main = "Perssonalizar las etiquetas de las marcas en los ejes",
     col.main = "#0098CD"
)
axis(1,
     at = c(-pi, -pi / 2, 0, pi / 2, pi),
     labels = expression(-pi, -pi / 2, 0, pi / 2, pi)
)
axis(2,
     at = c(-1, -0.5, 0, 0.5, 1),
     labels = c(-1, '', 0, '', 1)
)

#Modificar la fuente utilizada en los gráficos.
plot(x, y,
     type = "l",
     ylab = "Eje Y",
     xlab = "Eje X",
     main = "Título",
     sub = "Subtítulo",
     col.main = "#0098CD",
     col.sub = "#DB8100",
     col.lab = "#00566C",
     cex.axis = 0.8, # tamaño ticks en los ejes
     cex.lab = 1, # tamaño de las etiquetas de los ejes
     cex.main = 2, # tamaño texto del título
     cex.sub = 1.2, # tamaño del subtítulo
     font.main = 1, # Estilo de fuente del título
     font.sub = 2, # Estilo de fuente del subtítulo
     font.axis = 3, # Estilo de fuente en los ejes (ticks)
     font.lab = 4 # Estilo de fuente en los ejes (etiquetas)
)

#Cambiar el tipo y color de la caja exterior
par(mfrow = c(3, 3))
plot(x, y, type = "l", bty = "o", main = "Por defecto")
plot(x, y, type = "l", bty = "7", main = "bty = '7'")
plot(x, y, type = "l", bty = "L", main = "bty = 'L'")
plot(x, y, type = "l", bty = "U", main = "bty = 'U'")
plot(x, y, type = "l", bty = "C", main = "bty = 'C'")
plot(x, y, type = "l", bty = "n", main = "bty = 'n'")
plot(x, y, type = "l", bty = "o", fg = "#A5007B", main = "Color con fg")
plot(x, y, type = "l", bty = "n", main = "Caja con box")
box(which = "plot", col= "#A5007B")
plot(x, y, type = "l", bty = "n", main = "Caja con box")
box(which = "plot", col= "#A5007B")
box(which = "figure", col= "#007BA5", lwd = 2, lty = 3)
par(mfrow = c(1, 1))

#Función Lines - para añadir lineas a un gráfico
# Primero hacemos el gráfico de puntos (de dispersión)
set.seed(23)
x <- rnorm(50)
y <- 2*x +3 + rnorm(50)
par(pty="s")

plot(x, y,
     pch = 21,
     col = "#0098CD",
     bg = "#B3B3B3",
     cex = 1.2,
     bty = "n",
     xlim = c(-2,8),
     ylim = c(-2,8),
     xaxp = c(-4, 8, 6),
     yaxp = c(-4, 8, 6),
     main = 'Grafico de dispersión',
     cex.axis = 0.8,
     cex.main = 0.9,
     col.lab = "#00566C",
     las = 1
)

# añadimos la poligonal por los puntos
lines(x, y, col = "grey", lty = 2)

# añadimos la recta y = 2x + 3 utilizando la función lines
x <- seq(-2, 2, by = 0.1)
y = 2*x + 3
lines(x, y,
      col = "#EE9A00",
      lty = 2,
      lwd = 2
)

# Primero hacemos el gráfico de dispersión
set.seed(23)
x <- rnorm(50)
y <- 2*x +3 + rnorm(50)
par(pty="s")

plot(x, y,
     pch = 21,
     col = "#0098CD",
     bg = "#B3B3B3",
     cex = 1.2,
     bty = "n",
     xlim = c(-2,8),
     ylim = c(-2,8),
     xaxp = c(-4, 8, 6),
     yaxp = c(-4, 8, 6),
     main = 'Grafico de dispersión',
     cex.axis = 0.8,
     cex.main = 0.9,
     col.lab = "#00566C",
     las = 1
)

# añadimos la poligonal por los puntos
abline(
  a = 3,
  b = 2,
  col = "#EE9A00",
  lwd = 2,
  lty = 3
)

# Agregamos una vertical
abline(v = 3, col = "blue", lty = 2, lwd = 2)
# y una horizontal
abline(h = 3, col = "violetred2", lty = 2, lwd = 2)
# También podemos agregar una grilla
abline(h = -2:8, v = -2:8, col = "lightgray", lty = 3)


#Añadir la curva al grafico
# Primero creamos el gráfico
x <- sample(x = seq(-3, 3, 0.1), size = 10)
y <- dnorm(x)
plot(x, y,
     pch = 19,
     col = '#0098CD',
     ylim = c(0, 0.4),
     xlim = c(-3,3)
)
# Ahora añadimos la densidad de la normal estándar
curve(dnorm(x), col = 'darkgreen', lty = 2, add = TRUE)

#Función points - para añadir puntos a un gráfico
# Primero creamos el gráfico
x <- seq(-4, 4, length.out = 101)
y <- sin(x)
plot(x, y,
     type = "l",
     main = "Gráfico de la función seno",
     ylab = expression(italic(sen) ~ "( " * phi ~ ")"),
     xlab = expression(paste("Angulo de fase ", phi)),
     col.main = "#0098CD",
     bty = "n",
     xaxt = "n",
)

axis(1,
     at = c(-pi, -pi / 2, 0, pi / 2, pi),
     labels = expression(-pi, -pi / 2, 0, pi / 2, pi)
)
# Añadimos los puntos (0, 0) y (pi/2, 1)
points(
  x = c(0, pi/2),
  y = c(0, 1),
  pch = 19,
  col = "#DB8100",
  cex = 1.5
)

#Añadir texto a un gráfico
# Primero creamos el gráfico
plot(x, y,
     type = 'n',
     xaxt = "n",
     yaxt = "n",
     main = ""
)
#---------------
# Función mtext
#---------------
# Abajo centro
mtext("Abajo", side = 1)
# Izquierda centro
mtext("Izquierda", side = 2)
# Arriba centro
mtext("Arriba", side = 3)
# Derecha centro
mtext("Derecha", side = 4)
# Abajo izquierda
mtext("Abajo izquierda", side = 1, adj = 0)
# Abajo derecha
mtext("Abajo derecha", side = 1, adj = 1, cex = 0.7)
# Arriba izquierda
mtext("Arriba izquierda", side = 3, adj = 0, font = 3)
# Arriba derecha
mtext("Arriba derecha", side = 3, adj = 1, font = 2)
# Arriba, con separación especificando argumento line
mtext("Texto arriba", side = 3, line = 2.5)
# Izquierda arriba, con separación especificando argumento line
mtext("Arriba izquierda", side = 2, adj = 1, line = 2, col = 'blue', cex = 0.9)
# Derecha abajo, con separación especificando argumento line
mtext("Abajo derecha", side = 4, adj = 0, line = 1, font = 4, col = 'red')
# Derecha abajo, con separación especificando argumento line
mtext(expression(frac(pi,2)~'sen('~theta~')'), side = 4, adj = 1, line = 1, col = 'darkgreen', cex = 0.7)
#--------------
# Función text
#--------------
# Texto simple en las coordenadas indicadas
text(-2, 0.5, "texto simple")
points(-2, 0.5, col= '#0098CD', pch = 19)
text(-2, 0, "texto simple, adj = 0.5", adj = 0.5)
points(-2, 0, col= '#0098CD', pch = 19)
text(-2, -0.5, "texto simple, adj = 1", adj = 1)
points(-2, -0.5, col= '#0098CD', pch = 19)
text(-2, 1, "texto simple, adj = 0.8", adj = 0.8)
points(-2, 1, col= '#0098CD', pch = 19)
text(2, 1, "texto simple, pos = 1", pos = 1)
points(2, 1, col= '#0098CD', pch = 19)
text(2, 0.5, "texto simple, pos = 2", pos = 2)
points(2, 0.5, col= '#0098CD', pch = 19)
text(2, 0, "texto simple, pos = 3", pos = 3)
points(2, 0, col= '#0098CD', pch = 19)
text(2, -0.5, "texto simple, pos = 4", pos = 4)
points(2, -0.5, col= '#0098CD', pch = 19)
# Fórmula en las coordenadas indicadas
text(0, 0.5, expression(frac(alpha[1], 4)))
points(0, 0.5, col= '#0098CD', pch = 19)
text(0, 0, expression(frac(alpha[1], 4)~', adj = 0'), adj = 0)
points(0, 0, col= '#0098CD', pch = 19)
text(0, -0.5, expression(frac(alpha[1], 4)~', pos = 4'), pos = 4)
points(0, -0.5, col= '#0098CD', pch = 19)

#Añadir una leyenda al gráfico - función legend
color = c('#008FBF','#7EB433','#DB8100','#5A1560')
mus <- c(0,0,0,2)
sigmas <- c(0.5,1, 1.5, 1.5)
curve(dnorm(x, mus[1], sigmas[1]), main = expression(paste("Densidades para distintos valores de ", mu, " y ", sigma)), lwd=2,bty='L',
      xlim = c(-3,7),ylim=c(0,.8), xlab = '', ylab = 'f(x)', col = color[1],col.main="#1A0644",cex.axis=0.8,
      col.axis="#1A0644",cex=.75,las=1)
lines(c(mus[1],mus[1]),c(0,dnorm(mus[1],mus[1],sigmas[1])),lty=2,col='red')
for(j in 1:3){
  curve(dnorm(x, mus[j+1], sigmas[j+1]), main = '',xlab = '', ylab = '', col = color[j+1],lwd=2,add=TRUE)
  lines(c(mus[j+1],mus[j+1]),c(0,dnorm(mus[j+1],mus[j+1],sigmas[j+1])),lty=2,col='red')
}
leg <- sprintf("μ = %1d, σ = %.1f \n",mus, sigmas)
legend(
  4,0.85,
  legend = leg,
  lwd=2,
  lty=1,
  col=color,
  bty='n',
  cex=.8
)

##Constuir un histograma
library(readxl)
NutritionStudy <- read_excel("NutritionStudy.xlsx")
attach(NutritionStudy)
hist(Fiber)

#Modificar el aspecto del histograma
hist(Fiber,
     freq = FALSE,
     border = 'grey',
     col = '#E5F8FF',
     xlab = 'Fibras (gr/sem)',
     ylab = 'Densidad',
     labels = TRUE,
     ylim = c(0,0.1),
     main = 'Hstograma de la variable Fiber',
     cex.main = 0.9,
     font.main = 4,
     cex.lab = 0.9,
     cex.axis = 0.8,
     font.lab = 2,
     font.axis = 3,
     col.lab = 'gray27',
     col.axis = 'midnightblue'
)
lines(density(Fiber), col = 'red')

#Argumento breaks
par(mfrow = c(1, 3), mar = c(2.9,2.8,1,1), mgp = c(2,0.55,0), las = 0)
hist(Fiber, breaks = 2, freq = FALSE, main = "Pocas clases", ylab = "Densidad")
hist(Fiber, breaks = 50, freq = FALSE, main = "Demasiadas clases", ylab = "Densidad")
hist(Fiber, freq = FALSE, main = "Método de Sturges (por defecto)", ylab = "Densidad")
hist(Fiber, breaks = c(0,10,20,30,40), freq = FALSE, main = "Dando los puntos de corte", ylab = "Densidad")
hist(Fiber, breaks = 4, freq = FALSE, main = "Dando la cantidad de intervalos", ylab = "Densidad")
hist(Fiber, freq = FALSE, main = "Método de FD ", ylab = "Densidad")
par(mfrow = c(1, 1))

## boxplot
#una variable
boxplot(Fiber,
        col = "#E5F8FF",
        horizontal = FALSE,
        border="#1D6786",
        boxwex = 0.3,staplewex = 0.3, width=4,
        col.axis="#0A335D",
        cex.axis=0.8)
title("Fibras consumidas (g/sem)",adj = 0.4,line=1)

#más de una variable
boxplot(Fiber,
        Fat,
        col = "#E5F8FF",
        border = "#1D6786",
        names = c("Fibras", "Grasas")
        )
#diagramas de caja de una variable numérica segmentada por un factor
boxplot(Fiber ~ Sex,
        col = rainbow(2, alpha = 0.5),
        names = c("Mujeres", "Varones"),
        xlab = 'Sexo',
        ylab = "Fibras consumidas (g/sem)"
)

##Barplot - no tengo lo datos para hacer el ejercicio
tabla_abs <- table(Drive)
tabla_abs
tabla_prop <- prop.table(table(Drive))
tabla_prop

bp <- barplot(
  tabla_prop, # datos
  main = "Gráfico de barras", # título del gráfico
  xlab = "Tracción", # Etiqueta del eje X
  names.arg = c("Total", "Delantera", "Trasera"), # Etiquetas d las barras
  ylab = "Frecuencia relativa", # Etiqueta eje Y
  col = c("#C9A340", "#008FBF", "#F50A8BD4"), # Color para cada barra
  density = 50, angle = 45, # Densidad e inclinación de las líneas de sombreado de cada barras
  border = "white", # color del borde de las barras
  cex.names = 0.8
)
text(bp, 0, round(tabla_abs, 1), cex=0.9, pos=3) # agregamos texto con las frecuencias absolutas de cada barra

#Diagrama de barras apiladas con dos variables cualitativas
# Primero creamos las tablas de frecuencias
tabla2C <- table(Drive, Size) # absolutas
tabla2C_prop <- prop.table(tabla2C, 1) # relativas
color <- c("#C9A340", "#008FBF", "#F50A8BD4")
leyenda <- rownames(tabla2C_prop)
leyenda <- ifelse(leyenda == 'AWD', "Total", ifelse(leyenda == "FWD", "Delantera", "Trasera"))
barplot(
  tabla2C_prop,
  main = "Gráfico de barras apiladas",
  xlab = "Size",
  names.arg = c("Grande", "Mediano", "Pequeño"),
  col = color,
  density = 50, angle = 45,
  border = "white",
  cex.names = 0.8,
  legend.text = leyenda,
  args.legend = list(
    x = "topleft",
    bty = 'n',
    cex = 0.9,
    border = "white",
    density = 50,
    angle = 45
  )
)

#Diagrama de barras adosadas con dos variables cualitativas
barplot(
  tabla2C_prop,
  beside = TRUE,
  main = "Gráfico de barras adosadas",
  xlab = "Size",
  names.arg = c("Grande", "Mediano", "Pequeño"),
  col = color,
  density = 50, angle = 45,
  border = "white",
  cex.names = 0.8,
  legend.text = leyenda,
  args.legend = list(
    x = "topleft",
    bty = 'n',
    cex = 0.9,
    border = "white",
    density = 50,
    angle = 45
  )
)

###ggplot2
library(tidyverse)
library(ggplot2)

#mi primer gráfico con ggplot()
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG))

#geom_point() o gráficos de dispersión (scatter plots)
# Agregando una tercera variable - grafico base es el anterior
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG, colour = Type))

#Añadir una variable utilizando mapeo estético de tamaño (size)
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG, size = Type))

#Añadir una variable utilizando mapeo estético de forma (shape) y transparencia (alpha)
# estética de forma
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG, shape = Type))

# estética de transparencia
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG, alpha = Type))

# Cambiar estética manualmente
ggplot(data = Cars2020) +
  geom_point(mapping = aes(x = Weight, y = HwyMPG), shape = 21, colour = "#0098CD", fill = "#C1F5BF", size = 3)

##Objetos geométricos
#grafico con más de un geom
ggplot(data = Cars2020, aes(x = Weight, y = HwyMPG)) +
  geom_smooth(mapping = aes(linetype = Size, colour = Size)) +
  geom_point(mapping = aes(colour = Size))

#Estéticas globales vs locales
ggplot(data = Cars2020, aes(x = Weight, y = HwyMPG)) +
  geom_smooth(mapping = aes(linetype = Size)) +
  geom_point(mapping = aes(colour = Drive))

#Graficar capas con diferentes datos
ggplot(data = Cars2020, mapping = aes(x = Weight, y = HwyMPG)) +
  geom_point(data = filter(Cars2020, Drive == "FWD"), mapping = aes(colour = Size)) +
  geom_smooth(se = FALSE, colour = '#810BB8', size = 0.8, linetype = 2)

##geom_line() o gráficos de líneas
library(datos)
paises %>% filter(pais == "Argentina") %>%
  ggplot(aes(y = esperanza_de_vida, x = anio)) +
  geom_line()

#varias observaciones en un mismo punto.
paises %>% filter(continente == "Américas") %>%
  ggplot(aes(y = esperanza_de_vida, x = anio)) +
  geom_line()

#agrupar observaciones
# con la estética de color
paises %>% filter(continente == "Américas") %>%
  ggplot(aes(y = esperanza_de_vida, x = anio)) +
  geom_line(aes(colour = pais))

#con la estética de grupo
paises %>% filter(continente == "Américas") %>%
  ggplot(aes(y = esperanza_de_vida, x = anio)) +
  geom_line(aes(group = pais))

#Relación entre variables
paises %>%
  group_by(continente, anio) %>%
  summarise(esperanza_de_vida_media = mean(esperanza_de_vida)) %>%
  ggplot(aes(anio, esperanza_de_vida_media)) +
  geom_point()

paises %>%
  group_by(continente, anio) %>%
  summarise(esperanza_de_vida_media = mean(esperanza_de_vida)) %>%
  ggplot(aes(anio, esperanza_de_vida_media)) +
  geom_point(aes(colour = continente)) +
  geom_smooth(method = "lm", colour = '#67BF4C')

##geom_boxplot() o diagramas de caja y bigotes - no tengo los datos para hacer los gráficos
# diagrama de caja básico
ggplot(data = Cars2020, aes(y = Length)) +
  geom_boxplot()

# eliminamos los valores en el eje X
ggplot(data = Cars2020, aes(x = "", y = Length)) +
  geom_boxplot()

# Agregamos las barras horizontales en los bigotes
ggplot(data = Cars2020, aes(x = "", y = Length)) +
  stat_boxplot(geom = "errorbar", width = 0.15) +
  geom_boxplot()

#Personalización del diagrama de caja
ggplot(Cars2020, aes(x = "", y = Length)) +
  stat_boxplot(geom = "errorbar",
               width = 0.1,
               color = "#090D45") + # Color barras error
  geom_boxplot(fill = "#E0F2FC", # Color de relleno de la caja
               alpha = 0.5, # Transparencia
               color = "#090D45", # Color del borde de la caja
               outlier.colour = "#0098CD", # Color atípicos
               width = 0.2) # Ancho de la caja

#Agregar estadística a un gráfico
ggplot(Cars2020, aes(x='', Length)) +
  geom_boxplot(width = 0.2) +
  stat_summary(geom = "point", fun = "mean", colour = "red", size = 4)
ggplot(Cars2020, aes(x='', Length)) +
  geom_boxplot(width = 0.2) +
  geom_point(stat = "summary", fun = "mean", colour = "red", size = 4)

#Boxplot para una variable cuantitativa en función de otra cualitativa
ggplot(Cars2020, aes(x = Size, y = Length)) +
  stat_boxplot(geom = "errorbar",
               width = 0.1,
               color = "#090D45") + # Color barras error
  geom_boxplot(fill = "#E0F2FC", # Color de relleno de la caja
               color = "#090D45", # Color del borde de la caja
               outlier.colour = "#0098CD", # Color atípicos
               width = 0.4) +
  geom_point(stat = "summary", fun = "mean", colour = "red", size = 3) +
  scale_x_discrete(labels=c("Grande","Mediano", "Pequeño"))

##geom_histogram() o histograma
# histogramas
iz <- ggplot(Cars2020, aes(x = Length)) +
  geom_histogram(colour = "white", fill = "blue") +
  labs(x = "Longitud del vehículo", y = "Frecuencia Absoluta") +
  theme(axis.title = element_text(size = 10, face = "bold"))
der <- ggplot(Cars2020, aes(x = Length)) +
  geom_histogram(binwidth = 10, colour = "white", fill = "blue") +
  labs(x = "Longitud del vehículo", y = "Frecuencia Absoluta") +
  theme(axis.title = element_text(size = 10, face = "bold"))
# los disponemos en un arreglo de dos columas
library(ggpubr)
ggpubr::ggarrange(iz, der)

#histograma en escala de densidades
ggplot(Cars2020, aes(x = Length)) +
  geom_histogram(aes(y = ..density..), colour = "white", fill = "blue") +
  labs(x = "Longitud del vehículo", y = "Densidad")

#Histograma por grupo
ggplot(Cars2020, aes(x = Length, fill = Size)) +
  geom_histogram(binwidth = 10, colour = "white") +
  xlab("Longitud del vehículo") +
  ylab("Frecuencia")

# Histograma por grupo position = "identity"
ggplot(Cars2020, aes(x = Length, colour = Size, fill = Size)) +
  geom_histogram(binwidth = 10, alpha = 0.5, position = "identity") +
  labs(title = 'position = "identity"', x = "Longitud del vehículo", y = "Frecuencia") +
  theme(plot.title = element_text(color="#615E5E", size=11, face="bold.italic", hjust = 0.5))

# Histograma por grupo position = "dodge"
ggplot(Cars2020, aes(x = Length, colour = Size, fill = Size)) +
  geom_histogram(binwidth = 10, alpha = 0.5, position = "dodge") +
  xlab("Longitud del vehículo") +
  ylab("Frecuencia") +
  ggtitle(label = 'position = "dodge"') +
  theme(plot.title = element_text(color="#615E5E", size=11, face="bold.italic", hjust = 0.5))

#disponer el gráfico en forma de una matriz de gráficos por fila y columna
ggplot(Cars2020, aes(x = Length, fill = Size)) +
  geom_histogram(binwidth = 10, colour = "white") +
  xlab("Longitud del vehículo") +
  ylab("Frecuencia") +
  facet_wrap(~ Size, nrow = 1, labeller=labeller(Size = c(Large = "Grande", Midsized = "Mediano", Small = "Pequeño"))) +
  theme(legend.position="none",
        strip.text.x = element_text(size=8, angle=0))

##geom_bar() o diagrama de barras
# gráfico de barras con datos crudos
ggplot(Cars2020, aes(x = Drive)) +
  geom_bar()
# gráfico de barras con tabla de frecuencias
df_aux = data.frame(
  traccion = c("Delantera", "Trasera", "Total"),
  frecuencias = c(25, 5, 80))
ggplot(df_aux, aes(x = traccion, y = frecuencias)) +
  geom_bar(stat = "identity")

#Reordenar las barras con scale_x_discrete
ggplot(Cars2020, aes(x = Drive)) +
  geom_bar() +
  scale_x_discrete(
    limits = c("FWD", "RWD", "AWD"),
    labels = c(
      "FWD" = "Delantera",
      "RWD" = "Trasera",
      "AWD" = "Total"
    )
  )

#Argegar etiquetas o texto sobre las barras
# Etiqueta dentro de cada barra
ggplot(Cars2020, aes(x = factor(Drive, levels = c("FWD", "RWD", "AWD")))) +
  geom_bar() +
  geom_text(aes(label = ..count..),
            stat = "count",
            vjust = 1.5,
            colour = "white",
            size = 3) +
  labs(x="Tracción del vehículo", y="Número de autos")

# Etiqueta encima de cada barra
ggplot(Cars2020, aes(x = factor(Drive, levels = c("FWD", "RWD", "AWD")))) +
  geom_bar() +
  geom_text(aes(label = ..count..),
            stat = "count",
            vjust = -1,
            colour = "black",
            size = 3) +
  ylim(c(0, 85)) + # Incrementa los límites del eje Y si es necesario
  labs(x="Tracción del vehículo", y="Número de autos")

#Personalizando colores de las barras
ggplot(Cars2020, aes(x = Drive, fill = Drive)) +
  geom_bar() +
  scale_x_discrete(
    limits = c("FWD", "RWD", "AWD"),
    labels = c(
      "FWD" = "Delantera",
      "RWD" = "Trasera",
      "AWD" = "Total"
    )
  ) +
  scale_fill_manual(values = c("#0098CD", "#DB8100", "#CD0098"))

# O usar un vector con nombres donde los nombres son las categorías
ggplot(Cars2020, aes(x = Drive, fill = Drive)) +
  geom_bar() +
  scale_x_discrete(
    limits = c("FWD", "RWD", "AWD"),
    labels = c(
      "FWD" = "Delantera",
      "RWD" = "Trasera",
      "AWD" = "Total"
    )
  ) +
  scale_fill_manual(values = c("FWD" = "#DB8100", "RWD" = "#CD0098", "AWD" = "#0098CD"))

##Temas en {ggplot2}

