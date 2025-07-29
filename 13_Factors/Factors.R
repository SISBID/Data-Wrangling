## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ----factor1------------------------------------------------------------------
x <- c("yellow", "red", "red", "blue", "yellow", "blue")
class(x)

x_fact <- factor(x) # factor() is a function
class(x_fact)


## -----------------------------------------------------------------------------
x
x_fact


## -----------------------------------------------------------------------------
levels(x_fact)


## -----------------------------------------------------------------------------
dropouts <- read_delim("http://jhudatascience.org/intro_to_r/data/dropouts.txt", delim = "\t")
dropouts


## -----------------------------------------------------------------------------
dropouts <-
  dropouts %>%
  group_by(CDS_CODE) %>%
  summarize(
    Freshman = sum(D9),
    Sophomore = sum(D10),
    Junior = sum(D11),
    Senior = sum(D12)
  )
dropouts


## -----------------------------------------------------------------------------
dropouts <-
  dropouts %>%
  pivot_longer(
    !CDS_CODE,
    names_to = "grade",
    values_to = "n_dropouts"
  )
dropouts


## -----------------------------------------------------------------------------
head(dropouts)


## -----------------------------------------------------------------------------
set.seed(123) # same random sample each time
dropouts_subset <- slice_sample(dropouts, n = 32)
dropouts_subset


## ----fig.height= 3------------------------------------------------------------
dropouts_subset %>%
  ggplot(aes(x = grade, y = n_dropouts)) +
  geom_boxplot() +
  theme_bw(base_size = 16) # make all labels size 16


## -----------------------------------------------------------------------------
dropouts_fct <-
  dropouts_subset %>%
  mutate(grade = factor(grade,
    levels = c("Freshman", "Sophomore", "Junior", "Senior")
  ))

dropouts_fct %>%
  pull(grade) %>%
  levels()


## -----------------------------------------------------------------------------
head(dropouts_fct)


## ----fig.height= 3------------------------------------------------------------
dropouts_fct %>%
  ggplot(aes(x = grade, y = n_dropouts)) +
  geom_boxplot() +
  theme_bw(base_size = 16)


## -----------------------------------------------------------------------------
dropouts_subset %>%
  arrange(grade)


## -----------------------------------------------------------------------------
dropouts_fct %>%
  arrange(grade)


## -----------------------------------------------------------------------------
dropouts_subset %>%
  group_by(grade) %>%
  summarize(total_dropouts = sum(n_dropouts))


## -----------------------------------------------------------------------------
dropouts_fct %>%
  group_by(grade) %>%
  summarize(total_dropouts = sum(n_dropouts))


## ----fig.alt="Forcats hex sticker", out.width = "30%", echo = FALSE, fig.align='center'----
knitr::include_graphics("https://github.com/tidyverse/forcats/raw/main/man/figures/logo.png")


## ----fig.height= 3------------------------------------------------------------
library(forcats)

dropouts_fct %>%
  ggplot(aes(x = grade, y = n_dropouts)) +
  geom_boxplot() +
  theme_bw(base_size = 16)


## ----eval=FALSE---------------------------------------------------------------
## fct_reorder({column getting changed}, {guiding column}, {summarizing function})


## ----fig.height= 3------------------------------------------------------------
library(forcats)

dropouts_fct %>%
  ggplot(aes(x = fct_reorder(grade, n_dropouts, mean), y = n_dropouts)) +
  geom_boxplot() +
  labs(x = "Student Grade") +
  theme_bw(base_size = 16)


## ----fig.height= 3------------------------------------------------------------
library(forcats)

dropouts_fct %>%
  ggplot(aes(x = fct_reorder(grade, n_dropouts, mean, .desc = TRUE), y = n_dropouts)) +
  geom_boxplot() +
  labs(x = "Student Grade") +
  theme_bw(base_size = 16)


## -----------------------------------------------------------------------------
dropouts_fct %>%
  pull(grade) %>%
  fct_count(prop = TRUE)

