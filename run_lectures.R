x = list.files(pattern = ".Rmd$",
               path = here::here("lecture_notes"), 
               full.names = TRUE,
               recursive = TRUE)

sapply(x, function(x) {
  out = sub(".Rmd$", ".R", x)
  knitr::purl(input = x, output = out)
})

sapply(x, rmarkdown::render, envir = new.env())

