## ----message = FALSE----------------------------------------------------------
library(tidyverse)


## -----------------------------------------------------------------------------
ufo_slice_5 <- read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_5.csv")


## -----------------------------------------------------------------------------
str(ufo_slice_5)
head(ufo_slice_5)
glimpse(ufo_slice_5)
nrow(ufo_slice_5)


## -----------------------------------------------------------------------------
ufo_slice_6 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_6.txt")
ufo_slice_6
ufo_slice_6 <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_6.txt", trim_ws = TRUE)
ufo_slice_6


## -----------------------------------------------------------------------------
# read_delim! read_table interprets all whitespace as delimiting - spaces in our data interfere with this function reading the data.
ufo_slice_7_table <- read_table("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_7.txt")
ufo_slice_7_delim <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_slice_7.txt")

