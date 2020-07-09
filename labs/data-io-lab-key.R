## ---- intialSetup-----------------------------------------------------------------
library(readr)


## ---- tabRead---------------------------------------------------------------------
ufo2 = read_delim("http://sisbid.github.io/Module1/data/ufo/ufo_data_complete.txt",
                    delim = "\t")


## ---- rename----------------------------------------------------------------------
colnames(ufo2) = c("DateTime", "City", "State", "Country", "Shape",
                   "Duration_sec","Duration_hourMin","Comments",
                   "PostedDate", "Latitude","Longitude")


## ---- date------------------------------------------------------------------------
library(lubridate)
ufo2$PostedDate = mdy(ufo2$PostedDate)
ufo2$DateTime = mdy_hm(ufo2$DateTime)



## ---- caps------------------------------------------------------------------------
ufo2$State= toupper(ufo2$State)
head(ufo2$State)


## ---- numeric---------------------------------------------------------------------
ufo2$Latitude = as.numeric(ufo2$Latitude)
ufo2$Longitude = as.numeric(ufo2$Longitude)


## ---- export, eval=FALSE----------------------------------------------------------
## write.csv(ufo2, file="new_ufo_data.csv",row.names=FALSE)


## ---- excel, eval=FALSE-----------------------------------------------------------
## library(readxl)
## ufo_excel = read_excel("../data/ufo/ufo_data_complete.xlsx")
## ufo_excel = read_excel("../data/ufo/ufo_data_complete.xlsx",
##                         col_type="text")
## 

