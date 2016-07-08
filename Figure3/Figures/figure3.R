source("setup.R")
library(tikzDevice)
library(gridExtra)
library(cowplot)
library(dplyr)


load(paste0(res.dir,"auc.RData"))
toplot <- df %>%
  group_by(method, m.ms) %>%
  mutate(auc.mean = mean(auc), N = length(auc), sd = sd(auc), se = sd / sqrt(N))
pl <- ggplot(toplot ,aes(x = m.ms, y = auc.mean, col = method)) +
  geom_errorbar(aes(ymin = auc.mean - se, ymax = auc.mean + se), width = .1) +
  geom_line() +
  geom_point() +
  theme_bw() +
  xlab("$m/ms$") +
  ylab("$AUC$")
pl



tikzDevice::tikz(paste0(fig.dir,"figure3.tex"), width = 0.7 * page$width,
                 height = 0.7 * page$width, standAlone = TRUE)
pl
dev.off()
bup <- getwd()
setwd(fig.dir)
tools::texi2dvi("figure3.tex",pdf = TRUE)
setwd(bup)
