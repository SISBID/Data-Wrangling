## ----include = TRUE-----------------------------------------------------------
library(tidyverse)
library(readxl)


## -----------------------------------------------------------------------------
iris_q1 <- read_csv("https://sisbid.github.io/Data-Wrangling/data/iris/iris_q1.csv") # Your directory may vary!
head(iris_q1)


## -----------------------------------------------------------------------------
iris_q2 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/iris/iris_q2.tsv", 
    delim = "\t")
head(iris_q2)


## -----------------------------------------------------------------------------
iris_q3 <- read_table("https://sisbid.github.io/Data-Wrangling/data/iris/iris_q3.txt")
head(iris_q3)


## -----------------------------------------------------------------------------
iris_q4 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/iris/iris_q4.csv", 
    delim = ":", escape_double = FALSE, trim_ws = TRUE)
head(iris_q4)


## -----------------------------------------------------------------------------
url <- "https://sisbid.github.io/Data-Wrangling/data/iris/iris_xl.xlsx"
destfile <- "iris_xl.xlsx"
curl::curl_download(url, destfile)
iris_xl <- read_excel(destfile)
head(iris_xl)

