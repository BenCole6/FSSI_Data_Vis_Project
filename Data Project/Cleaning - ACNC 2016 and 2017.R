if(!("pacman" %in% rownames(installed.packages()))) {
  
  install.packages("pacman")
  
} else {
  
  require(pacman)
  
}

p_load(tidyverse,
       rmarkdown,
       plotly,
       readxl,
       janitor)

ACNC_2017 <- clean_names(read_excel("Web Report/ACNC Data/ACNC_ais17.xlsx"), "snake")

ACNC_2016 <- clean_names(read_excel("Web Report/ACNC Data/ACNC_ais16.xlsx"), "snake")

VIC_ACNC_2017 <- filter(ACNC_2017,
                        str_detect(state, regex("VIC|Victoria", ignore_case = T)))


