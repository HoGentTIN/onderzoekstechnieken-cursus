# Samenhang tussen "Onderhoud algemeen" en categorieen bouwjaar
onderhoud_categorie <- with(Makelaar, table(bouwjaarcategorie, oordeel4))
print(onderhoud_categorie)
chisq.test(onderhoud_categorie)
cramersV(onderhoud_categorie)
