library(pagedown)
x = list.files(pattern = ".Rmd$",
               path = here::here("lecture_notes"), 
               full.names = TRUE,
               recursive = TRUE)
x = x[!grepl("Bioconductor_intro.Rmd", x)]
sapply(x, function(x) {
  out = sub(".Rmd$", ".R", x)
  knitr::purl(input = x, output = out)
})

sapply(x, function(r) {
  rmarkdown::render(r, envir = new.env())
  xx = sub("Rmd$", "html", r)
  pagedown::chrome_print(xx)
  r
})

# xx = sub("Rmd$", "html", x)
# sapply(xx, function(r) {
#   xaringan::decktape(r, output = sub("html$", "pdf", r), 
#                      docker = FALSE)
# })

# sapply(xx, pagedown::chrome_print)
