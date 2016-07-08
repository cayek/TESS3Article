################################################################################
# Setup
library(tess3r)
library(raster)
library(ggplot2)
library(reshape2)
library(dplyr)
library(tikzDevice)
library(gridExtra)
library(cowplot)
library(foreach)
library(doParallel)
#library(tess3r)
#library(LEA)
library(DescTools)
source("../functions.R")


################################################################################
# Functions

################################################################################
# dir
res.dir <- "./Experiments/Results/"
fig.dir <- "./Figures/"
data.dir <- "../Data/"


################################################################################
# page size
page <- list(width = 8.3, heigth = 11.7)
