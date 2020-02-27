library(tidyverse)
library(ggimage)
library(png)
library(colorblindr)
library(colorspace)
library(RColorBrewer)
library(magick)
df <- read.csv("./data.csv")
packs <- c("png","grid")
lapply(packs, require, character.only = TRUE)
img <- readPNG("./talia.png")
g <- rasterGrob(img,interpolate=TRUE)

ggplot(df,aes(x=column1,y=column2)) +
  annotation_custom(g) + geom_point() +
  ggimage::geom_image(aes(image="./anti.png"),size=.09) +
  labs(title = "i DoNt BeLiEvE iN cLiMaTe ChAnGe", caption = "this plot is dedicated to my in-laws\nXOXO",
       subtitle = "eSsEnTiAl OiLs CuReD mY cAnCeRrRrR...",x="column 1", y="column 2") +
  theme(plot.background = element_rect(fill = "Purple"),
        panel.background = element_rect(fill = "Purple"),
        axis.title.y = element_text(angle=180,color = "Purple2",size=60,face = "bold"),
        axis.title.x = element_text(angle = 180,color = "Purple2",size=60,face = "bold"),
        axis.text.x = element_text(angle=20,color= "Orange",size=10,face = "bold"),
        axis.text.y = element_text(angle=20,color = "Red",size=100,face = "bold"),
        title = element_text(color = "Plum",size=20)) +
  scale_x_continuous(labels = scales::number_format(accuracy = 0.0000000000000000000000000000000000000000000000000001)) +
  ylim(NA, 20)
ggsave("./ugly_plot4.png",dpi=80, width = 50,height = 9, limitsize = FALSE)  
    