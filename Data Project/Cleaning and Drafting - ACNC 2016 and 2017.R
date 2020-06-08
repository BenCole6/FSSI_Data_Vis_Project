if(!("pacman" %in% rownames(installed.packages()))) {
  
  install.packages("pacman")
  
} else {
  
  require(pacman)
  
}

p_load(tidyverse,
       rmarkdown,
       plotly,
       readxl,
       janitor,
       scales,
       grid,
       gridExtra)

ACNC_2017 <- clean_names(read_excel("Web Report/ACNC Data/ACNC_ais17.xlsx"), "snake")

ACNC_2016 <- clean_names(read_excel("Web Report/ACNC Data/ACNC_ais16.xlsx"), "snake")

VIC_ACNC_2017 <- filter(ACNC_2017,
                        str_detect(state, regex("VIC|Victoria", ignore_case = T)))


gg_BarCount_17 <- ggplot(ACNC_2017) +
  geom_bar(aes(x = social_services,
               fill = social_services,
               text = "2017"),
           show.legend = F) +
  scale_y_continuous("Number of Charities",
                     labels = comma) +
  theme_minimal()

p_BarCount_17 <- ggplotly(gg_BarCount_17)


gg_BarCount_16 <- ggplot(ACNC_2016) +
  geom_bar(aes(x = social_services,
               fill = social_services,
               text = "2016"),
           show.legend = F) +
  scale_y_continuous("Number of Charities",
                     labels = comma) +
  theme_minimal()

p_BarCount_16 <- ggplotly(gg_BarCount_16)

grid.arrange(gg_BarCount_16, gg_BarCount_17,
             nrow = 1)

subplot(p_BarCount_16, p_BarCount_16,
        shareY = T, nrows = 1) %>% 
  layout(title = "Change in Victorian Charities in 2016 and 2017",
         showlegend = F)


for(col_name in colnames(VIC_ACNC_2017)) {
  
  if(c("n", "y") %in% unique(ACNC_2017[[col_name]]) == c(T, T)) {
    
    VIC_ACNC_2017[[col_name]] <- recode(VIC_ACNC_2017[[col_name]],
                                        "n" = F,
                                        "y" = T)
    
  }
}


summarise(group_by(VIC_ACNC_2017,
                   main_activity),
          count = n()) %>% 
  arrange(count)


colnames(VCOSS_ACNC_16)
