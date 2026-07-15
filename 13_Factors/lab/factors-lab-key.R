## ----message=FALSE------------------------------------------------------------
library(tidyverse)


## ----1.0response--------------------------------------------------------------
yts <- read_csv("http://jhudatascience.org/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")
yts <- yts %>% select(Sample_Size, Education, LocationAbbr)


## ----1.1response--------------------------------------------------------------
yts %>%
  ggplot(aes(x = Education, y = Sample_Size)) +
  geom_boxplot()


## ----1.2response--------------------------------------------------------------
yts %>%
  count(Education)


## ----1.3response--------------------------------------------------------------
yts_fct <-
  yts %>% mutate(Education = factor(Education,
    levels = c("Middle School", "High School")
  ))


## ----1.4response--------------------------------------------------------------
yts_fct %>%
  ggplot(aes(x = Education, y = Sample_Size)) +
  geom_boxplot()

yts_fct %>%
  count(Education)


## ----P.1response--------------------------------------------------------------
yts_fct <- yts_fct %>% mutate(LocationAbbr = factor(LocationAbbr))


## ----P.2response--------------------------------------------------------------
yts_fct <- yts_fct %>%
  group_by(LocationAbbr) %>%
  mutate(med_sample_size = median(Sample_Size, na.rm = TRUE))


## ----P.3response--------------------------------------------------------------
library(forcats)

yts_fct_plot <- yts_fct %>%
  drop_na() %>%
  ggplot(aes(
    x = fct_reorder(
      LocationAbbr, med_sample_size
    ),
    y = Sample_Size
  )) +
  geom_boxplot() +
  labs(x = "State")

ggsave(
  filename = "yts_fct.png", # will save in working directory
  plot = yts_fct_plot,
  width = 10, height = 3
)

