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
mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), round)) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = c(disp, drat, wt, qsec), ~ round(digits = 1))) %>%
  head(2)



## -----------------------------------------------------------------------------

mtcars %>% 
  mutate(across(.cols = disp:qsec, round)) %>%
  head(2)

mtcars %>% 
  mutate(across(.cols = everything(), round))%>%
  head(2)


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
head(iris, 3)

iris %>% 
  modify_if(is.numeric, as.character) %>%
  head(3)


## -----------------------------------------------------------------------------
iris %>% 
  mutate(new =Sepal.Length + Petal.Width + Petal.Length + Sepal.Width) %>%
  head(2)

iris %>% 
  rowwise() %>%
  mutate(new =sum(Sepal.Length:Petal.Width))
  head(2)


## -----------------------------------------------------------------------------
iris %>%
  pmap(paste) %>%
  head()


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
list.files(here::here("data", "iris"), pattern = "*.csv")

file_list <- paste0(here::here(), "/data/iris/", list.files(here::here("data", "iris"), pattern = "*.csv"))

multifile_data <- file_list %>%
  map(read_csv)

class(multifile_data)



## ---- eval = FALSE------------------------------------------------------------
## head(multifile_data[[1]], 3)
## dim(multifile_data[[1]])
## head(multifile_data[[2]], 3)
## dim(multifile_data[[2]])
## head(multifile_data[[3]], 3)
## dim(multifile_data[[3]])
## 
## multifile_data[[2]] <- separate(multifile_data[[2]],
##                             col =`Sepal.Length:Sepal.Width:Petal.Length:Petal.Width:Species`,
##                          into = c("Sepal.Length", "Sepal.Width",
##                                   'Petal.Length', "Petal.Width", "Species"), sep = ":")
## head(multifile_data[[2]], 3)
## 
## multifile_data[[2]] <-multifile_data[[2]] %>% mutate(across(!Species, as.numeric))
## 


## ---- eval = FALSE------------------------------------------------------------
## library(plyr)
## combined<-ldply(multifile_data)
## dim(combined)
## 


## -----------------------------------------------------------------------------
bindrows_data <- multifile_data %>%
    map_df(bind_rows, .id = "experiment") # recall that modify keeps the same data type 
# so that will not do what we want here because we want a data frame!
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

