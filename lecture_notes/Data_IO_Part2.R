## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(tidyverse)
library(visdat)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ---- dims--------------------------------------------------------------------
nrow(ufo)
ncol(ufo)
dim(ufo)


## ---- colnames----------------------------------------------------------------
colnames(ufo)


## ----stop_problems------------------------------------------------------------
head(problems(ufo))


## -----------------------------------------------------------------------------
dim(problems(ufo))


## ----spec---------------------------------------------------------------------
# Use cols_condense(spec(ufo)) for a summary
spec(ufo)


## ----col_types----------------------------------------------------------------
ufo_char = read_csv("../data/ufo/ufo_data_complete.csv", col_types = cols(
  .default = col_character()
))
dim(problems(ufo_char))


## ----stop_problems2, eval=FALSE-----------------------------------------------
## stop_for_problems(ufo)


## ----vis_dat------------------------------------------------------------------
library(visdat)
ufo_samp = ufo %>% sample_n(size = 1000) # Subset for big data
vis_dat(ufo_samp)


## ----vis_miss-----------------------------------------------------------------
vis_miss(ufo_samp)


## -----------------------------------------------------------------------------
library(naniar)
gg_miss_var(ufo)


## -----------------------------------------------------------------------------
miss_case_summary(ufo)


## -----------------------------------------------------------------------------
miss_var_summary(ufo)


## -----------------------------------------------------------------------------
write_rds(ufo, file = "ufo_dataset.rds", compress = "xz")


## -----------------------------------------------------------------------------
ufo3 = read_rds(file = "ufo_dataset.rds")
identical(ufo, ufo3) # test if they are the same 


## ---- message = FALSE---------------------------------------------------------
x = 5
save(ufo, x, file = "ufo_data.rda")


## ---- echo = FALSE, out.width="100%"------------------------------------------
knitr::include_graphics("media/IO_save.png")


## ---- eval = FALSE------------------------------------------------------------
## load(file = "ufo_data.rda")


## -----------------------------------------------------------------------------
args(readr::write_delim)


## ----writecsv-----------------------------------------------------------------
write_delim(ufo[1:100,], file = "ufo_first100.csv", delim = ",")
# same as write_csv(ufo[1:100,], file = "ufo_first100.csv")


## ---- include = FALSE---------------------------------------------------------
file.remove("ufo_dataset.rds")
file.remove("ufo_data.RData")
file.remove("ufo_data.rda")
file.remove("ufo_first100.csv")

