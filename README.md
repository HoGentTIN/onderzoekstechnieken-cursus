# Onderzoekstechnieken

Cursusmateriaal Onderzoekstechnieken.

## Cursus-pdf genereren

De directory `cursus/` bevat de LaTeX-broncode voor de cursustekst. We publiceren bewust niet de PDF-versie om je aan te moedigen om met LaTeX te werken. De procedure om de PDF-versie zelf te genereren:

1. `latexmk -pdf "cursus-onderzoekstechnieken"`
2. `biber "cursus-onderzoekstechnieken"`
3. `latexmk -pdf "cursus-onderzoekstechnieken"`

Het commando `latexmk` (dat normaal beschikbaar is als je LaTeX geïnstalleerd hebt op je systeem), genereert de PDF aan de hand van het "hoofddocument" `cursus-onderzoekstechnieken.tex`. Het document is dan nog niet klaar, want de bibliografie zal op dat nog niet opgenomen zijn in de tekst. Daarom moet je nog eens het commando `biber` uitvoeren en opnieuw `latexmk`.

In TeXstudio:

1. Controleer eerst deze instellingen:
    - Options > Configure TeXstudio > Build
    - Default Compiler: `latexmk`
    - Default Bibliography tool: `biber`
3. Compile (F6)

## Interessante artikels, ...

- [R Tutorial](https://www.tutorialspoint.com/r/)
- [Praktische Gids Bachelorproef](https://github.com/bertvv/bachproef-gids) (work in progress, door Bert Van Vreckem)
- [Joint Committee on Standards for Graphic Presentation](http://www.jstor.org/stable/2965153?seq=1#page_scan_tab_contents)
- [Spurious correlations](http://dangerousminds.net/comments/spurious_correlations_between_nicolas_cage_movies_and_swimming_pool)
- [Simpson's paradox](https://en.wikipedia.org/wiki/Simpson%27s_paradox)
- [Twenty Statistical Errors Even YOU Can Find in Biomedical Research Articles](http://web.udl.es/Biomath/Bioestadistica/CMJ%2020%20stat%20errors.pdf)
- [Anscombe's Quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet): vier verschillende datasets met identieke statistische eigenschappen. Toont het belang aan van data-visualisatie.
