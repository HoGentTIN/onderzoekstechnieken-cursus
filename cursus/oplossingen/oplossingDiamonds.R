#open library diamonds
install.packages('ggplot2')
library('ggplot2')
diamonds

#hoeveel observaties zitten in de dataset?
nrow(diamonds)

#hoeveel variabelen zijn er?
ncol(diamonds)

#hoeveel geordende factoren zijn er in de dataset?
str(diamonds)

#welke letters worden gebruikt om een kleur van een diamand voor te stellen?
levels(diamonds$color)

#teken een histogram van de prijs van alle diamonds in de dataset
hist(diamonds$price)
#of
ggplot(diamonds,aes(x=price))+geom_histogram(color='black',fill='DarkOrange',binwidth=500)

#centrummaten?
summary(diamonds$price)
boxplot(diamonds$price)

#hoeveel diamanten <$500?
nrow(subset(diamonds,price<500))

#hoeveel diamanten <$500 and cut=ideal?
nrow(subset(diamonds,price<500 & cut=='Ideal'))

#plot enkel data tussen Q1 en Q3
s<-summary(diamonds$price)
min<-s[2]
max<-s[5]
#or=||
set<-subset(diamonds,diamonds$price>=min& diamonds$price<max)
nrow(set)
ggplot(set,aes(x=price))+geom_histogram(color='black',fill='DarkOrange')
#of
hist(set$price,prob=TRUE)
lines(density(set$price))