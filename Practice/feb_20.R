#analyze the tidy data
library(tidyverse)
#load the tidied data
dat <- read.csv("./long_and_tidy.csv")

# start playing with a new dataset
data("diamonds")
glimpse(diamonds)
?diamonds
ggplot(diamonds,aes(x=carat,y=price)) +
  geom_hex() + geom_smooth(method = "lm") +
  facet_wrap(~cut)

ggplot(diamonds,aes(x=carat,y=price)) +
  geom_hex(alpha=.25) + geom_smooth(method = "lm",aes(color=cut)) +
  coord_cartesian(ylim=c(0:20000)) 

ggplot(diamonds,aes(x=carat,y=price)) +
  geom_hex(alpha=.25) + geom_smooth(method = "lm",aes(color=clarity)) +
  coord_cartesian(ylim=c(0:20000)) +
  facet_wrap(~cut)
#the thing on the left should always be y-axis (AKA Dependent variable)
mod1 <- lm(data = diamonds,price~carat)
mod2 <- lm(data = diamonds,price~carat + clarity)
#how to look at statistical analysis
summary(mod1)
summary(mod2)

newdata1 <- data.frame(carat= c(2,2.1,2.2,2.3))
newdata2 <- data.frame(carat= c(2,2.1,2.2,2.3),
                      clarity = "I1")
predict(mod1,newdata = newdata1)
predict(mod2,newdata = newdata2)
