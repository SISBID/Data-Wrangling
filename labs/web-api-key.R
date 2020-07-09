## ---------------------------------------------------------------------------------
library(rvest)
htmlfile = html("./bioc-software.html")
nds = html_nodes(htmlfile,xpath='//*[@id="biocViews_package_table"]')
dat = html_table(nds)
dat = as.data.frame(dat)
head(dat)


## ---------------------------------------------------------------------------------
library(wordcloud)
txt = paste(dat[,3],collapse=" ")
wordcloud(txt,max.words=50)


## ---------------------------------------------------------------------------------
library(jsonlite)
p53_dat = fromJSON("http://rest.ensembl.org//lookup/id/ENSG00000141510?content-type=application/json;expand=1")


## ---------------------------------------------------------------------------------
braf_info = fromJSON("http://rest.ensembl.org//lookup/symbol/homo_sapiens/BRAF?content-type=application/json;expand=1")
braf_info$id

