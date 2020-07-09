LIST  = Statistics
LIST += Data_Visualization
LIST += Knitr
LIST += Data_Summarization
LIST += RStudio
LIST += Manipulating_Data_in_R
LIST += Data_Cleaning
LIST += Data_IO
LIST += Data_Classes
LIST += Simple_Knitr
LIST += Basic_R
# LIST += Functions
LIST += Knitr
LIST += Arrays_Split
LIST += Subsetting_Data_in_R
LIST += Intro
LIST += Data_Classes_summary

all: labs index.html lecture_notes

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

lab_files := $(wildcard labs/*.Rmd)

labs: $(lab_files) run_labs.R
	Rscript run_labs.R

ln_files := $(wildcard lecture_notes/*.Rmd)

lecture_notes: $(ln_files) run_lectures.R
	Rscript run_lectures.R		

clean: 
	rm index.html labs/*.html
