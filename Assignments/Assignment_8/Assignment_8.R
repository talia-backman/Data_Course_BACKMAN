library(tidyverse)
library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
library(GGally)

data("mtcars")
glimpse(mtcars)


## trying out different models: MODEL 1
mod1 = lm(mpg ~ disp, data = mtcars)
summary(mod1)
# call = model I ran
# residuals = measures of how well your data fit the model
# coefficients = intercept, slope of best-fit line
plot(mtcars$mpg ~ mtcars$disp)
abline(mod1)
# on the line: the residuals are the average distance from 
# the best fit line for each point
# coefficient for displacement: slope

## MODEL 2
mod2 = lm(mpg ~ qsec, data = mtcars)
plot(mtcars$mpg ~ mtcars$qsec)
abline(mod2, col = "Blue")

## COMPARING THE 2 MODELS
mean(mod1$residuals^2)
mean(mod2$residuals^2)
# the second model sucks compared to the first model, so we will use mod1

## LOOKING AT ACTUAL VS PREDICTED VALUES
preds = add_predictions(mtcars, mod1)
preds[1:5,c(1,12)]
newdf = data.frame(disp = c(500,600,700,800,900))
predictions = predict(mod1, newdata = newdf)
plot(mtcars$mpg ~ mtcars$disp, xlim=c(0,1000), ylim=c(-10,50))
points(x=newdf$disp,y=predictions,col="Red")
abline(mod1)

df <- read.csv("./Data/mushroom_growth.csv")
ggpairs(df)
# MODEL 1
mod1 <- lm(GrowthRate ~ Temperature, data = df)


# MODEL 2
mod2 <- aov(GrowthRate ~ Humidity, data = df)
  









