RSCRIPT = Rscript
LATEX = pdflatex
PRINT = @echo -e "\e[1;34mBuilding $@\e[0m"
FIGURES = Figures/map.pdf Figures/manhattanplot.png \
Figures/Kselection.pdf Figures/variogram.pdf
EXPERIMENTS = Experiments/Results/TAIR9/err.K110.rep5.RData \
Experiments/Results/TAIR9/snpsTAIR9vepTAIR10.RData \
Experiments/Results/TAIR9/variogram.RData \
Experiments/Results/TAIR9/snmfK6.RData \
Experiments/Results/TAIR9/tess3K6.sigmaHeat1.5.RData
RMARKDOWNS = selectionScan.html

.PHONY: all figures rmarkdowns

all: figures rmarkdowns experiments

################################################################################
# Figures

figures: $(FIGURES)

Figures/%.png: Figures/%.R setup.R
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

################################################################################
# Rmd

rmarkdowns: $(RMARKDOWNS)

%.html: %.Rmd
	$(PRINT)
	R --vanilla -e 'rmarkdown::render("$<")'
