library(tidyverse)
library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
library(GGally)

# At last, your assignment!

#+ Make a new Rproj and Rscript in your personal Assignment_7 directory and work from there.
#+ Write a script that:
#1.  loads the "/Data/mushroom_growth.csv" data set
#2.  creates several plots exploring relationships between the response and predictors
#3.  defines at least 2 models that explain the **dependent variable "GrowthRate"**
  #+ One must be a lm() and 
#+ one must be an aov()
#4.  calculates the mean sq. error of each model
#5.  selects the best model you tried
#6.  adds predictions based on new values for the independent variables used in your model
#7.  plots these predictions alongside the real data
#+ Upload responses to the following as a numbered plaintext document to Canvas:
#  1.  Are any of your predicted response values from your best model scientifically meaningless? Explain.
#2.  In your plots, did you find any non-linear relationships?  If so, do a bit of research online and give a link to at least one resource explaining how to deal with this in R

#1. load data
df <- read.csv("./Data/mushroom_growth.csv")
glimpse(df)
ggpairs(df)

mod1 <- lm(GrowthRate ~ Humidity * Species, data = df)
mod2 <- aov(GrowthRate ~ Nitrogen * Species, data = df)


plot(df$GrowthRate ~ df$Humidity)
plot(df$GrowthRate ~ df$Nitrogen)
abline(mod1, col= "Blue")
abline(mod2, col= "Blue")

summary(mod1) ; summary(mod2) ; summary(mod3) ; summary(mod4)

#I like mod1's pvalue the most

# mean square error
mean(residuals(mod1)^2) #6249.059
mean(residuals(mod2)^2) #9130.487
# the better model is mod1 because it's the lower number 

# add predictions
pred <- add_predictions(data = df,model = mod1)
glimpse(pred)
plot(df$GrowthRate ~ df$Humidity)

df2 <- add_predictions(data = df, model = mod1)

### plot real data against predicted data 

ggplot(pred, aes(x=as.factor(Humidity), y=GrowthRate)) +
  geom_point() + facet_wrap(~Humidity) + geom_point(aes(y=pred), color = "Blue") +
  labs(title = "Growth Rate as a Function and Humidity", y="Growth Rate", x="Humidity")


#1.  Are any of your predicted response values from your best model scientifically meaningless? Explain.
# Yes because the model is too perfect in a sense.  Models that are too perfect are not good at predicting reality. 

#2.  In your plots, did you find any non-linear relationships?  If so, do a bit of research online and give a link to at least one resource explaining how to deal with this in R
# Yes some plots did. We can make the analysis better by using polynomial regressions. 

# https://datascienceplus.com/fitting-polynomial-regression-r/


