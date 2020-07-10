## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(httr)
library(jsonlite)


## -----------------------------------------------------------------------------
# response = httr::GET()


## ---- error = TRUE------------------------------------------------------------
out = jsonlite::fromJSON(httr::content(response, as = "text", flatten = TRUE))
class(out)
head(out)

