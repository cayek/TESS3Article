source("setup.R")
library(tikzDevice)
library(gridExtra)
library(cowplot)

load(paste0(res.dir,"L.rmse.RData"))
load(paste0(res.dir,"n.rmse.RData"))
toplot <- df.n  %>% melt(id = c("n", "rep", "L", "method"), value.name = "rmse") %>% mutate(variable = ifelse(variable == "rmseQ", "$RMSE(Q,Q_0)$", "$RMSE(G,G_0)$")) %>% group_by(n, method, variable) %>% mutate(rmse.mean = mean(rmse), N = length(rmse), sd = sd(rmse), se = sd / sqrt(N))
pl.n <- ggplot(toplot ,aes(x = n, y = rmse.mean, col = method)) +
  geom_errorbar(aes(ymin = rmse.mean - se, ymax = rmse.mean + se), width = .1) +
  geom_line() +
  geom_point() +
  facet_grid(. ~ variable) +
  theme_bw() +
  xlab("$n$") +
  ylab("$RMSE$")

toplot <- df.L  %>% melt(id = c("nsites.neutral", "rep", "L", "method"), value.name = "rmse") %>% mutate(variable = ifelse(variable == "rmseQ", "$RMSE(Q,Q_0)$", "$RMSE(G,G_0)$")) %>% group_by(nsites.neutral, method, variable) %>% mutate(rmse.mean = mean(rmse), N = length(rmse), sd = sd(rmse), se = sd / sqrt(N), L = mean(L))
pl.L <- ggplot(toplot ,aes(x = L, y = rmse.mean, col = method)) +
  geom_errorbar(aes(ymin = rmse.mean - se, ymax = rmse.mean + se), width=.1) +
  geom_line() +
  geom_point() +
  facet_grid(. ~ variable) +
  theme_bw() +
  xlab("$L$") +
  ylab("$RMSE$")

tikzDevice::tikz(paste0(fig.dir,"figure1.tex"), width = 0.7 * page$width,
  height = 0.7 * page$heigth, standAlone = TRUE)
plot_grid(pl.n,pl.L, ncol = 1, labels = c("A", "B"))
dev.off()
bup <- getwd()
setwd(fig.dir)
tools::texi2dvi("figure1.tex", pdf = TRUE)
setwd(bup)
