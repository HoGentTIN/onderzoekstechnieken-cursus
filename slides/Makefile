## POSIX-compliant Makefile for compiling LaTeX files in the current directory

##---------- Preliminaries ----------------------------------------------------
.POSIX:     # Get reliable POSIX behaviour
.SUFFIXES:  # Clear built-in inference rules
.PHONY : help clean mrproper

##---------- Variables --------------------------------------------------------

# LaTeX command for compiling the .tex files:
latex_cmd := latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -shell-escape
sources := $(wildcard ozt-*.tex)           # Files to be compiled
pdfs := $(patsubst %.tex,%.pdf,$(sources)) # Names of all resulting PDFs

##---------- Build targets ----------------------------------------------------

help: ## Toon deze hulpboodschap
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "Specifieke PDF genereren: make NAAM.pdf\n"
	@printf "Met NAAM een van de hieronder opgesomde bestandsnamen:\n"
	@printf "\033[36m%s\033[0m\n" $(pdfs)

all: $(pdfs) ## Compileer alle LaTeX-bestanden (hieronder opgesomd)

%.pdf: %.tex
	$(latex_cmd) $<

clean: ## Verwijder LaTeX hulpbestanden
	rm -vf ./*.{bak,aux,log,nav,out,snm,ptc,toc,bbl,blg,idx,ilg,ind,tcp,vrb,tps,lof,log,lol,lot,synctex.gz,fls,fdb_latexmk,bcf,run.xml,xdv}
	rm -vrf _minted*

mrproper: clean ## Verwijder LaTeX hulpbestanden én PDFs
	rm -v *.pdf