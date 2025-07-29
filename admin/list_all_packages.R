### find and install all packages
rm(list = ls())

ss = function(x,pattern,slot=1,...) {
  sapply(strsplit(x = x, split = pattern, ...), "[", slot)
}

## find RMDs
files <- dir(pattern = '[.]R', recursive = TRUE)
files = files[ !grepl("scratch", files)]
files = files[ !grepl("all_packages", files)]
# files = files[ files != "index.Rmd" ]
# files = files[ !grepl("HW", files)]
files = files[ basename(files) != "illusion.Rmd" ]

## read in code
fileList = lapply(files, scan, what = "character()", sep="\n")
allFiles = unlist(fileList)
allFiles = trimws(allFiles)
libCalls = allFiles[grep("^(library|require)", allFiles)]
theLibs = ss(ss(libCalls, "(", 2, fixed = TRUE), ")", fixed=TRUE)
theLibs = ss(theLibs, ",", 1, fixed = TRUE)
theLibs = ss(theLibs, '"', 1, fixed = TRUE)
theLibs = ss(theLibs, " ", 1, fixed = TRUE)
theLibs = unique(theLibs)
theLibs = sort(theLibs)

writeLines(theLibs, con = "all_the_packages.txt")


