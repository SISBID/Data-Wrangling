## ---- echo = FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)
library(ggplot2)


## .watch-out {

##   #background-color: lightpink;

##   border: 3px solid red;

##   font-weight: bold;

## }

## # from: https://bookdown.org/yihui/rmarkdown-cookbook/chunk-styling.html

## 
## #Then just use class.source="watch-out" in the chunk parameters


## ---- eval = FALSE------------------------------------------------------------
## readr::read_csv()
## readr::read_delim()
## readxl::read_excel()


## -----------------------------------------------------------------------------
head(diamonds)


## -----------------------------------------------------------------------------
head(pull(diamonds,carat))


## -----------------------------------------------------------------------------
diamonds %>% pull(carat) %>% head()


## -----------------------------------------------------------------------------
head(pull(diamonds, carat))
head(diamonds$carat)


## -----------------------------------------------------------------------------
select(diamonds, carat)


## -----------------------------------------------------------------------------
select(diamonds, carat, depth)


## ---- eval = FALSE------------------------------------------------------------
## ??tidyselect::select_helpers


## ---- eval = FALSE------------------------------------------------------------
## last_col()
## ends_with()
## starts_with()
## contains() # like searching


## -----------------------------------------------------------------------------
diamonds %>% select(starts_with("c"))


## -----------------------------------------------------------------------------
diamonds %>% select(ends_with("e"))


## -----------------------------------------------------------------------------
filter(diamonds, depth > 60)


## -----------------------------------------------------------------------------
diamonds %>% filter(depth > 60)


## -----------------------------------------------------------------------------
diamonds %>% filter(depth > 60, table > 60, price > 2775)


## -----------------------------------------------------------------------------
diamonds %>% filter(color == "I", 
            clarity == "SI2", cut == "Premium")


## -----------------------------------------------------------------------------
diamonds %>% filter(clarity %in% c("SI1", "SI2"))


## -----------------------------------------------------------------------------
diamonds %>% filter(clarity %in% c("SI1", "SI2"),
                    cut == "Premium", price > 3000)


## -----------------------------------------------------------------------------
diamonds %>% filter(depth > 60 & table > 60 & price > 2775)


## -----------------------------------------------------------------------------
diamonds %>% filter(depth > 60 | table > 60 | price > 2775)


## -----------------------------------------------------------------------------
diamonds %>% filter(clarity =="SI1" | clarity == "SI2") %>% head(2)
diamonds %>% filter(clarity %in% c("SI1", "SI2")) %>% head(2)


## -----------------------------------------------------------------------------
diamonds %>% 
  filter(clarity == "SI2") %>% 
  select(starts_with("c"))


## ----eval=FALSE---------------------------------------------------------------
## diamonds %>%
##   select(starts_with("c") %>%
##   filter(table > 60))

