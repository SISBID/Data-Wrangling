## ---- echo = FALSE, include=FALSE-------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)


## ---- echo = FALSE, message=FALSE-------------------------------------------------
library(tidyverse)


## ---- echo = FALSE----------------------------------------------------------------
ex_wide = tibble(id = 1:2,
                     visit1 = c(10, 5),
                     visit2 = c(4, 6),
                     visit3 = c(3, NA)
                     )
ex_long = tibble(id = c(rep(1, 3), rep(2, 2)),
                     visit = c(1:3, 1:2),
                     value = c(10, 4, 3, 5, 6))


## ---- echo = FALSE----------------------------------------------------------------
ex_wide


## ---- echo = FALSE----------------------------------------------------------------
ex_long


## ---- message = FALSE-------------------------------------------------------------
circ = read_csv("../data/Charm_City_Circulator_Ridership.csv")
head(circ, 2)
class(circ$date)


## ---- message = FALSE-------------------------------------------------------------
library(lubridate) # great for dates!


## ---- message= FALSE--------------------------------------------------------------
sum(is.na(circ$date))
sum( circ$date == "")
circ = mutate(circ, date = mdy(date))
sum( is.na(circ$date) ) # all converted correctly
head(circ$date, 3)
class(circ$date)


## ---------------------------------------------------------------------------------
long = gather(circ, key = "var", value = "number", 
              -day, -date, -daily)
head(long, 4)


## ---------------------------------------------------------------------------------
long = gather(circ, key = "var", value = "number", 
              starts_with("orange"), starts_with("purple"),
              starts_with("green"), starts_with("banner"))
long


## ---------------------------------------------------------------------------------
long %>% count(var)


## ---------------------------------------------------------------------------------
long = long %>% mutate(
  var = var %>% 
    str_replace("Board", ".Board") %>% 
    str_replace("Alight", ".Alight") %>% 
    str_replace("Average", ".Average") 
)
long %>% count(var)


## ---------------------------------------------------------------------------------
long = separate(long, var, into = c("line", "type"), 
                 sep = "[.]")
head(long, 2)
unique(long$line)
unique(long$type)


## ---------------------------------------------------------------------------------
reunited = long %>% 
  unite(col = var, line, type, sep = ".")  
reunited %>% select(day, var) %>% head(3) %>% print


## ---------------------------------------------------------------------------------
# have to remove missing days
wide = long %>% filter(!is.na(date))
wide = wide %>% spread(type, number)
head(wide)

