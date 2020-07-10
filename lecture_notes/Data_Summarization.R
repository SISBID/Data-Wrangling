## ---- include = FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
library(tidyverse)


## -------------------------------------------------------------------------
circ = read_csv(paste0("http://sisbid.github.io/Module1/",
                       "data/Charm_City_Circulator_Ridership.csv"))


## -------------------------------------------------------------------------
head(circ, 3)
tail(circ)


## -------------------------------------------------------------------------
mean(circ$daily)
sum(circ$daily)
mean(circ$daily, na.rm = TRUE)


## ---- error=TRUE----------------------------------------------------------
quantile(circ$daily)


## -------------------------------------------------------------------------
quantile(circ$daily, na.rm = TRUE)
quantile(circ$daily, na.rm = TRUE, probs = c(0.6, 0.84))
median(circ$daily, na.rm = TRUE)


## -------------------------------------------------------------------------
t.test(circ$daily)
broom::tidy(t.test(circ$daily))


## ---- message = FALSE-----------------------------------------------------
unique(circ$day)


## -------------------------------------------------------------------------
length(unique(circ$date))


## ---- message = FALSE-----------------------------------------------------
table(circ$day)


## ---- message = FALSE-----------------------------------------------------
circ %>% count(day)


## ---- message = FALSE-----------------------------------------------------
circ %>% mutate(many_riders = daily > 1000) %>% count(many_riders, day)


## -------------------------------------------------------------------------
circ %>% 
  summarize(mean_purple = mean(purpleAverage, na.rm = TRUE),
            median_orange = median(orangeAverage, na.rm = TRUE),
            median(bannerAverage, na.rm = TRUE))


## ----colMeans-------------------------------------------------------------
avgs = circ %>% select(ends_with("Boardings"))
colMeans(avgs, na.rm = TRUE)


## -------------------------------------------------------------------------
circ = circ %>% mutate(mean_boarding = rowMeans(avgs, na.rm = TRUE))
head(circ %>% select(day, mean_boarding))


## -------------------------------------------------------------------------
circ %>% summarize(avg_boarding = mean(orangeBoardings, na.rm = TRUE))


## -------------------------------------------------------------------------
circ %>% summarise(across(ends_with("Boardings"), mean, na.rm = TRUE))


## -------------------------------------------------------------------------
sub_circ = group_by(circ, day)
head(sub_circ)


## -------------------------------------------------------------------------
sub_circ %>% summarize(avg_daily = mean(daily, na.rm = TRUE))


## -------------------------------------------------------------------------
day_avgs = circ %>% 
  group_by(day) %>% 
  summarize(mean = mean(daily, na.rm = TRUE),
            med = median(daily, na.rm = TRUE))
head(day_avgs)


## -------------------------------------------------------------------------
sub_circ = ungroup(sub_circ)
sub_circ


## -------------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  mutate(mean = mean(daily, na.rm = TRUE)) %>% 
  select(day, date, mean, daily)


## -------------------------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  summarize(n = n(),
            mean = mean(daily, na.rm = TRUE)) %>% 
  head


## ---- eval = FALSE--------------------------------------------------------
qplot


## ---- echo = FALSE--------------------------------------------------------
args(qplot)


## ---- warning =FALSE------------------------------------------------------
library(ggplot2)
circ %>% 
  mutate(date = lubridate::mdy(date)) %>% 
  qplot(x = date, y = daily, colour = day, data = .) + geom_line()

