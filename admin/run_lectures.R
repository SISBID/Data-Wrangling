library(pagedown)
x = list.files(pattern = ".Rmd$",
               path = here::here("lecture_notes"), 
               full.names = TRUE,
               recursive = TRUE)
# x = x[!grepl("Advanced|Bioconductor_intro.Rmd", x)]
sapply(x, function(x) {
  out = sub(".Rmd$", ".R", x)
  knitr::purl(input = x, output = out)
})

sapply(x, function(xx) {
  out_html = sub("Rmd$", "html", xx)
  if (!file.exists(out_html) ||
      file.info(out_html)$mtime < 
      file.info(xx)$mtime) {
    rmarkdown::render(xx, envir = new.env())
  }
  out_pdf = sub("Rmd$", "pdf", xx)
  
  if (!file.exists(out_pdf) ||
      file.info(out_pdf)$mtime < 
      file.info(xx)$mtime ||
      file.info(out_pdf)$mtime < 
      file.info(out_html)$mtime) {
    pagedown::chrome_print(out_html)
  }
  xx
})

# xx = sub("Rmd$", "html", x)
# sapply(xx, function(r) {
#   xaringan::decktape(r, output = sub("html$", "pdf", r), 
#                      docker = FALSE)
# })

# sapply(xx, pagedown::chrome_print)
