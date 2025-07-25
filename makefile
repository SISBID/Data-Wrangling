all: index.html lectures labs

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

labs:
	Rscript admin/run_labs.R

lectures: 
	Rscript admin/run_lectures.R          

clean: 
	rm -f index.html
	Rscript admin/clean_lectures.R
	Rscript admin/clean_labs.R