onderhoud_categorie <- with(Makelaar, table(oordeel4, bouwjaarcategorie))
onderhoud_categorie_pct <- prop.table(onderhoud_categorie, 2)
stacked_plot <- barplot(onderhoud_categorie_pct, horiz = TRUE,
  legend.text = TRUE,
  main = "Oordeel over onderhoud", ylab = "Bouwjaar", xlab = "Frequentie")
text(y = stacked_plot, x = onderhoud_categorie_pct[1,]/2,
  labels=paste(round(onderhoud_categorie_pct[1,]*100), "%"))
text(y = stacked_plot, x = onderhoud_categorie_pct[1,]+onderhoud_categorie_pct[2,]/2,
  labels=paste(round(onderhoud_categorie_pct[2,]*100), "%"))
text(y = stacked_plot, x = colSums(onderhoud_categorie_pct)*.9,
  labels=paste(round(onderhoud_categorie_pct[3,]*100), "%"))
