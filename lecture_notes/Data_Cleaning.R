## ---- include = FALSE-------------------------------------------------------------
library(knitr)
library(tidyverse)
opts_chunk$set(comment = "")


## ---------------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4)
x > 2


## ---------------------------------------------------------------------------------
x != NA
x > 2 & !is.na(x)


## ---------------------------------------------------------------------------------
(x == 0 | x == 2) # has NA
(x == 0 | x == 2) & !is.na(x) # No NA


## ---------------------------------------------------------------------------------
x %in% c(0, 2) # NEVER has NA and returns logical


## ---------------------------------------------------------------------------------
x %in% c(0, 2, NA) # NEVER has NA and returns logical
x %in% c(0, 2) | is.na(x)


## ---------------------------------------------------------------------------------
df = tibble(x = x)
df %>% filter(x > 2)
filter(df, between(x, -1, 3) | is.na(x))


## ---------------------------------------------------------------------------------
x + 2
x * 2


## ----table------------------------------------------------------------------------
unique(x)
table(x)
table(x, useNA = "ifany") # will not 


## ----onetab_ifany-----------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "ifany")


## ----onetab-----------------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "always")


## ----onetab_fact------------------------------------------------------------------
fac = factor(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             levels = 1:4)
tab = table(fac)
tab
tab[ tab > 0 ]


## ---------------------------------------------------------------------------------
tab <- table(c(0, 0, 0, 1, 1,2, 3, 2, 3, 3, 2,2, 3,3,2,3,3), 
             c(0, 0,1, 1, 2, 3, 3, 2, 3, 3, 4, 4, 3,2,2,1,1), 
              useNA = "always")


## ----margin-----------------------------------------------------------------------
margin.table(tab, 2)


## ----table2-----------------------------------------------------------------------
prop.table(tab)
prop.table(tab,1) * 100


## ----codeNA-----------------------------------------------------------------------
ages = c(23,21,44,32,57,65,-999,54)
range(ages)


## ----codeNA2----------------------------------------------------------------------
ages[ages == -999] = NA
range(ages)
range(ages,na.rm=TRUE)


## ----codeFromNA-------------------------------------------------------------------
is.na(ages)
ages[is.na(ages)] = -999
ages


## ---- importUfo-------------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ---------------------------------------------------------------------------------
p = problems(ufo)
p


## ---------------------------------------------------------------------------------
ufo[p$row, ]


## ---------------------------------------------------------------------------------
ufo = ufo[-p$row,]


## ----isna-------------------------------------------------------------------------
any(is.na(ufo$state)) # are there any NAs?
table(is.na(ufo$state)) # are there any NAs?


## ---- eval = FALSE----------------------------------------------------------------
## data$gender[data$gender %in%
##     c("Male", "M", "m")] <- "Male"


## ----gender, echo=FALSE-----------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)


## ----gentab-----------------------------------------------------------------------
table(gender)


## ----Paste------------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5)


## ----Paste2-----------------------------------------------------------------------
paste(1:5)
paste(1:5, collapse = " ")


## ----strsplit_base----------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- str_split(x, pattern = " ") # returns a list
y


## ---------------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))


## ----stsplit2---------------------------------------------------------------------
map_chr(y, first) # on the fly
map_chr(y, nth, 2) # on the fly
map_chr(y, last) # on the fly


## ----alienMatch-------------------------------------------------------------------
which(str_detect(ufo$comments, "two aliens"))


## ----alienMatch_log---------------------------------------------------------------
str_detect(ufo$comments, "two aliens") %>% head()


## ----ggrep------------------------------------------------------------------------
str_subset(ufo$comments, "two aliens")
ufo %>% filter(str_detect(comments, "two aliens"))


## ----ggrep2-----------------------------------------------------------------------
ss = str_extract(ufo$comments, "two aliens")
head(ss)
ss[ !is.na(ss)]


## ----grepstar---------------------------------------------------------------------
str_subset(ufo$comments, "^aliens.*")


## ----grepstar2--------------------------------------------------------------------
str_subset(ufo$comments, "space.?ship") %>% head(7)


## ----classSal---------------------------------------------------------------------
class(ufo$latitude)


## ----orderstring------------------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))


## ----destringSal------------------------------------------------------------------
head(ufo$latitude, 4)
head(as.numeric(ufo$latitude), 4)


## ---- dropIndex-------------------------------------------------------------------
dropIndex = which(is.na(as.numeric(ufo$latitude)) | 
                      is.na(as.numeric(ufo$longitude)))
ufo_clean = ufo[-dropIndex,]
dim(ufo_clean)


## ----order------------------------------------------------------------------------
ufo2 = ufo_clean
ufo2$latitude = as.numeric(ufo2$latitude)
ufo2$longitude = as.numeric(ufo2$longitude)
ufo2 <- ufo2[order(ufo2$latitude, ufo2$longitude), ] 
ufo2[1:5, c("datetime", "latitude", "longitude")]


## ----orderSal_stringr-------------------------------------------------------------
ufo_dplyr = ufo_clean
ufo_dplyr = ufo_dplyr %>% mutate( 
  latitude = latitude %>% as.numeric,
  longitude = longitude %>% as.numeric) %>% 
    arrange(latitude,longitude)
ufo_dplyr[1:5, c("datetime", "latitude", "longitude")]


## ---------------------------------------------------------------------------------
money = tibble(group = letters[1:5], 
  amount = c("$12.32", "$43.64", "$765.43", "$93.31", "$12.13"))
money %>% arrange(amount)
as.numeric(money$amount)


## ---------------------------------------------------------------------------------
money$amountNum = as.numeric(str_replace(money$amount, fixed("$"), ""))
money %>% arrange(amountNum)


## ---------------------------------------------------------------------------------
money$amount = parse_number(money$amount)


## ----strsplit---------------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- strsplit(x, split = " ") # returns a list
y

