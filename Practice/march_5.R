
# to get the normal distribution we need the mean and the standard deviation
?rnorm
?rbinom
?runif

set.seed(123)
a <- rnorm(5, mean = 0, sd = 1)
b <- rnorm(5,mean = 1,sd = 1)

hist(a)
hist(b)

df <- data.frame(a=a,b=b) %>% gather(key=object, value= value, 1:2)
df
ggplot(df, aes(x=value,fill= object)) + geom_density(alpha=.5)

pnorm(7,mean=5, sd=1,lower.tail = FALSE) 
# if we want to know the probability of randomly picking one person and that person being 7 feet tall, the probability is 2.2%

t.test(a,b)
# t.test predicts that the distributions are the same, if the pvalue is significant that means that the distributions are not the same
# compares means and says whether the distributions are the same or if they aren't
# can detect differences between means that are very different 