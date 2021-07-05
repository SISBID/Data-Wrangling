## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)


## ---- message = FALSE---------------------------------------------------------
wide = read_csv(
  "http://sisbid.github.io/Data-Wrangling/data/Charm_City_Circulator_Ridership.csv"
)


## -----------------------------------------------------------------------------
long = wide %>% 
  pivot_longer( !c(daily, day, date), names_to = "variable", values_to = "n_people")
head(long)


## -----------------------------------------------------------------------------
# We over-wrote the day column by assigning it new values (in this case, calendar "day")
long2 = long %>%
  separate(col = "date", into = c("month", "day", "year"),
           sep = "/", remove = FALSE)
table(long2$day)


## -----------------------------------------------------------------------------
long2 = long2 %>%
  unite(col = "newdate", year, month, day, sep = "-")
head(long2)


## ---- error = TRUE------------------------------------------------------------
long = long %>% 
  mutate(
    variable = variable %>% 
      str_replace("Board", "_Board") %>% 
      str_replace("Alight", "_Alight") %>% 
      str_replace("Average", "_Average") 
  )
head(long)


## -----------------------------------------------------------------------------
long = long %>%
  separate(col = "variable", into = c("route", "type"), sep = "_")
head(long)


## -----------------------------------------------------------------------------
wide_by_route = long %>% 
  pivot_wider(names_from = route, values_from = n_people)

