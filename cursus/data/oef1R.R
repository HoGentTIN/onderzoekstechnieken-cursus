#Opgave met sinus en cosin
chuppy <- function(x) 1+sin((2*pi*x)/4) + cos((2*pi*x)/4)
curve (chuppy, 1,10,n=100)

#Moving average voorbeeld
data = c(4, 16, 12, 25, 13, 12, 4, 8, 9, 14,
         +          3, 14, 14, 20, 7, 9, 6, 11, 3, 11,
         +          8, 7, 2, 8, 8, 10, 7, 16, 9, 4)
x = 1:30
f10 <- rep(1/10,10)
y_lag <- filter(data,f10,sides=1)
plot(x,data,type="l")
lines(x,y_lag,col="red")

f5 <- rep(1/5,5)
y_lag5 <- filter(data,f5,sides=1)
