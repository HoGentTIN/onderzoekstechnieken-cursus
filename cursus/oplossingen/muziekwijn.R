#Oplossing oefening 5.1

# Nullhypothese: er is geen verband tussen muziek en wijn
# Alternatieve Hypothese: er is wel een verband

#Stap 1: tabel maken van dataframe
mytable <- table(muziekwijn);
mytable;

#Stap 2: kijken naar marginale en percentages
margin.table(mytable, 1)
margin.table(mytable, 2)
prop.table(mytable)
#Stap 3: kijken naar chi² crosstabel
library(gmodels)
library(lsr)

#Geeft kruitabel terug met ch² waarden
CrossTable(mytable)

# Stap 4: kramers V bepalen ( 0.19 dus zwak verband)
cramersV(mytable)

#Stap 5: chisq test uitvoeren, p-waarde < alfa (0.05) nullhypothse
#verwerpen, p-waarde > alfa nullhypothese niet verwerpen
chisq.test(mytable)

#Kritieke grenswaarde bepalen
qchisq(0.95, df = 4)

#X-waarde laten overeenkomen met kans, moet gelijk zijn aan chi²
qchisq(1-0.001088, df =4)

#Teken de chi² functie
x <- seq(0,20,length=100)
hx <- dchisq(x,df=4)
plot(x,hx, type='l')