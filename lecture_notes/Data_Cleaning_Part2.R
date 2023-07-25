## ---- include = FALSE---------------------------------------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## ----gender, echo=FALSE-------------------------------------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)
data_gen = tibble(gender)


## ----gentab-------------------------------------------------------------------------------------------------
table(gender)


## -----------------------------------------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>% mutate(gender = 
                      case_when(gender %in% c("Male", "M", "m", "Man")
                                ~ "Male",
                           TRUE ~ gender)) 
head(data_gen)


## -----------------------------------------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>%
                mutate(gender = str_to_sentence(gender)) %>%
                mutate(gender = 
                      case_when(gender %in% c("Male", "M", "m", "Man")
                                ~ "Male",
                           TRUE ~ gender)) 
head(data_gen)


## -----------------------------------------------------------------------------------------------------------
ufo <-read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv", col_types = cols(`duration (seconds)` = "c"))
p <- problems(ufo)
ufo_clean <- ufo %>% slice((pull(p, row))*-1)



## -----------------------------------------------------------------------------------------------------------
colnames(ufo_clean)
ufo_clean <- clean_names(ufo_clean)
colnames(ufo_clean)


## -----------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(str_detect( string = duration_seconds, pattern = "`"))



## -----------------------------------------------------------------------------------------------------------
ufo_clean  <- ufo_clean %>% mutate(duration_seconds = str_remove(string = duration_seconds,pattern = "`"))

ufo_clean  <- ufo_clean %>% mutate(duration_seconds = as.numeric(duration_seconds))
ufo_clean %>% filter(str_detect( string = duration_seconds, pattern = "`"))



## -----------------------------------------------------------------------------------------------------------
ufo_clean %>% mutate(duration_seconds = paste(duration_seconds, "sec", sep = " ")) %>% glimpse()



## -----------------------------------------------------------------------------------------------------------
str_sub("I like friesian horses", 8,12)
#123456789101112
#I like fries
str_sub(c("Site A", "Site B", "Site C"), 6,6)


## ----alienMatch---------------------------------------------------------------------------------------------
ufo_clean %>% filter(str_detect(comments, "two aliens")) %>% head()
ufo_clean %>%filter(str_detect(comments, "two aliens")) %>% count()


## -----------------------------------------------------------------------------------------------------------
filter(ufo_clean, str_detect(comments, "two aliens"))
filter(ufo_clean, str_detect(comments, "two aliens")) %>% select(comments)



## ----ggrep--------------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>% str_subset( "two aliens")



## ----ggrep2-------------------------------------------------------------------------------------------------
ufo_clean %>% mutate(two  = str_extract(comments, "two")) %>% count(two)



## ----grepstar-----------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>%str_subset( "^aliens.*")


## ----grepstar2----------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>%str_subset("space.?ship") %>% head(4) # gets "spaceship" or "space ship" or...
ufo_clean %>% pull(comments) %>% str_subset("space.ship") %>% head(4) # no "spaceship" must have character in bw



## ----classSal-----------------------------------------------------------------------------------------------
head(pull(ufo_clean, duration_hours_min))

ufo_clean %>% mutate(duration_hours_min = 
                 str_replace(string = duration_hours_min, 
                             pattern = "minutes", 
                             replacement ="mins")) %>%
  pull(duration_hours_min) %>%
  head(8)



## ---- warning=FALSE-----------------------------------------------------------------------------------------
ufo_clean %>% separate(duration_hours_min,
                 into = c("duration_amount", "duration_unit"),
                 sep = " ") %>%
  select(duration_amount, duration_unit) %>% head()


## ---- warning=FALSE-----------------------------------------------------------------------------------------
ufo_clean %>% separate(date_posted,
                 into = c("date_posted", "time_posted"),
                 sep = " ") %>%
  select(date_posted, time_posted) %>% head()


## ---- message = FALSE---------------------------------------------------------------------------------------
library(lubridate)#need to load this one!

ufo_clean <- ufo_clean %>% mutate(date_posted = mdy(date_posted))
head(ufo_clean)


## -----------------------------------------------------------------------------------------------------------
str_detect(string = c("abcdd", "two"), pattern = "dd")
str_subset(string = c("abcdd", "two"), pattern = "dd")
str_extract(string = c("abcdd", "two"), pattern = "dd")
str_sub(string = c("abcdd", "two"), start = 1, end = 3)

