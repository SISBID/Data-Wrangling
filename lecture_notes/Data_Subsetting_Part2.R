## ---- include=FALSE-----------------------------------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(comment = "")
library(tidyverse)


## -----------------------------------------------------------------------------------------------------------
library(tidyverse)
head(diamonds)


## ---- eval = FALSE------------------------------------------------------------------------------------------
# general format! not code!
{data you are creating or changing} <- {data you are using} %>%
                                    rename({New Name} = {Old name})
                                          


## -----------------------------------------------------------------------------------------------------------

diamonds_2<- diamonds %>%
  rename(depth_percentage = depth)
head(diamonds_2, n = 3)


## -----------------------------------------------------------------------------------------------------------
diamonds_2<- diamonds %>%
  rename(depth_percentage = depth,
                   length = x,
                    width = y,
                    depth = z)
glimpse(diamonds_2)


## ---- eval = FALSE------------------------------------------------------------------------------------------
diamonds %>% rename(depth percentage = depth)# this will cause an error


## ---- eval = FALSE------------------------------------------------------------------------------------------
diamonds %>% rename(depth_percentage = depth) # this will work


## ---- eval = FALSE------------------------------------------------------------------------------------------
diamonds %>% rename(`depth percentage` = depth) # not recommended


## ---- fig.alt="dplyr", out.width = "14%", echo = FALSE, fig.align='center'----------------------------------
knitr::include_graphics("media/backtick_1.png")


## ---- fig.align='center', echo = FALSE----------------------------------------------------------------------
include_graphics("https://media.giphy.com/media/6q29hxDKvJvPy/giphy.gif")


## ---- echo = FALSE------------------------------------------------------------------------------------------
diamonds_bad_names <- rename(diamonds, `Price(in US dollars)` = price,
                                        `Length (in mm)` = x,
                                        `Width in mm` = y,
                                        `Depth percentage` = z)


## -----------------------------------------------------------------------------------------------------------
glimpse(diamonds_bad_names)
diamonds_bad_names %>%
        rename(price = `Price(in US dollars)`)


## -----------------------------------------------------------------------------------------------------------
diamonds_upper <- diamonds %>% rename_with(toupper)
head(diamonds_upper, 2)


## -----------------------------------------------------------------------------------------------------------
diamonds_upper %>% rename_with(tolower) %>% head(n = 2)


## ---- message=FALSE-----------------------------------------------------------------------------------------
#install.packages("janitor")
library(janitor)
clean_names(diamonds_bad_names) %>% glimpse()


## -----------------------------------------------------------------------------------------------------------
head(diamonds, 2)
diamonds %>% select(where(is.numeric)) %>% head(n = 2)



## -----------------------------------------------------------------------------------------------------------
head(diamonds, 2)
diamonds %>% select(where(is.ordered)) %>% head(n = 2)



## -----------------------------------------------------------------------------------------------------------
distinct(diamonds, cut)


## ---- eval = FALSE------------------------------------------------------------------------------------------
# General format - Not the code!
{data object to update} <- {data to use} %>% 
                    mutate({new variable name} = {new variable source}) 


## -----------------------------------------------------------------------------------------------------------
diamonds %>% 
  mutate(price_canadian = price * 1.32) %>% glimpse()



## ---- eval = FALSE------------------------------------------------------------------------------------------
# General format - Not the code!
{data object to update} <- {data to use} %>%
            mutate({variable name to change} = {variable modification}) 


## -----------------------------------------------------------------------------------------------------------
mutate(diamonds, price = price * 1.32) %>% glimpse()


## ---- eval = FALSE------------------------------------------------------------------------------------------
diamonds <- diamonds %>% mutate(price = price * 1.32) %>% glimpse()


## -----------------------------------------------------------------------------------------------------------
select(diamonds, - price) %>% glimpse()


## -----------------------------------------------------------------------------------------------------------
select(diamonds, -c("x", "y", "z")) %>% glimpse()


## -----------------------------------------------------------------------------------------------------------
head(diamonds, n = 2)
diamonds %>% select(price, depth, carat, cut, color) %>% head(n = 2)


## -----------------------------------------------------------------------------------------------------------
head(diamonds, n = 2)
diamonds %>% select(price, everything()) %>% head(n = 2)


## -----------------------------------------------------------------------------------------------------------
head(diamonds, n = 2)
diamonds %>% select(-price, everything(), price) %>% head(n = 2)


## -----------------------------------------------------------------------------------------------------------
head(diamonds, n = 2)
diamonds %>% relocate( price, .before = cut) %>% head(n = 2)



## -----------------------------------------------------------------------------------------------------------
order(colnames(diamonds))
diamonds %>% select(order(colnames(diamonds)))


## -----------------------------------------------------------------------------------------------------------
diamonds %>% arrange(cut)


## -----------------------------------------------------------------------------------------------------------
diamonds %>% arrange(depth)


## -----------------------------------------------------------------------------------------------------------
diamonds %>% arrange(desc(price))


## -----------------------------------------------------------------------------------------------------------
arrange(diamonds, desc(carat), table)

