# Voorbeeld kruistabellen: waardering v/e product tussen
# vrouwen en mannen. Vergelijk de uitkomsten van elke stap
# met het voorbeeld in de cursus!
# 
# Bron: http://www.cyclismo.org/tutorial/R/tables.html#creating-a-table-directly

# Kruistabel opmaken. Normaal zou je deze berekenen uit
# de frequenties van ordinale/nominale variabelen bij 
# observaties met bv. table(waardering, geslacht)
waarderingen_m <- matrix(c(9,8,5,0,8,10,5,4), ncol = 2)
rownames(waarderingen_m) <- 
  c("Goed", "Voldoende", "Onvoldoende", "Slecht")
colnames(waarderingen_m) <- c("Vrouw", "Man")
waarderingen <- as.table(waarderingen_m)

# Marginale totalen berekenen:
margin.table(waarderingen, 1)  # Rijtotalen
margin.table(waarderingen, 2)  # Kolomtotalen
margin.table(waarderingen)     # Algemeen totaal (# observaties)

# Gepercenteerde waarden, over de rijtotalen
waarderingen_pct <- prop.table(waarderingen, 2)

# Berekening chi-kwadraat, de moeilijke manier
# Verwachte waarden (ahv matrix-vermenigvuldiging)
verwacht <- as.array(margin.table(waarderingen,1)) %*%
  t(as.array(margin.table(waarderingen,2))) / 
  margin.table(waarderingen)
# Afwijkingen, gekwadrateerd en genormeerd
afwijkingen <- (waarderingen - verwacht) ^ 2 / verwacht
# Chi-kwadraat:
sum(afwijkingen)

# Rechtstreekse berekening chi-kwadraatwaarde
summ <- summary(waarderingen)
chi_sq <- summ$statistic

# Cramér's V
k <- min(nrow(waarderingen), ncol(waarderingen))
V <- sqrt(chi_sq/
            (margin.table(waarderingen) *
               (k - 1)))

# Plot: mosaic plot
plot(t(waarderingen))

# Clustered bar chart
barplot(waarderingen, beside = TRUE)

# Stacked percentage chart
barplot(waarderingen_pct, horiz = TRUE)
