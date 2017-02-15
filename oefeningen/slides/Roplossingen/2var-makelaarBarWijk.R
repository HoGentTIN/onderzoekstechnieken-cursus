wijk.freq <- table(Makelaar$wijk); # Creates table from Makelaar
barplot(wijk.freq); #Creates Barplot in new window
barplot(wijk.freq[order(wijk.freq)],horiz = T)
colors <- rainbow(length(wijk.freq))
barplot(wijk.freq[order(wijk.freq)],
        horiz = T, 
        col=colors,
        xlim = c(0,150),
        xlab = "Frequentie",
        ylab = "Naam van de wijk",
        border=NA)

        