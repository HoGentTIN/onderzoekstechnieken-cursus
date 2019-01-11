## Onderzoekstechnieken 15-16 Reeks 3
## Analyse van 1 variabele

## Oefening 3.3: Lengte en gewicht

# Data importeren
library(RcmdrMisc) # voor de functie readXL
LengteGewicht <- 
  read.table("/home/bert/Documents/Vakken/onderzoekstechnieken/15-16/oefeningen/3_1var/lengtegewicht.txt",
   header=TRUE, sep="", na.strings="NA", dec=".", strip.white=TRUE)

# Gemiddelden, standaardafwijking, variatiecoefficient
numSummary(LengteGewicht[,c("gewicht", "lengte")], 
  statistics=c("mean", "sd", "cv"))

# Variabele lengte opdelen in intervallen van 5cm
# Hoeveel intervallen nodig? => 7.884
with(LengteGewicht, (max(lengte) - min(lengte))/5)

# Maak de intervallen aan
LengteGewicht$lengtecategorie <- with(LengteGewicht, bin.var(lengte, bins=8,
   method='intervals', labels=NULL))

# Frequentietabel
with(LengteGewicht, table(lengtecategorie))
# Histogram (eigenlijk een barchart van de frequenties van variabele lengtecategorie)
with(LengteGewicht, Barplot(lengtecategorie, xlab="lengtecategorie", 
  ylab="Frequentie"))

## Analyse 2 variabelen
# Scatterplot gewicht vs lengte
scatterplot(gewicht~lengte, reg.line=lm, smooth=FALSE, spread=FALSE, boxplots=FALSE, span=0.5,
   ellipse=FALSE, levels=c(.5, .9), main="Lengte vs gewicht", data=LengteGewicht)
# Lineaire regressie
LengteVsGewicht <- lm(lengte~gewicht, data=LengteGewicht)
summary(LengteVsGewicht)

