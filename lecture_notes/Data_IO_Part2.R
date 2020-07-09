## ---- include = FALSE-------------------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")
ufo = read_csv("../data/ufo/ufo_data_complete.csv")


## ----stop_problems----------------------------------------------------------------
dim(problems(ufo))
spec(ufo)


## ----stop_problems2, eval=FALSE---------------------------------------------------
## stop_for_problems(ufo)


## ---------------------------------------------------------------------------------
write_rds(ufo, path = "ufo_dataset.rds", compress = "xz")


## ---------------------------------------------------------------------------------
ufo3 = read_rds(path = "ufo_dataset.rds")
identical(ufo, ufo3) # test if they are the same 


## ---- message = FALSE-------------------------------------------------------------
x = 5
save(ufo, x, file = "ufo_data.RData")


## ---- dims------------------------------------------------------------------------
dim(ufo)
nrow(ufo)
ncol(ufo)


## ---- colnames--------------------------------------------------------------------
colnames(ufo)


## ---------------------------------------------------------------------------------
args(readr::write_delim)


## ----writecsv---------------------------------------------------------------------
write_csv(ufo[1:100,], path="ufo_first100.csv")


## ---- include = FALSE-------------------------------------------------------------
file.remove("ufo_dataset.rds")
file.remove("ufo_data.RData")
file.remove("ufo_data.rda")
file.remove("ufo_first100.csv")

