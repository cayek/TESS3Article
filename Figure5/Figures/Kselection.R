source("setup.R")
library(ggplot2)
library(tikzDevice)
library(tools)
library(tess3r)

################################################################################
# load res and data
res.file <- paste0(res.dir, "tess3.K110.rep5.RData")
load(res.file)

################################################################################
# plot

ggplot(data.frame(rmse = med, K = seq_along(tess3project.obj))) + geom_point(aes(x = as.factor(K), y = rmse)) + 
  geom_line(aes(x = K, y = rmse)) + 
  labs(y = "$RMSE$", x = "$K$") +
  theme_gray() + 
  theme(legend.position = "none")