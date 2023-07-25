## ---- message = FALSE---------------------------------------------------------------------------------------
library(tidyverse)

crash <- read_csv("https://sisbid.github.io/Data-Wrangling/labs/crashes.csv")
road <- read_csv("https://sisbid.github.io/Data-Wrangling/labs/roads.csv")
head(crash)
head(road)


## -----------------------------------------------------------------------------------------------------------
merged <- inner_join(crash, road)
merged <- inner_join(crash, road, by = "Road")
nrow(merged)


## -----------------------------------------------------------------------------------------------------------
full <- full_join(crash, road)
nrow(full)


## -----------------------------------------------------------------------------------------------------------
left <- left_join(road, crash)
nrow(left)


## -----------------------------------------------------------------------------------------------------------
right <- right_join(road, crash)
nrow(right)


## -----------------------------------------------------------------------------------------------------------
roads1 <- road %>% pull(Road)
roads2 <- crash %>% pull(Road)
setdiff(roads1, roads2) # This value is in `road` but not `crash`

# Could also search for NAs created by the join
full %>% filter(is.na(N_Crashes))

anti_join(road, crash)


## -----------------------------------------------------------------------------------------------------------
roads1 <- road %>% pull(Road)
roads2 <- crash %>% pull(Road)
setdiff(roads2, roads1) # These values are in `crash` but not `road`

# Could also search for NAs created by the join. Would be good to summarize with `count`
full %>% filter(is.na(District)) %>% count(Road)

anti_join(crash, road)

