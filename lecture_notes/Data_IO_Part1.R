## ---- echo = FALSE, message=FALSE-------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
opts_chunk$set(comment = "")


## ----code-------------------------------------------------------------------------
print("I'm code")


## ---------------------------------------------------------------------------------
#################
# Title: Demo R Script
# Author: Andrew Jaffe
# Date: 7/13/2020
# Purpose: Demonstrate comments in R
###################
 
# nothing to its right is evaluated

# this # is still a comment
### you can use many #'s as you want

# sometimes you have a really long comment,
#    like explaining what you are doing 
#    for a step in analysis. 
# Take it to another line


## ----assign-----------------------------------------------------------------------
x = 2 # Same as: x <- 2
x
x * 4
x + 2


## ---- eval = FALSE----------------------------------------------------------------
## ?dir
## help("dir")


## ---- echo = FALSE----------------------------------------------------------------
args(readr::read_delim)


## ----readCSV----------------------------------------------------------------------
read_csv


## ----readCSV2---------------------------------------------------------------------
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ----viewInput, message=FALSE-----------------------------------------------------
head(ufo)
class(ufo)


## ---- viewTibble------------------------------------------------------------------
ufo


## ----workingDirectory,eval=FALSE--------------------------------------------------
## ## get the working directory
## getwd()
## setwd("~/Lectures")

