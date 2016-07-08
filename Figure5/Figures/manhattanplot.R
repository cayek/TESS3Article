source("setup.R")
library(ggplot2)
library(tikzDevice)
library(tools)
library(tess3r)

################################################################################
# load res and data
res.file <- paste0(res.dir, "tess3K6.sigmaHeat1.5.RData")
load(res.file)
res.file <- paste0(res.dir, "snmfK6.RData")
load(res.file)
res.file <- paste0(res.dir, "snpsTAIR9vepTAIR10.RData")
load(res.file)
data.file <-
  paste0(data.dir, "AthalianaGegMapLines/call_method_75/call_method_75_TAIR9.RData")
load(data.file)

################################################################################
# Plot TESS3 manhattanplot
toplot <- data.frame(fst = tess3Main.obj$Fst, 
                     pvalue = tess3Main.obj$pvalue,
                     call_method_75_TAIR9.europe$locus.coord, 
                     index = seq_along(tess3Main.obj$Fst))

## control fdr


## plot
pl <- ggplot(toplot, aes(x = index, y = -log(pvalue), 
                         color = as.factor(Chromosome), fill = Chromosome)) + 
  geom_point() + 
  labs(y = "-log(pvalue)", x = "locus index") +
  theme_gray() + 
  theme(legend.position = "none")


# png(paste0(fig.dir,"G_K6_sigma1_5.png"), width = slide$width * 0.9,
#     height = slide$heigth * 0.8,res = 600, units = "in")
# pl 
# dev.off()

################################################################################
# Plot snmf
fst <- ComputeFst(snmf.obj$Q, snmf.obj$G, 1)
pvalue <- 
toplot <- data.frame(fst = fst, 
                     pvalue = pvalue,
                     call_method_75_TAIR9.europe$locus.coord, 
                     index = seq_along(fst))

## controle fdr


## plot
pl <- ggplot(toplot, aes(x = index, y = -log(pvalue), 
                         color = as.factor(Chromosome), fill = Chromosome)) + 
  geom_point() + 
  labs(y = "-log(pvalue)", x = "locus index") +
  theme_gray() + 
  theme(legend.position = "none")

################################################################################
# Comparison snmf tess3
todo

