## -----------------------------------------------------------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------------------------------------
library(readr)
ufo <- read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------------------------------------
library(janitor)
ufo <- clean_names(ufo)


## -----------------------------------------------------------------------------------------------------------
ufo %>% filter(str_detect(duration_hours_min, "min"))%>% nrow()


## -----------------------------------------------------------------------------------------------------------
sub <- ufo %>% filter(str_detect(duration_hours_min, "min"),
                      duration_seconds<60 | duration_seconds >3600)
nrow(sub)


## -----------------------------------------------------------------------------------------------------------
ufo %>% pull(city) %>% str_subset("field$") %>% length() # A
ufo %>% pull(city) %>% str_subset("ton$") %>% length() # B
ufo %>% pull(city) %>% str_subset("port$") %>% length() # C

