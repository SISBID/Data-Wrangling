## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ----factor1------------------------------------------------------------------
x <- c("yellow", "red", "red", "blue", "yellow", "blue")
class(x)

x_fact <- factor(x) # factor() is a function
class(x_fact)


## -----------------------------------------------------------------------------
x
x_fact


## -----------------------------------------------------------------------------
levels(x_fact)


## -----------------------------------------------------------------------------
ufo <- 
  read_csv("https://raw.githubusercontent.com/SISBID/Module1/gh-pages/data/ufo/ufo_data_complete.csv")


## ----messages=FALSE, warning = FALSE, include = FALSE-------------------------
library(janitor)
ufo <- clean_names(ufo)



## -----------------------------------------------------------------------------
ufo <- clean_names(ufo)
glimpse(ufo)


## -----------------------------------------------------------------------------
ufo <- ufo %>%separate(datetime,into = c("date", "time"), sep = " ")

glimpse(ufo)


## -----------------------------------------------------------------------------
ufo <- ufo %>% separate(time, into= c("hour", "min")) 

glimpse(ufo)


## -----------------------------------------------------------------------------
ufo <-ufo %>% mutate(hour = as.numeric(hour), min = as.numeric(min))

glimpse(ufo)


## -----------------------------------------------------------------------------
ufo <- ufo %>%   mutate(timespan = 
                    case_when(hour %in%c(18,19,20,21)~ "Evening", 
                              hour >21 ~ "Night",
                              hour >=0 & hour <12 ~ "Morning",
                              hour >=12 & hour <18 ~ "Afternoon"))

ufo %>% count(timespan)


## -----------------------------------------------------------------------------
ufo %>% count(timespan)



## -----------------------------------------------------------------------------

ufo %>% arrange(timespan) %>% glimpse()



## ----fig.width= 5-------------------------------------------------------------
count(ufo, timespan) %>% ggplot(aes(x  = timespan, y = n)) + geom_col()


## -----------------------------------------------------------------------------
ufo <- ufo %>% mutate(timespan = factor(timespan, levels = 
                  c("Morning", "Afternoon", "Evening", "Night")))



## -----------------------------------------------------------------------------

ufo %>% count(timespan)



## -----------------------------------------------------------------------------

ufo %>% arrange(timespan) %>% glimpse()



## ----fig.height= 3, fig.width=5-----------------------------------------------
count(ufo, timespan) %>% ggplot(
  aes(x  = timespan, y = n)) + 
  geom_col() + 
  xlab("General Time of Sighting") + ylab("Frequency")+
  theme_bw(base_size = 16) 


## ----fig.alt="Forcats hex sticker", out.width = "30%", echo = FALSE, fig.align='center'----
knitr::include_graphics("https://github.com/tidyverse/forcats/raw/main/man/figures/logo.png")


## ----eval=FALSE---------------------------------------------------------------
# fct_reorder({column getting changed}, {guiding column}, {summarizing function})


## ----fig.height= 3, fig.width=5-----------------------------------------------
count(ufo, timespan) %>% ggplot(
  aes(x  = fct_reorder(timespan, n), y = n)) + 
  geom_col() + 
  xlab("General Time of Sighting") + ylab("Frequency")+
  theme_bw(base_size = 16) 


## ----fig.height= 3, fig.width=5-----------------------------------------------
count(ufo, timespan) %>% ggplot(
  aes(x  = fct_reorder(timespan, n, .desc = TRUE), y = n)) + 
  geom_col() + 
  xlab("General Time of Sighting") + ylab("Frequency")+
  theme_bw(base_size = 16) 


## -----------------------------------------------------------------------------
ufo %>%
  pull(timespan) %>%
  fct_count(prop = TRUE)

