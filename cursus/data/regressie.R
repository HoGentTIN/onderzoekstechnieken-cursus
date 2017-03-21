# Voorbeeld Lineaire Regressie
gewichtstoename <- read.csv('santa.txt', sep = "")
attach(gewichtstoename)

# x = eiwitgehalte (%)
# y = gewichtstoename (g)
plot(x, y, 
     main = 'Gewichtstoename',
     xlab = 'eiwitgehalte (%)',
     ylab = 'gewichtstoename (g)')
# Bereken regressie ("Linear Model")
regr <- lm(y ~ x)
abline(regr, col = 'red') # Plot regressierechte