# Oef 7.5 z-toets

sample <- c(400,350,400,500,300,350,200,500,200,250,250,500,350,100)
n <- length(sample)    # Steekproefgrootte

m0 <- 300      # "vermoeden" populatiegemiddelde (H0)
sm <- mean(sample)  # gemiddelde in de steekproef
s <- sd(sample)   # stdev in de steekproef
a <- 0.05 # betrouwbaarheidsniveau (5%)
t <- qt(1-a, n-1)

# H0: m0 = 44
# H1: m0 > 44

# Methode kritieke gebied

# Kritieke grenswaarde
g <- m0 + t * s / sqrt(n)

x <- seq(-4, 4, length=200) # grenzen van de plot (x-waarden)
dist <- dt(x, n-1)                      # y-waarden
plot (x, dist, type = 'l')

# Toon het gevonden steekproefgemiddelde ahv rode verticale lijn
abline(v=(sm-m0)/(s/sqrt(n)), col='red')
text(sm, 0.4, sm)

# Grens aanvaardingsgebied plotten
abline(v=t, col='green')

# Methode overschrijdingskans
# Wat is de kans dat je een steekproefgemiddelde van (minstens)
# sm uitkomt? Als die kans p < a, dan verwerpen we H0
p <- 1 - pt((sm-m0)/(s / sqrt(n)), df = n-1)

# Besluit:
if(p < a) {
  print("Verwerp H0")
} else {
  print("Verwerp H0 *niet*")
}

# R-functie voor t.test gebruiken:
test_result <-
  t.test(sample,
         alternative = "greater",
         conf.level = 1-a,
         mu = m0)
p <- test_result$p.value
