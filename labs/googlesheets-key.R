gsurl2 = gs_url("https://docs.google.com/spreadsheets/d/1L-7BNn6a252Zw7f_jiUNJ5nOgnucyrlcHVFOnaqkP6s/edit?usp=sharing")
dat = gs_read(gsurl2)
dat = gs_read(gsurl2,range=cell_cols(1:3))
dim(dat)

## I cheated 
install.packages("janitor")
library(janitor)

dat %>% clean_names() %>%
  mutate(exp = years_of_r_experience > 2)
  

final_dat = dat %>% clean_names() %>%
  mutate(exp = years_of_r_experience > 2) %>%
  mutate(experience = ifelse(exp,"Skilled","Learning"))


