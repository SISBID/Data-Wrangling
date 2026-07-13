## ----include=FALSE------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(comment = "")
library(tidyverse)


## -----------------------------------------------------------------------------
library(tidyverse)
ufo <- read_csv(
  "https://sisbid.github.io/Data-Wrangling/data/ufo/ufo_data_complete.csv")


## ----eval = FALSE-------------------------------------------------------------
# # general format! not code!
# {data you are creating or changing} <- {data you are using} |>
#                                     rename({New Name} = {Old name})
# 


## -----------------------------------------------------------------------------
ufo_2<- ufo |>
  rename(duration_seconds = `duration (seconds)`)
head(ufo_2, n = 3)


## -----------------------------------------------------------------------------
ufo_2<- ufo |>
        rename(duration_seconds = `duration (seconds)`,
                duration_h_m = `duration (hours/min)`)
glimpse(ufo_2)


## ----fig.align='center', echo = FALSE-----------------------------------------
include_graphics("https://media.giphy.com/media/6q29hxDKvJvPy/giphy.gif")


## -----------------------------------------------------------------------------
ufo_upper <- ufo |> rename_with(toupper)
head(ufo_upper, 2)


## -----------------------------------------------------------------------------
ufo_upper |> rename_with(tolower) |> head(n = 2)


## ----message=FALSE------------------------------------------------------------
#install.packages("janitor")
library(janitor)
ufo <- clean_names(ufo)
head(ufo)


## -----------------------------------------------------------------------------
head(ufo, 2)
ufo |> select(where(is.numeric)) |> head(n = 2)



## ----eval = FALSE-------------------------------------------------------------
# # General format - Not the code!
# {data object to update} <- {data to use} |>
#                     mutate({new variable name} = {new variable source})


## -----------------------------------------------------------------------------
ufo |> 
  mutate(state_upper = toupper(state)) |> glimpse()



## ----eval = FALSE-------------------------------------------------------------
# # General format - Not the code!
# {data object to update} <- {data to use} |>
#             mutate({variable name to change} = {variable modification})


## -----------------------------------------------------------------------------
ufo |> 
  mutate(state = toupper(state)) |> glimpse()



## ----eval = FALSE-------------------------------------------------------------
# ufo <- ufo |>
#   mutate(state = toupper(state))


## -----------------------------------------------------------------------------
select(ufo, - datetime) |> glimpse()


## -----------------------------------------------------------------------------
select(ufo, -(starts_with("c"))) |> glimpse()


## -----------------------------------------------------------------------------
head(ufo, n = 2)
ufo |> select(country, shape, datetime) |> head(n = 2)


## -----------------------------------------------------------------------------
head(ufo, n = 2)
ufo |> relocate(datetime, .after = shape) |> head(n = 2)


## -----------------------------------------------------------------------------
head(ufo, n = 2)
ufo |> relocate(shape, .before = city) |> head(n = 2)



## -----------------------------------------------------------------------------
ufo |> arrange(duration_seconds)


## -----------------------------------------------------------------------------
ufo |> arrange(desc(duration_seconds))


## -----------------------------------------------------------------------------
arrange(ufo, desc(duration_seconds), shape)


## -----------------------------------------------------------------------------
arrange(ufo, shape, desc(duration_seconds))

