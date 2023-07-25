## ---- echo = FALSE, include=FALSE---------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(tidyverse)


## ----echo=FALSE---------------------------------------------------------------------------------------------
data_As <- tibble(State = c("Alabama", "Alaska"),
                 June_vacc_rate = c("37.2%", "47.5%"),
                 May_vacc_rate = c("36.0%", "46.2%"))
data_cold <- tibble(State = c("Maine", "Alaska"),
                    April_vacc_rate = c("32.4%", "41.7%"))


## -----------------------------------------------------------------------------------------------------------
data_As
data_cold


## ---- fig.alt="A gif showing the inner joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Join_inner-join.gif")


## ----inner_join---------------------------------------------------------------------------------------------
ij = inner_join(data_As, data_cold)
ij


## ---- fig.alt="A gif showing the left joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Join_left-join.gif")


## ----left_join----------------------------------------------------------------------------------------------
lj = left_join(data_As, data_cold)
lj


## ---- include=FALSE-----------------------------------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)


## ----left_join_log------------------------------------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)
left_join(data_As, data_cold)


## ---- fig.alt="A gif showing the right joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Join_right-join.gif")


## ----right_join---------------------------------------------------------------------------------------------
rj <- right_join(data_As, data_cold)
rj


## ----right_join2--------------------------------------------------------------------------------------------
lj2 <- left_join(data_cold, data_As)
lj2


## ---- fig.alt="A gif showing the full joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Join_full-join.gif")


## -----------------------------------------------------------------------------------------------------------
fj <- full_join(data_As, data_cold)
fj


## ----echo=FALSE---------------------------------------------------------------------------------------------
data_As <- tibble(State = c("Alabama", "Alaska"),
                 state_bird = c("wild turkey", "willow ptarmigan"))
data_cold <- tibble(State = c("Maine", "Alaska", "Alaska"),
                    vacc_rate = c("32.4%", "41.7%", "46.2%"),
                    month = c("April", "April", "May"))


## -----------------------------------------------------------------------------------------------------------
data_As
data_cold


## -----------------------------------------------------------------------------------------------------------
lj <- left_join(data_As, data_cold)


## -----------------------------------------------------------------------------------------------------------
lj


## ---- fig.alt="A gif showing how data can be duplicated from one dataset when joining two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Join_left_join_extra.gif")


## -----------------------------------------------------------------------------------------------------------
unloadNamespace("tidylog")


## ----use_by-------------------------------------------------------------------------------------------------
full_join(data_As, data_cold, by = "State")


## ----eval=FALSE---------------------------------------------------------------------------------------------
full_join(x, y, by = c("a" = "b"))


## -----------------------------------------------------------------------------------------------------------
data_As
data_cold


## -----------------------------------------------------------------------------------------------------------
A_states <- data_As %>% pull(State)
cold_states <- data_cold %>% pull(State)


## -----------------------------------------------------------------------------------------------------------
setdiff(A_states, cold_states)
setdiff(cold_states, A_states)


## -----------------------------------------------------------------------------------------------------------
one <- starwars[1:4, ]
two <- starwars[9:12, ]

bind_rows(one, two)

