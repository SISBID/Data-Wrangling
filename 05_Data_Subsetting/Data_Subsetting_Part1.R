## ----include = FALSE----------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)
library(ggplot2)
library(here)


## .watch-out {
##   #background-color: lightpink;
##   border: 3px solid red;
##   font-weight: bold;
## }
## # from: https://bookdown.org/yihui/rmarkdown-cookbook/chunk-styling.html
## 
## #Then just use class.source="watch-out" in the chunk parameters

## ----eval = FALSE-------------------------------------------------------------
# readr::read_csv()
# readr::read_delim()
# readxl::read_excel()


## ----message = FALSE----------------------------------------------------------
library(tidyverse)
ufo <- read_csv(
  "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv")


## -----------------------------------------------------------------------------
head(pull(ufo,country))


## -----------------------------------------------------------------------------
ufo |> pull(country) |> head()


## -----------------------------------------------------------------------------
head(pull(ufo, country))
head(ufo$country)


## -----------------------------------------------------------------------------
select(ufo, country)


## -----------------------------------------------------------------------------
select(ufo, country, shape)


## ----echo = FALSE, fig.align = 'center', out.width="70%"----------------------
knitr::include_graphics("https://github.com/SISBID/Data-Wrangling/blob/gh-pages/images/tidyselect.png?raw=true")


## ----eval = FALSE-------------------------------------------------------------
# last_col()
# ends_with()
# starts_with()
# contains() # search for a pattern
# everything()


## -----------------------------------------------------------------------------
ufo |> select(starts_with("c"))


## -----------------------------------------------------------------------------
ufo |> select(ends_with("e"))


## -----------------------------------------------------------------------------
filter(ufo, `duration (seconds)` > 6000)


## -----------------------------------------------------------------------------
ufo |> filter(`duration (seconds)` > 6000)


## -----------------------------------------------------------------------------
ufo |> filter(country == "us")


## -----------------------------------------------------------------------------
ufo |> filter(`duration (seconds)` > 6000 & country == "us")


## -----------------------------------------------------------------------------
ufo |> filter(country %in% c("us", "gb"))


## -----------------------------------------------------------------------------
ufo |> filter(country %in% c("us", "gb") &
                    `duration (seconds)` > 6000)


## -----------------------------------------------------------------------------
ufo |> filter(`duration (seconds)` > 60000) |> head(2) #This works
ufo |> filter(`duration (seconds)` > "60000") |> head(2) # not right!



## -----------------------------------------------------------------------------
ufo |> filter("country" == "gb") # didn't work!
ufo |> filter(country == "gb")


## ----fig.alt="dplyr", out.width = "12%", echo = FALSE, fig.align='center'-----
knitr::include_graphics("https://github.com/SISBID/Data-Wrangling/blob/gh-pages/images/backtick_1.png?raw=true")


## ----error = TRUE-------------------------------------------------------------
try({
ufo |> filter(duration (seconds) > 6000) # didn't work!
ufo |> filter(`duration (seconds)` > 6000) # worked!

})


## -----------------------------------------------------------------------------
ufo |> filter(country == "gb") |> dim()
ufo |> filter(country == "gb" | `duration (seconds)` > 6000) |> dim()
ufo |> filter(country == "gb" | `duration (seconds)` > 6000)


## -----------------------------------------------------------------------------
ufo |> filter(country =="us" | country == "gb") |> dim()
ufo |> filter(country %in% c("us", "gb")) |> dim()


## -----------------------------------------------------------------------------
ufo|> 
  filter(country == "gb") |> 
  select(starts_with("c"))


## ----error=TRUE---------------------------------------------------------------
try({
ufo|> 
  select(starts_with("c")) |> 
  filter(shape == "light")
 
})


## -----------------------------------------------------------------------------
head(ufo, 2)
ufo |> select(`duration (seconds)`, starts_with("c"))


## -----------------------------------------------------------------------------
ufo |> select(starts_with("c"), ends_with("e"))



## -----------------------------------------------------------------------------
ufo |> select(starts_with(c("c", "s")))


## ----echo = FALSE, fig.align='center'-----------------------------------------
url = "https://media.giphy.com/media/5b5OU7aUekfdSAER5I/giphy.gif"
knitr::include_graphics(url)

