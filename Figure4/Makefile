RSCRIPT = Rscript
PRINT = @echo -e "\e[1;34mBuilding $@\e[0m"
FIGURES = $(wildcard Figures/*.R)
FIGURES_SRC = $(wildcard Figures/*.R)
FIGURES = $(FIGURES_SRC:.R=.pdf)
EXPERIMENTS_SRC = $(wildcard Experiments/*.R)

.PHONY: all figures

all: figures

################################################################################
# Figures

figures: $(FIGURES)

Figures/%.pdf: Figures/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<

################################################################################
# Experiements

Experiments/Results/%.RData: Experiments/%.R setup.R
	$(PRINT)
	$(RSCRIPT) $<
