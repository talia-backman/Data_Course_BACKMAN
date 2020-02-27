library(tidyverse)
df <- read.delim("./Data/ITS_mapping.csv")

glimpse(df)
table(df$Ecosys_Type)

df2 <- df[df$Ecosys_Type %in% c("Aerial","Marine"),]
# Same way to do one above:
# df2 <- subset(df,"Ecosystem_Type" == "Aerial","Marine")
# df %>% filter(Ecosys_Type %in% c("Aerial","Marine"))     ###This one is the tidyverse version (most practical)

summary(df$Lat)
summary(df$Lat)[3]
summary(df$Lat)[c(3,5)]

jpeg("./Practice/badplot.jpg")
plot(df2$Lat,df2$Lon)
dev.off()

#Numeric to character
df$Ecosystem <- as.character(df$Ecosystem)
class(df$Ecosystem)
#Character to numeric
df$Ecosystem <- as.numeric(df$Ecosystem)
class(df$Ecosystem)

#Make a subset of marine vs terrestrial (Ecosys_Type)
#Number of samples in each, and mean Lat of each
df3 <- df %>% filter(Ecosys_Type %in% c("Marine","Terrestrial"))
summary(df3$Lat)[4]
summary(df3$Ecosys_Type)[2:3]
glimpse(df3)

mean(df$Lat)
df[is.na(df$Lat),] <- 0

#How Dr. Zahn did it..
df4 <- df[] %>% group_by(Ecosys_Type) %>% 
  summarize(NumberOfSamples = n(),
            Mean_Lat = mean(Lat)) %>%
  filter(Ecosys_Type %in% c("Marine","Terrestrial"))


#How Dr. Zahn did it in multiple steps..
marine <- df %>% filter(Ecosys_Type == "Marine")
terrestrial <- df %>% filter(Ecosys_Type == "Terrestrial")

a <- mean(marine$Lat)
mean(terrestrial$Lat)

b <- length(marine$Lat)
c <- mean(terrestrial$Lat)
d <- length(terrestrial$Lat)

dim(terrestrial)[1]

#Sticking it together in a dataframe
data.frame(MeanLat)
