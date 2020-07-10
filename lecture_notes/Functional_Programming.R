## ---- include=FALSE-------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## -------------------------------------------------------------------------
class(got_chars)
length(got_chars)
lengths(got_chars)
names(got_chars[[1]])


## -------------------------------------------------------------------------
char_names = vector("character", length(got_chars)) # initiate
for(i in seq(along=got_chars)) { # iterate
    char_names[i] = got_chars[[i]]$name
}
char_names[1:5] # examine


## -------------------------------------------------------------------------
sapply(got_chars[1:5], function(x) x$name)


## -------------------------------------------------------------------------
sapply(got_chars[1:5], "[[", "name")


## -------------------------------------------------------------------------
map_chr(got_chars[1:5], "name")


## -------------------------------------------------------------------------
sapply(got_chars[2:3], "[[", "aliases")


## ----eval=FALSE-----------------------------------------------------------
map_chr(got_chars[2:3], "aliases")
Error: Result 1 must be a single string, not a character vector of length 11



## -------------------------------------------------------------------------
chars <- tibble(char = got_chars)
chars


## -------------------------------------------------------------------------
chars2 <- chars %>% unnest_wider(char)
chars2


## -------------------------------------------------------------------------
chars2 %>%
  select(name, title = titles) %>%
  unnest_longer(title)

