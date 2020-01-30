# Assignment Week 3
library(skimr)



# topics:   type conversions, factors, plot(), making a data frame from "scratch",
#           reordering, 


# vector operations!
library(tidyverse)
vector1 = c(1,2,3,4,5,6,7,8,9,10)
vector2 = c(5,6,7,8,4,3,2,1,3,10)

vector1*vector2

list.files()
getwd()
?read.csv()

dat = read.csv("./Data/thatch_ant.csv")
names(dat)

#why are these plots different??? 
# The first shows a scatterplot of xlab=Headwidth..mm. ylab=Mass. It is also using numbers.
# The second plot shows box plots of xlab=Size.class and ylab=mass. This one is using factors.
plot(x=dat$Headwidth..mm., y=dat$Mass)
plot(x=dat$Size.class, y=dat$Mass)


#check the classes of these vectors
# First= numeric, second= factor
class(dat$Headwidth..mm.)
class(dat$Size.class)

# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat)

# Two of them are "Factor" ....why is the column "Headwidth" a factor? It looks numeric!

# we can try to coerce one format into another with a family of functions
# as.factor, as.matrix, as.data.frame, as.numeric, as.character, as.POSIXct, etc....

#make a numeric vector to play with:
nums = c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9)
class(nums) # make sure it's numeric

# convert to a factor
as.factor(nums) # show in console
nums_factor = as.factor(nums) #assign it to a new object as a factor
class(nums_factor) # check it

#check it out
plot(nums) 
plot(nums_factor)
# take note of how numeric vectors and factors behave differently in plot()

# Let's modify and save these plots. Why not!?
?plot()
plot(nums, main = "My Title", xlab = "My axis label", ylab = "My other axis label")

getwd()

### can't get it to save to my folder, got it to save by Zahn's folder but it wouldn't open..
jpeg("Plot1.jpeg")
plot(nums, main = "My Title", xlab = "My axis label", ylab = "My other axis label")
dev.off()



# back to our ant data...
dat$Headwidth
levels(dat$Headwidth) # levels gives all the "options" of a factor you feed it


# I notice a couple weird ones in there: "" and "41mm"
# The "" means a missing value, basically. The "41mm" sure looks like a data entry error.
# It should probably be "41.000"

# FIND WHICH ONES HAVE "41mm"

dat$Headwidth=="41mm"

# CONVERT THOSE TO "41.000"
dat$Headwidth[dat$Headwidth=="41mm"] <- "41.000"


# DO THE SAME FOR "", BUT CONVERT THOSE TO "NA"

dat$Headwidth
dat$Headwidth == ""
dat$Headwidth[dat$Headwidth == ""] <- NA


# NOW, REMOVE ALL THE ROWS OF "dat" THAT HAVE AN "NA" VALUE
dat <- na.omit(dat)

# NOW, CONVERT THAT PESKY "Headwidth" COLUMN INTO A NUMERIC VECTOR WITHIN "dat"
str(dat)
glimpse(dat)
dat$Headwidth <- factor(dat$Headwidth, levels = unique(dat$Headwidth))
#two ways of doing the same thing:
dat$Headwidth <- as.numeric(as.character(dat$Headwidth))
dat$Headwidth %>% as.character() %>% as.numeric()
dat$Headwidth <- dat$Headwidth %>% as.character() %>% as.numeric()
dat$Headwidth
skim(dat)
str(dat)

p <- plot(dat$Headwidth,dat$Mass)
p <- ggplot(dat,aes(x=Headwidth,y=Mass)) +geom_point()


# LET'S LEARN HOW TO MAKE A DATA FRAME FROM SCRATCH... WE JUST FEED IT VECTORS WITH NAMES!

# make some vectors *of equal length* (or you can pull these from existing vectors)
col1 = c("hat", "tie", "shoes", "bandana")
col2 = c(1,2,3,4)
col3 = factor(c(1,2,3,4)) # see how we can designate something as a factor             

# here's the data frame command:
data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # colname = vector, colname = vector....
df1 = data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # assign to df1
df1 # look at it...note column names are what we gave it.



# Make a data frame from the first 20 rows of the ant data that only has "Colony" and "Mass"
# save it into an object called "dat3"

cols = c("Colony","Mass")
dat3 <- dat[1:20,cols]




###### WRITING OUT FILES FROM R #######
?write.csv()


# Write your new object "dat3" to a file named "LASTNAME_first_file.csv" in your PERSONAL git repository
write.csv(dat3, "Assignments/Assignment_3/BACKMAN_first_file.csv")

summary(dat$Mass)
plot(y=dat$Mass,x=dat$Size.class)

under30_mass <- dat %>% filter(Size.class == "<30") %>%
  select(Mass)
mean(under30_mass$Mass)
under30_mass <- dat %>% filter(Size.class == "30-34") %>%
  select(Mass)
mean(under30_mass$Mass)


### for loops in R ###

#simplest example:
for(i in 1:10){
  print(i)
}
for(i in 1:10){
  print(i+10)
}

#another easy one
for(i in levels(dat$Size.class)){
  print(i)
}

# can calculate something for each value of i ...can use to subset to groups of interest
#shows where mean bars are on graph..
for(i in levels(dat$Size.class)){
  print(mean(dat[dat$Size.class == i,"Mass"]))
}

# more complex:
# define a new vector or data frame outside the for loop first
new_vector = c() # it's empty
# also define a counter
x = 1

for(i in levels(dat$Size.class)){
  new_vector[x] = mean(dat[dat$Size.class == i,"Mass"])
  x = x+1 # add 1 to the counter (this will change the element of new_vector we access each loop)
}

#check it
new_vector



# PUT THIS TOGETHER WITH THE LEVELS OF OUR FACTOR SO WE HAVE A NEW DATA FRAME:
# FIRST COLUMN WILL BE THE FACTOR LEVELS....
# SECOND COLUMN WILL BE NAMED "MEAN" AND WILL BE VALUES FROM  new_vector

#fill it in
size_class_mean_mass = data.frame(Size_Class = levels(dat$Size.class),
                                  MEAN = new_vector)

dat %>% group_by(Size.class) %>%
  summarize(MEAN = mean(Mass))

datsummary <- dat %>% group_by(Size.class) %>%
    summarize(firstvariablename = mean(Mass),
     secondvariablename = mean(Headwidth),
     medianheadwidth = median(Headwidth))

############ YOUR HOMEWORK ASSIGNMENT ##############

# 1.  Make a scatterplot of headwidth vs mass. See if you can get the points to be colored by "Colony"
plot(x=dat$Headwidth,y=dat$Mass,pch=19,col=dat$Colony,xlab="Headwidth",ylab="Mass",main= "Wow, A Cool Scatterplot!")

# 2.  Write the code to save it (with meaningful labels) as a jpeg file
jpeg("Cool_Scatterplot.jpeg")
plot(x=dat$Headwidth,y=dat$Mass,pch=19,col=dat$Colony,xlab="Headwidth",ylab="Mass",main= "Wow, A Cool Scatterplot!")
dev.off()

# 3.  Subset the thatch ant data set to only include ants from colony 1 and colony 2
dat4 <- dat %>% filter(Colony %in% c(1,2))     


# 4.  Write code to save this new subset as a .csv file
write.csv(dat4, "Assignments//Assignment_3/Colony1_2.csv")

# 5.  Upload this R script (with all answers filled in and tasks completed) to canvas
# I should be able to run your R script and get all the plots created and saved, etc.


