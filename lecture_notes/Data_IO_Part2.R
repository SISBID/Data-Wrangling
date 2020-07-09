## ---- echo = FALSE, message=FALSE-------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
opts_chunk$set(comment = "")


## ----stop_problems----------------------------------------------------------------
dim(problems(ufo))
spec(ufo)


## ----stop_problems2, eval=FALSE---------------------------------------------------
## stop_for_problems(ufo)


## ---------------------------------------------------------------------------------
write_rds(ufo, path = "ufo_dataset.rds")


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

