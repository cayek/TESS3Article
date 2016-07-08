RSCRIPT = Rscript
PRINT = @echo -e "\e[1;34mBuilding $@\e[0m"
FIGURES = $(wildcard Figures/*.R)
EXPERIMENTS = $(wildcard Experiments/*.R)

.PHONY: all figures experiments

all: figures experiments

################################################################################
# Figures
figures: $(FIGURES)


Figures/%.pdf: Figures/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

################################################################################
# Experiements

experiments: $(EXPERIMENTS)

Experiments/Results/TAIR9/%.RData: Experiments/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<
