## -----------------------------------------------------------------------
library(tidyverse)
library(naniar)

bike <-read_csv("https://sisbid.github.io/Data-Wrangling/labs/Bike_Lanes.csv")



## -----------------------------------------------------------------------
bike %>%
  pull(dateInstalled) %>%
  is.na() %>%
  any()


## -----------------------------------------------------------------------
have_rout <- bike %>% drop_na(route)


## -----------------------------------------------------------------------
gg_miss_var(bike)


## -----------------------------------------------------------------------
pull(bike, subType) %>% pct_complete() # this
miss_var_summary(bike) # or this

