################################################################################
# Setup
library(raster)
library(ggplot2)
library(reshape2)
library(dplyr)
library(tikzDevice)
library(gridExtra)
library(cowplot)
source("../functions.R")

################################################################################
# dir
res.dir <- "./Experiments/Results/"
fig.dir <- "./Figures/"
data.dir <- "../Data/"


################################################################################
# page size
page <- list(width = 8.3, heigth = 11.7)
