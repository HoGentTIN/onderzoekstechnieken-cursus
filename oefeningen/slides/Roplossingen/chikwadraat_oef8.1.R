# Chi-kwadraat toetsen
# Oef. 8.1. Vroegtijdig bevallen vs woonsituatie

a <- 0.05
val <- data.frame(
  "vroegtijdig" = c(50, 29, 11, 6, 3),
  "normaal" = c(894, 229, 164, 66, 36),
  row.names = c("eigenaar", "soc woning", "huurder", "bij ouders", "anders")
)

test_results <- chisq.test(val)
chisq_val <- test_results$statistic
g <- qchisq(1 - a, df = test_results$parameter['df'])

sprintf(" chi²: %f", chisq_val)
sprintf("    g: %f", g)

if(chisq_val < g) {
  print("H0 niet verwerpen")
} else {
  print("H0 verwerpen")
}

# Plot situatie
x <- seq(0, g*2, length = 200)
dist <- dchisq(x, df = test_results$parameter['df'])
plot (x, dist, type = 'l')

abline(v = g, col = 'green')       # Aanvaardingsgebied
abline(v = chisq_val, col = 'red') # Teststatistiek
