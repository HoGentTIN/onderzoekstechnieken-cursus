# Casus restaurantbezoek - Analyse van 2 variabelen

library(dplyr)

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

# Groeperen per Klanttype, en gemiddeld Bedrag berekenen
# Maakt gebruik van dplyr package. De operator "%>%" kan je
# vergelijken met een pipe-symbool in Bash.
bedrag_type <- resto %>%
  group_by(Klanttype) %>%
  summarize_each(funs(mean(., na.rm=T)), Bedrag)
# Staafdiagram met labels
bedrag_type_plot <- barplot(
  bedrag_type$Bedrag, 
  main = 'Gemiddeld besteed bedrag per klanttype',
  names = bedrag_type$Klanttype,
  ylim = c(0, 15))
text(x = bedrag_type_plot, 
     y = bedrag_type$Bedrag + 1,
     labels = as.character(bedrag_type$Bedrag))

# Boxplot
boxplot(Bedrag ~ Klanttype, horizontal = T)

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
keuze_geslacht_props <- prop.table(t(keuze_geslacht_xtab),2)
barplot(
  keuze_geslacht_props,
  xlim = c(0, ncol(keuze_geslacht_props) + 1.5),
  legend.text = T,
  args.legend = list(
    x = ncol(keuze_geslacht_props) + 1.5,
    y = max(colSums(keuze_geslacht_props))
  ))
# Eenvoudiger versie van deze plot, maar de legende wordt over de grafiek
# getekend:
# barplot(keuze_geslacht_props, legend.text = T)

#
# Is er verband tussen het aantal dagen dat men bezoekt en het bedrag dat
# men wekelijks besteedt?
#
plot(Bezoek, Bedrag)
bezoek_bedrag_lm <- lm(Bedrag ~ Bezoek)
abline(bezoek_bedrag_lm, col='red')
