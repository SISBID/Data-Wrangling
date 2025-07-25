x = list.files(pattern = ".Rmd$",
               path = here::here("labs"), 
               full.names = TRUE,
               recursive = TRUE)
x = x[!grepl("rmarkdown|googlesheets", x)]
x = x[grepl("key", x)]


sapply(x, function(xx) {
  out = sub(".Rmd$", ".R", xx)
  out_html = sub(".Rmd$", ".html", xx)
  
  knitr::purl(input = xx, output = out)
  if (!file.exists(out_html) ||
      file.info(out_html)$mtime < 
      file.info(xx)$mtime) {
    rmarkdown::render(xx, envir = new.env())
  }
})

if (file.exists("labs/my_flights_db.sqlite3")) {
  file.remove("labs/my_flights_db.sqlite3")
}
