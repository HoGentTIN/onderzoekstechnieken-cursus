## Onderzoekstechnieken 15-16 Reeks 3
## Analyse van 1 variabele - Oefening 3.1: Bevolkingsgegevens
# 0. Bestand inlezen
# library(RcmdrMisc) # voor de functie readXL
Bevolkingsgegevens <- 
  readXL("/home/bert/Documents/Vakken/onderzoekstechnieken/15-16/oefeningen/3_1var/bevolkingsgegevens.xlsx",
   rownames=FALSE , header=TRUE , na="", sheet="bevolkingsgegevens", stringsAsFactors=TRUE)
# 1. Gemiddelde van Echtscheidingen en Levendgeborenen
numSummary(Bevolkingsgegevens[,
  c("Echtscheiding", "Levendgeborenen", "Overledenen")], 
  statistics=c("mean"))
# 2. Standaardafwijking van Emigratie en Immigratie
numSummary(Bevolkingsgegevens[,
  c("Emigratie", "Immigratie")], 
  statistics=c("sd"))
# 3. Variatiecoefficient van Echtscheidingen en Huwelijksontbindingen
numSummary(Bevolkingsgegevens[,c("Echtscheiding", "Huwelijksontbindingen")],statistics=c("cv"))
# 4. Grafiek van Bevolking tov Periode
# In een "gewone" plot zal de x-as genummerd worden van 1-200 (index). We gaan deze vervangen door 
#een string van de vorm "jjjj-mm").Bereken eerst de indexes van de maanden die we in de x-as gaan plotten (elke 6 maand)
maanden <- seq(1,200,6)
# Selecteer de overeenkomstige labels uit de kolom Periode
maandlabels <- Bevolkingsgegevens$Periode[maanden]
# Plot de bevolkingscijfers
plot(Bevolkingsgegevens$Bevolking,
  type="l", # Lijngrafiek
  xaxt="n", # De gewone labels van de x-as weglaten
  xlab="")  # Titel van de x-as weglaten
axis(1,               # Vervang de x-as
  at=maanden,         
  labels=maandlabels,las=3)              
# 5. Grafiek van Immigratie en Emigratie
with(Bevolkingsgegevens, lineplot(PerNum, Emigratie, Immigratie))

