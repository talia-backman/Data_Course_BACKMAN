# Typical modeling workflow: ####

# Packages and example data
library(tidyverse)
library(modelr)
library(GGally)
library(lindia)
library(skimr)
library(patchwork)
library(caret)

# Data
data("mtcars")
data("iris")


# Get to know your data ####
mtcars %>% ggpairs()
iris %>% filter(Species == "setosa") %>% ggpairs()
iris %>% ggpairs(mapping = c("Species","Sepal.Length"))


# Build possible models ####

# lm() is linear model. There are LOTS of other model types
mod1 <- lm(data=iris, formula = Sepal.Length ~ Sepal.Width)
mod2 <- lm(data=iris, formula = Sepal.Length ~ Sepal.Width + Species)
mod3 <- lm(data=iris, formula = Sepal.Length ~ Sepal.Width * Species)



# Look at model summaries ####
summary(mod1)
summary(mod2)
summary(mod3)

# how to interpret results?
# Coefficients, P-values, Adjusted R-squared


# Look at model diagnostics ####
gg_diagnose(mod1)
gg_diagnose(mod2)
gg_diagnose(mod3)


# Compare models ####
anova(mod1, mod2) # different? #anova command in R do NOT do ANOVAs
anova(mod1, mod3)  # shows that model 1 and model 2 show different models (if the pvalue,0.05)
anova(mod2, mod3)  # mod2 and mod3 are not different.  mod1 & mod2 are, mod1 & mod3 are

# which has better line fit ?
mod1mse <- mean(residuals(mod1)^2)
mod2mse <- mean(residuals(mod2)^2)
mod3mse <- mean(residuals(mod3)^2)

mod1mse ; mod2mse ; mod3mse
# mod3 has the best fit line so we would use that model for our data

# Evaluate predictions ####
df_mod1 <- add_predictions(iris,mod1) # adds model prediction column using a single model
df_mod1 # the line above predicted Sepal.Length based on the Sepal.Width (that's what the pred column means)
formula(mod1)

allmods <- gather_predictions(iris, mod1,mod2,mod3) # add many models' predictions at once (tidy-style)
allmods
skim(allmods)
names(allmods)

# compare predictions to reality
p1 <- ggplot(df_mod1,aes(x=Sepal.Width,color=Species)) +
  geom_point(aes(y=Sepal.Length),alpha=.5,size=2) +
  geom_point(aes(y=pred),color="Black") + theme_bw()
p1

p1 + geom_segment(aes(y=Sepal.Length,xend=Sepal.Width,yend=pred),
                  linetype=2,color="Black",alpha=.5)

# look at plot of predictions for each model
# we can do this after using gather_predictions() with more than 1 model
ggplot(allmods,aes(x=Sepal.Width,color=Species)) +
  geom_point(aes(y=Sepal.Length),alpha=.25) +
  geom_point(aes(y=pred),color="Black") +
  facet_wrap(~model) +
  theme_bw()

# which model is best? <- mod2 and mod3 are about the same and are the best
# mod2 (+ species) only allowed the y intercept to change
# mod3 (* species) allowed the y intercept AND the slope to change
# each model is a fake version of reality.  It's using a simple equation to relate different factors


# Using mtcars #
skim(mtcars)
carsmod1 <- lm(data=mtcars, formula = mpg ~ wt + factor(cyl))
carsmod2 <- lm(data=mtcars, formula = mpg ~ wt * factor(cyl))

p1 <- add_predictions(mtcars,carsmod1) %>%
  ggplot(aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=mpg)) +
  geom_smooth(method = "lm",aes(y=pred)) +
  labs(title = "wt + cyl")

p2 <- add_predictions(mtcars,carsmod2) %>%
  ggplot(aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=mpg)) +
  geom_smooth(method = "lm",aes(y=pred)) +
  labs(title = "wt * cyl")

p1 / p2

# Cross-validation ####

# if we train our model on the full data set, it can become "over-trained"
# In other words, we want to make sure our model works for the SYSTEM, not just the data set

set.seed(123) # set reproducible random number seed, put any number in there 
set <- caret::createDataPartition(iris$Sepal.Length, p=.5) # pick random subset of data, p=.5 which means 50% of random points
set
set <- set$Resample1 # it saved as a dataframe for some good reason, I'm sure. convert to vector

train <- iris[set,] # subset iris using the random row numbers we made
test <- iris[-set,] # The other half of the iris dataset

# build our best iris model (mod3, from above)
formula(mod3)
mod3_cv <- lm(data=train, formula = formula(mod3))
summary(mod3_cv)
gg_diagnose(mod3_cv)

# Test trained model on unused other half of data set
iristest <- add_predictions(test,mod3_cv)

# plot it
ggplot(iristest,aes(x=Sepal.Width,color=Species)) +
  geom_point(aes(y=Sepal.Length),alpha=.25) +
  geom_point(aes(y=pred),shape=5)


# compare MSE from our over-fitted model to the cross-validated one
testedresiduals <- (iristest$pred - iristest$Sepal.Length)

mod3mse # our original MSE
mean(testedresiduals^2) # our cross-validated model.. 
# shows that model 3 doesn't make as great of predictions as we thought..
# if mod3mse < mean(testedresiduals^2), the model isn't as good as it seemed to be.

# Plot comparison of original and validated model 

# gather model predictions
df <- gather_predictions(iris, mod3,mod3_cv)

# plot - distinguish model predictions using "linetype"
ggplot(df, aes(x=Sepal.Width,color=Species)) +
  geom_point(aes(y=Sepal.Length),alpha=.2) +
  geom_smooth(method = "lm",aes(linetype=model,y=pred)) + theme_bw()

# If it still looks good, you can use the full model for future predictions ####


################################## Your turn ... ########################################

# Now, use this workflow to model miles per gallon in the mtcars dataset!
# Things to consider:
# What variables are explanatory? 
# What interaction terms are useful?
# What's the simplest model that has good explanatory power?

data("mtcars")
mtcars %>% ggpairs() # i will use disp and wt for my variables (based on cyl)

mod1.new <- lm(data=mtcars, formula = disp ~ wt)
mod2.new <- lm(data=mtcars, formula = disp ~ wt + cyl)
mod3.new <- lm(data=mtcars, formula = disp ~ wt * cyl)

summary(mod1.new) # also great pvalues!!
summary(mod2.new) # great pvalues!! 
summary(mod3.new) # pvalues aren't very good <- rule out 

gg_diagnose(mod1.new)
gg_diagnose(mod2.new)
gg_diagnose(mod3.new)

anova(mod1.new, mod2.new) # great pvalue: mod1.new and mod2.new are different
anova(mod1.new, mod3.new) # great pvalue, better than the one above so we will use this one
anova(mod2.new, mod3.new) # okay pvalue, mod2.new and mod3.new are not different

mod1mse.new <- mean(residuals(mod1.new)^2)
mod2mse.new <- mean(residuals(mod2.new)^2)
mod3mse.new <- mean(residuals(mod3.new)^2)

mod1mse.new ; mod2mse.new ; mod3mse.new

df_mod2.new <- add_predictions(mtcars,mod2.new) 
df_mod2.new 
formula(mod2.new)

allmods.new <- gather_predictions(mtcars, mod1.new,mod2.new,mod3.new) 
allmods.new
skim(allmods.new)
names(allmods.new)

p1.new <- ggplot(df_mod2.new,aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=disp),alpha=.5,size=2) +
  geom_point(aes(y=pred),color="Black") + theme_bw()
p1.new

p1.new + geom_segment(aes(y=disp,xend=wt,yend=pred),
                  linetype=2,color="Black",alpha=.5)

ggplot(allmods.new,aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=disp),alpha=.25) +
  geom_point(aes(y=pred),color="Black") +
  facet_wrap(~model) +
  theme_bw()

set.seed(123)
set.new <- caret::createDataPartition(mtcars$disp)
set.new <- set.new$Resample1

train <- mtcars[set,]
test <- mtcars[-set,]

formula(mod3.new)
trainedmodel <- lm(data=train, formula = formula(mod3.new))

add_predictions(test,mod3.new) %>%
  ggplot(aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=disp)) + geom_smooth(method = "lm",aes(y=pred))

testedresiduals.new <- (test$pred - test$disp)

df2 <- gather_predictions(mtcars, mod3.new,trainedmodel)


add_predictions(df2, mod3.new) %>%
  ggplot(mod3.new, aes(x=wt,color=factor(cyl))) +
  geom_point(aes(y=disp),alpha=.2) +
  geom_smooth(method = "lm",aes(linetype=model,y=pred)) + theme_bw()
