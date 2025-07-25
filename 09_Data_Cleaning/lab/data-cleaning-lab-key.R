## -----------------------------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------
library(readr)
ufo <- read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
library(janitor)
ufo <- clean_names(ufo)


## -----------------------------------------------------------------------------
South_West <- ufo %>% filter(state %in% c("tx", "nm", "ut")) %>%
  mutate(state = case_when(
    state  == "tx" ~ "Texas",
    state  == "nm" ~ "New_Mexico" ,
    state  ==  "ut" ~ "Utah"), 
    .defualt = state)
South_West



## -----------------------------------------------------------------------------
ufo %>%
  mutate(continent = case_when(country %in% c("ca", "us") ~ "North America",
                               country %in% c("gb", "de") ~ "Europe",
                               country == "au" ~ "Australia"))

