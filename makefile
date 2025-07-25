all: index.html lectures labs

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

labs: labs/*.html
labs/*.html: labs/*.Rmd run_labs.R 
	Rscript run_labs.R

lectures: 
	Rscript admin/run_lectures.R          

clean: 
	rm -f index.html
	Rscript admin/clean_lectures.R
