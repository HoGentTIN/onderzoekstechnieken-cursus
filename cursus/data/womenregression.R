#Oplossing vrouwen: gewicht vs hoogte

women;

#Stap 1: plot maken van de data
plot(women$height, women$weight);

#Stap2: regressiecoëfficiënten gaan bepalen
regression <- lm(women$weight ~ women$height)

#Stap 3: schattingen bepalen
x <- women$height*3.45 + (-87.52)

#Stap 4: correlatie bepalen
correlate(women$height,women$weight)

#Stap 5: Determinatiecoëfficiënt bepalen
0.995^2

#Stap 6: regressierechte tekenen op tekening
abline(regression)
lines(women$height,x,type="o", col = 'red')