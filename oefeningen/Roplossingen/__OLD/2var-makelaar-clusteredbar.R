# Percentages per kolom
onderhoud_categorie_pct <- prop.table(onderhoud_categorie, 2)
clustered_plot <- barplot(onderhoud_categorie_pct, beside = TRUE,
  legend.text = TRUE,
  main = "Oordeel over onderhoud", xlab = "Bouwjaar", ylab = "Frequentie")
text(x=clustered_plot, y=onderhoud_categorie_pct*.8,
  labels=as.character(paste(round(onderhoud_categorie_pct*100), "%")))
