## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)

circ = read_csv(paste0("http://sisbid.github.io/Module1/",
                       "data/Charm_City_Circulator_Ridership.csv"))


## ----q1-----------------------------------------------------------------------
nrow(circ)
dim(circ)
circ %>% 
  nrow()


## ----q2-----------------------------------------------------------------------
sum(circ$greenBoardings, na.rm = TRUE)


## ----q3-----------------------------------------------------------------------
table(is.na(circ$daily), useNA = "ifany")

circ %>% 
  count(is.na(daily))

circ %>% 
  mutate(missing_daily = is.na(daily)) %>% 
  group_by(missing_daily) %>% 
  summarise(n())


## ----q4-----------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarise(n = n(),
            non_missing = sum(!is.na(daily)),
            mean = mean(daily, na.rm = TRUE)) %>% 
  arrange(desc(mean)) 

circ %>% 
  group_by(day) %>% 
  summarise(n = n(),
            non_missing = sum(!is.na(daily)),
            mean = mean(daily, na.rm = TRUE)) %>% 
  arrange(desc(mean)) %>% 
  ungroup() %>% 
  slice(1) %>% 
  magrittr::extract("day")


## ----q6-----------------------------------------------------------------------
quantile(circ$orangeBoardings, na.rm = TRUE)
circ %>% 
  summarise(quantile(orangeBoardings, na.rm = TRUE))

qplot(x = orangeBoardings, data = circ, geom = "histogram")
qplot(x = orangeBoardings, data = circ, geom = "density")


## ----q7-----------------------------------------------------------------------
quantile(circ$orangeBoardings, na.rm = TRUE)
circ %>% 
  group_by(day) %>% 
  summarise(quantile(orangeBoardings, na.rm = TRUE))


## -----------------------------------------------------------------------------
qplot(x = orangeBoardings, y = day, data = circ, geom = "boxplot")
qplot(x = day, y = orangeBoardings, data = circ, geom = "boxplot")

