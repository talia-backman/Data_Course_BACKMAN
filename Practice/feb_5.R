getwd()
df <- read.csv("./Data/Bird_Measurements.csv")
summary(df)
library(tidyverse)
glimpse(df)

plot(x=df$Species_name,y=df$Egg_mass)
plot(x=df$M_mass_N,y=df$Egg_mass)
plot(x=df$English_name,y=df$M_mass)
plot(x=df$Mating_System,y=df$Egg_mass,pch=19,col=df$English_name,ylab=Egg_mass,xlab=Mating_System)
plot(x=df$Mating_System,y=df$Egg_mass,pch=19,col=df$English_name,main="Pretty",xlab="Mating_System",ylab="Egg_Mass")

jpeg("cool_plot.jpeg")
plot(x=df$Mating_System,y=df$Egg_mass,pch=19,col=df$English_name,main="Pretty",xlab="Mating_System",ylab="Egg_Mass")
dev.off()

  