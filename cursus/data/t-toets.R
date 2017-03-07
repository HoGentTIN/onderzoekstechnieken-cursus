# De t-toets

# We hebben een steekproef met
n <- 25      # steekproefgrootte
sm <- 3.483  # steekproefgemiddelde
ss <- 0.55  # standaardafwijking van de steekproef
a <- 0.05    # significantieniveau (gekozen door de onderzoeker)
m0 <- 3.3    # hypothetisch populatiegemiddelde (H0)

# Kunnen we vanuit deze steekproef besluiten dat mu > 3.3?
# H0: mu = 3.3    -> nulhypothese, willen we ontkrachten
# H1: mu > 3.3    -> alternatieve hypothese, willen we aantonen

#
# Methode 1. Kritieke grensgebied
#
# Onder welke waarde kan je H0 niet verwerpen?
g <- m0 + qt(1-a, df = n-1) * ss / sqrt(n)

# Als het gevonden steekproefgemiddelde onder g ligt, kan je H0 niet verwerpen
if (sm < g) {
  print("H0 niet verwerpen")
} else {
  print("H0 verwerpen")
}

#
# Methode 2. Overschrijdingskans
#
# Wat is de kans dat je in een steekproef het gegeven steekproefgemiddelde
# ziet? P(M > sm) in een verdeling M ~ T(m0, ss/sqrt(n), df=n-1)
p <- 1 - pt((sm - m0) / (ss/sqrt(n)), df = n-1)

# De gevonden kans is bijzonder klein, kleiner dan het significantieniveau
if(p < a) {
  print("H0 verwerpen")
} else {
  print("H0 niet verwerpen")
}

#
# Plot van deze casus
#

# grenzen van de plot (x-waarden)
x <- seq(m0-4*ss/sqrt(n), m0+4*ss/sqrt(n), length=200)
# y-waarden (volgen de Gauss-curve van de t-verdeling)
dist <- dt((x-m0)/(ss/sqrt(n)), df = n-1) * ss/sqrt(n)
plot (x, dist, type = 'l', xlab = '', ylab = '')

# Het aanvaardingsgebied plotten
i <- x <= g                    # Waarden van x links van g
polygon(                       # Plot deze waarden op de grafiek
  c(x[i],    g,                              g),
  c(dist[i], dt((g-m0)/(ss/sqrt(n)),df=n-1), 0),
  col = 'lightgreen')

text(m0, 0.01, m0) # Hypothetisch populatiegemiddelde
abline(v=m0)       # Trek daar een vertikale lijn

text(g+.025,.02,signif(g, digits=4)) # Toon grenswaarde

# Toon het gevonden steekproefgemiddelde ahv rode vertikale lijn
abline(v=sm, col='red')
text(sm-.025, .005, sm, col = 'red')

text(m0, 0.02, 'aanvaardingsgebied (H0)')
