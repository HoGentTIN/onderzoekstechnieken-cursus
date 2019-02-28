# Slides lessen Onderzoekstechnieken

In deze directory vind je de LaTeX broncode voor de slides uit de lessen, opgemaakt volgens de huisstijl van HOGENT (zoals ingevoerd in academiejaar 2018-2019).

Het stijlsjabloon met enkele voorbeelden kan je terugvinden op <https://github.com/HoGentTIN/presentatie-latex-sjabloon>

## Vereisten

- Voor het gebruik van dit sjabloon heb je de volgende lettertypes nodig:
    - [Montserrat](https://fonts.google.com/specimen/Montserrat). Dit is het standaard-lettertype van de HOGENT huisstijl (i.h.b. de gewichten Regular, Semibold en Extrabold)
    - [Code Pro Black](https://www.dafontfree.net/freefonts-code-pro-black-f62435.htm). Dit lettertype wordt gebruikt voor de "fotoletters" (zie verder).
    - [Fira Code](https://github.com/tonsky/FiraCode). De HOGENT huisstijl specifieert geen lettertype voor monogespatieerde tekst, zoals gebruikt bij `\texttt` of in de `verbatim`-omgeving. Dit sjabloon gebruikt Fira Code, een lettertype met ligaturen voor programmacode.
- Omdat het sjabloon werkt met TrueType-lettertypes, moet je de presentatie compileren met **XeTeX** of LuaTex.
    - In TexStudio: Options > Configure Texstudio > Build
        - Default compiler: _txs:///xelatex_
        - PDF Chain: _txs:///xelatex | txs:///view-pdf_
