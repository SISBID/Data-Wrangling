## -----------------------------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------
library(readr)
ufo = read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
library(janitor)
ufo = clean_names(ufo)


## -----------------------------------------------------------------------------
library(stringr)
str_subset(ufo$duration_hours_min, "min") %>% length()


## -----------------------------------------------------------------------------
sub = ufo %>% filter(str_detect(duration_hours_min, "min"))
sum(sub$duration_seconds < 60 | sub$duration_seconds > 3600)
(449/length(sub$duration_seconds))*100 # to get the percentage


## -----------------------------------------------------------------------------
str_subset(ufo$city, "field$") %>% length() # A
str_subset(ufo$city, "ton$") %>% length() # B
str_subset(ufo$city, "port$") %>% length() # C

