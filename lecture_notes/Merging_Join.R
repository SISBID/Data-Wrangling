## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(tidyverse)


## ----merging------------------------------------------------------------------
base <- tibble(id = 1:10, Age = seq(55,60, length=10))
head(base, 2)


## -----------------------------------------------------------------------------
visits <- tibble(id = c(rep(1:8, 3), 11), visit= c(rep(1:3, 8), 3),
                    Outcome = seq(10,50, length=25))
tail(visits, 2)


## ----inner_join---------------------------------------------------------------
ij = inner_join(base, visits)
dim(ij)
tail(ij)


## ----left_join----------------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
tail(lj)


## ----right_join---------------------------------------------------------------
rj = right_join(base, visits)
tail(rj, 3)


## ----right_join2--------------------------------------------------------------
rj2 = right_join(visits, base)
tail(rj2, 3)

## ----right_join_arrange, echo = FALSE-----------------------------------------
rj2 = arrange(rj2, id, visit) %>% select(id, visit, Outcome, Age)
lj = arrange(lj, id, visit) %>% select(id, visit, Outcome, Age)

## ----right_join_arrange_out---------------------------------------------------
identical(rj2, lj) ## after some rearranging


## ----full_join----------------------------------------------------------------
fj = full_join(base, visits)
tail(fj, 4)


## ---- include=FALSE-----------------------------------------------------------
library(tidylog)


## ----left_join_log------------------------------------------------------------
library(tidylog)
left_join(base, visits)


## ----include=FALSE------------------------------------------------------------
unloadNamespace("tidylog")


## ----use_by-------------------------------------------------------------------
base = base %>% mutate(x = 5)
visits = visits %>% mutate(x = 4)
head(full_join(base, visits))


## ----use_by_suffix------------------------------------------------------------
head(full_join(base, visits, by = "id"))
head(full_join(base, visits, by = "id", suffix = c("_base", "_visit")))


## ----use_by_diff--------------------------------------------------------------
base = base %>% 
  select(-x) %>% 
  mutate(myvar = 4)
visits = visits %>% 
  select(-x) %>% 
  mutate(MyVar = 4)
full_join(base, visits, by = c("id", "myvar" = "MyVar"))

