## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)

circ <- read_csv("https://sisbid.github.io/Data-Wrangling/data/Charm_City_Circulator_Ridership.csv")


## ----q1-----------------------------------------------------------------------
nrow(circ)
dim(circ)
circ %>% 
  nrow()


## ----q2-----------------------------------------------------------------------
sum(circ$greenBoardings, na.rm = TRUE)

circ %>% pull(greenBoardings) %>% sum(na.rm = TRUE)

count(circ, wt = greenBoardings)


## ----q3-----------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarize(mean = mean(daily, na.rm = TRUE))


## ----q4-----------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarize(median = median(orangeBoardings, na.rm = TRUE))


## ----q5-----------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarize(across(where(is.numeric), ~mean(.x, na.rm=T)))

