all: index.html lecture_notes labs

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

labs: labs/*.html
labs/*.html: labs/*.Rmd run_labs.R 
	Rscript run_labs.R

lecture_notes: lecture_notes/*.html

lecture_notes/*.html: lecture_notes/*.Rmd run_lectures.R
	Rscript run_lectures.R          

clean: 
	rm -f index.html labs/*.html lecture_notes/*.html
