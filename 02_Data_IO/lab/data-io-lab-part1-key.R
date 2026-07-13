## ----include = TRUE-----------------------------------------------------------
library(tidyverse)
library(readxl)


## -----------------------------------------------------------------------------
ufo_slice_1 <- read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_1.csv") # Your directory may vary!
head(ufo_slice_1)


## -----------------------------------------------------------------------------
ufo_slice_2 <-
  read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_2.tsv",
             delim = "\t")
head(ufo_slice_2)


## -----------------------------------------------------------------------------
ufo_slice_3 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_3.txt")
head(ufo_slice_3)


## -----------------------------------------------------------------------------
ufo_slice_4 <-
  read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_4.csv",
             delim = ":")
head(ufo_slice_4)


## -----------------------------------------------------------------------------
url <- "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_5.xlsx"
destfile <- "ufo_slice_5.xlsx"
curl::curl_download(url, destfile)
ufo_slice_5 <- read_excel(destfile)
head(ufo_slice_5)

