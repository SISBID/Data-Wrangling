## ---- include = FALSE--------------------------------------------------------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")


## ----code--------------------------------------------------------------------------------------------------------------
print("I'm code")


## ----assign------------------------------------------------------------------------------------------------------------
x <- 2
x
x * 4
x + 2


## ---- eval = FALSE-----------------------------------------------------------------------------------------------------
## ?dir
## help("dir")


## ---- echo = FALSE, out.width="70%"------------------------------------------------------------------------------------
knitr::include_graphics("media/IO_help.png")


## ---- eval = FALSE-----------------------------------------------------------------------------------------------------
## install.packages("naniar")
## AnVIL::install("naniar") # Alternative
## library(naniar)


## ---- echo = FALSE, out.width="70%"------------------------------------------------------------------------------------
knitr::include_graphics("media/IO_help.png")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_79")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_85")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_91")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_97")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_103")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_109")


## ----------------------------------------------------------------------------------------------------------------------
ufo_data_complete_csv <- 
  read_csv("http://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv.gz")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_115")


## ---- echo = FALSE, out.width="70%"------------------------------------------------------------------------------------
knitr::include_graphics("media/IO_comments_to_self.png")


## ----eval=FALSE--------------------------------------------------------------------------------------------------------
## # example:
## read_delim(file = "file.txt", delim = "\t")
## read_csv("file.csv")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_121")


## ---- eval = FALSE-----------------------------------------------------------------------------------------------------
## ufo <- read_csv("../ufo_data_complete.csv.gz")


## ---- eval=FALSE-------------------------------------------------------------------------------------------------------
## ufo <- read_csv("data/ufo/ufo_data_complete.csv")


## ---- echo=FALSE-------------------------------------------------------------------------------------------------------
ufo <- read_csv("../data/ufo/ufo_data_complete.csv")


## ----viewInput, message=FALSE------------------------------------------------------------------------------------------
class(ufo)


## ---- viewTibble-------------------------------------------------------------------------------------------------------
ufo


## ---- eval = FALSE-----------------------------------------------------------------------------------------------------
## library(haven)
## 
## # SAS
## read_sas(file = "mtcars.sas7bdat")
## 
## # SPSS
## read_sav(file = "mtcars.sav")
## 
## # Stata
## read_dta(file = "mtcars.dta")

