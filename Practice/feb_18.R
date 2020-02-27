library(tidyverse)
library(patchwork)
devtools::install_github("wilkelab/cowplot")
install.packages("colorspace", repos = "http://R-Forge.R-project.org")
devtools::install_github("clauswilke/colorblindr")
library(RColorBrewer)
library(colorspace)
library(colorblindr)

df <- mtcars
glimpse(df)

p1 <- ggplot(df,aes(x=disp,y=mpg,color=factor(cyl))) +
  geom_point()
ggsave("./testplot.pdf")
ggsave("./testplot.png")
ggsave("./testplot.tiff",dpi = 600,height = 4,width = 4)
p1
ggsave(filename = "./test1.png",plot= p1, device = "png")

p2 <- ggplot(df,aes(x=disp,y=mpg,color= cyl)) +
  geom_point() + geom_smooth(method = "lm",color = "purple")
p2
ggsave(filename = "./test2.png",plot= p2, device = "png")

#function below uses patchwork package
p1/p2
p1+p2
p2/p1

p3 <- ggplot(mtcars,aes(x=hp,y=mpg)) + geom_smooth()

(p1+p2)/p3
p1+p2+p3
p1/p2/p3
p1+p2/p3
ggsave("./multiplot.png")


pal1 <- c("#6d61e8","#63169e","#434d52")
pal <- brewer.pal(3,"Dark2") 
p1 <- ggplot(df,aes(x=disp,y=mpg,color=factor(cyl))) +
  geom_point()
p5 <- p1 + theme_bw() +
  labs(title="Miles per gallon vs. Displacement",
       x= "Engine Displacement",y="Miles per Gallon",
       color="Number of\ncylinders",
       subtitle = "sure, why not?",
       caption = "Brought to you by mtcars dataset") +
  scale_color_manual(values = pal)

p5 +
  theme(title = element_text(color = "Blue",
                             face = "italic"),
        panel.background = element_rect(fill = "Blue"),
        plot.background = element_rect(fill = "Red"),
        legend.background = element_rect(fill = "Purple"),
        panel.grid = element_line(size=2),
        legend.text = element_text(size = 20),
        axis.text.y = element_text(angle = 180),
        axis.title = element_text(angle = 180))

mod <- lm(data = mtcars,formula = mpg ~ disp)
summary(mod)
residuals(mod)
mtcars$resids <- residuals(mod)

mtcars <- mutate(mtcars,DIFF=mpg-resids)

ggplot(mtcars,aes(x=disp,y=mpg)) +
  geom_point() + geom_smooth(method = "lm",se=FALSE) +
  geom_segment(aes(x=disp,y=mpg,xend=disp,yend=DIFF))

ggplot(mtcars,aes(x=disp,y=mpg)) +
  geom_point() + geom_smooth(method = "lm",se=FALSE) +
  scale_x_log10()

ggplot(mtcars,aes(x=sqrt(disp),y=mpg)) +
  geom_point() + geom_smooth(method = "lm",se=FALSE) 

p4 <- p1+scale_x_reverse()
p4+theme_minimal()

#shows what color different blindness will look like with your plots
cvd_grid(p1)
palette_plot(pal)
palette_plot(brewer.pal(12,"Dark2"))


df <- read.csv("./Data/mushroom_growth.csv")
glimpse(df)

library(splines)

ggplot(df,aes(x=Nitrogen, y=GrowthRate,color=Light)) +
         geom_point() + geom_smooth(method = "lm",formula = y~poly(x,2)) + facet_wrap(~Species) +
  scale_color_gradient(low = "Blue",high = "Red") +
  theme(strip.text = element_text(face = "italic"))

mod2 <- lm(data = df,GrowthRate ~ poly(Nitrogen,2))
summary(mod2)
mod2

# once ggimage is installed you can do these next things..
# library(ggimage)
# ggimage::geom_image()
#mtcars$fn <- "./clown.jpeg"
# change geom_point() to geom_image() in your ggplot
# ggplot(mtcars,aes(x=sqrt(disp),y=mpg)) +
  # geom_image(aes(image = fn)) + geom_smooth(method = "lm", se=FALSE)

#geom_pokemon()
#list.pokemon()
#add it to say geom_pokemon(image="tauros")


  
