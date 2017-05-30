x <- rnorm(n = 10000,mean = 0, sd = 1);
hist(x,probability = TRUE);
xgetallen <- seq(-4,4,length = 100)
hx <- dnorm(xgetallen)
lines(xgetallen,hx, col='red')