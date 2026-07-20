library(pagedown)
library(rmarkdown)

make_R_files <- FALSE # Should .R equivalents of .Rmd files be made?

x <- list.files(
  pattern = ".Rmd$",
  path = here::here(),
  full.names = TRUE,
  recursive = TRUE
)

# Keep only lecture files
x <- x[!grepl("lab|index|archive|admin", x)]

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
    render(
      x,
      ioslides_presentation(
        css = "../styles/styles.css",
        widescreen = TRUE,
        includes = includes(in_header = "../styles/header.html")
      ),
      envir = new.env()
    )
  }
}))
cli::cli_alert(cli::col_cyan("HTMLs complete!"))

# Make .pdf file if .html file has been changed
cli::cli_alert(cli::col_cyan("Making PDFs..."))
invisible(sapply(x, function(x) {
  x_html <- sub(".Rmd$", ".html", x)
  x_pdf <- sub(".Rmd$", ".pdf", x)
  if (!file.exists(x_pdf) ||
      file.info(x_pdf)$mtime <
      file.info(x_html)$mtime) {
    message(paste0("Creating ", getwd(), x_pdf))
    pagedown::chrome_print(x_html)
  }
}))
cli::cli_alert(cli::col_cyan("PDFs complete!"))
