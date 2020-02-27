library(tidyverse)
library(ggimage)
library(png)
library(colorblindr)
library(colorspace)
library(RColorBrewer)
library(magick)
data("airquality")
airquality
?airquality
names(airquality)
packs <- c("png","grid")
lapply(packs, require, character.only = TRUE)
img <- readPNG("./Assignments/Ugly_plot/sun.png")
g <- rasterGrob(img,interpolate=TRUE)

ggplot(airquality,aes(x=Temp,y=Ozone)) +
  annotation_custom(g) +
  geom_point() +
  labs(title = "i DoNt BeLiEvE iN cLiMaTe ChAnGe", caption = "this plot is dedicated to my in-laws",
       subtitle = "So ThErEs NoThInG wE cAn Do AbOuT iT",x="temp", y="ozone") +
  ggimage::geom_image(aes(image= "./Assignments/Ugly_plot/evidence.png"),size=.1) +
  geom_smooth(method = "lm",color = "Purple")
