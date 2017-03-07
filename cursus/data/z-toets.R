# De z-toets

# We hebben een steekproef met
n <- 30      # steekproefgrootte
sm <- 3.483  # steekproefgemiddelde
s <- 0.55    # standaardafwijking (verondersteld gekend)
a <- 0.05    # significantieniveau (gekozen door de onderzoeker)
m0 <- 3.3    # hypothetisch populatiegemiddelde (H0)

# Kunnen we vanuit deze steekproef besluiten dat mu > 3.3?
# H0: mu = 3.3    -> nulhypothese, willen we ontkrachten
# H1: mu > 3.3    -> alternatieve hypothese, willen we aantonen

#
# Methode 1. Overschrijdingskans
#
# Wat is de kans dat je in een steekproef het gegeven steekproefgemiddelde
# ziet? P(M > sm) in een verdeling M ~ Nor(m0, s/sqrt(n))
p <- 1 - pnorm(sm, m0, s/sqrt(n))  # => 0.03419546

# De gevonden kans is bijzonder klein, kleiner dan het significantieniveau
if(p < a) {
  print("H0 verwerpen")
} else {
  print("H0 niet verwerpen")
}

#
# Methode 2. Kritieke grensgebied
#
# Onder welke waarde kan je H0 niet verwerpen?
g <- m0 + qnorm(1-a) * s / sqrt(n)

# Als het gevonden steekproefgemiddelde onder g ligt, kan je H0 niet verwerpen
if (sm < g) {
  print("H0 niet verwerpen")
} else {
  print("H0 verwerpen")
}

#
# Plot van deze casus
#

# grenzen van de plot (x-waarden)
x <- seq(m0-4*s/sqrt(n), m0+4*s/sqrt(n), length=200)
# y-waarden (volgen de Gauss-curve)
dist <- dnorm(x, m0, s/sqrt(n))
plot (x, dist, type = 'l', xlab = '', ylab = '')

# Toon het gevonden steekproefgemiddelde ahv rode vertikale lijn
abline(v=sm, col='red')
text(sm, 2, sm)

# Het aanvaardingsgebied plotten
i <- x <= g                    # Waarden van x links van g
polygon(                       # Plot deze waarden op de grafiek
  c(x[i],    g,                       g),
  c(dist[i], dnorm(g, m0, s/sqrt(n)), 0),
  col = 'lightgreen')
text(g,.5,signif(g, digits=4)) # Toon grenswaarde

text(m0, 0.1, m0)              # Hypothetisch populatiegemiddelde
abline(v=m0)                   # Trek daar een vertikale lijn

text(m0, 1.5, 'aanvaardingsgebied (H0)')
