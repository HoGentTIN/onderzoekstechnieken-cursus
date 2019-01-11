#Creeer de relatie
relation <- lm(formula = nicolas$drowned~nicolas$films);
print(relation);

#Laten we de statistieken erbij halen
print(summary(relation));

#Of
R <-cor(nicolas$drowned,nicolas$films, method = "pearson");
print(R)

#Visualiseren van de regressie

#Laten we deze keer een naam geven
png(file = "nicolasregression.png");
plot(nicolas$films, nicolas$drowned, 
     main="Verband aantal films en verdrinkingen");
abline(relation,col="red")