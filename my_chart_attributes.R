mychartattributes <- theme_bw() + 
  theme(text=element_text(family="Helvetica")) + 
  theme(panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor = element_blank(),
        axis.line=element_line(colour="gray"),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank())