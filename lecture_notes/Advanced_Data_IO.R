## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(rvest)
library(jsonlite)






## ---- eval = FALSE------------------------------------------------------------
## install.packages("googlesheets")
## library(googlesheets)








## ---- message = FALSE---------------------------------------------------------
sheets_url = paste0("https://docs.google.com/spreadsheets/d/",
                    "1WBrH655fxqKW1QqvD5hnqvvEWIvRzDJcKEgjjFeYxeM")

gsurl1 = gs_url(sheets_url)

dat = gs_read(gsurl1)
date_read = lubridate::today()
head(dat)


## ---- eval = FALSE------------------------------------------------------------
## library(googlesheets4)
## # May be necessary on rstudio.cloud
## options(httr_oob_default=TRUE)
## # Will ask you to log in
## out = read_sheet(sheets_url)


## ---- message = FALSE---------------------------------------------------------
token = readr::read_rds("googledrive_token.rds")
library(googledrive)
drive_auth(token = token) # could also use googlesheets4::gs4_auth
library(googlesheets4)
out = read_sheet(sheets_url)
head(out)






## -----------------------------------------------------------------------------
#install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
head(jsonData)


## -----------------------------------------------------------------------------
dim(jsonData)
head(jsonData$name)
class(jsonData$owner) #Some of the columns is a data frame!
dim(jsonData$owner); names(jsonData$owner)












## -----------------------------------------------------------------------------
recount_url = "http://bowtie-bio.sourceforge.net/recount/"
# install.packages("rvest")
library(rvest)
htmlfile = read_html(recount_url)

nds = html_nodes(htmlfile,                
xpath='//*[@id="recounttab"]/table')
dat = html_table(nds)
dat = as.data.frame(dat)
head(dat)


## -----------------------------------------------------------------------------
colnames(dat) = as.character(dat[1,])
dat = dat[-1,]
head(dat)




















## -----------------------------------------------------------------------------
#install.packages("httr")
library(httr)

query_url = paste0("https://api.github.com/", "search/repositories", 
                   "?q=created:2014-08-13", "+language:r", "+-user:cran")

req = GET(query_url)
names(content(req))




## ---- eval = FALSE------------------------------------------------------------
## myapp = oauth_app("twitter",
##                    key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
## sig = sign_oauth1.0(myapp,
##                      token = "yourTokenHere",
##                       token_secret = "yourTokenSecretHere")
## homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
## 
## # But you can get cool data
## json1 = content(homeTL)
## json2 = jsonlite::fromJSON(toJSON(json1))
## json2[1,1:4]


## ---- eval = FALSE------------------------------------------------------------
##                     created_at           id             id_str
## 1 Mon Jan 13 05:18:04 +0000 2014 4.225984e+17 422598398940684288
##                                                                                                                                          text
## 1 Now that P. Norvig's regex golf IPython notebook hit Slashdot, let's see if our traffic spike tops the previous one: http://t.co/Vc6JhZXOo8

