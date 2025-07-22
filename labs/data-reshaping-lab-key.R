## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)


## ----message = FALSE----------------------------------------------------------
chicks <- datasets::ChickWeight


## -----------------------------------------------------------------------------
chicks_wide <- chicks %>% pivot_wider(names_from = Time, values_from = weight, names_prefix = "Time_")
chicks_wide


## -----------------------------------------------------------------------------
chicks_wide <- chicks_wide %>% filter(Time_0 <= 40 & Time_21 >= 200)
chicks_wide


## -----------------------------------------------------------------------------
chicks_wide <- chicks_wide %>% select(Chick, Diet, Time_0, Time_21)
chicks_wide


## -----------------------------------------------------------------------------
chicks_wide %>% pivot_longer(c(Time_0, Time_21), names_to = "Time", values_to = "weight")

