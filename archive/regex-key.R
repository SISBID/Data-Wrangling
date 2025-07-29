## ---------------------------------------------------------------------------------
library(stringr)
sisbid = "[Ss][Ii][Ss][Bb][Ii][Dd]"
x = c("SISBID","SiSBID","sisbid","sisBID")
str_detect(x,sisbid)


## ---------------------------------------------------------------------------------
x = c(333,33,3,33333)
three3 = "3{3}"
str_detect(x,three3)


## ---------------------------------------------------------------------------------
x = c("jeff","jeffff","jef","je","j","jefffffff")
two2fourf = "f{2,4}"
str_detect(x,two2fourf)


## ---------------------------------------------------------------------------------
x = c("yes.","no","why1",",ok")
alphapuncend = "[:alpha:][:punct:]$"
str_detect(x,alphapuncend)

