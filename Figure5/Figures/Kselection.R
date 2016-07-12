source("setup.R")
library(ggplot2)
library(tikzDevice)
library(tools)
library(tess3r)

################################################################################
# load res and data
res.file <- paste0(res.dir, "err.K110.rep5.RData")
load(res.file)

################################################################################
# plot
toplot <- err.df %>% group_by(K) %>% 
  summarise(med = median(rmse), min = min(rmse), max = max(rmse),
            mean = mean(rmse), sd = sd(rmse), se = sd/sqrt(length(rmse)))

pl <- ggplot(toplot) + 
  geom_point(aes(x = as.factor(K), y = med)) + 
  geom_line(aes(x = K, y = med)) + 
  #geom_errorbar(aes(x = K, y = med, 
  #                  ymin=min, ymax=max), width=.1) +
  labs(y = "$RMSE$", x = "$K$") +
  theme_gray() + 
  theme(legend.position = "none")


tikzDevice::tikz(paste0(fig.dir,"Kselection.tex"), width = page$width * 0.7,
                 height = page$heigth * 0.7,standAlone = TRUE)
pl
dev.off()