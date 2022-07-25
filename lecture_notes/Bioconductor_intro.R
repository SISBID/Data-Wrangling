## ----include=FALSE-----------------------------------------------------------------------------------------------------------------
library(stringr)
library(tibble)
library(SummarizedExperiment)
library(dplyr)
library(biomaRt)


## ---- eval=FALSE-------------------------------------------------------------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## install.packages("BiocManager")
## # Install all core packages and update all installed packages
## BiocManager::install()


## ---- eval=FALSE-------------------------------------------------------------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## BiocManager::install(c("GEOquery", "limma", "biomaRt", "SummarizedExperiment"))


## ----------------------------------------------------------------------------------------------------------------------------------
library(GEOquery)
# https://pubmed.ncbi.nlm.nih.gov/32619517/
geo_data = getGEO("GSE146760")[[1]] # find accession in paper


## ----------------------------------------------------------------------------------------------------------------------------------
tibble(Biobase::pData(geo_data))


## ----------------------------------------------------------------------------------------------------------------------------------
Biobase::exprs(geo_data) # gene expression
Biobase::fData(geo_data) # gene/feature/row annotation


## ----------------------------------------------------------------------------------------------------------------------------------
getGEOSuppFiles("GSE146760")
counts  = read.delim("GSE146760/GSE146760_RNASeq_analysis_CountsTable.txt.gz")
pheno = read.delim("GSE146760/GSE146760_RNASample_Info_v2.txt.gz")


## ----------------------------------------------------------------------------------------------------------------------------------
#colnames(counts) = sapply(str_split(colnames(counts), "Aligned"), "[[", 1)
colnames(counts) = str_remove(string = colnames(counts), pattern = "Aligned.sortedByCoord.out.bam")
identical(colnames(counts), pheno$Prefix)


## ----------------------------------------------------------------------------------------------------------------------------------
rownames(pheno) = pheno$Status
colnames(counts) = pheno$Status


## ---- message = FALSE--------------------------------------------------------------------------------------------------------------
library(SummarizedExperiment)
rse = SummarizedExperiment(assays = list(counts = counts),
                            colData = DataFrame(pheno))


## ---- cache=TRUE-------------------------------------------------------------------------------------------------------------------
library(biomaRt)

if(interactive()){
listEnsembl()
}
#datasets <- listDatasets(ensembl)
#head(datasets)
#searchAttributes(mart = ensembl, pattern = "hgnc")


## ----------------------------------------------------------------------------------------------------------------------------------
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
geneMap = getBM(attributes = c("ensembl_gene_id",
                "chromosome_name","start_position",
          "end_position", "strand", "external_gene_name"),
			values=rownames(counts), mart=ensembl)


## ----------------------------------------------------------------------------------------------------------------------------------
head(geneMap)


## ----------------------------------------------------------------------------------------------------------------------------------
#geneMap$chromosome_name = paste0("chr", geneMap$chromosome_name)
geneMap <-geneMap %>% mutate(chromosome_name = paste0("chr", chromosome_name))
#geneMap$strand = ifelse(geneMap$strand == 1, "+", "-")
geneMap <-geneMap %>% mutate(strand = case_when(strand == 1 ~"+", TRUE ~ "-"))
geneMap_gr = makeGRangesFromDataFrame(geneMap,
            seqnames.field = "chromosome_name",
            start.field = "start_position",
            end.field = "end_position")
names(geneMap_gr) = geneMap$ensembl_gene_id
geneMap_gr


## ----------------------------------------------------------------------------------------------------------------------------------
identical(rownames(counts), names(geneMap_gr))
table(rownames(counts) %in% names(geneMap_gr))
mm = match(rownames(counts), names(geneMap_gr))
geneMap_gr = geneMap_gr[mm[!is.na(mm)]]
counts = counts[!is.na(mm),]


## ---- eval=FALSE-------------------------------------------------------------------------------------------------------------------
## 
## rse = SummarizedExperiment(assays = list(counts = counts),
##                            rowRanges = GRangesList(geneMap_gr),
##                            colData = DataFrame(pheno))
## rse


## ----------------------------------------------------------------------------------------------------------------------------------
source("scale_counts.R") # or install recount package
load(file.path('SRP044749', 'rse_gene.Rdata'))
rse_gene = scale_counts(rse_gene)
rse_gene

