## ---- include = FALSE-----------------------------------------------------
library(knitr)
library(tidyverse)
library(visdat)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ---- dims----------------------------------------------------------------
dim(ufo)
nrow(ufo)
ncol(ufo)


## ---- colnames------------------------------------------------------------
colnames(ufo)


## ----stop_problems--------------------------------------------------------
problems(ufo)
dim(problems(ufo))


## ----spec-----------------------------------------------------------------
spec(ufo)
cols_condense(spec(ufo))


## ----col_types------------------------------------------------------------
ufo_char = read_csv("../data/ufo/ufo_data_complete.csv", col_types = cols(
  .default = col_character(),
  longitude = col_double()
))
dim(problems(ufo))
dim(problems(ufo_char))


## ----stop_problems2, eval=FALSE-------------------------------------------
stop_for_problems(ufo)


## ----vis_dat--------------------------------------------------------------
library(visdat) # only so many rows can be visualized are good
ufo_samp = ufo %>% sample_n(size = 1000)
vis_dat(ufo_samp)


## ----vis_miss-------------------------------------------------------------
vis_miss(ufo_samp)


## -------------------------------------------------------------------------
library(naniar)
gg_miss_var(ufo)


## -------------------------------------------------------------------------
miss_case_summary(ufo)


## -------------------------------------------------------------------------
miss_var_summary(ufo)


## -------------------------------------------------------------------------
write_rds(ufo, path = "ufo_dataset.rds", compress = "xz")


## -------------------------------------------------------------------------
ufo3 = read_rds(path = "ufo_dataset.rds")
identical(ufo, ufo3) # test if they are the same 


## ---- message = FALSE-----------------------------------------------------
x = 5
save(ufo, x, file = "ufo_data.rda")


## -------------------------------------------------------------------------
args(readr::write_delim)


## ----writecsv-------------------------------------------------------------
write_csv(ufo[1:100,], path = "ufo_first100.csv")


## ---- include = FALSE-----------------------------------------------------
file.remove("ufo_dataset.rds")
file.remove("ufo_data.RData")
file.remove("ufo_data.rda")
file.remove("ufo_first100.csv")

