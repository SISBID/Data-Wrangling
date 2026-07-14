## ----include=FALSE------------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## -----------------------------------------------------------------------------
sapply(mtcars, FUN = round)



## -----------------------------------------------------------------------------
rounded_mtcars <- mtcars %>% select(disp, drat, wt, qsec) %>%
sapply(FUN = round)
bind_cols(rounded_mtcars, select(mtcars, -c(disp, drat, wt, qsec)))


## -----------------------------------------------------------------------------
head(mtcars, 2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(2)


## -----------------------------------------------------------------------------

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(.x, digits = 1))) %>%
  head(n = 2)


mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(., digits = 1))) %>% 
  head(n = 2)
  


## -----------------------------------------------------------------------------
my_function <- function(x){x + 1}
my_function


## -----------------------------------------------------------------------------
my_data  <- c(2,3,4)

my_function(x = my_data)
my_function(my_data)


## -----------------------------------------------------------------------------
mtcars %>% 
  map_df(round, digits = 1) %>%
  head(n = 2)

mtcars %>% 
  mutate(across(.cols = everything(), ~ round(.x, digits = 1))) %>%
  head(n = 2)


## -----------------------------------------------------------------------------
head(as_tibble(iris), 3)

as_tibble(iris) %>% 
  modify_if(is.numeric, round) %>%
  head(3)


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


## ----message = FALSE----------------------------------------------------------
library(here)
library(readr)
file_list <- list.files(here::here("data/iris/"), pattern = "*.csv")

file_list <- paste0(here::here("data/iris/"), file_list)
file_list

multifile_data <- file_list %>%
  map(read_csv)


## -----------------------------------------------------------------------------
multifile_data[[1]]


## -----------------------------------------------------------------------------
multifile_data[[2]]


## -----------------------------------------------------------------------------
multifile_data[[3]]


## ----message=FALSE------------------------------------------------------------
delimiters <- c(",", ":", ",")  # delimiters for each file

# Write our own function to read files with specific delimiters:

read_with_delimiter <- function(file, delimiter) {
  read_delim(file, delim = delimiter)
}

# Map over file_list and delimiters
multifile_data <- map2(file_list, delimiters, read_with_delimiter)


## -----------------------------------------------------------------------------
multifile_data[[1]]


## -----------------------------------------------------------------------------
multifile_data[[2]]


## -----------------------------------------------------------------------------
multifile_data[[3]]


## -----------------------------------------------------------------------------
all_files_data <- 
  multifile_data %>%
  map_df(bind_rows, .id = "experiment")

glimpse(all_files_data)


## -----------------------------------------------------------------------------
my_function <- \(x){x + 1}
my_function

my_function(x = my_data)


## -----------------------------------------------------------------------------
mtcars %>%
  filter(cyl > 3 & cyl < 8,
         gear > 3 & gear < 8,
         carb > 3 & carb < 8)


## -----------------------------------------------------------------------------
mtcars %>%
   filter(if_all(c(cyl, gear, carb), ~.x > 3 & .x < 8))



## -----------------------------------------------------------------------------
mtcars %>% 
  mutate(across(.cols = disp:wt, round)) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = everything(), round))%>%
  head(2)


## -----------------------------------------------------------------------------
system.time(iris %>%
              modify_if(is.factor, as.character))


system.time(iris %>%
               mutate(across(.cols = where(is.factor), as.character)))



## ----Listsref2----------------------------------------------------------------
mylist[1:2] # returns a list


## -----------------------------------------------------------------------------
multifile_data[[2]] <-
  separate(
    multifile_data[[2]],
    col = 1,
    into = colnames(multifile_data[[1]]),
    sep = ":"
  )

head(multifile_data[[2]], 3)


## -----------------------------------------------------------------------------
multifile_data[[2]] <-
  multifile_data[[2]] %>%
  mutate(across(!Species, as.numeric))

head(multifile_data[[2]], 3)

