dnorm(0)
# 0.3989423
dnorm(0)*sqrt(2*pi)
# 1
dnorm(0,mean=4)
# 0.0001338302
dnorm(0,mean=4,sd=10)
# 0.03682701
v <- c(0,1,2)
dnorm(v)
# 0.39894228 0.24197072 0.05399097
x <- seq(-20,20,by=.1)
y <- dnorm(x)
plot(x,y)
y <- dnorm(x, mean=5, sd=1.5)
plot(x,y)

# Function that draws a Gauss plot with given mean
# and standard deviation.
gauss_plot <- function(m, s) {
  x <- seq(m-4*s, m+4*s, length.out = 101)
  y <- dnorm(x, mean = m, sd = s)
  plot(x, y, type = 'l')
}

gauss_plot(m = 100, s = 25)
abline(v = 125, col = 'red')
points(x = 125, y = dnorm(125, mean = 100, sd = 25), col = 'green')

