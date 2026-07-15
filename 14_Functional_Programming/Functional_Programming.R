## ----include=FALSE------------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## -----------------------------------------------------------------------------
sapply(mtcars, FUN = round)


## -----------------------------------------------------------------------------
mtcars %>% 
  mutate(across(
    c(mpg, disp, hp, drat), 
    round # no parentheses if no arguments
  ))


## -----------------------------------------------------------------------------
mtcars %>% 
  mutate(across(
    c(mpg, disp, hp, drat), 
    ~ round(., digits = -1) # note ~ and .
  ))


## -----------------------------------------------------------------------------
my_function <- function(x){x + 1}
my_function


## -----------------------------------------------------------------------------
my_data  <- c(2,3,4)

my_function(x = my_data)


## -----------------------------------------------------------------------------
my_function <- \(x){x + 1}
my_function

my_function(x = my_data)


## -----------------------------------------------------------------------------
mtcars %>% map(sum)


## -----------------------------------------------------------------------------
mtcars %>% map_dbl(sum)


## -----------------------------------------------------------------------------
mtcars %>% modify(round)


## -----------------------------------------------------------------------------
mtcars %>% modify(\(x) x * 100)


## ----message=FALSE------------------------------------------------------------
ufo1 <- read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_1.csv")


## -----------------------------------------------------------------------------
ufo1 %>% 
  modify_if(is.character, toupper) %>%
  head(3)


## -----------------------------------------------------------------------------
system.time(ufo1 %>% 
              modify_if(is.character, toupper))

system.time(ufo1 %>%
               mutate(across(where(is.character), toupper)))


## -----------------------------------------------------------------------------
mtcars %>%
  filter(cyl > 3 & cyl < 8,
         gear > 3 & gear < 8,
         carb > 3 & carb < 8)


## -----------------------------------------------------------------------------
mtcars %>%
   filter(if_all(c(cyl, gear, carb), ~.x > 3 & .x < 8))


## ----makeList-----------------------------------------------------------------
mylist <- list(
  letters = c("A", "b", "c"),
  numbers = 1:3,
  matrix(1:25, ncol = 5),
  iris
)


## ----Lists--------------------------------------------------------------------
head(mylist)


## ----Listsref1----------------------------------------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list


## ----Listsrefvec--------------------------------------------------------------
mylist[[1]] # returns the vector 'letters'
mylist[["letters"]] # returns the vector 'letters'


## ----message=FALSE------------------------------------------------------------
ufo1 <- read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_1.csv")
ufo2 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_2.tsv")
ufo3 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_3.csv", delim = ":")


## -----------------------------------------------------------------------------
ufo_datasets <- list(ufo1, ufo2, ufo3)


## ----message=FALSE------------------------------------------------------------
library(janitor)

ufo_datasets_clean <- 
  ufo_datasets %>%
  map(clean_names)


## ----message=FALSE------------------------------------------------------------
ufo_datasets_clean[[1]]


## ----message=FALSE------------------------------------------------------------
ufo_datasets %>%
  map(\(x) x %>% count(country))


## -----------------------------------------------------------------------------
head(mtcars)


## -----------------------------------------------------------------------------
mtcars_split <- mtcars %>% group_by(cyl) %>% group_split()
mtcars_keys <- mtcars %>% group_by(cyl) %>% group_keys() %>% pull(cyl)
names(mtcars_split) <- mtcars_keys
glimpse(mtcars_split)


## -----------------------------------------------------------------------------
mtcars_split %>% 
  map(~lm(mpg ~ wt, data = .)) %>% # apply linear model to each
  map(summary) %>%
  map_dbl("r.squared")

