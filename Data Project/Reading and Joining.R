library(pacman)

p_load(tidyverse,
       lubridate,
       lemon,
       zoo,
       readxl,
       janitor)

Census_Path <- "../Master PowerBI Docs/Excel/Census 2016/"

for (file in list.files(Census_Path)) {
  
  if (str_ends(file, ".xls|.xlsx")){
    
    assign(value = read_excel(file.path(Census_Path, file)),
           x = str_replace_all(str_remove(file, ".xls|.xlsx"),
                               pattern = " ", replacement = "_"))
    
  } else if (str_ends(file, ".csv")) {
    
    assign(value = read_csv(file.path(Census_Path, file)),
           x = str_replace_all(str_remove(file, ".csv"),
                               pattern = " ", replacement = "_"))
    
  }
  
  else cat("\n ======================================================\n",
           "======================================================\n",
           file, "could not be read\n",
           "======================================================\n",
           "======================================================\n\n")
    
    next
  
}


p_load(plotly)

ggplot(ANZSCO_4_Age_Vic_Cleanx) +
  geom_bar(aes(x = ANZSCO_4_Name,
               y = people_count),
           stat = "identity") +
  coord_flip()

plot_ly(ANZSCO_4_Age_Vic_Cleanx,
        y = ~ANZSCO_4_Name,
        x = ~people_count,
        type = "bar",
        orientation = "h")

plot_ly(ANZSCO_4_Age_Vic_Individual_Year_Cleanx,
        x = ~Age,
        y = ~Count,
        type = "bar")

plot_ly(ANZSCO_4_Highest_Level_Educational_Attainment_Vic_Cleanx,
        y = ~variable,
        x = ~value,
        color = ~grouping,
        type = "bar",
        orientation = "h")

plot_ly(ANZSCO_4_Sex_Vic_Cleanx,
        y = ~ANZSCO_4_Name,
        x = ~Count,
        color = ~`SEXP Sex`,
        colors = c("#06d6bd", "#ea5456"),
        type = "bar",
        orientation = "h") %>% 
  layout(barmode = 'stack')

