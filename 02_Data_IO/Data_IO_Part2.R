## ----include = FALSE--------------------------------------------------------------------
library(knitr)
library(tidyverse)
library(visdat)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")
ufo <-read_csv("../data/ufo/ufo_data_complete.csv")


## ----eval=FALSE-------------------------------------------------------------------------
## # example for character delimited:
## read_delim(file = "file.txt", delim = "\t")


## ----eval=FALSE-------------------------------------------------------------------------
## # comma delimited:
## read_csv("file.csv")


## ----eval=FALSE-------------------------------------------------------------------------
## # From URL
## ufo <- read_csv(
##   "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv"
## )
## 
## # From your 'data-wrangling' directory
## ufo <- read_csv("ufo_data_complete.csv")


## ----viewInput, message=FALSE-----------------------------------------------------------
class(ufo)


## ----eval=FALSE-------------------------------------------------------------------------
## # example for whitespace delimited :
## read_table(file = "file.txt")


## ----eval=FALSE-------------------------------------------------------------------------
## # example:
## read_csv(file = "file.txt", trim_ws = TRUE)


## ----out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_121")


## ----eval = FALSE-----------------------------------------------------------------------
## ufo <- read_csv("../ufo_data_complete.csv.gz")


## ----eval=FALSE-------------------------------------------------------------------------
## ufo <- read_csv("data/ufo/ufo_data_complete.csv")


## ----echo=FALSE-------------------------------------------------------------------------
ufo <- read_csv("../data/ufo/ufo_data_complete.csv")


## ----dims-------------------------------------------------------------------------------
nrow(ufo)
ncol(ufo)
dim(ufo)


## ----colnames---------------------------------------------------------------------------
colnames(ufo)


## ----str--------------------------------------------------------------------------------
glimpse(ufo)


## ----stop_problems----------------------------------------------------------------------
head(problems(ufo))


## ---------------------------------------------------------------------------------------
dim(problems(ufo))


## ----eval=FALSE-------------------------------------------------------------------------
## # example:
## read_excel(path = "file.xlsx", sheet = 2)
## read_excel(path = "file.xlsx", sheet = "data")


## ----writecsv---------------------------------------------------------------------------
first_100 <- ufo[1:100,]
write_delim(first_100, file = "ufo_first100.csv", delim = ",")
write_csv(first_100, file = "ufo_first100.csv")


## ----eval=FALSE-------------------------------------------------------------------------
## write_rds(ufo, file = "ufo_dataset.rds", compress = "xz")


## ----eval=FALSE-------------------------------------------------------------------------
## ufo_new <- read_rds(file = "ufo_dataset.rds")


## ----message = FALSE--------------------------------------------------------------------
x = 5
save(ufo, x, file = "ufo_data.rda")


## ----eval = FALSE-----------------------------------------------------------------------
## load(file = "ufo_data.rda")

