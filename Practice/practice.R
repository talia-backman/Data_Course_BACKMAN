#REGULAR SENTENCES EXERCISE
#Exercise 1:How to do sequences with different intervals
library(tidyverse)
seq(1,10, by=2)
seq(1,10,by=3)

#Exercise 2: Use the seq() function to generate the sequence 9,18,27,36,45
seq(9,45, by=9)

#Exercise 3: Give a range of numbers and then a number to divide by
seq(1,10, length.out = 5)
seq(1,10, length.out = 3)

#Exercise 4: Repeating sets of numbers in different ways
x= 1:5
rep(x,2)
rep(x,2, each=2)
rep(x,each=4)

#Exercise 5: How to repeat words/ values in different ways
x= "Hip"
y="Hooray"
rep(c(rep(x,2),y),3)

#Exercise 6:
seq(100,50,by=-5)

#Exercise 7:
Semester_Start = as.Date("2019-08-19")
Semester_End = as.Date("2019-12-05")
seq(Semester_Start,Semester_End,by="week")
midterm = seq(Semester_Start,Semester_End,length.out = 3)[2]


#INDEXING EXERCISE
#Exercise 1:
x= c("ss","aa","ff","kk","bb")
x[1]
x[c(1,3)]

#Exercise 2:
d = data.frame(Name = c("Betty","Bob","Susan"),
               Age = seq(20,30,length.out = 3),
               Height_cm = c(490,22,0))
d[c("Name","Age")]
d[c("Age","Name","Height_cm")][1,]

#Exercise 3:
d$Name
d$Age[2]

#Exercise 4:
d$Age > 20
d[d$Age > 20,]
d[d$Height_cm < 100,]
d[1,c("Name","Age")]


#MISSING VALUES EXERCISE
#Exercise 1:
X = c(NA,3,14,NA,33,17,NA,41)
is.na(X)
!is.na(X)
X[!is.na(X)]

#Exercise 2:
Y = 21:28
Z= data.frame(X,Y)
Z
Z[is.na(Z)] <- 0
Z
P = c(X,33,NA,400,12,0,15)  
P
P[is.na(P)] <- 10
P

#Exercise 3:
#***** How to make it show up as TRUE and not 1??????????????????
W <- c(11,3,5,NA,6)
W[is.na(W)]<- TRUE
W

#Exercise 4:
A <- c(33,21,12,NA,7,8)
A[is.na(A)] <- 0
A
Am <- mean(A)
Am

#Exercise 5:
data(Orange)
head(Orange)
Orange$age[is.na(Orange$age)] <- NA
Orange$age
class(Orange$age)
navalues <- which(Orange$age == 118) 
Orange$age[navalues] <- NA
Orange$age

#Exercise 6:
c1 <- c(1,2,3,NA)
c2 <- c(2,4,6,89)
c3 <- c(45,NA,66,101)
X <- data.frame(c1,c2,c3)
X
complete.cases(X)
missing_values <- X[is.na(X),]
missing_values <- X[rowSums(is.na(X))>0,]

#Exercise 7:
df <- data.frame (Name = c(NA,"Joseph","Martin",NA,"Andrea"),
                  Sales = c(15,18,21,56,60),
                  Price = c(34,52,21,44,20),
                  stringAsFactors = FALSE)
library(tidyverse)
df2 <- df[complete.cases(df),]


#LOOPS EXERCISE
for(i in 1:3){
  x <- paste0("Number ",i)
  print(x)
}
planets <- c("Mercury","Venus","Earth","Mars","Jupiter","Saturn","Uranus","Neptune")
n <- 1
newvector <- c()
for(i in planets){
  newvector[n] <- paste0(i,i)
  n=n+1
}
newvector

#Exercise 1:
