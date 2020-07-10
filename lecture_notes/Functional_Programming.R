## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(repurrrsive)
library(tidyr)


## ----makeList, comment="", prompt=TRUE----------------------------------------
mylist <- list(letters=c("A", "b", "c"), 
        numbers=1:3, matrix(1:25, ncol=5))


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


## -----------------------------------------------------------------------------
h = c("I like performing", "much data wrangling in R", "it is oh so fun")
ll = str_split(h, " ")
ll


## -----------------------------------------------------------------------------
class(got_chars)
length(got_chars)
lengths(got_chars)
names(got_chars[[1]])


## -----------------------------------------------------------------------------
char_names = vector("character", length(got_chars)) # initiate
for (i in seq(along=got_chars)) { # iterate
  char_names[i] = got_chars[[i]]$name
}
char_names[1:5] # examine


## -----------------------------------------------------------------------------
sapply(got_chars[1:5], function(x) x$name)


## -----------------------------------------------------------------------------
sapply(got_chars[1:5], "[[", "name")


## -----------------------------------------------------------------------------
map_chr(got_chars[1:5], "name")


## -----------------------------------------------------------------------------
sapply(got_chars[2:3], "[[", "aliases")


## ---- error = TRUE------------------------------------------------------------
map_chr(got_chars[2:3], "aliases")


## -----------------------------------------------------------------------------
map_chr(ll, first)
map_chr(ll, last)
map_chr(ll, nth, 3)


## -----------------------------------------------------------------------------
chars <- tibble(char = got_chars)
chars


## -----------------------------------------------------------------------------
chars2 <- chars %>% unnest_wider(char)
chars2


## -----------------------------------------------------------------------------
chars2 %>%
  select(name, title = titles) %>%
  unnest_longer(title)

