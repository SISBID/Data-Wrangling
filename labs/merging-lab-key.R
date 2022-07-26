## ---- message = FALSE--------------------------------------------------------------------------------------------------
library(tidyverse)

crash <- read_csv("https://sisbid.github.io/Data-Wrangling/labs/crashes.csv")
road <- read_csv("https://sisbid.github.io/Data-Wrangling/labs/roads.csv")
head(crash)
head(road)


## ----------------------------------------------------------------------------------------------------------------------
merged <- inner_join(crash, road)
merged <- inner_join(crash, road, by = "Road")
nrow(merged)


## ----------------------------------------------------------------------------------------------------------------------
full <- full_join(crash, road)
nrow(full)


## ----------------------------------------------------------------------------------------------------------------------
left <- left_join(road, crash)
nrow(left)


## ----------------------------------------------------------------------------------------------------------------------
right <- right_join(road, crash)
nrow(right)


## ----------------------------------------------------------------------------------------------------------------------
no_dat <- crash %>% 
  anti_join(road) %>% 
  group_by(Road) %>%
  summarize(total_crashes = sum(N_Crashes))
no_dat


## ----------------------------------------------------------------------------------------------------------------------
corrections <- read_csv("https://sisbid.github.io/Data-Wrangling/labs/crashes_corrections.csv")

corrections$ROAD <- corrections$ROAD %>% str_replace("INTERSTATE", "Interstate")

crash %>% 
  full_join(corrections, by = c("Year" = "YEAR", "Road" = "ROAD"), suffix = c(".orig", ".checked")) %>%
  mutate(Corrected = ifelse(is.na(N_Crashes.checked), 0, 1)) %>%
  mutate(N_Crashes = ifelse(Corrected == 0, N_Crashes.orig, N_Crashes.checked)) %>%
  select(Year, Road, N_Crashes, Volume.orig, Corrected) %>%
  rename(Volume = Volume.orig)

