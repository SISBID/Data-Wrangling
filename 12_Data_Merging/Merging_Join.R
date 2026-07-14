## ----echo = FALSE, include=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(tidyverse)


## ----fig.alt="Inner, outer, left, and right joins represented with venn diagrams", out.width = "50%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/joins.png")


## ----echo=FALSE---------------------------------------------------------------
data_As <- tibble(
  State = c("Alabama", "Alaska"),
  June_vacc_rate = c(0.516, 0.627),
  May_vacc_rate = c(0.514, 0.626)
)
data_cold <- tibble(
  State = c("Maine", "Alaska", "Vermont"),
  April_vacc_rate = c(0.795, 0.623, 0.82)
)


## -----------------------------------------------------------------------------
data_As
data_cold


## ----fig.alt="A gif showing the inner joining of two simple datasets.", out.width = "40%", echo = FALSE----
knitr::include_graphics("../images/Join_inner-join.gif")


## ----out.width = "50%", echo = FALSE, fig.show='hold'-------------------------
include_graphics("../images/joining_data.png")
include_graphics("../images/inner.png")


## -----------------------------------------------------------------------------
lj <- inner_join(data_As, data_cold)
lj


## ----fig.alt="A gif showing the left joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Join_left-join.gif")


## ----out.width = "50%", echo = FALSE, fig.show='hold'-------------------------
include_graphics("../images/joining_data.png")
include_graphics("../images/left.png")


## ----left_join----------------------------------------------------------------
lj <- left_join(data_As, data_cold)
lj


## ----include=FALSE------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)


## ----left_join_log------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)
left_join(data_As, data_cold)


## ----fig.alt="A gif showing the right joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Join_right-join.gif")


## ----out.width = "50%", echo = FALSE, fig.show='hold'-------------------------
include_graphics("../images/joining_data.png")
include_graphics("../images/right.png")


## ----right_join---------------------------------------------------------------
rj <- right_join(data_As, data_cold)
rj


## ----right_join2--------------------------------------------------------------
lj2 <- left_join(data_cold, data_As)
lj2


## ----fig.alt="A gif showing the full joining of two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Join_full-join.gif")


## ----out.width = "50%", echo = FALSE, fig.show='hold'-------------------------
include_graphics("../images/joining_data.png")
include_graphics("../images/full.png")


## -----------------------------------------------------------------------------
fj <- full_join(data_As, data_cold)
fj


## ----fig.alt="A gif showing how data can be duplicated from one dataset when joining two simple datasets.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Join_left_join_extra.gif")


## -----------------------------------------------------------------------------
unloadNamespace("tidylog")


## ----use_by-------------------------------------------------------------------
full_join(data_As, data_cold, by = "State")


## ----eval=FALSE---------------------------------------------------------------
# full_join(x, y, by = c("state" = "entity_territory"))


## -----------------------------------------------------------------------------
data_As
data_cold


## -----------------------------------------------------------------------------
A_states <- data_As %>% pull(State)
cold_states <- data_cold %>% pull(State)


## -----------------------------------------------------------------------------
setdiff(A_states, cold_states)
setdiff(cold_states, A_states)


## ----error = TRUE-------------------------------------------------------------
try({
rbind(data_As, data_cold)
})


## -----------------------------------------------------------------------------
bind_rows(data_As, data_cold)


## -----------------------------------------------------------------------------
full_join(data_As, data_cold)


## ----out.width = "50%", echo = FALSE, fig.show='hold'-------------------------
include_graphics("../images/joining_data.png")
include_graphics("../images/Antijoin-in-R.png")


## ----fig.alt="A gif showing the full joining of two simple datasets.", out.width = "50%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Join_anti-join.gif")


## -----------------------------------------------------------------------------
anti_join(data_As, data_cold)


## -----------------------------------------------------------------------------
anti_join(data_cold, data_As)


## -----------------------------------------------------------------------------
cross_join(data_As, data_cold)


## -----------------------------------------------------------------------------
nj <- nest_join(data_As, data_cold)


## -----------------------------------------------------------------------------
nj


## -----------------------------------------------------------------------------
nj %>% pull(data_cold)


## -----------------------------------------------------------------------------
data_As <- tibble(State = c("Alabama", "Alaska", "Alaska"),
                 state_bird = c("wild turkey", "willow ptarmigan", "puffin"))
data_cold <- tibble(State = c("Maine", "Alaska", "Alaska"),
                    vacc_rate = c("32.4%", "41.7%", "46.2%"),
                    month = c("April", "April", "May"))


## -----------------------------------------------------------------------------
full_join(data_As, data_cold)

