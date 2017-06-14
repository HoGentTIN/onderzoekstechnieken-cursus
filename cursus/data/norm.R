> dnorm(0)
[1] 0.3989423
> dnorm(0)*sqrt(2*pi)
[1] 1
> dnorm(0,mean=4)
[1] 0.0001338302
> dnorm(0,mean=4,sd=10)
[1] 0.03682701
>v <- c(0,1,2)
> dnorm(v)
[1] 0.39894228 0.24197072 0.05399097
> x <- seq(-20,20,by=.1)
> y <- dnorm(x)
> plot(x,y)
> y <- dnorm(x,mean=2.5,sd=0.1)
> plot(x,y)
