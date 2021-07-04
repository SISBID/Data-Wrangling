## ---- include = FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
library(tidyverse)


## -----------------------------------------------------------------------------
circ = read_csv(paste0("http://sisbid.github.io/Data-Wrangling/",
                       "data/Charm_City_Circulator_Ridership.csv"))
# or circ = read_csv("../data/Charm_City_Circulator_Ridership.csv")


## -----------------------------------------------------------------------------
head(circ)


## -----------------------------------------------------------------------------
tail(circ, 10)


## -----------------------------------------------------------------------------
mean(circ$daily)
sum(circ$daily)
mean(circ$daily, na.rm = TRUE)
sum(circ$daily, na.rm = TRUE)


## -----------------------------------------------------------------------------
quantile(circ$daily, na.rm = TRUE)
quantile(circ$daily, na.rm = TRUE, probs = c(0.6, 0.84))
median(circ$daily, na.rm = TRUE)


## ---- message = FALSE---------------------------------------------------------
unique(circ$day)


## -----------------------------------------------------------------------------
length(unique(circ$date))


## ---- message = FALSE---------------------------------------------------------
table(circ$day)


## ---- message = FALSE---------------------------------------------------------
circ %>% count(day)


## ---- message = FALSE---------------------------------------------------------
circ %>% mutate(many_riders = daily > 1000) %>% count(many_riders, day)


## -----------------------------------------------------------------------------
circ %>% 
  summarize(mean_purple = mean(purpleAverage, na.rm = TRUE),
            mean(bannerAverage, na.rm = TRUE))


## -----------------------------------------------------------------------------
circ %>% summarise(across(ends_with("Boardings"), mean, na.rm = TRUE))


## -----------------------------------------------------------------------------
sub_circ = circ %>% group_by(day)
head(sub_circ)


## -----------------------------------------------------------------------------
sub_circ %>% summarize(avg_daily = mean(daily, na.rm = TRUE))


## -----------------------------------------------------------------------------
day_avgs = circ %>% 
  group_by(day) %>% 
  summarize(avg_daily = mean(daily, na.rm = TRUE))
head(day_avgs)


## -----------------------------------------------------------------------------
sub_circ = ungroup(sub_circ)
sub_circ


## -----------------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  mutate(mean = mean(daily, na.rm = TRUE)) %>% 
  select(day, date, mean, daily)


## -----------------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarize(n = n(),
            mean = mean(daily, na.rm = TRUE)) %>% 
  head


## -----------------------------------------------------------------------------
t.test(circ$daily)
broom::tidy(t.test(circ$daily))


## ----colMeans-----------------------------------------------------------------
avgs = circ %>% select(ends_with("Boardings"))
colMeans(avgs, na.rm = TRUE)


## -----------------------------------------------------------------------------
circ = circ %>% mutate(mean_boarding = rowMeans(avgs, na.rm = TRUE))
head(circ %>% select(day, mean_boarding))


## ---- eval = FALSE------------------------------------------------------------
## qplot


## ---- echo = FALSE------------------------------------------------------------
args(qplot)


## ---- warning =FALSE----------------------------------------------------------
library(ggplot2)
circ %>% 
  mutate(date = lubridate::mdy(date)) %>% 
  qplot(x = date, y = daily, colour = day, data = .) + geom_line()

