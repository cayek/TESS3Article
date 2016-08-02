################################################################################
# for color output
RED = \033[0;31m
GREEN =  \033[0;32m
NC = \033[0m # No Color
PRINT = @echo "$(GREEN)Building $@ $(NC)"

LATEX = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make
SRC = $(wildcard *.tex)
MAIN = draft

.PHONY: all

all: draft.pdf

view: draft.pdf
		evince draft.pdf&

draft.pdf: $(SRC)
		$(LATEX) draft.tex

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
