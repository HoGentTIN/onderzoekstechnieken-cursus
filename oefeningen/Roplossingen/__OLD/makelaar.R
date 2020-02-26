## Oefeningen Onderzoekstechnieken 15-16
## Analyse op 2 variabelen
## Case "Makelaar"

library(colorspace, pos=16)
library(dichromat)    # Kleurenpaletten voor kleurenblindheid
library(foreign)      # Importeren SPSS .sav-bestand
library(lsr)          # Cramer's V

Makelaar <- read.spss("../data/Makelaar.sav",
   use.value.labels=TRUE, max.value.labels=Inf, to.data.frame=TRUE)
colnames(Makelaar) <- tolower(colnames(Makelaar))
attach(Makelaar)

# 1. Geef grafieken met overzicht van:

# a. Taartdiagram van type (soort) woningen
pie(table(soort),
  labels=levels(soort), xlab="", ylab="",
  main="Type woning",
  col=dichromat(topo.colors(length(levels(soort)))))

# b. Staafdiagram van huizen per wijk
barplot(table(wijk), ylab="Aantal huizen per wijk",
  col=dichromat(topo.colors(length(levels(wijk)))))

# c. Boxplot van aantal kamers
boxplot(kamers, data=Makelaar)

# 2. Groepenindeling

# a. Bouwjaar opdelen in 3 (ongeveer gelijke) groepen
bins <- quantile(bouwjaar, probs=c(0,.33,.67,1), names=FALSE)
bouwjaarcategorie <- cut(bouwjaar, bins, dig.lab=4)

# b. Staafdiagram van huizen binnen deze categorieën
cat_frq <- table(bouwjaarcategorie)
cat_frq_pct <- prop.table(cat_frq)
barplot_cat <- barplot(cat_frq_pct, ylab="Frequentie",
  col=dichromat(topo.colors(length(levels(bouwjaarcategorie)))))
text(x=barplot_cat, y=cat_frq_pct/2, labels = paste(round(cat_frq_pct*100), "%"))

# c. Samenhang tussen "Onderhoud algemeen" en categorieen
onderhoud_categorie <- table(bouwjaarcategorie, oordeel4)
chisq.test(onderhoud_categorie)
cramersV(onderhoud_categorie)

# d. Geclusterd staafdiagram, gegroepeerd per waardering
onderhoud_categorie_pct <- prop.table(onderhoud_categorie, 2)
clustered_plot <- barplot(onderhoud_categorie_pct, beside = TRUE,
  legend.text = TRUE,
  main = "Oordeel over onderhoud", xlab = "Bouwjaar", ylab = "Frequentie")
text(x=clustered_plot, y=onderhoud_categorie_pct*.8,
  labels=as.character(paste(round(onderhoud_categorie_pct*100), "%")))

# e. Rependiagram, gegroepeerd per waardering
onderhoud_categorie <- table(oordeel4, bouwjaarcategorie)
onderhoud_categorie_pct <- prop.table(onderhoud_categorie, 2)
stacked_plot <- barplot(onderhoud_categorie_pct, horiz = TRUE,
  legend.text = TRUE,
  main = "Oordeel over onderhoud", ylab = "Bouwjaar", xlab = "Frequentie")
text(y = stacked_plot, x = onderhoud_categorie_pct[1,]/2,
  labels=paste(round(onderhoud_categorie_pct[1,]*100), "%"))
text(y = stacked_plot, x = onderhoud_categorie_pct[1,]+onderhoud_categorie_pct[2,]/2,
  labels=paste(round(onderhoud_categorie_pct[2,]*100), "%"))
text(y = stacked_plot, x = colSums(onderhoud_categorie_pct)*.9,
  labels=paste(round(onderhoud_categorie_pct[3,]*100), "%"))

# 3. Lineaire regressie

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

# 4. Geef met een drievoudige boxplot het verschil in vraagprijs weer tussen de drie types
# woningen.
boxplot(prijs~soort)

# 5. Analyseer of er verschil in vraagprijs is tussen huizen met en zonder sauna. Kies zelf
# de gewenste statische analyse.
boxplot(prijs ~ optie2)
aggregate(prijs ~ optie2, data = Makelaar, mean)
aggregate(prijs ~ optie2, data = Makelaar, sd)

# 6. Analyseer of er verschil is tussen de wijken met betrekking tot de oppervlakte van het
# perceel. Kies zelf een geschikte statische analyse.
boxplot(oppervlakte ~ wijk)
aggregate(oppervlakte ~ wijk, data = Makelaar, mean)
aggregate(oppervlakte ~ wijk, data = Makelaar, sd)
