source("setup.R")
library(ggplot2)
library(tikzDevice)
library(tools)

################################################################################
# load res and data
res.file <- paste0(res.dir, "variogram.RData")
load(res.file)

################################################################################
# Plot
pl <- ggplot(vario.gen, aes(x = h, y = semi.variance, size = size)) + 
  geom_point() + geom_vline(xintercept = 1.5, colour = "red") +
  labs(y = "Semivariance", 
       x = "Geographic distance between individuals (km $\\times 100$)") +
  theme_gray(base_size = 12) + 
  scale_size_continuous(range = c(1,3)) +
  guides(size = guide_legend(title = "Bin size"))



tikzDevice::tikz(paste0(fig.dir,"variogram.tex"), width = page$width * 0.7,
                 height = page$heigth * 0.7,standAlone = TRUE)
pl
dev.off()
