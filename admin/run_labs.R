x <- list.files(
  pattern = ".Rmd$",
  path = here::here(),
  full.names = TRUE,
  recursive = TRUE
)

make_R_files <- FALSE # Should .R equivalents of .Rmd files be made?

# Keep only lab files
x <- x[!grepl("index|archive|admin", x)]
x <- x[grepl("lab", x)]
x <- x[grepl("key", x)] # Only render keys

# Make .R file if .Rmd file has been changed
if (make_R_files) {
  cli::cli_alert(cli::col_cyan("Making .R files..."))
  invisible(sapply(x, function(x) {
    x_r <- sub(".Rmd$", ".R", x)
    if (!file.exists(x_r) ||
        file.info(x_r)$mtime <
        file.info(x)$mtime) {
      knitr::purl(input = x, output = x_r)
    }
  }))
  cli::cli_alert(cli::col_cyan(".R files made!"))
}

# Make .html file if .Rmd file has been changed
cli::cli_alert(cli::col_cyan("Making HTMLs..."))
invisible(sapply(x, function(x) {
  x_html <- sub(".Rmd$", ".html", x)
  if (!file.exists(x_html) ||
      file.info(x_html)$mtime <
      file.info(x)$mtime) {
    rmarkdown::render(x, envir = new.env())
  }
}))
cli::cli_alert(cli::col_cyan("HTMLs complete!"))