# Creeer een data frame waarbij je geslacht uitzet tot moordcategorie
friday.data <- data.frame(Friday$Gender, Friday$Death.Category);
print(friday.data)

#We kijken eens naar de percentages t.o.v. totaal
print(prop.table(friday.data));

#we bekijken ook eens de marginale totalen
margin.table(friday.data,1);
margin.table(friday.data,2);

#Daarna kijken we ook naar de marginale totalen per kolom en rij
prop.table(friday.data,1);
prop.table(friday.data,2);

#Of we kunnen ook de crosstabs functie gebruiken van de gmodels library
CrossTable(Friday$Gender,Friday$Death.Category);

#Om te kijken of er een verband is tussen gender en moordwijze kunnen
#we chi kwadraat uitvoeren
chisq.test(friday.data);

#Cramer's V berekend (gebruik makende van library vcd)
assocstats(friday.data);

#Visualisatie (hier moet nog aan gewerkt worden)
bp <- barplot(prop.table(friday.data,2), main="Distributie moorden en geslacht", xlab="Moorden")
