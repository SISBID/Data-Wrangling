## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message = FALSE---------------------------------------------------------
library(dplyr)
library(tidyverse)


## -----------------------------------------------------------------------------
mpg = mpg %>% rename(YEAR = year)


## -----------------------------------------------------------------------------
mpg = rename_all(mpg, toupper)
head(mpg)


## -----------------------------------------------------------------------------
mpg = mpg %>% arrange(CYL)


## -----------------------------------------------------------------------------
mpg = mpg %>% mutate(CTY2 = CTY^2)
mpg


## -----------------------------------------------------------------------------
# any of the following work because all cars are in either of the to groups of car `CLASS` options listed

mpg1 = mpg %>% 
  mutate(
    group_class = case_when(
      CLASS %in% c("compact", "midsize", "minivan",
                   "subcompact", "2seater") ~ "car",
      TRUE ~ CLASS)
  )

mpg2 = mpg %>% 
  mutate(
    group_class = case_when(
      CLASS %in% c("compact", "midsize", "minivan",
                   "subcompact", "2seater") ~ "car",
      CLASS %in% c("pickup", "suv") ~ CLASS)
  )

mpg3 = mpg %>% 
  mutate(
    group_class = case_when(
      CLASS %in% c("pickup", "suv") ~ CLASS,
      TRUE ~ "car")
  )

mpg4 = mpg %>% 
  mutate(
    group_class = if_else(
      CLASS %in% c("pickup", "suv"), CLASS, "car")
  )

mpg5 = mpg %>% 
  mutate(
    group_class = if_else(
      CLASS %in% c("compact", "midsize", "minivan",
                   "subcompact", "2seater"), "car", CLASS)
  )

identical(mpg1, mpg2)
identical(mpg1, mpg3)
identical(mpg1, mpg4)
identical(mpg1, mpg5)

