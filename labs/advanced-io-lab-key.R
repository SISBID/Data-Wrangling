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
response = httr::GET("https://api.github.com/users/hadley/repos")
httr::content(response)
httr::status_code(response)


## ---- error = TRUE------------------------------------------------------------
out = jsonlite::fromJSON(httr::content(response, as = "text", flatten = TRUE))
class(out)
head(out)


## -----------------------------------------------------------------------------
out$stargazers_count


## -----------------------------------------------------------------------------
owner_data = out$owner

