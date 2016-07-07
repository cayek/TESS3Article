RSCRIPT = Rscript
TEX = pdflatex
PRINT = @echo -e "\e[1;34mBuilding $@\e[0m"

.PHONY: all

all:

################################################################################
# Figures



################################################################################
# Experiements

Experiments/Results/TAIR9/%.RData: Experiments/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<
