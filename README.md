## Informatie betreffende afstandslessen 

HOGENT wil haar maatschappelijke rol opnemen om de verspreiding van het Coronavirus in te dijken. Daarom werd er besloten, op basis van de huidige situatie, dat de contactmomenten vanaf 16/03/2020 niet doorgaan, maar dat de cursus op alternatieve wijze zal gedoceerd worden.

We beseffen dat dit niet evident zal zijn en dat het ook voor ons een zoektocht wordt om met de situatie om te gaan. Wij willen van onze kant het engagement opnemen om een kwalitatieve opleiding te blijven aanbieden en staan open voor constructieve feedback. We rekenen daarbij ook op jullie verantwoordelijkheidszin: dit is geen vakantie! Steek voldoende tijd en inspanning in het vak, maak een goede studieplanning en hou je er aan.

### Leerpad

In deze mail leggen we uit hoe dit praktisch in z'n werk gaat. Alle extra documenten, extra filmpjes en ander extra materiaal zal je terugvinden in het [leerpad op Chamilo][leerpad] waardoor je geleid door de leerstof kan gaan. 

Alle reguliere materialen blijven beschikbaar op de GitHub [github repo][repository] van het vak. Bekijk zeker de logs om te zien of er toevoegingen/wijzigingen doorgevoerd zijn. 

### Contactmomenten

Virtuele contactmomenten zullen doorgaan via Teams. Op Chamilo zullen er groepen aangemaakt worden per lector waar je ingedeeld in zit. Tijdens de contactmomenten kan je dit direct kanaal naar jouw begeleider gebruiken. 

## Hoorcollege's

De hoorcollege's zullen opgenomen worden via een screencast, waarbij de uitleg te horen zal zijn. Deze screencast zal je terugvinden in het leerpad, via een youtube link. Je mag de screencast op voorhand bekijken (indien beschikbaar), maar je mag ze evengoed tijdens de geroosterde contactmomenten bekijken. De docenten zullen online zijn via Teams waar je eventuele vragen kan stellen. 

## Oefensessies

Per hoofdstuk zullen enkele basisoefeningen (zoals je op het examen kunt krijgen) uitgewerkt staan via screencast. Ander opgeloste oefeningen vind je terug, zoals altijd, op de [github repo][repository] onder `oefeningen/oplossingen/Roplossingen/naamhoofdstuk`

Indien je vragen hebt over de oefeningen, dan kan je deze tijdens de geroosterde contactmomenten stellen via Teams. Heb je daarna nog vragen, dan kan je terecht op het forum van het opleidingsonderdeel. Vragen over oefeningen stel je op `Forum OZT/Oefeningen/Hoofstuknaam`. Per oefening kan je 1 topic aanmaken waar je met je vraag terecht kan. Maak geen twee topics voor dezelfde oefeningen. In de titel van de topic zet je het oefeningennummer.

Indien je een topic maakt, hanteer je de regels van [stackoverflow][Stackoverflow] met betrekking tot het stellen van vragen. Indien je vraag niet correct gesteld is, zal sowieso eerst gevraagd worden om de relevante informatie te bezorgen of eventuele code die je al had te posten. Bespaar jezelf en ons dus wat tijd. 

## NPE
De NPE verloopt zoals anders, en staat duidelijk en uitgebreid beschreven in het opgavedocument dat je kan terugvinden op Chamilo. We raden aan dit nog eens door te nemen. 

### Vragen rond NPE
Indien je inhoudelijke vragen hebt met betrekking tot de taak, dan kan je deze stellen via [de Teams app][Teams] tijdens de geroosterde uren. Indien de vraag met code te maken heeft (denk aan vragen rond het gebruik van R of LateX), dan kan het handig zijn een pull request of issue aan te maken in je repository en je begeleider als reviewer aan te duiden. Op deze manier kan er relatief efficiënt codefeedback verzorgd worden. In een pull request kan je meteen verwijzen naar je code, issues kan je gebruiken voor algemenere vragen.

Zit je toch met een prangende vraag buiten de contacturen, dan kan je natuurlijk terecht op het forum onder `Forum OZT/Taak`. 

 
# Nuttige referenties

- [leerpad]: https://chamilo.hogent.be/index.php?application=Chamilo%5CApplication%5CWeblcms&go=CourseViewer&course=36676 
- [repository]: https://github.com/HoGentTIN/onderzoekstechnieken-cursus 
- [Teams]: https://products.office.com/nl-be/microsoft-teams/group-chat-software 
- [stackoverflow]: https://stackoverflow.com/help/how-to-ask 

- Reguliere inleidingstekst

# Onderzoekstechnieken

Cursusmateriaal Onderzoekstechnieken.

## Installatie software

Voor de cursus onderzoekstechnieken maak je gebruik van verschillende softwarepakketten. Hier vind je wat uitleg over de installatie en hoe je er mee aan de slag kan. Heb je ondanks deze richtlijnen toch problemen? Tijdens de oefeningensessies kan je hulp vragen aan je lector. Als die je niet meteen kan verder helpen, kan je ook contact opnemen met [Bert Van Vreckem](mailto:bert.vanvreckem@hogent.be?subject=[OZT]%20Vraag%20ivm%20software-installatie).

### Windows

Installeer eerst de Chocolatey package manager als Administrator in een PowerShell (of CMD) terminal (<https://chocolatey.org/>).
Daarna voer je onderstaande commando's uit, opnieuw als Administrator in een PowerShell (of CMD) terminal.

```
choco install git
choco install miktex
choco install texstudio
choco install JabRef
choco install ghostwriter
choco install r.project
choco install r.studio
```

Als alternatief kun je de software ook op de *traditionele* wijze installeren. Download vanaf de projectwebsites en installeer:

- Git: <https://git-scm.com/download/win>
- MikTeX: <https://miktex.org/download>
- TeXStudio: <http://www.texstudio.org/>
- JabRef: <https://www.fosshub.com/JabRef.html>
- Ghostwriter: <https://wereturtle.github.io/ghostwriter/>
- R: <https://lib.ugent.be/CRAN/>
- Rstudio: <https://www.rstudio.com/products/rstudio/download/#download>

### MacOS X

Traditionele werkwijze

- Git: <https://git-scm.com/download/mac>
- MacTeX: <https://www.tug.org/mactex/mactex-download.html>
- TeXStudio: <http://www.texstudio.org/>
- JabRef: <https://www.fosshub.com/JabRef.html>
- R: <https://lib.ugent.be/CRAN/>
- Rstudio: <https://www.rstudio.com/products/rstudio/download/#download>

Via de homebrew package manager (<https://brew.sh/>). *Let op: werkwijze nog niet getest, feedback welkom!*

```
brew install git
brew install --cask mactex
brew install --cask texstudio
brew install --cask jabref
brew install Caskroom/cask/xquartz
```
- R en Rstudio moeten via de downloadpagina geïnstalleerd worden, indien je dit niet gedaan hebt, zullen er geen X11 libraries beschikbaar zijn die worden gebruikt door R. 
- Je kan de aanwezigheid van de X11 libraries controleren met het volgende commando in Rstudio:
```
capabilities()
```

Het is ook handig om een markdown editor te installeren (bvb. retext, ...)

### Linux:

**Ubuntu/Debian.** Controleer eerst de link naar de laatste versie van RStudio via de [website](https://www.rstudio.com/products/rstudio/download/#download)

```
sudo apt update
sudo apt install texlive-latex-base texlive-latex-extra texlive-lang-european texlive-bibtex-extra biber
sudo apt install git texstudio jabref r-base
cd ~/Downloads
wget https://download1.rstudio.org/rstudio-1.1.419-amd64.deb
sudo dpkg -i ./rstudio-1.1.419-amd64.deb
```

Het is ook handig om een markdown editor te installeren (bvb. retext, ghostwriter, ...)

**Fedora.** Controleer eerst de link naar de laatste versie van RStudio via de [website](https://www.rstudio.com/products/rstudio/download/#download)

```
sudo dnf install git texstudio texlive-collection-latex texlive-babel-dutch jabref
sudo dnf install retext
sudo dnf install R https://download1.rstudio.org/rstudio-1.1.419-x86_64.rpm
```

## Instellingen

### Git, Github

Wellicht heb je Git al geconfigureerd voor enkele van je andere vakken. Kijk eventueel alles nog eens na! Als alles ok is, kan je deze sectie overslaan.

**Wij raden aan om Git via de command line te gebruiken.** Zo krijg je het beste inzicht in de werking. Het commando `git status` geeft op elk moment een goed overzicht van de toestand van je lokale repository en geeft aan met welk commando je een stap verder kan zetten of de laatste stap ongedaan maken.

Eerst enkele tips:

- Als je nog geen gebruikersnaam hebt, kies er dan één die je na je afstuderen nog kan gebruiken (dus bv. niet je HoGent login). De kans is erg groot dat je tijdens je carrière nog van Github gebruik zult maken.
- Koppel je *HoGent*-emailadres aan je Github account (je kan meerdere adressen registreren). Op die manier kan je aanspraak maken op het [Github student developer pack](https://education.github.com/pack), wat je gratis toegang geeft tot een aantal in principe betalende producten en diensten.

Windows-gebruikers voeren volgende instructies uit via **Git Bash**,  
MacOS X- en Linux-gebruikers via de standaard (Bash) terminal.

```
git config --global user.name "Pieter Stevens"
git config --global user.email pieter.stevens.u12345@student.hogent.be
git config --global push.default simple
```

Maak ook een [SSH-sleutel](https://help.github.com/articles/connecting-to-github-with-ssh/) aan om het synchroniseren met Github te vereenvoudigen (je moet dan geen wachtwoord meer opgeven bij push/pull van/naar een private repository).

```
ssh-keygen
```

Volg de instructies op de command-line, druk gewoon ENTER als je gevraagd wordt een wachtwoordzin (pass phrase) in te vullen. In de home-directory van je gebruiker (bv. `c:\Users\Bert` op Windows, `/Users/bert` op Mac, `/home/bert` op Linux) is nu een directory met de naam `.ssh/` aangemaakt met twee bestanden: `id_rsa` (je private key) en `id_rsa.pub` (je public key). Open dit laatste bestand met een teksteditor en kopieer de volledige inhoud naar het klembord. Ga vervolgens naar je [Github profiel](https://github.com/settings/profile) en kies links voor [SSH and GPG keys](https://github.com/settings/keys). Klik rechtsboven op de groene knop met "New SSH Key" en plak de inhoud van je publieke sleutel in het veld "Key". Bevestig je keuze.

Test nu of je de code van de cursus Onderzoekstechnieken kan downloaden. Ga in de Bash shell naar een directory waar je dit project lokaal wil bijhouden en voer uit:

```
git clone git@github.com:HoGentTIN/onderzoekstechnieken-cursus.git
```

Als dit lukt, is er nu een directory aangemaakt met dezelfde naam als de repository, `onderzoekstechnieken-cursus/`. Doe tijdens het semester regelmatig `git pull` om de laatste wijzigingen in het cursusmateriaal bij te werken. Pas zelf geen bestanden aan binnen dit project, dit zal leiden tot conflicten.

### TeXStudio configureren

Controleer deze instellingen via menu-item *Options > Configure TeXstudio*

- Build:
    - Default Compiler: XeLaTeX
    - Default Bibliography tool: `biber`
- Commands:
    - XeLaTeX: `xelatex -synctex=1 -interaction=nonstopmode -shell-escape %.tex` (voeg de optie `-shell-escape` toe)
- Editor:
    - Indentation mode: *Indent and Unindent Automatically*
    - Replace Indentation Tab by Spaces: *Aanvinken*
    - Replace Tab in Text by spaces: *Aanvinken*
    - Replace Double Quotes: *English Quotes: ``''*

Om te testen of TeXStudio goed werkt, kan je het bestand `cursus/cursus-onderzoekstechnieken.tex` openen. Kies *Tools > Build & View* om de cursus te compileren in een PDF-bestand.

Veel functionaliteiten van LaTeX zitten in aparte packages die niet noodzakelijk standaard geïnstalleerd zijn. De eerste keer dat je een bestand compileert, is het dan ook mogelijk dat er extra packages moeten gedownload worden. MiKTeX zal een pop-up tonen om je toestemming te vragen, bevestig dit. De eerste keer compileren kan enkele minuten duren zonder dat je feedback krijgt over wat er gebeurt. Even geduld, dus.

Indien er zich fouten voordoen bij de compilatie, kan je onderaan in het tabblad *Log* een overzicht krijgen van de foutboodschappen. Wanneer je bij je lector hulp vraagt, is het belangrijk om de **exacte foutboodschap** mee te geven. Dat kan het makkelijkst door het tabblad *Logbestand* te selecteren en de gehele inhoud te kopiëren.

### JabRef

[JabRef](http://www.jabref.org/) is een GUI voor het bewerken van BibTeX-bestanden, een soort database van bronnen uit de wetenschappelijke of vakliteratuur voor een LaTeX-document.

van de bibliografische databank compatibel met dat van de cursus en het aangeboden LaTeX-sjabloon voor de bachelorproef
- Kies in het menu voor *Options > Preferences > General* en kies onderaan voor de optie "Default bibliography mode" voor "biblatex". Dit maakt de bestandsindeling van de bibliografische databank compatibel met dat van de cursus en het aangeboden LaTeX-sjabloon voor de bachelorproef.
- Kies in het *Preferences*-venster voor de categorie *File* en geef een directory op voor het bijhouden van PDFs van de gevonden bronnen onder *Main file directory*. Het is heel interessant om de gevonden artikels te downloaden en onder die directory bij te houden. Nog beter is om als naam van het bestand de BibTeX key te nemen (typisch naam van de eerste auteur + jaartal, bv. Knuth1998.pdf). Je kan het bestand dan makkelijk openen vanuit Jabref.

## Interessante artikels, ...

- [R Tutorial](https://www.tutorialspoint.com/r/)
- [Praktische Gids Bachelorproef](https://github.com/bertvv/bachproef-gids) (work in progress, door Bert Van Vreckem)
- [Joint Committee on Standards for Graphic Presentation](http://www.jstor.org/stable/2965153?seq=1#page_scan_tab_contents)
- [Spurious correlations](http://dangerousminds.net/comments/spurious_correlations_between_nicolas_cage_movies_and_swimming_pool)
- [Simpson's paradox](https://en.wikipedia.org/wiki/Simpson%27s_paradox)
- [Twenty Statistical Errors Even YOU Can Find in Biomedical Research Articles](http://web.udl.es/Biomath/Bioestadistica/CMJ%2020%20stat%20errors.pdf)
- [Anscombe's Quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet): vier verschillende datasets met identieke statistische eigenschappen. Toont het belang aan van data-visualisatie.
