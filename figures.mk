################################################################################
# for color output
RED = \033[0;31m
GREEN =  \033[0;32m
NC = \033[0m # No Color
PRINT = @echo "$(GREEN)Building $@ $(NC)"

################################################################################
# command
RSCRIPT = Rscript
LATEX = pdflatex

.PHONY: all figures rmarkdowns experiments

all: figures rmarkdowns experiments

################################################################################
# Figures

figures: $(FIGURES)

Figures/%.png: Figures/%.R setup.R
		$(PRINT)
		$(RSCRIPT) $<

Figures/%.R.pdf: Figures/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

Figures/%.tex: Figures/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

Figures/%.pdf: Figures/%.tex
		$(PRINT)
		$(LATEX) -output-directory=Figures/ $<

################################################################################
# Experiements

experiments: $(EXPERIMENTS)

Experiments/Results/TAIR9/%.RData: Experiments/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

Experiments/Results/%.RData: Experiments/%.R setup.R
		$(PRINT)
		$(RSCRIPT) $<

################################################################################
# Rmd

rmarkdowns: $(RMARKDOWNS)

%.html: %.Rmd
	$(PRINT)
	R --vanilla -e 'rmarkdown::render("$<")'
