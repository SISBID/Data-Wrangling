## ----include = FALSE----------------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## ----gender, echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
status <- sample(c("treatment", "T", "treat", 
                   "Traet", "Treat", "C", "Cont",
                   "cont", "cOnt", "Control", "control"),
                 1000, replace = TRUE)
data_gen = tibble(status)


## ----gentab-------------------------------------------------------------------------------------------------------------------------------------------------------
count(data_gen, status)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>% mutate(status = 
            case_when(status 
          %in% c("C", "cont", "cOnt", "Cont", "control", "Control")
                                ~ "Control",
                           .default =  status)) 
count(data_gen, status)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>%
                mutate(status = str_to_sentence(status))
count(data_gen, status)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#case_when way:
data_gen <-data_gen %>%
                mutate(status = str_to_sentence(status)) %>%
                mutate(status = 
                      case_when(status %in% 
                    c("Treatment", "T", "Treat", "Traet", "Treat")
                                ~ "Treatment",
                           .default = status)) 
count(data_gen, status)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
ufo <-read_csv(
  "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv", 
  col_types = cols(`duration (seconds)` = "c"))




## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
colnames(ufo)
ufo_clean <- clean_names(ufo)
colnames(ufo_clean)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  filter(str_detect( 
    string = duration_seconds, 
    pattern = "`"))



## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean  <- ufo_clean %>% 
  mutate(duration_seconds = 
           str_remove(string = duration_seconds,
                     pattern = "`"))


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean  <- ufo_clean %>% 
  mutate(duration_seconds = as.numeric(duration_seconds))

glimpse(ufo_clean)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
str_sub("I like friesian horses", 8,12)
#123456789101112
#I like fries
str_sub(c("Site A", "Site B", "Site C"), 6,6)


## ----alienMatch---------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  filter(str_detect(comments, "two aliens")) %>% 
  head()


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>%
  filter(str_detect(comments, "two aliens")) %>% 
  select(comments)


## ----ggrep--------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>%
  str_subset( "two aliens")



## ----ggrep2-------------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  mutate(aliens  = str_extract(comments, "two aliens")) %>%
  count(aliens)



## ----grepstar-----------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>%str_subset( "^aliens")


## ----grepstar2----------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% pull(comments) %>%
  str_subset("space.?ship") %>% head(4) # gets "spaceship" or "space ship" or...
ufo_clean %>% pull(comments) %>% 
  str_subset("space.ship") %>% head(4) # no "spaceship" must have character in between



## -----------------------------------------------------------------------------------------------------------------------------------------------------------------

pull(ufo_clean, duration_hours_min) %>% head(n = 20)


## ----classSal-----------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% mutate(duration_hours_min = 
                 str_replace(string = duration_hours_min, 
                             pattern = "minutes", 
                             replacement ="mins")) %>%
  pull(duration_hours_min) %>%
  head(8)



## ----warning=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean %>% separate(duration_hours_min,
                 into = c("duration_amount", "duration_unit"),
                 sep = " ") %>%
  select(duration_amount, duration_unit) %>% head()


## ----warning=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% separate(datetime,
                 into = c("date", "time"),
                 sep = " ")
ufo_clean %>% select(date, time) %>% head()


## ----message = FALSE----------------------------------------------------------------------------------------------------------------------------------------------
library(lubridate)#need to load this one!

ufo_clean <- ufo_clean %>% mutate(date = mdy(date))
head(ufo_clean)


## -----------------------------------------------------------------------------------------------------------------------------------------------------------------
str_detect(string = c("abcdd", "two"), pattern = "dd")
str_subset(string = c("abcdd", "two"), pattern = "dd")
str_extract(string = c("abcdd", "two"), pattern = "dd")
str_sub(string = c("abcdd", "two"), start = 1, end = 3)

