## ----include = FALSE----------------------------------------------------------
library(knitr)
library(tidyverse)
library(janitor)
opts_chunk$set(comment = "")


## -----------------------------------------------------------------------------
ufo <- read_delim(
  "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv", 
  delim = ",")



## -----------------------------------------------------------------------------
p <-problems(ufo)
p %>% glimpse()


## -----------------------------------------------------------------------------
p %>% count(expected, actual, col)


## -----------------------------------------------------------------------------
colnames(ufo)
glimpse(ufo)


## -----------------------------------------------------------------------------
p %>% filter(col == 6)


## -----------------------------------------------------------------------------
 slice(ufo, 30894 -1) %>% glimpse()


## ----include=TRUE, echo =FALSE, out.width="100%"------------------------------

knitr::include_graphics("https://github.com/SISBID/Data-Wrangling/raw/gh-pages/images/raw_ufo_col6.png")


## -----------------------------------------------------------------------------
url <- 
  "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv"
ufo <-read_csv(url, col_types = cols(`duration (seconds)` = "c"))


## -----------------------------------------------------------------------------
p <- problems(ufo)
count(p, expected, actual, col)


## -----------------------------------------------------------------------------
slice(ufo, 30894 -1) %>% glimpse()



## -----------------------------------------------------------------------------
head(p, n = 2)
(pull(p, row) -1) %>% head()
ufo_clean <- ufo %>% slice(-(pull(p, row)-1))


## -----------------------------------------------------------------------------
nrow(ufo) - nrow(ufo_clean)
count(p, expected, actual)


## -----------------------------------------------------------------------------
ufo_colnames <-colnames(ufo)
ufo_colnames<-c(ufo_colnames, "empty") # add a new column name for 12th column

ufo2 <-
read.table("https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv",
                  header = TRUE, sep = ",", col.names = ufo_colnames, fill = TRUE, na = "", 
           colClasses = c(rep("character",10), "numeric")) # based on what the values seem to be currently
ufo2 <-ufo2 %>% filter(empty == 0)



## -----------------------------------------------------------------------------
colnames(ufo_clean)
ufo_clean <- clean_names(ufo_clean)
colnames(ufo_clean)


## ----echo=FALSE---------------------------------------------------------------
dup_df <- data.frame(
  ID = c(1, 3, 2, 2),
  Name = c("R", "R", "Python", "Python"),
  value = c(25, 60, 30, 30)
)


## -----------------------------------------------------------------------------
dup_df
distinct(dup_df) # to get just distinct rows


## -----------------------------------------------------------------------------
dup_df %>% aggregate(value ~ Name, mean)
dup_df %>% aggregate(value ~ Name, sum)


## -----------------------------------------------------------------------------
ufo_clean %>% 
  mutate(country = 
           case_when(country == "gb" ~ "Great Britain"),
         .default = country) %>% 
  glimpse()



## -----------------------------------------------------------------------------
ufo_clean %>% 
  mutate(country = 
           case_when(country == "gb" ~ "Great Britain",
         TRUE ~ country)) %>% 
  glimpse()



## -----------------------------------------------------------------------------
ufo_clean %>% count(country)


## -----------------------------------------------------------------------------
ufo_clean %>% mutate(country = case_when(
                  country == "gb" ~ "Great Britain",
                  country == "us" ~"United States",
                  country == "au" ~ "Australia",
                  country == "DE" ~ "Germany",
                             .default = country))%>%
  glimpse()



## -----------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% mutate( 
            region = case_when(
              country %in% c("us", "ca") ~ "North America",
              country %in% c("de") ~ "Europe",
              country %in% "gb" ~ "Great Britain",
              .default = "Other"
            ))
ufo_clean %>% select(country, region) %>% head()


## -----------------------------------------------------------------------------
head(ufo_clean)



## -----------------------------------------------------------------------------
ufo_clean %>% filter(state == "tx") %>% count(country, state)
ufo_clean %>% filter(state == "tx" & is.na(country)) %>% select(city)


## -----------------------------------------------------------------------------
ufo_clean %>% filter(state == "ut") %>% count(country, state)
ufo_clean %>% filter(state == "ut" & is.na(country))  %>% select(city)


## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "us") %>%
  count(state) %>%
  pull(state)
US_states <- ufo_clean %>%
  filter(country == "us") %>%
  count(state) %>%
  pull(state)



## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "ca") %>%
  count(state) %>%
  pull(state)
CA_states <- ufo_clean %>%
  filter(country == "ca") %>%
  count(state) %>%
  pull(state)



## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "gb") %>%
  count(state) %>%
  pull(state)
GB_states <- ufo_clean %>%
  filter(country == "gb") %>%
  count(state) %>%
  pull(state)



## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "de") %>%
  count(state) %>%
  pull(state)



## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "au") %>%
  count(state) %>%
  pull(state)
AU_states <- ufo_clean %>%
  filter(country == "au") %>%
  count(state) %>%
  pull(state)



## -----------------------------------------------------------------------------
numbers <-c(1,2,3)
letters <-c("a", "b", 3)

setdiff(numbers, letters)
setdiff(letters, numbers)


## -----------------------------------------------------------------------------
US_states
c(AU_states, GB_states, CA_states)
US_states <- setdiff(US_states, c(AU_states, GB_states, CA_states))
US_states


## -----------------------------------------------------------------------------
AU_states <- setdiff(AU_states, c(US_states, GB_states, CA_states))

CA_states <- setdiff(CA_states, c(US_states, GB_states, AU_states))

GB_states <- setdiff(GB_states, c(US_states, AU_states, CA_states))


## -----------------------------------------------------------------------------
ufo_clean %>%
  filter(country != "us" & !is.na(country)) %>%
  count(country)



## -----------------------------------------------------------------------------
ufo_clean <- ufo_clean %>% mutate(prob_country =
      case_when((is.na(country) & state %in% c(US_states)) ~ "United States",
                (is.na(country) & state %in% c(CA_states)) ~ "Canada",
                (is.na(country) & state %in% c(AU_states)) ~ "Australia",
                (is.na(country) & state %in% c(GB_states)) ~ "Great Britain",
                   TRUE ~ country))


## -----------------------------------------------------------------------------
count(ufo_clean, prob_country)


## -----------------------------------------------------------------------------
ufo_clean %>% filter(is.na(prob_country))


## -----------------------------------------------------------------------------
ufo_clean %>% filter(country == "de") %>%
  pull(city)


## -----------------------------------------------------------------------------
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



## -----------------------------------------------------------------------------
ufo_clean %>%
  count(country, prob_country)

