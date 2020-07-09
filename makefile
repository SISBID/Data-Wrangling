all: labs index.html lecture_notes

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

lab_files := $(wildcard labs/*.Rmd)

labs: $(lab_files) run_labs.R
	Rscript run_labs.R

ln_files := $(wildcard lecture_notes/*.Rmd)

lecture_notes: lecture_notes/*.Rmd run_lectures.R
	Rscript run_lectures.R		

clean: 
	rm -f index.html labs/*.html lecture_notes/*.html
