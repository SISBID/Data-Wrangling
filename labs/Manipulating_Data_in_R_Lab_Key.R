## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------------------------------------------------------
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)


## ---------------------------------------------------------------------------------
wide = read_csv("https://sisbid.github.io/Module1/labs/Bike_Lanes_Wide.csv")


## ---------------------------------------------------------------------------------
long = wide %>% 
  gather(key = "lanetype", value = "the_length", -name)
head(long)


## ---------------------------------------------------------------------------------
crash = read_csv("https://sisbid.github.io/Module1/labs//crashes.csv")
road = read_csv("https://sisbid.github.io/Module1/labs//roads.csv")
head(crash)
head(road)


## ---------------------------------------------------------------------------------
crash2 = crash %>% mutate(Road = str_replace(Road, "-", " "))
table(crash2$Road)


## ---------------------------------------------------------------------------------
dim(crash)
dim(road)


## ---------------------------------------------------------------------------------
crash2 = separate(crash2, col = "Road", into = c("type", "number"))
table( crash2$type)


## ---------------------------------------------------------------------------------
crash2 = unite(crash2, col = "road_hyphen", type, number ,sep = "-")
table( crash2$road_hyphen)


## ---------------------------------------------------------------------------------
unique(crash$Year)
length(unique(crash$Year))


## ---------------------------------------------------------------------------------
bike = read_csv("https://sisbid.github.io/Module1/labs/Bike_Lanes.csv")


## ---------------------------------------------------------------------------------
bike = filter(bike, !is.na(type) & !is.na(name))


## ---------------------------------------------------------------------------------
sub = bike %>% 
  group_by(name, type) %>% 
  summarize(length = sum(length))


## ---------------------------------------------------------------------------------
wide = spread(sub, key = type, value = length)


## ---------------------------------------------------------------------------------
merged = inner_join(crash, road)
merged = inner_join(crash, road, by = "Road")
dim(merged)


## ---------------------------------------------------------------------------------
full = full_join(crash, road)
nrow(full)


## ---------------------------------------------------------------------------------
left = left_join(road, crash)
nrow(left)


## ---------------------------------------------------------------------------------
right = right_join(road, crash)
nrow(right)

