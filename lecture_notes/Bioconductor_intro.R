## ----include=FALSE------------------------------------------------------------
library(stringr)
library(tibble)
library(SummarizedExperiment)


## ---- eval=FALSE--------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## install.packages("BiocManager")
## # Install all core packages and update all installed packages
## BiocManager::install()


## ---- eval=FALSE--------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## BiocManager::install(c("GEOquery", "limma", "biomaRt", "SummarizedExperiment"))


## -----------------------------------------------------------------------------
library(GEOquery)
# https://pubmed.ncbi.nlm.nih.gov/32619517/
geo_data = getGEO("GSE146760")[[1]] # find accession in paper


## -----------------------------------------------------------------------------
tibble(pData(geo_data))


## -----------------------------------------------------------------------------
exprs(geo_data) # gene expression
fData(geo_data) # gene/feature/row annotation


## -----------------------------------------------------------------------------
getGEOSuppFiles("GSE146760")
counts  = read.delim("GSE146760/GSE146760_RNASeq_analysis_CountsTable.txt.gz")
pheno = read.delim("GSE146760/GSE146760_RNASample_Info_v2.txt.gz")


## -----------------------------------------------------------------------------
colnames(counts) = sapply(str_split(colnames(counts), "Aligned"), "[[", 1)
identical(colnames(counts), pheno$Prefix)
rownames(pheno) = pheno$Status
colnames(counts) = pheno$Status


## -----------------------------------------------------------------------------
rse = SummarizedExperiment(assays = list(counts = counts),
                            colData = DataFrame(pheno))


## ---- cache=TRUE--------------------------------------------------------------
library(biomaRt)
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
geneMap = getBM(attributes = c("ensembl_gene_id",
                "chromosome_name","start_position",
          "end_position", "strand", "external_gene_name"),
			values=rownames(counts), mart=ensembl)


## -----------------------------------------------------------------------------
geneMap$chromosome_name = paste0("chr", geneMap$chromosome_name)
geneMap$strand = ifelse(geneMap$strand == 1, "+", "-")
geneMap_gr = makeGRangesFromDataFrame(geneMap,
            seqnames.field = "chromosome_name",
            start.field = "start_position",
            end.field = "end_position")
names(geneMap_gr) = geneMap$ensembl_gene_id
geneMap_gr


## -----------------------------------------------------------------------------
identical(rownames(counts), names(geneMap_gr))
table(rownames(counts) %in% names(geneMap_gr))
mm = match(rownames(counts), names(geneMap_gr))
geneMap_gr = geneMap_gr[mm[!is.na(mm)]]
counts = counts[!is.na(mm),]


## -----------------------------------------------------------------------------
rse = SummarizedExperiment(assays = list(counts = counts),
                            colData = DataFrame(pheno),
                           rowRanges = geneMap_gr)
rse


## -----------------------------------------------------------------------------
source("scale_counts.R") # or install recount package
load(file.path('SRP044749', 'rse_gene.Rdata'))
rse_gene = scale_counts(rse_gene)
rse_gene

