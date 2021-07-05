## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(tidyverse)


## ----merging------------------------------------------------------------------
base <- tibble(id = 1:10, Age = seq(55,60, length=10))
head(base, 2)


## -----------------------------------------------------------------------------
visits <- tibble(id = rep(2:11, 3), visit= rep(1:3, 10),
                    Outcome = seq(10,50, length=30))
head(visits, 2)


## ---- fig.alt="Innner join of two data frames.", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Join_inner-join.gif")


## ----inner_join---------------------------------------------------------------
ij = inner_join(base, visits)
dim(ij)
head(ij)


## ---- fig.alt="Left join of two data frames.", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Join_left-join.gif")


## ----left_join----------------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
head(lj)


## ---- include=FALSE-----------------------------------------------------------
library(tidylog)


## ----left_join_log------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)
left_join(base, visits)


## ---- fig.alt="Right join of two data frames.", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Join_right-join.gif")


## ----right_join---------------------------------------------------------------
rj = right_join(base, visits)


## ----right_join2--------------------------------------------------------------
lj2 = left_join(visits, base)


## ---- fig.alt="Full join of two data frames.", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Join_full-join.gif")


## ----full_join----------------------------------------------------------------
fj = full_join(base, visits)


## -----------------------------------------------------------------------------
# fj = full_join(base, visits)
head(fj, 10)


## ----include=FALSE------------------------------------------------------------
unloadNamespace("tidylog")


## -----------------------------------------------------------------------------
duplicated(1:5)
duplicated(c(1:5, 1))
fj %>% mutate(dup_id = duplicated(id))


## ----use_by-------------------------------------------------------------------
# for multiple, by = c(col1, col2)
head(full_join(base, visits, by = "id"))

