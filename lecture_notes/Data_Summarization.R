## ---- echo = FALSE, message=FALSE, error = FALSE---------------------------------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
suppressWarnings({library(dplyr)})
library(readr)
library(tidyverse)


## --------------------------------------------------------------------------------------------------
x <- c(1, 5, 7, 4, 2, 8)
mean(x)
mean(x, na.rm = TRUE) # Remove NAs if needed


## --------------------------------------------------------------------------------------------------
mtcars %>% pull(hp) %>% mean() # alt: pull(mtcars, hp) %>% mean()
mean(mtcars$hp)


## --------------------------------------------------------------------------------------------------
yts <- 
  read_csv("http://sisbid.github.io/Data-Wrangling/data/Youth_Tobacco_Survey_YTS_Data.csv")
head(yts)


## ---- message = FALSE------------------------------------------------------------------------------
locations <- yts %>% pull(LocationDesc)
locations


## ---- message = FALSE------------------------------------------------------------------------------
unique(locations)


## --------------------------------------------------------------------------------------------------
length(unique(locations))


## --------------------------------------------------------------------------------------------------
sum(is.na(locations))


## ---- message = FALSE------------------------------------------------------------------------------
yts %>% count(LocationDesc)


## ---- message = FALSE------------------------------------------------------------------------------
yts %>% count(LocationDesc, TopicDesc)


## ---- message = FALSE------------------------------------------------------------------------------
yts %>% count(LocationDesc, sort = TRUE)


## ---- message = FALSE------------------------------------------------------------------------------
# Add up "Data_Value" for each LocationDesc category
yts %>% count(LocationDesc, wt = Data_Value)


## --------------------------------------------------------------------------------------------------
# Regular data
yts


## --------------------------------------------------------------------------------------------------
yts_grouped <- yts %>% group_by(Response)
yts_grouped


## --------------------------------------------------------------------------------------------------
yts %>% 
  summarize(mean_value = mean(Data_Value, na.rm = TRUE))


## --------------------------------------------------------------------------------------------------
yts_grouped %>% 
  summarize(mean_value = mean(Data_Value, na.rm = TRUE))


## --------------------------------------------------------------------------------------------------
yts %>%
  group_by(Response) %>%
  summarize(mean_value = mean(Data_Value, na.rm = TRUE),
            max_value = max(Data_Value, na.rm = TRUE))


## --------------------------------------------------------------------------------------------------
yts %>%
  group_by(YEAR) %>%
  mutate(year_avg = mean(Data_Value, na.rm = TRUE)) %>%
  select(LocationDesc, Data_Value, year_avg)


## --------------------------------------------------------------------------------------------------
yts %>%
  group_by(YEAR) %>%
  summarize(n = n(),
            mean = mean(Data_Value, na.rm = TRUE))


## ---- eval = FALSE---------------------------------------------------------------------------------
# General format - Not the code!
across({ columns to go across }, ~ { summarization_function(.x, na.rm = ..) }) 


## --------------------------------------------------------------------------------------------------
yts %>%
  group_by(YEAR) %>%
  summarize(across( c(Data_Value, Data_Value_Std_Err, Sample_Size), 
                    ~ mean(.x, na.rm = TRUE)))


## --------------------------------------------------------------------------------------------------
yts %>% 
  summarize(across( where(is.numeric), ~ mean(.x, na.rm = TRUE)))


## --------------------------------------------------------------------------------------------------
summary(yts)

