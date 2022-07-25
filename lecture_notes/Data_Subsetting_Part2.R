## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(comment = "")
library(tidyverse)


## -----------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4)
x > 2


## -----------------------------------------------------------------------------
x
!is.na(x)
x > 2 & !is.na(x)


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


## ---- echo = FALSE, warning = FALSE-------------------------------------------
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
  head()


## -----------------------------------------------------------------------------
ufo %>% 
  filter( 
    (!is.na(state) & is.na(country)) | city == "seattle") %>% 
  head()


## -----------------------------------------------------------------------------
ufo = ufo %>% rename(City = city, duration_s = `duration (seconds)`)
head(ufo)


## -----------------------------------------------------------------------------
ufo_upper = ufo %>% rename_all(toupper)
head(ufo_upper)


## -----------------------------------------------------------------------------
ufo %>% select(state) %>% head(3)
ufo2 = ufo %>% mutate(State = toupper(state)) # we renamed city
ufo2 %>% select(State) %>% head(3)


## ----codeNA-------------------------------------------------------------------
ages = data.frame(age = c(23,-999,21,44,32,57,65,54))
range(ages$age)


## -----------------------------------------------------------------------------
pull(ages, age)
ages = ages %>% mutate(over_20 = ifelse(age > 30, "Yes", "No"))
ages


## ----codeNA2------------------------------------------------------------------
pull(ages, age)
ages = ages %>% mutate(age = ifelse(age == -999, NA, age))
range(ages$age)
range(ages$age, na.rm=TRUE)
pull(ages, age)


## -----------------------------------------------------------------------------
ufo = ufo %>% mutate( 
              region = ifelse(
              country %in% c("us", "ca"),
              "North America",
              "Not North America")
            )
ufo %>% select(country, region) %>% head()


## -----------------------------------------------------------------------------
ufo = ufo %>% mutate( 
            region = case_when(
              country %in% c("us", "ca") ~ "North America",
              country %in% c("de") ~ "Europe",
              country %in% "gb" ~ "Great Britain"
            ))

ufo %>% select(country, region) %>% head()


## -----------------------------------------------------------------------------
ufo = ufo %>% mutate( 
            region = case_when(
              country %in% c("us", "ca") ~ "North America",
              country %in% c("de") ~ "Europe",
              country %in% "gb" ~ "Great Britain",
              TRUE ~ "Other"
            ))
ufo %>% select(country, region) %>% head()


## -----------------------------------------------------------------------------
ufo %>% arrange(duration_s)


## -----------------------------------------------------------------------------
ufo %>% arrange(desc(duration_s))


## -----------------------------------------------------------------------------
ufo %>% arrange(country, desc(duration_s))

