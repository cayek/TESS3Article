RSCRIPT = Rscript
PRINT = @echo -e "\e[1;34mBuilding $@\e[0m"
FIGURES = $(wildcard Figures/*.R)
EXPERIMENTS = $(wildcard Experiments/*.R)

.PHONY: all

all: $(FIGURES) $(EXPERIMENTS)

################################################################################
# Figures

Figures/%.pdf: Figures/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

################################################################################
# Experiements

Experiments/Results/TAIR9/%.RData: Experiments/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<
