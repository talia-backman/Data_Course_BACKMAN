library(tidyverse)

# Task 1
landdata <- read.csv("./Exam_2/landdata-states.csv")
names(landdata)
names(landdata)[names(landdata) == "region"] <- "Region"
options(scipen = 999)
ggplot(landdata,aes(x=Year,y=Land.Value, color=Region)) +
  geom_smooth() +
  labs(y= "Land Value (USD") 
ggsave("./BACKMAN_Fig_1.jpg")
  
# Task 2
sum(is.na(landdata$Region))
which(is.na(landdata$Region))
landdata$State[(is.na(landdata$Region))]
#REAL CODE.. I didn't get :(:
landdata[which(is.na(landdata$Region)), "State"] %>% 
  unique()
#use unique values

# Task 3
unicef <- read.csv("./Exam_2/unicef-u5mr.csv")
names(unicef)
ncol(unicef)
long <- gather(unicef,key= Year, value= Child.Mortality, 2:67)
newnames <- str_remove(long$Year,c("U5MR."))
long$Year <- newnames
ggplot(long,aes(x=Year,y=Child.Mortality)) + 
  geom_point(aes(color=Continent),size=3) + theme_minimal() +
  labs(y="MortalityRate") +
  scale_x_discrete(breaks = c("1960","1980","2000"))
ggsave("./BACKMAN_Fig_2.jpg")

# Task 4
long2 <- long %>%
  group_by(Continent,Year) %>%
  summarise(Average = mean(Child.Mortality, na.rm = TRUE))
ggplot(long2,aes(x=Year, y=Average)) +
  geom_line(aes(group= Continent, color= Continent),size=3) + theme_minimal() +
  scale_x_discrete(breaks = c("1960","1980","2000")) +
  labs(y= "Mean Mortality Rate (deaths per 1000 live births)")
ggsave("./BACKMAN_Fig_3.jpg")

# Task 5
proportions <- long$Child.Mortality/1000
long3 <- cbind(long,proportions)
ggplot(long,aes(x=Year,y=proportions)) +
  geom_point(color = "blue",alpha=.5) +
  facet_wrap(~Region) +
  labs(y= "Mortality Rate") +
  scale_x_discrete(breaks = c("1960","1980","2000")) +
  theme_minimal() +
  theme(strip.background = element_rect(size = 1))
ggsave("./BACKMAN_Fig_4.jpg", height = 15, width = 15)
