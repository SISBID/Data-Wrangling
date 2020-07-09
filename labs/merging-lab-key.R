## ----warning=FALSE,eval=FALSE-----------------------------------------------------
## library(downloader)
## download("ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/20130606_sample_info.xlsx",destfile="1000genomes.xlsx")


## ----warning=FALSE----------------------------------------------------------------
library(readxl)
library(janitor)
# Have to skip one row because there is an extra header
kg_s4 = read_excel("1000genomes.xlsx",sheet=4,skip=1)
# subset to just low coverage
kg_s4 = kg_s4 %>% select(1:7)
kg_s4 = kg_s4 %>% clean_names()
dim(kg_s4)

kg_s1 = read_excel("1000genomes.xlsx",sheet=1)
dim(kg_s1)
kg_s1 = kg_s1 %>% clean_names()



## ---------------------------------------------------------------------------------
library(dplyr)
## inner join
ij = inner_join(kg_s4,kg_s1)

## semi join
sj = semi_join(kg_s4,kg_s1)

## left join
lj = left_join(kg_s4,kg_s1)

## How I actually write this

lj = kg_s4 %>%
  left_join(kg_s1)

## outer/full join
oj = merge(kg_s4,kg_s1,all=TRUE)


## ---------------------------------------------------------------------------------
dim(ij)
dim(sj)
dim(lj)
dim(oj)


## ---------------------------------------------------------------------------------
## Check if names are the same
sum(names(lj) %in% names(oj))



## ---------------------------------------------------------------------------------

lj = kg_s4 %>%
  left_join(kg_s1)

lj2 = kg_s1 %>%
  left_join(kg_s4)

