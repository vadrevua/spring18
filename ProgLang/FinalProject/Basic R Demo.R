#Math
2+2
5*2

#variables
a <- 10
b <- 5

#Arrays/Vectors
x <- c(1,9,3,4)

x[1]
x[2]

class(a)
class(x)



median(y = 0:10)
y

median(y <- 1:10)
y






#read CSV File
carData <- read.csv(file="C:/Users/Aditya/Desktop/cars.csv", header=TRUE, sep=";")

class(carData)
head(carData)
tail(carData)
names(carData)


carData$Car #by name
carData[1] #by column number

#histogram
hist(carData$MPG)
hist(carData$Horsepower, main = "Horsepower Distribution of Cars")

plot(x = carData$MPG, y = carData$Horsepower)

install.packages("ggplot2")
library(ggplot2)

#histogram
ggplot(carData, aes(x = MPG)) + geom_histogram(binwidth = 2)
#scatterplot
ggplot(carData, aes(y = Horsepower, x = MPG)) + geom_point() 

#scatterplot with names
ggplot(carData, aes(y = Horsepower, x = MPG)) + geom_point() + 
  geom_text(aes(label=Car), size = 3)


install.packages("dplyr")
library(dplyr)

sampleCars <- sample_n(carData,20)

ggplot(sampleCars, aes(y = Horsepower, x = MPG)) + geom_point() + 
  geom_text(aes(label=Car), size = 3)

install.packages("DT")
library(DT)

datatable(carData, options = list(pageLength = 10))

install.packages("metricsgraphics")
library(metricsgraphics)

mjs_plot(carData, x=MPG, y=Horsepower) %>%
  mjs_point(color_accessor=MPG, size_accessor=Horsepower) %>%
  mjs_labs(x="Cars MPG", y="Cars HP")

