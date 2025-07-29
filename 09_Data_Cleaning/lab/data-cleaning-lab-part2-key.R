## -----------------------------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------
library(readr)
ufo <- read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
library(janitor)
ufo <- clean_names(ufo)


## -----------------------------------------------------------------------------
ufo %>% filter(str_detect(duration_hours_min, "min"))%>% nrow()


## -----------------------------------------------------------------------------
sub <- ufo %>% filter(str_detect(duration_hours_min, "min"),
                      duration_seconds >14400)
nrow(sub)


## -----------------------------------------------------------------------------
ufo %>% pull(city) %>% str_subset("port$") %>% length() # C

