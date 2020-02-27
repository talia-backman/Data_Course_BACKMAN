library(tidyverse)
library(ggimage)
library(png)
library(colorblindr)
library(colorspace)
library(RColorBrewer)
library(magick)
data("starwars")
starwars
packs <- c("png","grid")
lapply(packs, require, character.only = TRUE) 
img <- readPNG("./hamster.PNG")
g <- rasterGrob(img,interpolate=TRUE)

ggplot(starwars,aes(x=species,y=mass)) +
  annotation_custom(g) +
  geom_point() +
  ggimage::geom_image(aes(image="./Practice/talia2.png"),size =.1) +
  labs(x="SpEcIeS",y="mASS",title = "#HAMSTERLYFE",
       subtitle = "she protec she attack", caption = "brought to you by little grabbies",
       color="categories") +
  theme(axis.text.x = element_text(angle = 40,color = "Orange",size = 20),
        axis.title.y = element_text(angle = 12,color = "Brown",size = 20),
        axis.title.x = element_text(angle = 12,color = "Brown",size = 20),
        axis.ticks = element_line(size = 10,color = "Purple"),
        plot.background = element_rect(fill = "Yellow"),
        panel.background = element_rect(fill="Purple"),
        title = element_text(color="#d7de1b",size=20)) +
  ylim(NA, 200)
ggsave("./uGlYpLoT.png",dpi = 80)
