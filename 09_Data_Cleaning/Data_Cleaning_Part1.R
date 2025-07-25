## ---- include = FALSE-----------------------------------------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## -------------------------------------------------------------------------------------------------------------
ufo <- read_delim("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv", delim = ",")



## -------------------------------------------------------------------------------------------------------------
p <-problems(ufo)
p %>% glimpse()


## -------------------------------------------------------------------------------------------------------------
count(p, expected, actual)


## ---- echo = FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics(here::here("lecture_notes", "media", "problems.png"))



## -------------------------------------------------------------------------------------------------------------
colnames(ufo)


## -------------------------------------------------------------------------------------------------------------
url <- "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv"
ufo <-read_csv(url, col_types = cols(`duration (seconds)` = "c"))


## -------------------------------------------------------------------------------------------------------------
p <- problems(ufo)

count(p, expected, actual)


## -------------------------------------------------------------------------------------------------------------
head(p, n = 2)
(pull(p, row) -1) %>% head()
((pull(p, row) -1) *-1) %>% head()
ufo_clean <- ufo %>% slice((pull(p, row)-1)*-1)


## -------------------------------------------------------------------------------------------------------------
nrow(ufo) - nrow(ufo_clean)
count(p, expected, actual)


## -------------------------------------------------------------------------------------------------------------
colnames(ufo_clean)
ufo_clean <- clean_names(ufo_clean)
colnames(ufo_clean)


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  mutate(country = 
           recode(country, gb = "Great Britain")) %>% 
  glimpse()



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% mutate(country = 
          recode(country, 
                 gb = "Great Britain",
                 us = "United States")) %>% 
  glimpse()



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% count(country)


## -------------------------------------------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% mutate( 
            region = case_when(
              country %in% c("us", "ca") ~ "North America",
              country %in% c("de") ~ "Europe",
              country %in% "gb" ~ "Great Britain",
              TRUE ~ "Other"
            ))
ufo_clean %>% select(country, region) %>% head()


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% mutate(country = case_when(
                  country == "gb" ~ "Great Britain",
                  country == "us" ~"United States",
                  country == "au" ~ "Australia",
                  country == "DE" ~ "Germany",
                             TRUE ~ country))%>%
  glimpse()



## -------------------------------------------------------------------------------------------------------------
head(ufo_clean)



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(state == "tx") %>% count(country, state)
ufo_clean %>% filter(state == "tx" & is.na(country)) %>% select(city)


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(state == "ut") %>% count(country, state)
ufo_clean %>% filter(state == "ut" & is.na(country))  %>% select(city)


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "us") %>% 
  count(state) %>% 
  pull(state)
US_states <- ufo_clean %>% 
  filter(country == "us") %>% 
  count(state) %>% 
  pull(state)



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "ca") %>% 
  count(state) %>% 
  pull(state)
CA_states <- ufo_clean %>% 
  filter(country == "ca") %>% 
  count(state) %>% 
  pull(state)



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "gb") %>% 
  count(state) %>% 
  pull(state)
GB_states <- ufo_clean %>% 
  filter(country == "gb") %>% 
  count(state) %>% 
  pull(state)



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "de") %>% 
  count(state) %>% 
  pull(state)



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "au") %>% 
  count(state) %>% 
  pull(state)
AU_states <- ufo_clean %>% 
  filter(country == "au") %>% 
  count(state) %>% 
  pull(state)



## -------------------------------------------------------------------------------------------------------------
US_states <- US_states[!(US_states %in% AU_states)]
US_states <- US_states[!(US_states %in% GB_states)]
US_states <- US_states[!(US_states %in% CA_states)]

AU_states <- AU_states[!(AU_states %in% US_states)]
AU_states <- AU_states[!(AU_states %in% GB_states)]
AU_states <- AU_states[!(AU_states %in% CA_states)]

CA_states <- CA_states[!(CA_states %in% US_states)]
CA_states <- CA_states[!(CA_states %in% GB_states)]
CA_states <- CA_states[!(CA_states %in% CA_states)]

GB_states <- GB_states[!(GB_states %in% US_states)]
GB_states <- GB_states[!(GB_states%in% AU_states)]
GB_states <- GB_states[!(GB_states %in% CA_states)]


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  filter(country != "us" & !is.na(country)) %>% 
  count(country) 



## -------------------------------------------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% mutate(prob_country = 
      case_when((is.na(country) & state %in% c(US_states)) ~ "United States",
                (is.na(country) & state %in% c(CA_states)) ~ "Canada",
                (is.na(country) & state %in% c(AU_states)) ~ "Australia",
                (is.na(country) & state %in% c(GB_states)) ~ "Great Britain",
                   TRUE ~ country))


## -------------------------------------------------------------------------------------------------------------
count(ufo_clean, prob_country)


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(is.na(prob_country))


## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% filter(country == "de") %>% 
  pull(city)


## -------------------------------------------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% mutate(prob_country = 
      case_when(
      (is.na(country) & state %in% c(US_states))  | 
  country == "us" ~ "United States",
      (is.na(country) & state %in% c(CA_states))  | 
  country == "ca" ~ "Canada",
      (is.na(country) & state %in% c(AU_states))  | 
  country == "au" ~ "Australia",
      (is.na(country) & state %in% c(GB_states))  | 
  country == "gb" ~ "Great Britain",
       country == "de" ~ "Germany",
                   TRUE ~ country))



## -------------------------------------------------------------------------------------------------------------
ufo_clean %>% 
  count(country, prob_country)

