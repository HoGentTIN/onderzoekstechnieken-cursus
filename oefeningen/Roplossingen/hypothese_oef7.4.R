# Oef. 7.4 Kansverdeling voor een fractie

n <- 31*24*60  # steekproefgrootte, aantal minuten in januari
k <- n - 1     # aantal successen
p <- k/n       # kans op succes binnen de steekproef
q <- 1 - p     # kans op falen binnen de steekproef

s <- sqrt(p*q/n) # stdev kansverdeling p
g <- 0.99999     # als p < g, dan is de SLA *niet* gehaald

# Schets van de situatie: kansverdeling van succespercentage
m <- p
x <- seq(m - 4 * s, m + 4 * s, length=200)
norm_dist <- dnorm(x, m, s)
title <- paste(
  "Normale verdeling, μ =",
  signif(m, digits=5),
  ", σ =", signif(s, digits=5))
plot(x, norm_dist, type = 'l',
     main=title)
abline(v = g)
text(g, 5000, g)


# Kans dat de SLA niet gehaald wordt, gegeven de
# bekomen kansverdeling
p_fail <- pnorm(g, p, s)
p_fail
