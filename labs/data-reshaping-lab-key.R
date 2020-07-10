## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)


## ---- message = FALSE---------------------------------------------------------
wide = read_csv(
  paste0("http://sisbid.github.io/Module1/",
         "data/Charm_City_Circulator_Ridership.csv"))
head(wide, 2)
class(wide$date)


## -----------------------------------------------------------------------------
long = wide %>% 
  gather(key = "variable", value = "n_people", -daily, -day, -date)
head(long$day)


## -----------------------------------------------------------------------------
long2 = separate(long, col = "date", into = c("month", "day", "year"), 
                sep = "/", remove = FALSE)
table(long2$day)


## -----------------------------------------------------------------------------
long2 = unite(long2, col = "newdate", year, month, day, sep = "-")
head(long2)


## ---- error = TRUE------------------------------------------------------------
long = long %>% 
  mutate(
    variable = variable %>% 
      str_replace("Board", "_Board") %>% 
      str_replace("Alight", "_Alight") %>% 
      str_replace("Average", "_Average") 
  )


## -----------------------------------------------------------------------------
long = separate(long, col = "variable", into = c("route", "type"), 
                sep = "_")


## -----------------------------------------------------------------------------
wide_by_route = spread(long, key = route, value = n_people)

