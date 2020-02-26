# a. Spreidingsdiagram met regressierechte
plot(oppervlakte, prijs, main = "Prijs t.o.v. oppervlakte", yaxt="n",
     xlim = c(-10, 2010),
     xlab = "Oppervlakte (in m²)",
     ylab = "Prijs (in 1000 €)")
axis(1, labels = seq(0, 2000, 500), at = seq(0, 2000, 500), tick = TRUE)
axis(2, labels = seq(100, 700, 100), at = seq(100000, 700000, 100000), tick = TRUE)

regressierechte <- lm(prijs~oppervlakte)
print(regressierechte)
abline(regressierechte, col="red")

# b. Correlatiecoëfficiënt
R <- cor(oppervlakte, prijs, method = "pearson")
print(paste("R = ", R))

# c. Determinatiecoëfficiënt
R2 <- R^2
print(paste("R^2 = ", R2))
