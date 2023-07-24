## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(comment = "")
library(tidyverse)


## -----------------------------------------------------------------------------
library(tidyverse)
glimpse(diamonds)


## ---- eval = FALSE------------------------------------------------------------
## # general format! not code!
## {data you are creating or changing} <- rename({data you are using},
##                                           {New Name} = {Old name})


## -----------------------------------------------------------------------------

diamonds_2<- rename(diamonds, depth_percentage = depth)
head(diamonds_2)


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, depth percentage = depth)# this will cause an error


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, depth_percentage = depth) # this will work


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, `depth percentage` = depth) # this will work but not recommended


## ---- fig.alt="dplyr", out.width = "14%", echo = FALSE, fig.align='center'----
knitr::include_graphics("images/backtick_1.png")


## ---- fig.align='center', echo = FALSE----------------------------------------
include_graphics("https://media.giphy.com/media/6q29hxDKvJvPy/giphy.gif")


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, ‘depth percentage’ = depth)# this will cause an error!


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, 'depth percentage' = depth) # this will work!


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, “depth percentage” = depth)# this will cause an error!


## ---- eval = FALSE------------------------------------------------------------
## rename(diamonds, "depth percentage" = depth) # this will work!


## -----------------------------------------------------------------------------
diamonds_upper <- rename_with(diamonds, toupper)
head(diamonds_upper, 3)


## -----------------------------------------------------------------------------
rename_with(diamonds_upper, tolower) %>% head(n = 3)


## -----------------------------------------------------------------------------
head(diamonds, 2)
diamonds %>% select(where(is.numeric)) %>% head(n = 2)



## -----------------------------------------------------------------------------
head(diamonds, 2)
diamonds %>% select(where(is.ordered)) %>% head(n = 2)



## -----------------------------------------------------------------------------
distinct(diamonds, cut)

distinct(diamonds, cut, color)


## ---- eval = FALSE------------------------------------------------------------
## # General format - Not the code!
## {data object to update} <- mutate({data to use},
##                            {new variable name} = {new variable source})


## -----------------------------------------------------------------------------
mutate(diamonds, price_can = price * 1.32) %>% glimpse()



## ---- eval = FALSE------------------------------------------------------------
## # General format - Not the code!
## {data object to update} <- mutate({data to use},
##                            {variable name to change} = {variable modification})


## -----------------------------------------------------------------------------
mutate(diamonds, price = price * 1.32) %>% glimpse()


## -----------------------------------------------------------------------------
diamonds %>% mutate(price = price * 1.32) %>% glimpse()


## ---- eval = FALSE------------------------------------------------------------
## diamonds <- diamonds %>% mutate(price = price * 1.32) %>% glimpse()


## ---- eval = FALSE------------------------------------------------------------
## select(diamonds, - price)


## ---- echo = FALSE------------------------------------------------------------
glimpse(select(diamonds, - price))


## -----------------------------------------------------------------------------
select(diamonds, -c("x", "y", "z")) %>% glimpse()


## -----------------------------------------------------------------------------
head(diamonds, 2)
diamonds %>% select(price, depth, carat, cut, color) %>% glimpse()


## -----------------------------------------------------------------------------
diamonds %>% select(price, everything()) %>% glimpse()


## -----------------------------------------------------------------------------
diamonds %>% select(-price, everything(), newcol) %>% glimpse()


## -----------------------------------------------------------------------------

diamonds %>% relocate( price, .before = carat) %>% glimpse()



## -----------------------------------------------------------------------------
order(colnames(diamonds))
diamonds %>% select(order(colnames(diamonds)))


## -----------------------------------------------------------------------------
arrange(diamonds, cut)


## -----------------------------------------------------------------------------
arrange(diamonds, desc(price))


## -----------------------------------------------------------------------------
arrange(diamonds, desc(carat), cut)


## -----------------------------------------------------------------------------
diamonds$price


## ---- eval = FALSE------------------------------------------------------------
## diamonds$price <- diamonds$price/2.2

