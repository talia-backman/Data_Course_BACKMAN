library(tidyverse)

# load some data
data("iris")

# subset
iris <- iris %>% filter(Species == "virginica")     #subset == Virginica
glimpse(iris)




# Plot Sepal.Length on y-axis; Petal.Length as x-axis
# Colored points in scatterplot by "Species"
plot(y=iris$Sepal.Length,x=iris$Petal.Length,col=iris$Species,xlab= "Petal Length", ylab= "Sepal Length",
     main= "Iris data",pch=20)



summary(iris)

# Boxplot of Sepal.Length as function of Species
plot(y=iris$Sepal.Length,x=iris$Species, main="Iris Data", ylab="Sepal Length", xlab= "Species")



hist(iris$Sepal.Length,breaks = 30)
plot(density(iris$Sepal.Length))

# how to save a plot
jpeg("densityplot.jpeg")
plot(density(iris$Sepal.Length))
dev.off()

