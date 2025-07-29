library(pagedown)

x <- list.files(
  pattern = ".Rmd$",
  path = here::here(),
  full.names = TRUE,
  recursive = TRUE
)

# Keep only lecture files
x <- x[!grepl("lab|index|archive|admin", x)]

# Remove .R files
cli::cli_alert(cli::col_magenta("Removing .R files..."))
invisible(sapply(x, function(x) {
  x_r <- sub(".Rmd$", ".R", x)
  if (file.exists(x_r)) {
    file.remove(x_r)
  }
}))
cli::cli_alert(cli::col_magenta(".R files removed!"))

# Remove .html files
cli::cli_alert(cli::col_magenta("Removing HTMLs..."))
invisible(sapply(x, function(x) {
  x_html <- sub(".Rmd$", ".html", x)
  if (file.exists(x_html)) {
    file.remove(x_html)
  }
}))
cli::cli_alert(cli::col_magenta("HTMLs removed!"))

# Remove .pdf files
cli::cli_alert(cli::col_magenta("Removing PDFs..."))
invisible(sapply(x, function(x) {
  x_pdf <- sub(".Rmd$", ".pdf", x)
  if (file.exists(x_pdf)) {
    file.remove(x_pdf)
  }
}))
cli::cli_alert(cli::col_magenta("PDFs removed!"))