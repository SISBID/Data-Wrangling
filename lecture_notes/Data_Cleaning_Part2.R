## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## -----------------------------------------------------------------------------
ufo <- read_delim("../data/ufo/ufo_data_complete.txt", 
                  col_types = cols("duration (seconds)" = col_character()))

ufo %>% glimpse()



## -----------------------------------------------------------------------------
colnames(ufo)
ufo = clean_names(ufo)
colnames(ufo)


## -----------------------------------------------------------------------------
ufo <- ufo %>% mutate(duration_seconds = str_remove(string = duration_seconds,
                                             pattern = "`"))
ufo <- ufo %>% mutate(duration_seconds = as.numeric(duration_seconds))
ufo[(p$row-1),]


## -----------------------------------------------------------------------------
head(Orange)
Orange %>% mutate(Tree = paste(Tree, "Tree", sep = "_"))



## -----------------------------------------------------------------------------
head(Orange)
Orange %>% mutate(Tree = paste0(Tree, "Tree"))



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

