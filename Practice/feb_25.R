library(tidyverse)
library(dplyr)
# load data
df1 <- read.csv("./Data/FacultySalaries_1995.csv")
df2 <- read.csv("./wide_income_rent.csv")
names(df1)
# clean the data
long <- gather(df1, key = Rank,value = Salary, 5:7) # or you can do: long <- gather(df1, key = Rank, value = Salary, c(5,7,9))
long$Rank[3000]
newranknames <- str_remove(long$Rank,c("Avg")) %>% str_remove("Salary")
newranknames[3000]
long$Rank <- newranknames
# make a plot
ggplot(long,aes(x=Rank, y= Salary, fill = Rank)) + geom_boxplot() +
  scale_fill_brewer(palette = 3)
# any scale_fill will change colors
# scale_fill_manual(values = c(pal.discrete))

# keep cleaning the data
names(long)
long2 <- gather(long, key= Rank, value = Compensation, 6:8)
long2$Rank
newranknames2 <- str_remove(long$Rank, c("Avg")) %>% str_remove("Salary")
long2$Rank <- newranknames2

# make a new plot but with Compensation
ggplot(long2,aes(x=Rank, y=Compensation, fill= Rank)) + geom_boxplot() 


#Now there is one more problem... 
long3 <- gather(long2,key = Type,value = Dollars,c(12,14))

#make a Dollars ggplot
ggplot(long3,aes(x=Rank,y=Dollars,fill=Rank)) + geom_boxplot() +
  facet_wrap(~Type)

# make a new plot
library(patchwork)
p1 <- ggplot(long2,aes(x=Rank,y=Compensation,fill=Rank)) + geom_boxplot() +
  theme(legend.position = "none")
p2 <- ggplot(long2,aes(x=Rank,y=Salary,fill=Rank)) + geom_boxplot()
p1 + p2

# onto the next dataset
df2
names(df2)
long4 <- gather(df2,key = State,value = Dollars,2:53) 
# can also do: long4 <- df2 %>% gather(key = State, value = Amount, 2:53)
# to rename a column: names(long4)[1] <- "Poop"
# longstate %>% filter(Poop =="income")
ggplot(long4,aes(x=State, y=Dollars)) + geom_point() + facet_grid(~variable) +
  theme(axis.text.x = element_text(angle = 70,size=6))
ggplot(long4,aes(x=State,y=Dollars,color=variable)) + geom_point() + theme_minimal() +
  theme(axis.text.x = element_text(angle=60,size=8)) 




