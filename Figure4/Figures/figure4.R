source("setup.R")
library(tikzDevice)
library(gridExtra)
library(cowplot)
library(dplyr)


g_legend <- function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

load(paste0(res.dir,"runtimes.RData"))

toplot <- df.n  %>% group_by(method, n) %>% mutate(mean = mean(it), N = length(it), sd = sd(it), se = sd / sqrt(N))
pl.it.n <- ggplot(toplot ,aes(x = n, y = mean, col = method)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = .1) +
  theme_bw() +
  xlab("number of individuals") +
  ylab("number of iterations") +
  theme(legend.position = "none")

toplot <- df.n  %>% group_by(n, method) %>% mutate(mean = mean(time.per.it.mean), N = length(time.per.it.mean), sd = sd(time.per.it.mean), se = sd / sqrt(N))
pl.time.n <- ggplot(toplot ,aes(x = n, y = mean, col = method)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = .1) +
  theme_bw() +
  scale_y_log10() +
  xlab("number of individuals") +
  ylab("time per iteration") +
  theme(legend.position = "none")

toplot <- df.L  %>% group_by(method, L) %>% mutate(mean = mean(it), N = length(it), sd = sd(it), se = sd / sqrt(N))
pl.it.L <- ggplot(toplot ,aes(x = L, y = mean, col = method)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = .1) +
  theme_bw() +
  xlab("number of loci") +
  ylab("number of iterations") +
  theme(legend.position = "none")

toplot <- df.L  %>% group_by(L, method) %>% mutate(mean = mean(time.per.it.mean), N = length(time.per.it.mean), sd = sd(time.per.it.mean), se = sd / sqrt(N))
pl.time.L <- ggplot(toplot ,aes(x = L, y = mean, col = method)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = .1) +
  theme_bw() +
  scale_y_log10() +
  xlab("number of loci") +
  ylab("time per iteration") +
  theme(legend.position = "none")


tikzDevice::tikz(paste0(fig.dir,"figure4.tex"), width = 0.7 * page$width,
                 height = 0.7 * page$heigth, standAlone = TRUE)
mylegend <- g_legend(pl.time.L + theme(legend.position = "top"))
grid.arrange(plot_grid(pl.it.n, pl.it.L, pl.time.n, pl.time.L, ncol = 2, labels = c("A", "B", "C", "D")),
             mylegend, nrow = 2, heights = c(10, 1))
dev.off()
bup <- getwd()
setwd(fig.dir)
tools::texi2dvi("figure4.tex",pdf = TRUE)
setwd(bup)