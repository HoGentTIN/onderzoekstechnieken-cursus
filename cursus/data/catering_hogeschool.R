# Casus restaurantbezoek - Analyse van 2 variabelen

# Data opladen uit SPSS .sav-bestand
library(foreign)
resto <- read.spss("catering_hogeschool.sav", to.data.frame = TRUE)
attach(resto)

# Wat is het aantal dagen dat men gebruik maakt van het restaurant?
summary(Bezoek)  # Gemiddelde, mediaan, kwartielen
boxplot(Bezoek, horizontal = T)  # Boxplot, toont de spreiding
bezoek_frq <- table(Bezoek)      # Frequentietabel
# Staafdiagram met labels
bezoek_plot <- barplot(bezoek_frq,
        main = "Restaurantbezoek",
        xlab = "Aantal dagen per week",
        ylab = "Frequentie",
        ylim = c(0, 16))
text(x = bezoek_plot, 
     y = bezoek_frq + 1,
     labels = as.character(bezoek_frq))

# Wat is het verschil in het bestede bedrag tussen student en medewerker?
boxplot(Bedrag ~ Klanttype)

#
# Is er verschil in waardering in het basisassortiment tussen mannen en vrouwen?
#
keuze_geslacht_xtab <- table(Geslacht, Keuze_basis)
summary(keuze_geslacht_xtab)
# Plot van de frequentietabel. De frequenties van elke categorie worden voorgesteld
# door rechthoeken met een oppervlakte proportioneel t.o.v. de relatieve frequentie.
plot(keuze_geslacht_xtab,
     main = "Beoordeling basisassortiment m/v",
     xlab = "Geslacht",
     ylab = "Beoordeling basisassortiment")
# Een rependiagram voor dezelfde data. Dit is een gestapeld staafdiagram waar
# de kolommen herschaald zijn naar 100% (met prop.table). De functie t()
# transponeert de tabel.
barplot(
  prop.table(t(keuze_geslacht_xtab),2),
  legend = colnames(keuze_geslacht_xtab))

# Is er verband tussen het aantal dagen dat men bezoekt en het bedrag dat
# men wekelijks besteedt?
plot(Bezoek, Bedrag)
bezoek_bedrag_lm <- lm(Bedrag ~ Bezoek)
abline(bezoek_bedrag_lm, col='red')
