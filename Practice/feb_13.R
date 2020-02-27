library(carData)
library(tidyverse)
library(skimr)
library(plotly)

options(scipen = 999)

?MplsStops
df <- MplsStops
df2 <- MplsDemo

skim(df)
skim(df2)

#identify dependent and independent variables of interest
 
ggplot(df,aes(x=race)) +
  geom_histogram(stat = "count")

ggplot(df,aes(x=lat,y=long,color=race)) +
  geom_point(alpha=0.1)

names(df)
names(df2)
# both have the column neighborhood in common
# so we are going to combine demographic info with stop info...
df3 <- full_join(df,df2,by="neighborhood")

ggplot(df3,aes(x=lat,y=long,color=black,size=collegeGrad)) +
  geom_point(alpha=.1)

ggplotly()

ggplot(df3,aes(x=lat,y=long,color=race)) +
  geom_density_2d(linemitre = 20)

ggplot(df3,aes(x=lat,y=long,fill=race)) +
  geom_hex(alpha=.5)

ggplot(df2,aes(x=white,y=collegeGrad,size=hhIncome)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(df2,aes(x=black,y=collegeGrad,size=hhIncome)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(df2,aes(x=foreignBorn,y=collegeGrad)) +
  geom_smooth(method = "lm",color = "black") +
  geom_point(aes(size=hhIncome),color="purple",alpha=.5) +
  labs(x="% Foreign-Born Residents",y= "% College Graduates",title = "How likely you are to graduate college",
       subtitle = "based on neighborhood and race", size= "Income",
       caption = "This graph was brought to you by T$") +
  theme(plot.title = element_text(hjust=1,face="italic",size=18)) +
  theme_minimal()

df4 <- carData::Friendly
?Friendly
ggplot(df4,aes(x=condition,y=correct,fill=condition)) +
  geom_violin() + geom_jitter(height = 0)
#geom_jitter helps reduce noise and overplotting

ggplot(df4,aes(x=condition,y=correct,fill=condition)) +
  geom_boxplot(alpha=.25) + geom_point(alpha=1) +theme_minimal()

# combine violin and boxplot
ggplot(df4,aes(x=condition,y=correct,fill=condition)) +
  geom_violin() + geom_jitter(height = 0) +
  geom_boxplot(alpha=.25) +theme_minimal()

df5 <- carData::Chile
carData::Chile
skim(df5)
plot(df5$statusquo)

ggplot(df5,aes(x=sex,y=income)) +
  geom_violin()

df5 %>% 
  filter(vote %in% c("N","Y")) %>%
ggplot(aes(x=statusquo,y=income,color=vote)) +
  geom_point()

df5 %>% 
  filter(vote %in% c("N","Y")) %>%
  ggplot(aes(x=statusquo,y=age,color=vote,alpha=.5)) +
  geom_point() + 
  facet_wrap(~education) +
  theme_minimal()

df5 %>% 
  filter(vote %in% c("N","Y")) %>%
  ggplot(aes(x=statusquo,y=education,color=vote)) +
  geom_point()

df5 %>% 
  filter(vote %in% c("N","Y")) %>%
  ggplot(aes(x=statusquo,y=region,color=vote)) +
  geom_point()

ggplot(df5,aes(x=age,y=statusquo)) +
  geom_smooth(method = "lm") + geom_point()

ggplot(df5,aes(x=statusquo,fill=sex)) +
  geom_density(alpha=.3) + facet_wrap(~region)

ggplot(df5,aes(x=income,fill=sex)) +
  geom_density(alpha=.3) + facet_wrap(~region)

ggplot(df5,aes(x=income,y=statusquo)) +
  geom_smooth(method = "lm") + geom_point()

pal <- c("#14438f","#145717")
p <- ggplot(df5,aes(x=statusquo,fill=sex)) +
  geom_density(alpha=.5) + facet_wrap(~region) + theme_minimal() +
  labs(x= "Status Quo Score",y="Density",fill="Sex") +
  scale_fill_discrete(name = "Sex", labels = c("Female", "Male")) +
  scale_fill_manual(values = pal2)

library(RColorBrewer)
pal2 <- RColorBrewer:: brewer.pal(name = "Spectral",n=5)
?brewer.pal












