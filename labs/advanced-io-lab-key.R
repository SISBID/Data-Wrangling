## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(httr)
library(jsonlite)
library(googlesheets4)


## -----------------------------------------------------------------------------
sheet_url = "https://docs.google.com/spreadsheets/d/1KIRtcPVn58R3_qr97WNtcOJiY4AaytHzGDzLW_3_R1s/edit?usp=sharing"


## -----------------------------------------------------------------------------
x = googlesheets4::read_sheet(sheet_url)


## -----------------------------------------------------------------------------
googlesheets4::sheet_names(sheet_url)


## -----------------------------------------------------------------------------
googlesheets4::read_sheet(sheet_url, range =  cell_cols(1:2))
googlesheets4::read_sheet(sheet_url, range =  cell_cols("A:B"))


## -----------------------------------------------------------------------------
jsonData = fromJSON("https://think.cs.vt.edu/corgis/datasets/json/airlines/airlines.json")


## ---- error = TRUE------------------------------------------------------------
str(jsonData)


## -----------------------------------------------------------------------------
lga_ord = jsonData %>% 
  filter(Airport$Code %in% c("LGA", "ORD") & Time$Year == 2016)


## -----------------------------------------------------------------------------
airport_compare = as_tibble(list(
  airport_code = lga_ord$Airport$Code,
  total_flights = lga_ord$Statistics$Flights$Total,
  delayed_proportion = lga_ord$Statistics$Flights$Delayed / lga_ord$Statistics$Flights$Total
  ))
airport_compare

