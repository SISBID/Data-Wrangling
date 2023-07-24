## ---- include = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
library(readr)
# suppressPackageStartupMessages(library(dplyr))
knitr::opts_chunk$set(comment = "")


## ----code------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
head(mtcars)


## ----assign----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
x <- 2
x
x * 4
x + 2


## ---- eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------
## ?dir
## help("dir")


## ---- echo = FALSE, out.width="70%"----------------------------------------------------------------------------------------------------------------------------------------------------
knitr::include_graphics("media/IO_help.png")


## ---- eval = FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------
## install.packages("tidyverse")
## library(tidyverse)


## ---- echo = FALSE, out.width="70%"----------------------------------------------------------------------------------------------------------------------------------------------------
knitr::include_graphics("media/install_packages.jpg")


## ---- out.width="80%", echo=FALSE, fig.alt='.'-----------------------------------------------------------------------------------------------------------------------------------------
ottrpal::include_slide("https://docs.google.com/presentation/d/104LQkFTsC5R9vAC4HHj4mK7IjCTH55X6BkrAb3aDd6E/edit#slide=id.g13ea04b780d_1_115")


## ---- echo = FALSE, out.width="70%"----------------------------------------------------------------------------------------------------------------------------------------------------
knitr::include_graphics("media/IO_comments_to_self.png")


## ---- fig.alt="The New R Project button is highlighted.", out.width = "40%", echo = FALSE, align = "center"----------------------------------------------------------------------------
knitr::include_graphics("media/Data_Input_Rproject.png")


## ---- fig.alt="In the New Project Wizard, the 'New Directory' option is highlighted.", out.width = "60%", echo = FALSE, align = "center"-----------------------------------------------
knitr::include_graphics("media/Data_Input_new_directory.png")


## ---- fig.alt="In the New Project Wizard, the 'New Project' option is highlighted.", out.width = "60%", echo = FALSE, align = "center"-------------------------------------------------
knitr::include_graphics("media/Data_Input_new_project.png")


## ---- fig.alt="In the New Project Wizard, the new project has been given a name and is going to be stored in the Desktop directory. The 'Create Project' button is highlighted.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("media/Data_Input_new_project_details.png")


## ---- fig.alt="The image shows an image of an arrow pointing to the newly created R project repository.", out.width = "60%", echo = FALSE, align = "center"----------------------------
knitr::include_graphics("media/Data_Input_new_desktop.png")


## ---- fig.alt="Gif showing the process of importing a dataset via readr.", out.width = "100%", echo = FALSE, align = "center"----------------------------------------------------------
knitr::include_graphics("media/Data_Input_import_dataset.gif")


## ---- fig.alt="The image shows an image of an arrow pointing to the newly created R project repository.", out.width = "80%", echo = FALSE, align = "center"----------------------------
knitr::include_graphics("media/Data_Input_browse.png")


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(readxl)

