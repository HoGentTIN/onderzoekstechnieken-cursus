## Onderzoekstechnieken 15-16 Reeks 3
## Analyse van 1 variabele

## Oefening 3.2: Aantal jongeren per leeftijd

# Importeer dataset uit Excel
# library(RcmdrMisc) # voor de functie readXL
Jongeren <- 
  readXL("/home/bert/Documents/Vakken/onderzoekstechnieken/15-16/oefeningen/3_1var/jongeren.xlsx", 
  rownames=FALSE, header=TRUE, na="", sheet="jongeren-1", stringsAsFactors=TRUE)

# Kwartielen van de meisjes
numSummary(Jongeren[,"vrouw"], statistics=c("quantiles"), quantiles=c(0,.25,.5,.75,1))

# Grafiek van aantal jongens en meisjes
with(Jongeren, lineplot(leeftijd, man, vrouw))

# Grafiek van de verhouding tussen meisjes en jongens
Jongeren$Verhouding <- with(Jongeren, vrouw/man)
with(Jongeren, lineplot(leeftijd, Verhouding))

# Boxplot jongens
Boxplot( ~ man, data=Jongeren, id.method="y")

