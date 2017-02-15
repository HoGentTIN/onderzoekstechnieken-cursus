# Oef 7.5 z-toets

n = 72    # Steekproefgrootte

m0 = 44
sm = 46.2  # gemiddelde in de steekproef
s = 6.2   # stdev in de steekproef
a = 0.025 # betrouwbaarheidsniveau (2.5%)

# H0: m0 = 44
# H1: m0 > 44

# Methode kritieke gebied

# Kritieke grenswaarde
g <- m0 + qnorm(1-a) * s / sqrt(n)
g <- qnorm(1-a, m0, s / sqrt(n)) # Equivalent

# OF:
# g <- qnorm(1-a, m0, s/sqrt(n))

x <- seq(m0-4*s/sqrt(n), m0+4*s/sqrt(n), length=200) # grenzen van de plot (x-waarden)
dist <- dnorm(x, m0, s/sqrt(n))                      # y-waarden
plot (x, dist, type = 'l')

# Toon het gevonden steekproefgemiddelde ahv rode vertikale lijn
abline(v=sm, col='red')
text(sm, 0.4, sm)

abline(v=g, col='green')

# Het aanvaardingsgebied plotten
i <- x <= g                    # Welke waarden van x links van g?
polygon(                       # Plot deze waarden op de grafiek
  c(x[i],    g),
  c(dist[i], 0),
  col = 'lightgreen')
text(g,.5,signif(g, digits=4)) # Toon grenswaarde

text(m0, 0.1, m0)              # toon hypothetisch populatiegemiddelde
abline(v=m0)                   # trek daar een vertikale lijn

text(m0, 0.2, 'aanvaardingsgebied (H0)')

# Methode overschrijdingskans
# Wat is de kans dat je een steekproefgemiddelde van (minstens)
# x uitkomt? Als die kans p < a, dan verwerpen we H0
p = 1 - pnorm(sm, m0, s / sqrt(n))

# Besluit:
if(p < a) {
  print("Verwerp H0")
} else {
  print("Verwerp H0 *niet*")
}



#
# Besluit: Er is wel degelijk een effect te merken in de
# behaalde studiepunten na het invoeren van het bindend
# studie-advies.
#
