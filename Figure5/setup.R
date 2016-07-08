################################################################################
# Setup

# Install if not function
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}


pkgTest("raster")
pkgTest("ggplot2")
pkgTest("reshape2")
pkgTest("dplyr")
pkgTest("gridExtra")
pkgTest("cowplot")
pkgTest("DescTools")
pkgTest("doParallel")
pkgTest("foreach")
pkgTest("devtools")
pkgTest("permute")
pkgTest("crayon")

# personal packages
#devtools::install_github("cayek/TESS3_encho_sen@master")
require("tess3r")

################################################################################
# dir

res.dir <- "./Experiments/Results/TAIR9/"
fig.dir <- "./Figures/"
data.dir <- "../Data/"