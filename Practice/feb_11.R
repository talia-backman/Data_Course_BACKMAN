library(tidyverse)
library(splines)

#load some data
data("iris")
data("mtcars")


#ggplot
# first argument is a data frame
names(iris)

# scatterplot, colored by species
ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width, color = Species)) +
  geom_point()

# bar chart, colored by species
ggplot(iris,aes(x = Sepal.Length,y= Sepal.Width, fill = Species)) +
  geom_bar(stat = "identity")

# bar chart showing mean of each species

iris %>% group_by(Species) %>%
  summarize(Mean = mean(Sepal.Length)) %>% 

ggplot(aes(x = Species,y = Mean, fill = Species)) +
  geom_col()


# another scatterplot (with three different ways of doing it)
# setosa and versicolor
# scatterplot: x= Sepal.Length, y= Sepal.Width, color= Species

spp <- c("setosa","versicolor")
iris %>% filter(Species %in% spp) %>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) + geom_point()


iris %>% filter(Species %in% c("setosa", "versicolor")) %>%
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) + geom_point()

# add geom_smooth() to show patterns.. grey shaded area shows error bars. 
# geom_smooth() shows y as a function of x (y~x)
    iris %>% filter(Species !="virginica") %>%
      ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) + 
      geom_point() + 
      geom_smooth(method = "lm")



# mtcars dataset
names(mtcars)

ggplot(mtcars,aes(x=gear,y=mpg)) +
  geom_col()

pal <- c("#346c8c","#d99be0","#a6584b")

ggplot(mtcars,aes(x=disp,y=mpg)) +
  geom_point(aes(color=factor(cyl)),size=3,shape=5) + 
  geom_smooth(method = "lm",color="purple",size=2,linetype=3,se=FALSE) +
  labs(x="Displacement in feet",y="Miles per Gallon",title="MPG ~ Displacement",subtitle = "STUFF",
       caption = "This is brought to you by the color purple",
       color="Cylinders") +
  scale_color_manual(values=pal) +
  theme_bw() +
  theme(plot.title = element_text(angle=60,hjust=1,face="italic",size=18))
  






