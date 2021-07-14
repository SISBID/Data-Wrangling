## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## -----------------------------------------------------------------------------
head(mtcars, 2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(2)


## -----------------------------------------------------------------------------
my_function <- function(x){x + 1}
my_function


## -----------------------------------------------------------------------------
my_data  <- c(2,3,4)

my_function(x = my_data)
my_function(my_data)


## -----------------------------------------------------------------------------
mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(.x))) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(1)


## -----------------------------------------------------------------------------

round_x <- mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(.x, digits = 1)))

head(round_x, 2)

round_per <- mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(., digits = 1)))
  
head(round_per, 2)

identical(round_x, round_per)



## -----------------------------------------------------------------------------
mtcars %>% 
  mutate(across(.cols = disp:qsec, round)) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = everything(), round))%>%
  head(2)


## -----------------------------------------------------------------------------
diamonds %>%
   filter(if_any(c(x, y, z), ~. > 11))

diamonds %>%
   filter(if_all(c(x, y, z), ~. > 8))



## -----------------------------------------------------------------------------
library(stringr)
diamonds %>%
    filter(str_detect(cut, "Ideal|Premium")) %>% head(2)

diamonds %>%
    filter(cut %in% c("Ideal", "Premium"), z > 4 , color == "E")


## -----------------------------------------------------------------------------
diamonds %>%
   filter(if_all(c(x, y, z), ~.x > 4 & .x < 5.5))

diamonds %>%
   filter(if_all(c(x, y, z), ~. == 0 | . > 8))


## -----------------------------------------------------------------------------
x <-c(1.2,2.3,3.5,4.6)
map(x, round) %>% unlist()
x <-tibble(values = c(1.2,2.3,3.5,4.6))
map_df(x,  round)


## -----------------------------------------------------------------------------
x <-c(1.2,2.3,3.5,4.6)
y <-c(2.4,5.3, 6.4, 1.0)
map2(x, y, min) %>% unlist()


## -----------------------------------------------------------------------------
trees$new <- trees$Volume-3
head(trees)
map2_dbl(trees$Girth, trees$new, min) %>% head()
map2_dbl(trees$Girth, trees$Height, function(x,y){ pi * ((x/2)/12)^2 * y})


## -----------------------------------------------------------------------------
pmap_list <-
  list(x = c(1.2,2.3,3.5,4.6), y = c(2.4,5.3, 6.4, 1.0), z = c(2,9, 4, 11.0))

pmap(pmap_list, min) %>% unlist()



## -----------------------------------------------------------------------------
library(purrr)
head(mtcars, 2)
 mtcars %>% 
   map_df(round) %>% # will be a tibble now - will remove rownames
   head(2)
 mtcars %>% 
   modify(round) %>% # modify keeps original data type
   head(2)


## -----------------------------------------------------------------------------
 mtcars %>% 
  map_df(round, digits = 1) %>%
  head()


## -----------------------------------------------------------------------------
head(as_tibble(iris), 3)

as_tibble(iris) %>% 
  modify_if(is.numeric, as.character) %>%
  head(3)

as_tibble(iris) %>% 
  map_if(is.numeric, as.character) %>%
  class()



## -----------------------------------------------------------------------------
mtcars %>%
  split(.$cyl) %>%
  map(~lm(mpg ~ wt, data = .)) %>%
  map(summary) %>%
  map_dbl("r.squared")


## ----makeList, comment="", prompt=TRUE----------------------------------------
mylist <- list(letters=c("A", "b", "c"), 
        numbers=1:3, matrix(1:25, ncol=5), matrix(1:25, ncol=5))


## ----Lists, comment="", prompt=TRUE-------------------------------------------
head(mylist)


## ----Listsref1, comment="", prompt=TRUE---------------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list


## ----Listsrefvec, comment="", prompt=TRUE-------------------------------------
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'


## ----Listsref2, comment="", prompt=TRUE---------------------------------------
mylist[1:2] # returns a list


## ----Listsref3, comment="", prompt=TRUE---------------------------------------
mylist$letters[1]
mylist[[2]][1]
mylist[[3]][1:2,1:2]


## ---- message = FALSE---------------------------------------------------------
library(here)
library(readr)
list.files(here::here("data", "iris"), pattern = "*.csv")

file_list <- paste0(here::here(), "/data/iris/", list.files(here::here("data", "iris"), pattern = "*.csv"))

file_list

multifile_data <- file_list %>%
  map(read_csv)

class(multifile_data)



## -----------------------------------------------------------------------------
multifile_data[[1]]
multifile_data[[2]]


## -----------------------------------------------------------------------------
multifile_data[[3]]


## -----------------------------------------------------------------------------
multifile_data[[2]] <- 
  separate(multifile_data[[2]], 
       col =`Sepal.Length:Sepal.Width:Petal.Length:Petal.Width:Species`, 
              into = c("Sepal.Length", "Sepal.Width", 
                      'Petal.Length', "Petal.Width", "Species"), 
       sep = ":")

head(multifile_data[[2]], 3)

multifile_data[[2]] <-
  multifile_data[[2]] %>%
  mutate(across(!Species, as.numeric))



## -----------------------------------------------------------------------------
# bind_rows(multifile_data[[1]], multifile_data[[3]], multifile_data[[2]])
bindrows_data <- multifile_data %>%
    map_df(bind_rows, .id = "experiment") # recall that modify keeps the same data type 
# so that will not do what we want here because we want a data frame instead of a list!
dim(bindrows_data)
tail(bindrows_data, 2)


## -----------------------------------------------------------------------------
set.seed(123)
data_highschool <- tibble(absences = sample(0:7, size = 32, replace = TRUE), 
                          grade = rep(c("Freshman","Sophmore", 
                                        "Junior", "Senior"), 8))
head(data_highschool, 3)


## -----------------------------------------------------------------------------
#boxplot(data = data_highschool, absences ~ grade)
data_highschool %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()



## -----------------------------------------------------------------------------
class(data_highschool$grade)
data_highschool_fct <- data_highschool %>% 
  mutate(grade = as_factor(grade))
head(data_highschool_fct, 3)


## -----------------------------------------------------------------------------
#boxplot(data = data_highschool_fct, absences ~ grade)
data_highschool_fct %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()



## -----------------------------------------------------------------------------
data_highschool %>% group_by(grade) %>% summarise(mean = mean(absences))

data_highschool_fct %>% group_by(grade) %>% summarise(mean = mean(absences))


## -----------------------------------------------------------------------------
#boxplot(data = data_highschool_fct, absences ~ fct_reorder(grade, absences))
data_highschool_fct %>%
  ggplot(mapping = aes(x = fct_reorder(grade, absences), 
                       y = absences)) +
  geom_boxplot()



## -----------------------------------------------------------------------------
#boxplot(data = data_highschool_fct, absences ~ fct_reorder(grade, absences, .desc = TRUE))
data_highschool_fct %>%
  ggplot(mapping = aes(x = fct_reorder(grade, absences, .desc = TRUE),
                       y = absences)) +
  geom_boxplot()



## -----------------------------------------------------------------------------

data_highschool_fct %>% group_by(grade) %>% summarise(mean = mean(absences))
data_highschool_fct$grade <- fct_reorder(data_highschool_fct$grade, 
                                         data_highschool_fct$absences,
                                         .desc = TRUE)
data_highschool_fct %>% group_by(grade) %>% summarise(mean = mean(absences))

