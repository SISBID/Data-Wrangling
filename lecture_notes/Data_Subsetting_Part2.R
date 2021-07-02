## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(comment = "")
library(tidyverse)


## -----------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4)
x > 2


## -----------------------------------------------------------------------------
x != NA
x > 2 & !is.na(x)


## -----------------------------------------------------------------------------
(x == 0 | x == 2) # has NA
(x == 0 | x == 2) & !is.na(x) # No NA


## -----------------------------------------------------------------------------
x %in% c(0, 2) # NEVER has NA and returns logical


## -----------------------------------------------------------------------------
x %in% c(0, 2, NA) # NEVER has NA and returns logical
x %in% c(0, 2) | is.na(x)


## -----------------------------------------------------------------------------
x + 2
x * 2


## ---- eval = FALSE------------------------------------------------------------
## ufo = read_csv("../data/ufo/ufo_data_complete.csv", col_types =
##                  cols(
##                    .default = col_character(),
##                    `duration (seconds)` = col_double(),
##                    longitude = col_double()
##                  ))
## head(ufo)

## ---- echo = FALSE------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv", col_types = 
                 cols(
                   .default = col_character(),
                   `duration (seconds)` = col_double(),
                   longitude = col_double()
                 ))
head(ufo)


## -----------------------------------------------------------------------------
ufo %>% 
  filter(is.na(state) | is.na(country)) %>% 
  head


## -----------------------------------------------------------------------------
ufo %>% 
  filter( 
    (!is.na(state) & is.na(country)) | city == "seattle") %>% 
  head


## -----------------------------------------------------------------------------
ufo = ufo %>% rename(City = city, duration_s = `duration (seconds)`)
head(ufo)


## -----------------------------------------------------------------------------
ufo_upper = ufo %>% rename_all(toupper)
head(ufo_upper)


## -----------------------------------------------------------------------------
ufo2 = ufo %>% mutate(State = toupper(state)) # we renamed city
ufo2 %>% select(State) %>% head


## ----codeNA-------------------------------------------------------------------
ages = data.frame(age = c(23,-999,21,44,32,57,65,54))
range(ages$age)


## -----------------------------------------------------------------------------
ufo2$State2 = tolower(ufo2$State)
ufo2 %>% select(state, State, State2) %>% head


## ----codeNA2------------------------------------------------------------------
ages = ages %>% mutate(age = ifelse(age == -999, NA, age))
range(ages$age)
range(ages$age,na.rm=TRUE)
ages


## ----codeFromNA---------------------------------------------------------------
ages = ages %>% mutate(age = ifelse(is.na(age), -999, age))
ages


## -----------------------------------------------------------------------------
ufo = ufo %>% mutate( 
            region = ifelse(
              country %in% c("us", "ca"),
              "North America",
              "Not North America")
            )
ufo %>% select(country, region) %>% head


## -----------------------------------------------------------------------------
ufo = ufo %>% mutate( 
            region = case_when(
              country %in% c("us", "ca") ~ "North America",
              country %in% c("de") ~ "Europe",
              country %in% "gb" ~ "Great Britain",
              TRUE ~ "Other"
            ))
ufo %>% select(country, region) %>% head


## -----------------------------------------------------------------------------
ufo %>% arrange(duration_s)


## -----------------------------------------------------------------------------
ufo %>% arrange(desc(duration_s))


## -----------------------------------------------------------------------------
ufo %>% arrange(country, desc(duration_s))

