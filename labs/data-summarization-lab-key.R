## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
library(tidyverse)

circ = read_csv(paste0("http://sisbid.github.io/Data-Wrangling/",
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
  summarise(mean = mean(daily, na.rm = TRUE),
            n = n()) %>% 
  arrange(desc(mean)) 


## ----q6-----------------------------------------------------------------------
quantile(circ$orangeBoardings, na.rm = TRUE)
circ %>% 
  summarise(quantile(orangeBoardings, na.rm = TRUE))


## ----q7-----------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarise(quantile(orangeBoardings, na.rm = TRUE))


## -----------------------------------------------------------------------------
# Hint:
# qplot(x = ???, y = ???, data = ???, geom = "boxplot")
qplot(x = orangeBoardings, y = day, data = circ, geom = "boxplot")

