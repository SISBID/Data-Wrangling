## ----echo = FALSE, message=FALSE, error = FALSE-------------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
suppressWarnings({library(dplyr)})
library(readr)
library(tidyverse)


## -----------------------------------------------------------------------------
x <- c(1, 5, 7, 4, 2, 8)
mean(x)


## -----------------------------------------------------------------------------
mtcars %>% pull(hp) %>% mean()


## ----warning=FALSE------------------------------------------------------------
ufo <- read_csv("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv")
ufo <- ufo %>% rename(duration_s = `duration (seconds)`)
head(ufo)


## ----message = FALSE----------------------------------------------------------
ufo_shapes <- ufo %>% pull(shape)
ufo_shapes


## -----------------------------------------------------------------------------
sum(is.na(ufo_shapes))


## ----message = FALSE----------------------------------------------------------
ufo %>% count(shape)


## ----message = FALSE----------------------------------------------------------
ufo %>% count(shape, country)


## ----message = FALSE----------------------------------------------------------
ufo %>% count(shape, sort = TRUE)


## ----message = FALSE----------------------------------------------------------
# Add up "duration_s" for each "shape" category
ufo %>% count(shape, wt = duration_s)


## -----------------------------------------------------------------------------
# No group_by()
ufo


## -----------------------------------------------------------------------------
ufo_grouped <- ufo %>% group_by(shape)
ufo_grouped


## -----------------------------------------------------------------------------
ufo_grouped %>% 
  summarize(mean_value = mean(duration_s, na.rm = TRUE))


## -----------------------------------------------------------------------------
ufo %>%
  group_by(shape) %>%
  summarize(mean_value = mean(duration_s, na.rm = TRUE),
            max_value = max(duration_s, na.rm = TRUE))


## -----------------------------------------------------------------------------
ufo_compare <- ufo %>%
  group_by(shape) %>%
  mutate(duration_shape_avg = mean(duration_s, na.rm = TRUE)) %>%
  select(shape, duration_s, duration_shape_avg)
ufo_compare


## -----------------------------------------------------------------------------
ufo_compare %>% mutate(diff = duration_s - duration_shape_avg)


## -----------------------------------------------------------------------------
dropouts <- read_delim("https://sisbid.github.io/Data-Wrangling/data/dropouts.txt", delim = "/")
dropouts %>%
  group_by(ETHNIC) %>%
  summarize(across(c(D9, D10, D11, D12), ~sum(.x)))


## -----------------------------------------------------------------------------
dropouts %>% 
  group_by(ETHNIC) %>% 
  summarize(across( where(is.numeric), ~ sum(.x, na.rm = TRUE)))


## -----------------------------------------------------------------------------
summary(dropouts)

