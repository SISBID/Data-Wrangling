get_slide_id = function (x) 
{
  x = sub(".*presentation/", "", x)
  x = sub("/d/e", "/d", x)
  x = sub("^(d|e)/", "", x)
  x = strsplit(x, "/")[[1]]
  x = x[!grepl("^(edit|pub|export|png)", x)]
  x = x[nchar(x) > 5]
  x
}
type_url = function (id, page_id = NULL, type = "png") 
{
  url = paste0("https://docs.google.com/presentation/d/", id, 
               "/export/", type, "?id=", id)
  if (!is.null(page_id)) {
    url = paste0(url, "&pageid=", page_id)
  }
  url
}
download_gs_file = function(id, out_type = "pptx",
                            stub = NULL) {
  id = as.character(id)
  id = get_slide_id(id)
  url = type_url(id = id, page_id = NULL, type = out_type)
  
  tfile = tempfile(fileext = paste0(".", out_type))
  if (!is.null(stub)) {
    tfile = paste0(stub, paste0(".", out_type))
  }
  result = httr::GET(url, 
                     httr::write_disk(tfile, overwrite = TRUE),
                     httr::progress())
  warn_them = FALSE
  fr_header = result$headers$`x-frame-options`
  if (is.null(fr_header)) {
    if (all(fr_header == "DENY")) {
      warn_them = TRUE
    }
  }
  if (httr::status_code(result) >= 300) {
    warn_them = TRUE
  }
  if (grepl("ServiceLogin", result$url)) {
    warn_them = TRUE
  }
  if (result$times["redirect"] > 0) {
    warn_them = TRUE
  }
  if (warn_them) {
    warning(
      paste0(
        "This presentation may not be available, ",
        "did you turn link sharing on?")
    )
  }
  tfile
}


url = paste0("https://docs.google.com/presentation/d/", 
             "1OAUbr-41EgwlSq0ZB-Edj_e0ix5I13pM3C_dfQ-W-Gw")

res = sapply(c("pdf", "pptx"), download_gs_file,
  id = url, stub = "lecture_notes/sisbid_rep_research_2020")
