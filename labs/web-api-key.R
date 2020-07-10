## -----------------------------------------------------------------------------
library(rvest)
# htmlfile = read_html("../data/R-wiki.html")
# nds = html_nodes(htmlfile, xpath='//*[@class="wikitable"]')
htmlfile = read_html("../data/bioc-software.html")
nds = html_nodes(htmlfile, xpath='.//*[@class="dataTable"]')
dat = html_table(nds)
dat = as.data.frame(dat[[2]])
head(dat)


## -----------------------------------------------------------------------------
library(wordcloud)
txt = paste(dat[,3],collapse=" ")
wordcloud(txt,max.words=50)


## ---- error = TRUE------------------------------------------------------------
library(jsonlite)
p53_dat = fromJSON("http://rest.ensembl.org/lookup/id/ENSG00000157764?expand=1;content-type=application/json")


## ---- error = TRUE------------------------------------------------------------
braf_info = fromJSON("http://rest.ensembl.org//lookup/symbol/homo_sapiens/BRAF?content-type=application/json;expand=1")
braf_info$id

