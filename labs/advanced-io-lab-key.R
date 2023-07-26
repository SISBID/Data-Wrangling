## ---- include=FALSE-------------------------------------------------------------------------------------------
library(tidyverse)
library(jsonlite)
library(googlesheets4)


## ----eval=FALSE-----------------------------------------------------------------------------------------------
## gs4_auth()


## -------------------------------------------------------------------------------------------------------------
sheet_url <- "https://docs.google.com/spreadsheets/d/1KIRtcPVn58R3_qr97WNtcOJiY4AaytHzGDzLW_3_R1s/edit?usp=sharing"


## -------------------------------------------------------------------------------------------------------------
x <- read_sheet(sheet_url)


## -------------------------------------------------------------------------------------------------------------
sheet_names(sheet_url)


## -------------------------------------------------------------------------------------------------------------
read_sheet(sheet_url, range =  cell_cols("A:B"))


## -------------------------------------------------------------------------------------------------------------
x %>%
  filter(str_detect(`Why are you taking this module (free text)`, pattern = "learn"))


## -------------------------------------------------------------------------------------------------------------
jsonData <- fromJSON("https://think.cs.vt.edu/corgis/datasets/json/airlines/airlines.json")


## ---- error = TRUE--------------------------------------------------------------------------------------------
str(jsonData)
# Airport, Time and Statistics
dim(jsonData$Airport)
dim(jsonData$Time)
dim(jsonData$Statistics)

colnames(jsonData$Statistics)


## -------------------------------------------------------------------------------------------------------------
air_2016 <- jsonData %>% 
  filter(Time$Year == 2016)


## -------------------------------------------------------------------------------------------------------------
air_2016$Airport %>% count()
# OR
length(unique(air_2016$Airport$Code))


## -------------------------------------------------------------------------------------------------------------
lga_ord <- jsonData %>% 
  filter(Airport$Code %in% c("LGA", "ORD"))


## -------------------------------------------------------------------------------------------------------------
airport_list <- list(
  airport_code = lga_ord$Airport$Code,
  total_flights = lga_ord$Statistics$Flights$Total,
  delayed_proportion = lga_ord$Statistics$Flights$Delayed / lga_ord$Statistics$Flights$Total
  )
airport_compare <- as_tibble(airport_list)
airport_compare

