source("setup.R")
library(ggplot2)
library(tikzDevice)
library(tools)

################################################################################
# load res and data
res.file <- paste0(res.dir, "tess3K6.sigmaHeat1.5.RData")
load(res.file)

################################################################################
# Plot
TODO