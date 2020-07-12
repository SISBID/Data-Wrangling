## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## ---- importUfo---------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv")
ufo = clean_names(ufo)


## -----------------------------------------------------------------------------
p = problems(ufo)
ufo = ufo[-p$row,] # brackets can also be used for subsetting


## ----isna---------------------------------------------------------------------
any(is.na(ufo$state)) # are there any NAs?
table(is.na(ufo$state)) # are there any NAs?


## ---- eval = FALSE------------------------------------------------------------
## data$gender[data$gender %in%
##     c("Male", "M", "m")] <- "Male"


## ----gender, echo=FALSE-------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)


## ----gentab-------------------------------------------------------------------
table(gender)


## ----Paste--------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5)


## ----Paste2-------------------------------------------------------------------
paste(1:5)
paste(1:5, collapse = " ")


## -----------------------------------------------------------------------------
str_sub("I like pizza", 8,12)
str_sub(c("Site A", "Site B", "Site C"), 6,6)


## ----alienMatch---------------------------------------------------------------
which(str_detect(ufo$comments, "two aliens"))


## ----alienMatch_log-----------------------------------------------------------
str_detect(ufo$comments, "two aliens") %>% head()


## ----ggrep--------------------------------------------------------------------
str_subset(ufo$comments, "two aliens")
ufo %>% filter(str_detect(comments, "two aliens"))


## ----ggrep2-------------------------------------------------------------------
ss = str_extract(ufo$comments, "two aliens")
head(ss)
ss[ !is.na(ss)]


## ----grepstar-----------------------------------------------------------------
str_subset(ufo$comments, "^aliens.*")


## ----grepstar2----------------------------------------------------------------
str_subset(ufo$comments, "space.?ship") %>% head(7)


## ----classSal-----------------------------------------------------------------
class(ufo$latitude)


## ----orderstring--------------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))


## ----destringSal--------------------------------------------------------------
head(ufo$latitude, 4)
head(as.numeric(ufo$latitude), 4)


## ---- dropIndex---------------------------------------------------------------
dropIndex = which(is.na(as.numeric(ufo$latitude)) | 
                      is.na(as.numeric(ufo$longitude)))
ufo_clean = ufo[-dropIndex,]
dim(ufo_clean)


## ----orderSal_stringr---------------------------------------------------------
ufo_dplyr = ufo_clean
ufo_dplyr = ufo_dplyr %>% mutate( 
  latitude = latitude %>% as.numeric,
  longitude = longitude %>% as.numeric) %>% 
    arrange(latitude,longitude)
ufo_dplyr[1:5, c("datetime", "latitude", "longitude")]


## -----------------------------------------------------------------------------
money = tibble(group = letters[1:5], 
  amount = c("$12.32", "$43.64", "$765.43", "$93.31", "$12.13"))
money %>% arrange(amount)
as.numeric(money$amount)


## -----------------------------------------------------------------------------
money$amountNum = as.numeric(str_replace(money$amount, fixed("$"), ""))
money %>% arrange(amountNum)


## -----------------------------------------------------------------------------
money$amount = parse_number(money$amount)
money %>% arrange(amount)



## -----------------------------------------------------------------------------
parse_number(c("12,123,123.00", "12,465.10"))


## -----------------------------------------------------------------------------
library(lubridate)
ufo$timestamp = mdy_hm(ufo$datetime)
ufo$date_posted = mdy(ufo$date_posted)
head(ufo$timestamp)

