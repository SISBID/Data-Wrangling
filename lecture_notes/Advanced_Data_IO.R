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
jsonData <- fromJSON(paste0("https://raw.githubusercontent.com/Biuni",
                            "/PokemonGO-Pokedex/master/pokedex.json"))
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

nds = html_nodes(htmlfile, xpath = '//*[@id="recounttab"]/table')
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

# Requests a random cat fact
query_url = "https://thatcopy.pw/catapi/rest/"

req = GET(query_url)
content(req)


## ---- eval = FALSE------------------------------------------------------------
## # install.packages("twitteR")
## library(twitteR)
## # Supplied by Twitter
## setup_twitter_oauth("API key", "API secret")
## 
## searchTwitter("crab cake", geocode="39.290692,-76.610221,5mi")


## ---- eval = FALSE------------------------------------------------------------
## # install.packages("tidycensus")
## library(tidycensus)
## # Supplied by census.gov
## census_api_key("YOUR API KEY GOES HERE")
## 
## get_decennial(geography = "state",
##                        variables = "P013001", # code for median age
##                        year = 2010)

