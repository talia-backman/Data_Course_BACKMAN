library(tidyverse)
library(readxl)
library(ggimage)
#load an excel sheet in R
dat <- read_xlsx("./Data/wide_data_example.xlsx")
# how to tell it what sheet to use:
# read_xlsx("./Desktop/excelfile.xlsx",sheet = 2)
names(dat)
#find and destry the "?"
dat$`Treatment 1`[dat$`Treatment 1` == "?"] <- NA
#convert treatment 1 to numeric
dat$`Treatment 1` <- as.numeric(dat$`Treatment 1`)
#create a graph with the "dat" data
ggplot(dat,aes(x=`Treatment 1`,y=`Treatment 2`)) + 
  geom_point()
#it is messy and not really valuable so we will keep tidying..
#clean up column names
names(dat) <- c("SampleID","Treatment1","Treatment2")
#tidy it to "long format" AKA one variable per column 
long <- gather(dat,key = "Watering",value = "Height",2:3)
#create a plot that makes sense
long$Watering <- str_replace(long$Watering, "Treatment","")
ggplot(long,aes(x=SampleID,y=Height,color=Watering)) + geom_boxplot()
#save the new, clean dataframe
write.csv(long,"./long_and_tidy.csv",row.names = FALSE)

