## ---- include=FALSE-------------------------------------------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## -------------------------------------------------------------------------------------------------------------
head(mtcars, 2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(2)


## -------------------------------------------------------------------------------------------------------------
my_function <- function(x){x + 1}
my_function


## -------------------------------------------------------------------------------------------------------------
my_data  <- c(2,3,4)

my_function(x = my_data)
my_function(my_data)


## -------------------------------------------------------------------------------------------------------------
mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(.x))) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(2)


## -------------------------------------------------------------------------------------------------------------

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(.x, digits = 1))) %>%
  head(n = 2)


mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(., digits = 1))) %>% 
  head(n = 2)
  


## -------------------------------------------------------------------------------------------------------------
mtcars %>% 
  mutate(across(.cols = disp:wt, round)) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = everything(), round))%>%
  head(2)


## -------------------------------------------------------------------------------------------------------------

iris %>% filter(Sepal.Length > 2.4 & Sepal.Width > 2.4 &
                Petal.Length > 2.4 & Petal.Width > 2.4)

iris %>% filter(if_all(Sepal.Length:Petal.Width, ~ . > 2.4))

iris %>% filter(if_all(where(is.numeric), ~ . > 2.4))


## -------------------------------------------------------------------------------------------------------------
library(stringr)
diamonds %>%
    filter(str_detect(cut, "Ideal|Premium")) %>% head(2)

diamonds %>%
    filter(cut %in% c("Ideal", "Premium"), z > 4 , color == "E") %>% head(2)


## -------------------------------------------------------------------------------------------------------------
mtcars %>%
   filter(if_all(c(cyl, gear, carb), ~.x > 3 & .x < 8))



## -------------------------------------------------------------------------------------------------------------
x <-c(1.2, 2.3, 3.5, 4.6)
map(x, round) %>% unlist()


## -------------------------------------------------------------------------------------------------------------
x <-tibble(values = c(1.2, 2.3, 3.5, 4.6))
map_df(x,  round)
modify(x, round)


## -------------------------------------------------------------------------------------------------------------
library(purrr)
head(mtcars, 2)
 mtcars %>% 
   map_df(round) %>% # will be a tibble now - will remove rownames
   head(2)
 mtcars %>% 
   modify(round) %>% # modify keeps original data type
   head(2)


## -------------------------------------------------------------------------------------------------------------
mtcars %>% 
  modify(format, digits = 1) %>%
  head(n = 2)

mtcars %>% 
  mutate(across(.cols = everything(), format, digits = 1)) %>%
  head(n = 2)


## -------------------------------------------------------------------------------------------------------------
head(as_tibble(iris), 3)

as_tibble(iris) %>% 
  modify_if(is.numeric, as.character) %>%
  head(3)

as_tibble(iris) %>% 
  map_if(is.numeric, as.character) %>%
  class()



## -------------------------------------------------------------------------------------------------------------
system.time(iris %>%
              modify_if(is.factor, as.character))


system.time(iris %>%
               mutate(across(.cols = where(is.factor), as.character)))



## ----makeList, comment="", prompt=TRUE------------------------------------------------------------------------
mylist <- list(
  letters = c("A", "b", "c"),
  numbers = 1:3,
  matrix(1:25, ncol = 5),
  matrix(1:25, ncol = 5)
)


## ----Lists, comment="", prompt=TRUE---------------------------------------------------------------------------
head(mylist)


## ----Listsref1, comment="", prompt=TRUE-----------------------------------------------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list


## ----Listsrefvec, comment="", prompt=TRUE---------------------------------------------------------------------
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'


## ----Listsref2, comment="", prompt=TRUE-----------------------------------------------------------------------
mylist[1:2] # returns a list


## -------------------------------------------------------------------------------------------------------------
head(mtcars)
str(mtcars %>% split(.$cyl))



## -------------------------------------------------------------------------------------------------------------

mtcars %>%
  split(.$cyl) %>% # creates split of data for each unique cyl value
  map(~lm(mpg ~ wt, data = .)) %>% # apply linear model to each
  map(summary) %>%
  map_dbl("r.squared")


## ---- message = FALSE-----------------------------------------------------------------------------------------
library(here)
library(readr)
list.files(here::here("data", "iris"), pattern = "*.csv")

file_list <- paste0(here::here(), "/data/iris/", list.files(here::here("data", "iris"), pattern = "*.csv"))

file_list

multifile_data <- file_list %>%
  map(read_csv)

class(multifile_data)



## -------------------------------------------------------------------------------------------------------------
multifile_data[[1]]


## -------------------------------------------------------------------------------------------------------------
multifile_data[[2]]


## -------------------------------------------------------------------------------------------------------------
multifile_data[[3]]


## -------------------------------------------------------------------------------------------------------------
multifile_data[[2]] <-
  separate(
    multifile_data[[2]],
    col = `Sepal.Length:Sepal.Width:Petal.Length:Petal.Width:Species`,
    into = c(
      "Sepal.Length",
      "Sepal.Width",
      'Petal.Length',
      "Petal.Width",
      "Species"
    ),
    sep = ":"
  )

head(multifile_data[[2]], 3)


## -------------------------------------------------------------------------------------------------------------
multifile_data[[2]] <-
  multifile_data[[2]] %>%
  mutate(across(!Species, as.numeric))

head(multifile_data[[2]], 3)


## -------------------------------------------------------------------------------------------------------------
# bind_rows(multifile_data[[1]], multifile_data[[3]], multifile_data[[2]])
bindrows_data <- multifile_data %>%
    map_df(bind_rows, .id = "experiment") # recall that modify keeps the same data type 
# so that will not do what we want here because we want a data frame instead of a list!
dim(bindrows_data)
tail(bindrows_data, 2)

