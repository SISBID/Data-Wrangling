## ---- include=FALSE-------------------------------------------------------
library(tidyverse)
library(httr)
library(jsonlite)


## -------------------------------------------------------------------------
response = httr::GET("https://api.github.com/users/hadley/repos")
httr::content(response)
httr::status_code(response)


## ---- error = TRUE--------------------------------------------------------
out = jsonlite::fromJSON(httr::content(response, as = "text", flatten = TRUE))
class(out)
head(out)


## -------------------------------------------------------------------------
out$stargazers_count


## -------------------------------------------------------------------------
owner_data = out$owner

