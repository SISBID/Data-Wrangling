## -----------------------------------------------------------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------------------------------------
library(readr)
ufo <- read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------------------------------------
library(janitor)
ufo_clean <- clean_names(ufo)


## -----------------------------------------------------------------------------------------------------------
South_West <- ufo_clean %>% filter(state %in% c("tx", "nm", "ut")) %>%
  mutate(recode(state, "Texas" = "tx",
                        "New_Mexico" = "nm",
                        "Utah" = "ut"))
South_West



## -----------------------------------------------------------------------------------------------------------
ufo_clean %>%
  mutate(continent = case_when(country %in% c("ca", "us") ~ "North America",
                               country %in% c("gb", "de") ~ "Europe",
                               country == "au" ~ "Australia"))

