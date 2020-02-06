#load dataset
df <- read.csv("./Exam_1/DNA_Conc_by_Extraction_Date.csv")
#summary of data
summary(df)
library(tidyverse)
glimpse(df)
class(df$Year_Collected)
class(df$Extract.Code)
class(df$DNA_Concentration_Ben)
#histograms
jpeg("Katy_hist.jpeg")
hist(x=df$DNA_Concentration_Katy,main="Katy's Data",xlab="DNA Concentration")
dev.off()
jpeg("Ben_hist.jpeg")
hist(x=df$DNA_Concentration_Ben,main="Ben's Data",xlab="DNA Concentration")
dev.off()
#Look at DNA concentrations from the different extraction years & Save them
jpeg("BACKMAN_Plot1.jpeg")
boxplot(df$DNA_Concentration_Katy~df$Year_Collected,
        main="Katy's Extractions",xlab="YEAR",ylab="DNA Concentration")
dev.off()
jpeg("BACKMAN_Plot2.jpeg")
boxplot(df$DNA_Concentration_Ben~df$Year_Collected,
        main="Ben's Extractions",xlab="YEAR",ylab="DNA Concentration")
dev.off()
#Ben vs Katy's concentrations..
summary(df$DNA_Concentration_Katy)
summary(df$DNA_Concentration_Ben)
summary(df$Year_Collected)
plot(x=df$DNA_Concentration_Ben,y=df$Extract.Code)
plot(x=df$DNA_Concentration_Katy,y=df$Extract.Code)
#Which YEAR was Ben's performance the lowest RELATIVE to Katy's?
df$C <- (df$DNA_Concentration_Ben - df$DNA_Concentration_Katy)
min(df$C)
df$Year_Collected[df$C == min(df$C)]
#Answer= 2000

#Subset df to just "Downstairs Lab"
#####MAKE A SUBSET df3 <- df %>% filter(Ecosys_Type %in% c("Marine","Terrestrial"))
class(df$Date_Collected)
df$Date_Collected <- as.character(df$Date_Collected)
class(df$Date_Collected)

jpeg("Downstairs.jpeg")
plot(x=df$Date_Collected,y=df$DNA_Concentration_Ben,col=df$Lab,xlab="Date_Collected",ylab="DNA_Concentration_Ben")
dev.off()
