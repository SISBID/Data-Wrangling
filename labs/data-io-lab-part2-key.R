## ----message = FALSE----------------------------------------------------------
library(tidyverse)
library(readxl)


## -----------------------------------------------------------------------------
circ <- read_csv("https://sisbid.github.io/Data-Wrangling/data/Charm_City_Circulator_Ridership.csv")


## -----------------------------------------------------------------------------
str(circ)
head(circ)
glimpse(circ)
nrow(circ)


## -----------------------------------------------------------------------------
write_csv(circ, "Circulator.csv")


## -----------------------------------------------------------------------------
curl::curl_download("https://sisbid.github.io/Data-Wrangling/data/iris/iris_q6.xlsx", "iris_q6.xlsx")


## -----------------------------------------------------------------------------
iris_q4 <- read_excel("iris_q6.xlsx", sheet= 1)
dim(iris_q4)


## -----------------------------------------------------------------------------
iris_q5 <- read_excel("iris_q6.xlsx", sheet= 2)
dim(iris_q5)

