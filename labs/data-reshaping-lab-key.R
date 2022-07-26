## ----setup, include=FALSE----------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----------------------------------------------------------------------------------------------------------------------
library(tidyverse)


## ---- message = FALSE--------------------------------------------------------------------------------------------------
wide <- read_csv("http://sisbid.github.io/Data-Wrangling/data/Charm_City_Circulator_Ridership.csv")


## ----------------------------------------------------------------------------------------------------------------------
long <- wide %>% 
  pivot_longer( !c(daily, day, date), names_to = "name", values_to = "n_people")
head(long)


## ----------------------------------------------------------------------------------------------------------------------
# We over-wrote the day column by assigning it new values (in this case, calendar "day")
long2 <- long %>%
  separate(col = "date", into = c("month", "day", "year"),
           sep = "/", remove = FALSE)
table(long2$day)


## ---- error = TRUE-----------------------------------------------------------------------------------------------------
long3 <- long %>%
  mutate(
    name = str_replace(name, "Board", "_Board"),
    name = str_replace(name, "Alight", "_Alight"),
    name = str_replace(name, "Average", "_Average")
  ) %>%
  separate(name, into = c("route", "type"), sep = "_")



## ----------------------------------------------------------------------------------------------------------------------
wide_by_route <- long3 %>% 
  pivot_wider(names_from = route, values_from = n_people)


## ----------------------------------------------------------------------------------------------------------------------
wide_by_day <- long3 %>% 
  pivot_wider(names_from = day, values_from = n_people)

