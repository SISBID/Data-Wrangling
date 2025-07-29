x <- list.files(
  pattern = ".Rmd$",
  path = here::here(),
  full.names = TRUE,
  recursive = TRUE
)

# Keep only lab files
x <- x[!grepl("index|archive|admin", x)]
x <- x[grepl("lab", x)]
x <- x[grepl("key", x)] # Only render keys

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
