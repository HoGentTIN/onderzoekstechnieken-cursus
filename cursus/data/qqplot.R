# Example of a Q-Q plot

m <- 1000
s <- 50
n <- 50

# Normal distribution
observations <- rnorm(n, m, s)
# Student's t distribution
#observations <- m + rt(n, df = 15) * s

# Q-Q plot of observations compared to normal distribution
qqnorm(observations)

# Plots the line of the expected position of observations
x <- seq(-3, +3, length = n)
lines(x, m+s*x, col = 'red')
