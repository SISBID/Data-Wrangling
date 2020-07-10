## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message = FALSE-------------------------------------------------------------
library(dplyr)
library(tidyverse)


## ---------------------------------------------------------------------------------
mtcars


## ---------------------------------------------------------------------------------
class(mtcars)


## ---------------------------------------------------------------------------------
dim(mtcars)
nrow(mtcars)
ncol(mtcars)
glimpse(mtcars)


## ---------------------------------------------------------------------------------
cars = mtcars
cars = rename(cars, MPG = mpg)
head(cars)


## ---------------------------------------------------------------------------------
cars = rename_all(cars, toupper)
head(cars)


## ----alternative------------------------------------------------------------------
cars = mtcars
cn = colnames(cars) # extract column names
cn = toupper(cn) # make them uppercase
colnames(cars) = cn # reassign
head(cars)


## ---------------------------------------------------------------------------------
cars = rownames_to_column(mtcars, var = "car")


## ---------------------------------------------------------------------------------
pvars = select(cars, ends_with("p"))


## ---------------------------------------------------------------------------------
carsSub = select(mtcars, wt, qsec, hp)
dim(carsSub)


## ---------------------------------------------------------------------------------
carsSub = rename_all(carsSub, toupper)


## ---------------------------------------------------------------------------------
cars_mpg = filter(cars, mpg > 18)
dim(cars_mpg)
nrow(cars_mpg)
# filter(cars, mpg > 20)


## ---------------------------------------------------------------------------------
cars %>% filter(mpg > 20) %>% nrow()
filter(cars, mpg > 20) %>% nrow()



## ---------------------------------------------------------------------------------
filter(cars, mpg < 16 & hp > 100)
nrow(filter(cars, mpg < 16 & hp > 100))
nrow(filter(cars, mpg < 16, hp > 100))
cars %>% filter(mpg < 16, hp > 100) %>% nrow()


## ---------------------------------------------------------------------------------
carsSub = filter(cars, cyl == 8) 
carsSub = select(carsSub, wt, qsec, hp, car)
dim(carsSub)
carsSub = cars %>% 
  filter(cyl == 8) %>% 
  select(wt, qsec, hp, car)
dim(carsSub)


## ---------------------------------------------------------------------------------
carsSub = arrange(carsSub, wt)


## ---------------------------------------------------------------------------------
carsSub %>% mutate(wt2 = wt^2)
carsSub = carsSub %>% mutate(wt2 = wt^2)

