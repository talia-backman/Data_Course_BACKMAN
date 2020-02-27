#LOGICAL OPERATIONS
data("mtcars")
head(mtcars)
# Exercise 1
df1 <- subset(mtcars, mpg > 15 & mpg < 20)
# Exercise 2
df2 <- subset(mtcars, cyl == 6 & am >=1)
# Exercise 3
names(mtcars)
?mtcars
df3 <- subset(mtcars, carb == 4 | gear ==4 )
# Exercise 4
df4 <- subset(mtcars,)
# HELP on 4!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Exercise 5
# HELP on 5   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Exercise 6
df6 <- subset(mtcars, vs != 0 & am != 0)
# Exercise 7
(TRUE + TRUE) *FALSE #This expression equals zero because true=1, false=0
# Exercise 8
df8 <- subset(mtcars, vs != 0 | am != 0)
#HOW DO I NOT USE != ......
# Exercise 9
# | means: Or, binary, vectorized (will give the entire list that represents that item)
# || means: Or, binary, not vectorized (will give only the first thing that represents that item)
# & means: And, binary, vectorized (will give the entire list that represents that item)
# && means: And, binary, not vectorized (will give only the first thing that represents that item)
# Exercise 10
# Exercise 11
# Exercise 12

#GGPLOT_INTRO
library(tidyverse)
data("midwest", package = "ggplot2")
ggplot(midwest) # what do you see?
ggplot(midwest, aes(x=area, y=poptotal))
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() 
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method = "lm")
p <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method = "lm")
p + lims(x=c(0,0.1),y=c(0,1000000)) # what did this do?
p + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) # how is this different?
p2 <- p + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))
p2 + labs(title="Area Vs Population", 
          subtitle="From midwest dataset", 
          y="Population", 
          x="Area", 
          caption="Midwest Demographics")
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(color="steelblue",size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
p3 <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(color=state),size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
p3
p3 + scale_color_brewer(palette = "Set1")
library(RColorBrewer)
brewer.pal.info
library(colorspace)
library(colorblindr)
pal = c("#c4a113","#c1593c","#643d91","#820616","#477887","#688e52",
        "#12aa91","#705f36","#8997b2","#753c2b","#3c3e44","#b3bf2d",
        "#82b2a4","#894e7d","#a17fc1","#262a8e","#abb5b5","#000000")
palette_plot(pal)
cvd_grid(palette_plot(pal))
p3 + scale_color_manual(values=pal)
p3 + scale_x_reverse()
p3 + theme_minimal()
p3 + theme_dark()
p4 = ggplot(midwest, aes(x=area/max(midwest$area), y=log10(poptotal))) + 
  geom_point(aes(color=state),size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", color = "State",
       y="log10 Population", x="Area (proportion of max)", caption="Midwest Demographics") +
  theme_minimal() +
  scale_color_manual(values=pal)

p4
p4 + facet_wrap(~ state)
p4 + facet_wrap(~ state, scales = "free") + theme(legend.position = "none")
p4 + facet_wrap(~ state) + theme(legend.position = "none", strip.text.x = element_text(size = 12, face="bold"))
p4 + facet_wrap(~ state) + theme(legend.position = "none", 
                                 strip.text.x = element_text(size = 12, face="bold"),
                                 strip.background = element_rect(fill = "lightblue"))
p5 = ggplot(midwest, aes(x=state,y=percollege, fill=state)) + labs(x="State",y="Percent with college degree")
p5
p5 + geom_boxplot()
p5 + geom_violin()
p5 + geom_bar(stat="identity") # something wrong with this picture!
library(carData)
data("MplsStops")

ggplot(MplsStops, aes(x=lat)) + geom_histogram() + labs(title = "Latitude of police stops in Minneapolis - 2017")
ggplot(MplsStops, aes(x=lat, fill = race)) + geom_density(alpha = .5) + labs(title = "Latitude of police stops in Minneapolis - 2017")


ggplot(MplsStops, aes(x=lat, fill = race)) + geom_histogram() + labs(title = "Latitude of police stops in Minneapolis - 2017") +
  facet_wrap(~race)
ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point() + theme_minimal()

ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point() + theme_minimal() + facet_wrap(~race) # "overplotting!?"


ggplot(MplsStops,)

  # Check out the issue with some random data
random_data = data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 11, 4.5) )

# quick look at data
plot(random_data$x)

# Basic scatterplot
ggplot(random_data, aes(x=x, y=y) ) +
  geom_point()

# 2D Density plot, instead
ggplot(random_data, aes(x=x, y=y) ) +
  geom_bin2d() +
  theme_bw()


# Back to our over-plotted figure from before...
ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point(alpha=.05) + theme_minimal() + facet_wrap(~race)

ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_density_2d() + theme_minimal() + facet_wrap(~race)

ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d()

ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d() + facet_wrap(~race)


# try faceting by month
MplsStops$Month <- months(MplsStops$date)
(MplsStops$date)

ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d() + facet_wrap(~Month)

library(gganimate)
library(gifski)
ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d() +
  labs(title = "Month: {frame_state}") +
  transition_time(date) +
  ease_aes('linear')


gganimate::
  # More advanced understanding of R functions will be required to replicate the following section, but it
  # is included as an example follow-up analysis
  
  # Plot using two related data sets
  data("MplsDemo") # demographic info by neighborhood can be joined to our police stop dataset

# don't worry about this yet...you'll learn how to do this soon, but I'm just adding mean neighborhood income
# to each row of the police stop data set
income = as.numeric(as.character(plyr::mapvalues(MplsStops$neighborhood, from=MplsDemo$neighborhood, to = MplsDemo$hhIncome)))
MplsStops$income <- income


ggplot(MplsStops, aes(x=lat,y=long,color=income)) + geom_point(alpha=.2)

ggplot(MplsStops, aes(x=income)) + geom_histogram(bins = 30)


counts = as.data.frame(table(MplsStops$income))
counts$Var1 <- as.numeric(as.character(counts$Var1))
mod1 = lm(Freq ~ Var1, data = counts)

ggplot(counts, aes(x=Var1,y=Freq)) + geom_point() + geom_smooth(method="lm") +
  labs(x="Mean neighborhood income",y="Numer of police stops",title = "Police stop counts in each neighborhood",
       subtitle = paste0("Adjusted R-sq. value = ",signif(summary(mod1)$adj.r.squared),3)) + 
  theme_minimal()


# OUT OF ORDER CO2 PLOT
library(tidyverse)
data("CO2")
names(CO2)
means <- CO2 %>% group_by(Type,Treatment, conc, uptake) %>%
  summarise(MeanUptake = mean(uptake))
ggplot(means,aes(x=conc,y=uptake,color=Treatment)) +
  geom_point() +
  facet_grid(~Type)

# DATA FRAME SUBSETS OUT OF ORDER
df1.1 <- data.frame(Species = rep(c("Cat","Dog","Mouse"),each=10),
                 Length = 5+rnorm(30),
                 Width = 10 + rnorm(30))
df



#