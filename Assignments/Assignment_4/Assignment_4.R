?read.csv
library(tidyverse)
df <- read.delim("./Data/ITS_mapping.csv",sep="")
df <- read.delim("./Data/ITS_mapping.csv")
#Learn how to load files into R no matter what they are separated by (For the exam)
summary(df)
glimpse(df)

apply(df,2,table)

table(df$Ecosystem)

png(filename = "./Assignments/Assignment_4/silly_boxplot.png")
plot(x=df$Ecosystem,y=df$Lat)
dev.off()