library(tidyverse)
#   1. load mtcars dataset
data("mtcars")
str(mtcars)
#2. subsets the mtcars dataframe to include only automatic transmissions 
df1 <- subset(mtcars,am == 0)
write.csv(df1,file = "./Assignments/Assignment_6/automatic_mtcars.csv")
png("./Assignments/Assignment_6/mpg_vs_hp_auto.png")
ggplot(df1,aes(x=hp,y=mpg)) +
  geom_point() + geom_smooth(method = "lm",color="purple") +
  labs(x="Gross Horsepower",y="Miles per Gallon",
       title = "Horsepower effect on Miles per Gallon",
       subtitle = "This graph is so useful!",
       caption = "T$")
dev.off()

tiff("./Assignments/Assignment_6/mpg_vs_wt_auto.tiff")
ggplot(df1,aes(x=wt,y=mpg)) +
  geom_point() + geom_smooth(method = "lm",color="purple") +
  labs(x="Weight",y="Miles per Gallon",
       title = "Weight effect on Miles per Gallon",
       subtitle = "This graph is so useful!",
       caption = "T$")
dev.off()

df2 <- subset(mtcars,disp <= 200)
write.csv(df2, file = "./Assignments/Assignment_6/mtcars_max200_disp.csv")

# 10. code that shows max hp for mtcars, df1, df2
max(mtcars$hp)
max(df1$hp)
max(df2$hp)

maxvals <- c(max(mtcars$hp),max(df1$hp),max(df2$hp))
names(maxvals) <- c("Original","Automatic","Max200")
maxvals
write.table(maxvals,file = "./Assignments/Assignment_6/hp_maximums.txt")
