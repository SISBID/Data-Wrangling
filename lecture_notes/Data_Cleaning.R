## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## ---- importUfo---------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
colnames(ufo)
ufo = clean_names(ufo)
colnames(ufo)


## -----------------------------------------------------------------------------
p = problems(ufo)
p


## -----------------------------------------------------------------------------
ufo = ufo[-p$row,] # brackets can also be used for subsetting


## ----isna---------------------------------------------------------------------
any(is.na(ufo$state)) # are there any NAs?
all(is.na(ufo$state)) # are the values all NAs?


## ----gender, echo=FALSE-------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)
data_gen = tibble(gender)


## ----gentab-------------------------------------------------------------------
table(gender)


## -----------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>% mutate(gender = 
                      case_when(gender %in% c("Male", "M", "m", "Man")
                                ~ "Male",
                           TRUE ~ gender)) 
head(data_gen)


## -----------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>%
                mutate(gender = str_to_sentence(gender)) %>%
                mutate(gender = 
                      case_when(gender %in% c("Male", "M", "m", "Man")
                                ~ "Male",
                           TRUE ~ gender)) 
head(data_gen)


## ----Paste--------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit", 1:5)


## ----Paste2-------------------------------------------------------------------

paste("Visit", 1:5, sep = "_") %>% length()
paste("Visit", 1:5, sep = "_", collapse = " ") %>% length()


## -----------------------------------------------------------------------------
paste("To", "is going be the ", "we go to the store!", sep = "day ")



## -----------------------------------------------------------------------------
str_sub("I like friesian horses", 8,12)
#123456789101112
#I like fries
str_sub(c("Site A", "Site B", "Site C"), 6,6)


## ----alienMatch---------------------------------------------------------------
str_detect(ufo$comments, "two aliens") %>% head()
str_detect(ufo$comments, "two aliens") %>% table()
which(str_detect(ufo$comments, "two aliens"))


## -----------------------------------------------------------------------------
filter(ufo, str_detect(comments, "two aliens"))
filter(ufo, str_detect(comments, "two aliens")) %>% select(comments)



## ----ggrep--------------------------------------------------------------------
str_subset(ufo$comments, "two aliens")



## ----ggrep2-------------------------------------------------------------------
ss = str_extract(ufo$comments, "two aliens")
head(ss)
ss[ !is.na(ss)]


## ----grepstar-----------------------------------------------------------------
str_subset(ufo$comments, "^aliens.*")


## ----grepstar2----------------------------------------------------------------
str_subset(ufo$comments, "space.?ship") %>% head(4) # gets "spaceship" or "space ship" or...
str_subset(ufo$comments, "space.ship") %>% head(4) # no "spaceship" must have character in bw



## ----classSal-----------------------------------------------------------------
head(ufo$duration_hours_min, 8)

ufo %>% mutate(duration_hours_min = 
                 str_replace(string = duration_hours_min, 
                             pattern = "minutes", 
                             replacement ="mins")) %>%
  pull(duration_hours_min) %>%
  head(8)



## ---- message = FALSE---------------------------------------------------------
library(lubridate)#need to load this one!
head(ufo$datetime)
ufo$date_posted = mdy(ufo$date_posted)
head(ufo$date_posted)

