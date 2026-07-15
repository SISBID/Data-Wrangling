## ----include = FALSE----------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------
ufo <- read_csv(
"https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
ufo %>%
  mutate(across(
    where(is.character),
    toupper
  ))


## -----------------------------------------------------------------------------
ufo %>%
  modify_if(is.character, toupper)


## -----------------------------------------------------------------------------
ufo %>%
  mutate(across(
    where(is.character),
    toupper
  )) %>% system.time()

ufo %>%
  modify_if(is.character, toupper) %>%
  system.time()


## -----------------------------------------------------------------------------
ufo_list <- ufo %>% group_by(country) %>% group_split()


## -----------------------------------------------------------------------------
ufo_keys <- ufo %>% group_by(country) %>% group_keys() %>% pull(country)
names(ufo_list) <- ufo_keys


## -----------------------------------------------------------------------------
ufo_list %>%
  map(\(x) count(x, shape))

