x = list.files(pattern = ".Rmd$",
               path = here::here("labs"), 
               full.names = TRUE,
               recursive = TRUE)
x = x[!grepl("rmarkdown", x)]
x = x[grepl("key", x)]


sapply(x, function(x) {
  out = sub(".Rmd$", ".R", x)
  knitr::purl(input = x, output = out)
  })

sapply(x, rmarkdown::render, envir = new.env())


