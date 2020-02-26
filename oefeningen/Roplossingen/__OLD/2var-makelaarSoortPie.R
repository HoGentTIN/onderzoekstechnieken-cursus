soort <- table(Makelaar$soort);
percentages <- round(100*soort/sum(soort),1);
label <- paste(percentages, "%",sep="");
colors <- rainbow(length(soort));
pie(soort, main="Huizensoorten",col=colors, labels=label, cex=0.8);
legend("topright",legend = names(soort),fill = colors)