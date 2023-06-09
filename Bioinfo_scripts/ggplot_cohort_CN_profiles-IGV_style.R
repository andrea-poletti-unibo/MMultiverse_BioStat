library(tidyverse)
library(cowplot)

seg <- BOBaFIT::TCGA_BRCA_CN_segments

seg %>% names

seg$Segment_Mean %>% density() %>% plot

seg$Segment_Mean[seg$Segment_Mean>1.5] <- 1.5
seg$Segment_Mean[seg$Segment_Mean< -1.5 ] <- -1.5

seg$Segment_Mean %>% density() %>% plot

samples <- seg$ID %>% unique

CNV.df <- seg %>% filter(ID %in% samples[1:10])

fig.cnv <- ggplot(CNV.df, 
                  aes(xmin = start, xmax = end, ymin = 0, ymax = 1)) +
  geom_rect(aes(fill = Segment_Mean), colour = NA, size=0) +
  scale_fill_gradient2(low = "#2166AC", high = "#B2182B", mid = "#FFFFFF", 
                       na.value = "grey",
                       midpoint = median(CNV.df$Segment_Mean)) +
  labs(fill = "Copy number") +
  facet_grid(rows = vars(ID),
             cols = vars(chr),
             scales = "free", 
             space = "free",
             switch = "y") +
  theme_nothing() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.background = element_blank(),
    panel.spacing.y = unit(0, "lines"),
    panel.spacing.x = unit(0, "lines"),
    panel.border = element_blank(),
    strip.text.y.left = element_text(angle = 0, size = 3),
    strip.text.x.top = element_text(angle = 0, size = 7))

fig.cnv