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


