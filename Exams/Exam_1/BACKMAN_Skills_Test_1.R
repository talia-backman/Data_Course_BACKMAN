#load dataset
df <- read.csv("./Exam_1/DNA_Conc_by_Extraction_Date.csv", stringsAsFactors = FALSE)
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
bensummary <- summary(df$DNA_Concentration_Ben)
katysummary <- summary(df$DNA_Concentration_Katy)
cbind(bensummary, katysummary)

#Which YEAR was Ben's performance the lowest RELATIVE to Katy's?
df$C <- (df$DNA_Concentration_Ben - df$DNA_Concentration_Katy)
min(df$C)
df$Year_Collected[df$C == min(df$C)]
#Answer= 2000

#Subset df to just "Downstairs Lab"
#####MAKE A SUBSET
library(tidyverse)
down <- df %>% filter(Lab == "Downstairs")
down$Date_Collected <- as.POSIXct(down$Date_Collected)

class(df$Date_Collected)
df$Date_Collected <- as.character(df$Date_Collected)
class(df$Date_Collected)

jpeg("Ben_DNA_over_time.jpeg")
plot(down$Date_Collected,down$DNA_Concentration_Ben,
     main= "Ben, Downstairs, by Date_Collected",
     xlab= "Date_Collected", ylab= "DNA_Concentration_Ben")
dev.off()

#BONUS: For Ben, Which year's extractions had the highest *average*
# DNA Concentration and what is it?

df2 <-df %>% 
  group_by(Year_Collected) %>%
  summarize(AVERAGE=mean(DNA_Concentration_Ben))
write.csv(df2, "./Exam_1/Ben_Average_Conc.csv")

max(df2$AVERAGE)
df2$Year_Collected[df2$AVERAGE == max(df2$AVERAGE)]
#Answer= 1.463386 is the highest average in 2007