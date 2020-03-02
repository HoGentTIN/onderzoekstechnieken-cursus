# Bouwjaar opdelen in 3 (ongeveer gelijke) groepen
bins <- quantile(Makelaar$bouwjaar, probs=c(0,.33,.67,1), names=FALSE)
Makelaar$bouwjaarcategorie <- cut(Makelaar$bouwjaar, bins, dig.lab=4)

# Staafdiagram van huizen binnen deze categorie
cat_frq <- table(Makelaar$bouwjaarcategorie)
cat_frq_pct <- prop.table(cat_frq)
barplot_cat <- barplot(cat_frq_pct, ylab="Frequentie",
  col=rainbow(n=3),ylim=c(0,0.5))
text(x=barplot_cat, y=cat_frq_pct/2, labels = paste(round(cat_frq_pct*100), "%"))


