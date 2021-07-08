## ---- include=FALSE-----------------------------------------------------------
library(tidyverse)
library(rvest)
library(jsonlite)




## -----------------------------------------------------------------------------
library(googlesheets4)

## ----eval=FALSE---------------------------------------------------------------
## # Prompts a browser pop-up
## gs4_auth()

## -----------------------------------------------------------------------------
# Once set up, you can automate this process by passing your email
gs4_auth(email = "avamariehoffman@gmail.com")


## ----eval = FALSE-------------------------------------------------------------
## library(googledrive)
## drive_auth(email= "<email>",
##            token = readRDS("google-sheets-token.rds")) # Saved in a file


## -----------------------------------------------------------------------------
sheet_url = paste0("https://docs.google.com/spreadsheets/d/1U6Cf_qEOhiR9",
                   "AZqTqS3mbMF3zt2db48ZP5v3rkrAEJY/edit#gid=780868077")
sheet_dat_1 = read_sheet(sheet_url)
head(sheet_dat_1)


## -----------------------------------------------------------------------------
sheet_url = paste0("https://docs.google.com/spreadsheets/d/1U6Cf_qEOhiR9",
                   "AZqTqS3mbMF3zt2db48ZP5v3rkrAEJY/edit#gid=780868077")
sheet_dat_oceania = read_sheet(sheet_url, sheet = "Oceania")
head(sheet_dat_oceania)


## -----------------------------------------------------------------------------
sheet_names(sheet_url)


## -----------------------------------------------------------------------------
gapminder_sheets = sheet_names(sheet_url)

data_list = list()
for(g_sheet in gapminder_sheets){
  data_list[[g_sheet]] = read_sheet(sheet_url, sheet = g_sheet)
}
str(data_list)


## -----------------------------------------------------------------------------
str(data_list)


## -----------------------------------------------------------------------------
sheet_dat_oceania = sheet_dat_oceania %>%
  mutate(lifeExp_days = lifeExp * 365)
sheet_out = gs4_create("Oceania-days", 
                       sheets = list(Oceania_days = sheet_dat_oceania))

## ----eval = FALSE-------------------------------------------------------------
## # Opens a browser window
## gs4_browse(sheet_out)


## -----------------------------------------------------------------------------
sheet_append(sheet_out, data = sheet_dat_oceania, sheet = "Oceania_days")






## -----------------------------------------------------------------------------
#install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json")
head(jsonData)


## -----------------------------------------------------------------------------
dim(jsonData$pokemon)
class(jsonData$pokemon$type) # Can be lists
jsonData$pokemon$type


## -----------------------------------------------------------------------------
class(jsonData$pokemon$next_evolution[[1]]) # Or lists of data.frames!
jsonData$pokemon$next_evolution












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

