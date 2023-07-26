## ---- include=FALSE-------------------------------------------------------------------------------------------
library(tidyverse)
library(rvest)
library(jsonlite)




## -------------------------------------------------------------------------------------------------------------
library(googlesheets4)

## ----eval=FALSE-----------------------------------------------------------------------------------------------
## # Prompts a browser pop-up
## gs4_auth()

## -------------------------------------------------------------------------------------------------------------
# Once set up, you can automate this process by passing your email
gs4_auth(email = "avamariehoffman@gmail.com")


## ----eval = FALSE---------------------------------------------------------------------------------------------
## library(googledrive)
## drive_auth(email= "<email>",
##            token = readRDS("google-sheets-token.rds")) # Saved in a file


## -------------------------------------------------------------------------------------------------------------
sheet_url <- 
  "https://docs.google.com/spreadsheets/d/1U6Cf_qEOhiR9AZqTqS3mbMF3zt2db48ZP5v3rkrAEJY/edit#gid=780868077"
sheet_dat_1 <- read_sheet(sheet_url)
head(sheet_dat_1)


## -------------------------------------------------------------------------------------------------------------
sheet_dat_oceania <- read_sheet(sheet_url, sheet = "Oceania")
head(sheet_dat_oceania)


## -------------------------------------------------------------------------------------------------------------
read_sheet(sheet_url, sheet = "Oceania", range =  cell_rows(1:4))


## -------------------------------------------------------------------------------------------------------------
read_sheet(sheet_url, sheet = "Oceania", range =  cell_cols("A:B"))


## -------------------------------------------------------------------------------------------------------------
sheet_names(sheet_url)


## -------------------------------------------------------------------------------------------------------------
gapminder_sheets <- sheet_names(sheet_url)

data_list <- map(gapminder_sheets, ~ read_sheet(sheet_url, sheet = .x))


## -------------------------------------------------------------------------------------------------------------
str(data_list)


## ----eval=FALSE-----------------------------------------------------------------------------------------------
## data_list[[{sheet}]]
## # OR
## data_list %>% pluck({sheet})
## # OR (if named)
## data_list${sheet}


## ---- out.width="80%", echo=FALSE, fig.alt='.'----------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13f84314e00_0_0")


## -------------------------------------------------------------------------------------------------------------
sheet_dat_oceania <- data_list[[5]]

sheet_dat_oceania <- sheet_dat_oceania %>%
  mutate(lifeExp_days = lifeExp * 365)

sheet_out <- gs4_create("Oceania-days", 
                       sheets = list(Oceania_days = sheet_dat_oceania))

## ----eval = FALSE---------------------------------------------------------------------------------------------
## # Opens a browser window
## gs4_browse(sheet_out)


## -------------------------------------------------------------------------------------------------------------
sheet_append(sheet_out, data = sheet_dat_oceania, sheet = "Oceania_days")






## -------------------------------------------------------------------------------------------------------------
#install.packages("jsonlite")
library(jsonlite)
jsonData <-
  fromJSON("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json")
head(jsonData)


## -------------------------------------------------------------------------------------------------------------
dim(jsonData$pokemon)
class(jsonData$pokemon)

jsonData$pokemon %>% filter(type == "Fire") %>% select(!(img))


## -------------------------------------------------------------------------------------------------------------
class(jsonData$pokemon$type) # Can be lists
jsonData$pokemon$type


## -------------------------------------------------------------------------------------------------------------
class(jsonData$pokemon$next_evolution[[1]]) # Or lists of data.frames!
jsonData$pokemon$next_evolution












## -------------------------------------------------------------------------------------------------------------
recount_url <- "http://bowtie-bio.sourceforge.net/recount/"
# install.packages("rvest")
library(rvest)
htmlfile <- read_html(recount_url)

nds <- html_nodes(htmlfile, xpath = '//*[@id="recounttab"]/table')
dat <- html_table(nds)
dat <- as.data.frame(dat)
head(dat)


## -------------------------------------------------------------------------------------------------------------
colnames(dat) <- as.character(dat[1,])
dat <- dat[-1,]
head(dat)


















## -------------------------------------------------------------------------------------------------------------
#install.packages("httr")
library(httr)

# Requests a random cat fact
query_url <- "https://thatcopy.pw/catapi/rest/"

req <- GET(query_url)
content(req)


## ---- eval = FALSE--------------------------------------------------------------------------------------------
## # install.packages("twitteR")
## library(twitteR)
## # Supplied by Twitter
## setup_twitter_oauth("API key", "API secret")
## 
## searchTwitter("crab cake", geocode="39.290692,-76.610221,5mi")


## ---- eval = FALSE--------------------------------------------------------------------------------------------
## # install.packages("tidycensus")
## library(tidycensus)
## # Supplied by census.gov
## census_api_key("YOUR API KEY GOES HERE")
## 
## get_decennial(geography = "state",
##                        variables = "P013001", # code for median age
##                        year = 2010)

