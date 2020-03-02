#http://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html

library(TTR)
oef91 <- read.csv('../oef9_1.csv')
SMA_2 <- SMA(oef91$x_t,2)
SMA_10 <- SMA(x = oef91$x_t,10)
colors <- rainbow(3)
plot(oef91$t,oef91$x_t,type="l",col=colors[1])
lines(oef91$t,SMA_2,col=colors[2])
lines(oef91$t,SMA_10,col=colors[3])
legend("topleft", inset=.05, title="SMA", c("Data","SMA_2","SMA_10"), col=colors, horiz=TRUE)
#Hier moet de voorspelling met lineaire regressie nog komen
lineair <- lm(oef91$x_t ~ oef91$t)
abline(lineair, col = 'orange')

timeseries <- ts(oef91$x_t)
#Gebruik schatting van R voor alpha
simpleExpponential <- HoltWinters(timeseries,beta=FALSE,gamma=FALSE)
simpleExpponential
simpleExpponential$fitted
plot(simpleExpponential)
simpleExpponential$SSE
simpleExpponential <- HoltWinters(timeseries,alpha=0.1,beta=FALSE,gamma=FALSE)
library("forecast")
forecast20 <- forecast.HoltWinters(simpleExpponential,20)

