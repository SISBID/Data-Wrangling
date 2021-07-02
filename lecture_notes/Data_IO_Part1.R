## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")


## ----code---------------------------------------------------------------------
print("I'm code")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_upload.png")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_file_menu_RStudiocloud.png")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_file_import_browser_RStudiocloud.png")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_file_import_browse_RStudiocloud.png")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_file_import_preview_RStudiocloud.png")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_file_import_console_code.png")


## ---- echo = FALSE, out.width="70%"-------------------------------------------
knitr::include_graphics("media/IO_comments_to_self.png")


## -----------------------------------------------------------------------------
#################
# Title: Demo R Script
# Date: 7/13/2020
# Purpose: Demonstrate comments in R
###################
 
# nothing to its right is evaluated
x = 2 # but the left will be

# this # is still a comment
### you can use many #s as you want
##### 5 #s or more make a collapsible section 

# sometimes if you have a really long comment,
# you can take it to another line


## ----assign-------------------------------------------------------------------
x = 2 # Same as: x <- 2
x
x * 4
x + 2


## ---- eval = FALSE------------------------------------------------------------
## ?dir
## help("dir")


## ---- echo = FALSE, out.width="70%"-------------------------------------------
knitr::include_graphics("media/IO_help.png")


## ---- echo = FALSE------------------------------------------------------------
args(readr::read_delim)


## ----eval=FALSE---------------------------------------------------------------
## # example:
## read_delim(file = "file.txt", delim = "\t")
## read_delim("file.txt", "\t")


## ----readCSV2-----------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ----viewInput, message=FALSE-------------------------------------------------
class(ufo)


## ---- viewTibble--------------------------------------------------------------
ufo


## ----workingDirectory,eval=FALSE----------------------------------------------
## ## get the working directory
## getwd()
## setwd("~/Lectures")

