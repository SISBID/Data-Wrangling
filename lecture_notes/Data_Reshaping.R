## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)


## ---- echo = FALSE, message=FALSE---------------------------------------------
library(tidyverse)


## ---- echo = FALSE------------------------------------------------------------
ex_wide = tibble(State = "Alabama",
                 June_vacc_rate = "37.2%",
                 May_vacc_rate = "36.0%",
                 April_vacc_rate = "32.4%"
                     )
ex_long = pivot_longer(ex_wide, cols = c(June_vacc_rate, May_vacc_rate, April_vacc_rate))


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- echo = FALSE------------------------------------------------------------
ex_wide = tibble(State = c("Alabama", "Alaska"),
                 June_vacc_rate = c("37.2%", "47.5%"),
                 May_vacc_rate = c("36.0%", "46.2%"),
                 April_vacc_rate = c("32.4%", "41.7%")
                     )
ex_long = pivot_longer(ex_wide, cols = c(June_vacc_rate, May_vacc_rate, April_vacc_rate))


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- fig.alt="Wide versus long data rearanges the position of column names and row content.", out.width = "60%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Reshape_pivot.jpg")


## ---- fig.alt="Wide versus long data rearanges the position of column names and row content, animated.", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Reshape_pivot_animated.gif")


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- message = FALSE---------------------------------------------------------
circ = read_csv(
  paste0("http://jhudatascience.org/intro_to_r/",
         "data/Charm_City_Circulator_Ridership.csv"))
head(circ, 5)


## -----------------------------------------------------------------------------
long = circ %>% 
  pivot_longer(starts_with(c("orange","purple","green","banner")),
               names_to = "var", values_to = "number")
long


## -----------------------------------------------------------------------------
long = circ %>% pivot_longer(!c(day, date, daily),
                    names_to = "var", values_to = "number")
long


## -----------------------------------------------------------------------------
long %>% count(var)


## -----------------------------------------------------------------------------
long = long %>% mutate(
  var = str_replace(var, "Board", "_Board"),
  var = str_replace(var, "Alight", "_Alight"),
  var = str_replace(var, "Average", "_Average") 
)
long


## -----------------------------------------------------------------------------
long = 
  long %>% 
  separate(var, into = c("line", "type"), sep = "_")
long


## -----------------------------------------------------------------------------
reunited = long %>% 
  unite(var, line, type, sep = "_")  
reunited


## -----------------------------------------------------------------------------
wide = long %>% pivot_wider(names_from = "type", 
                            values_from = "number") 
wide


## ---- fig.alt="Long form sandwich", out.width = "50%", echo = FALSE, fig.align='center'----
knitr::include_graphics("media/Reshape_pivot_sandwich.png")

