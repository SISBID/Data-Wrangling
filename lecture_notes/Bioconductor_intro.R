## ---- cache=FALSE------------------------------------------------------------------
# Set some global knitr options
suppressMessages(library("knitr"))
opts_chunk$set(cache = FALSE, messages = FALSE)


## ---- eval=FALSE-------------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## source("http://bioconductor.org/biocLite.R")
## # Install all core packages and update all installed packages
## biocLite()


## ---- eval=FALSE-------------------------------------------------------------------
## # Note that this is not evaluated here, so you will have to do it before using this knitr doc
## biocLite(c("GEOmetadb", "GEOquery", "limma", "affy"))


## ----------------------------------------------------------------------------------
dir.create("../data/geo", recursive = TRUE)


## ----query-GEO, cache = TRUE-------------------------------------------------------
suppressPackageStartupMessages(library(GEOquery))
# Download the mapping information and processed data
# This returns a list of eSets
GSE29617_set <- getGEO("GSE29617", destdir = "../data/geo/")[[1]]


## ----------------------------------------------------------------------------------
str(GSE29617_set, max.level = 2)


## ----------------------------------------------------------------------------------
data(iris)
class(iris)
summary(iris)


## ---- eval=FALSE-------------------------------------------------------------------
## # S3 class
## head(methods(class = "data.frame"))
## # S4 class
## showMethods(classes  = "eSet")


## ---- eval=FALSE-------------------------------------------------------------------
## library(Biobase)
## showMethods(classes = "eSet")


## ----------------------------------------------------------------------------------
class(GSE29617_set)
exprs(GSE29617_set)[1:2,1:3]


## ----------------------------------------------------------------------------------
# Information about preprocessing
# Nothing in here!
preproc(GSE29617_set)


## ----------------------------------------------------------------------------------
# A data.frame with number of rows equal to the number of samples
pData(GSE29617_set)[1:2,1:2]
# A data.frame with number of rows equal to the number of features/probes
fData(GSE29617_set)[1:2,1:2]


## ----------------------------------------------------------------------------------
fData(GSE29617_set)[1:2, 1:2]
# Note that S4 classes can be nested!
GSE29617_set@featureData@data[1:2, 1:2]


## ----download-raw-data-------------------------------------------------------------
# Download all raw data. This should only be evaluated once
# Then the data would be stored locally in the data directory
# Make sure the directory exists
if (length(dir("data/geo/", pattern = "GSE29617")) == 0) {
  getGEOSuppFiles("GSE29617", 
                  makeDirectory = TRUE, baseDir = "../data/geo/")
  untar("../data/geo/GSE29617/GSE29617_RAW.tar", exdir = "../data/geo/GSE29617/", 
        tar = Sys.getenv("TAR"))
}
# untar downloaded data


## ---- eval=FALSE-------------------------------------------------------------------
## ## In case we haven't downloaded it before.
## biocLite("affy")


## ----------------------------------------------------------------------------------
library(affy)


## ----------------------------------------------------------------------------------
# Read the CEL file and creates and AffyBatch
GSE29617_affyBatch <- ReadAffy(celfile.path = "../data/geo/GSE29617/")
# Normalize and summarize the data
GSE29617_set2 <- rma(GSE29617_affyBatch)


## ----------------------------------------------------------------------------------
exprs(GSE29617_set2)[1:2,1:2]


## ---- eval=FALSE-------------------------------------------------------------------
## # We first need to install our annotation package
## library(BiocInstaller)
## # Note that you don't have to use source anymore!
## biocLite("hthgu133a.db")


## ----------------------------------------------------------------------------------
library(hthgu133a.db)
probe_ids <- rownames(GSE29617_set2)
probe_data <- select(hthgu133a.db, keys = probe_ids, columns = "SYMBOL", keytype = "PROBEID")
probe_data[1,]


## ---- warning=TRUE-----------------------------------------------------------------
probe_ids <- gsub("_PM","", rownames(GSE29617_set2))
probe_data <- select(hthgu133a.db, keys = probe_ids, columns = "SYMBOL", keytype = "PROBEID")
probe_data[1, ]


## ----------------------------------------------------------------------------------
library(data.table)
probe_data_dt <- data.table(probe_data)
probe_data_dt_unique <- probe_data_dt[,list(SYMBOL = paste(SYMBOL, collapse = ";")), by = "PROBEID"]
probe_data_dt_unique[SYMBOL %like% ";"]


## ----------------------------------------------------------------------------------
annotaded_probes <- data.frame(probe_data_dt_unique)
rownames(annotaded_probes) <- rownames(GSE29617_set2)
fData(GSE29617_set2) <- annotaded_probes
head(fData(GSE29617_set2))


## ----sanitize-pdata----------------------------------------------------------------
### Sanitize data and metadata
sanitize_pdata <- function(pd){
keepCols <- c(
  "characteristics_ch1.1", "characteristics_ch1.2",
  "description", 
  "supplementary_file")
pd <- pd[, keepCols]
colnames(pd) <- c("ptid", "time", "description", "filename")
pd$ptid <- gsub(".*: ", "", pd$ptid)
pd$time <- gsub(".*: ", "", pd$time)
pd$time <- gsub("Day", "D", pd$time)
pd$description <- gsub("(-\\w*){2}$", "", pd$description)
pd$filename <- basename(as.character(pd$filename))
pd$filename <- gsub(".CEL.gz", "", pd$filename)
pd
}


## ----------------------------------------------------------------------------------
pData(GSE29617_set2) <- sanitize_pdata(pData(GSE29617_set))
pData(GSE29617_set2)[1:2, 1:2]


## ----iranges-----------------------------------------------------------------------
library(IRanges)
ir <- IRanges(start=c(10, 20, 30), width=5)
ir


## ----iranges-flank-----------------------------------------------------------------
flank(ir, 3)


## ----granges-----------------------------------------------------------------------
library(GenomicRanges)
gr <- GRanges(c("chr1", "chr1", "chr2"), ir, strand=c("+", "-", "+"))
gr


## ----granges-flank-----------------------------------------------------------------
flank(gr, 3)


## ----granges-methods---------------------------------------------------------------
methods(class="GRanges")


## ----granges-man-and-vignettes, eval=FALSE-----------------------------------------
## help(package="GenomicRanges")
## vignette(package="GenomicRanges")
## vignette(package="GenomicRanges", "GenomicRangesHOWTOs")


## ----txdb--------------------------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene


## ----txdb-exons--------------------------------------------------------------------
exons(txdb)


## ----txdb-exonsby------------------------------------------------------------------
exonsBy(txdb, "tx")


## ----BSgenome-require, message=FALSE-----------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
chr14_range = GRanges("chr14", IRanges(1, seqlengths(Hsapiens)["chr14"]))
chr14_dna <- getSeq(Hsapiens, chr14_range)
letterFrequency(chr14_dna, "GC", as.prob=TRUE)


## ----bam-require-------------------------------------------------------------------
library(GenomicRanges)
library(GenomicAlignments)
library(Rsamtools)

## our 'region of interest'
roi <- GRanges("chr14", IRanges(19653773, width=1)) 
## sample data
library('RNAseqData.HNRNPC.bam.chr14')
bf <- BamFile(RNAseqData.HNRNPC.bam.chr14_BAMFILES[[1]], asMates=TRUE)
## alignments, junctions, overlapping our roi
paln <- readGAlignmentsList(bf)
j <- summarizeJunctions(paln, with.revmap=TRUE)
j_overlap <- j[j %over% roi]

## supporting reads
paln[j_overlap$revmap[[1]]]


## ----vcf, message=FALSE------------------------------------------------------------
## input variants
library(VariantAnnotation)
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(fl, "hg19")
seqlevels(vcf) <- "chr22"
## known gene model
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
coding <- locateVariants(rowRanges(vcf),
    TxDb.Hsapiens.UCSC.hg19.knownGene,
    CodingVariants())
head(coding)


## ----genomicalignments-------------------------------------------------------------
## example BAM data
library(RNAseqData.HNRNPC.bam.chr14)
## one BAM file
fl <- RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]
## Let R know that this is a BAM file, not just a character vector
library(Rsamtools)
bfl <- BamFile(fl)


## ----readgalignments---------------------------------------------------------------
aln <- readGAlignments(bfl)
aln


## ----galignments-methods-----------------------------------------------------------
methods(class=class(aln))


## ----sessionInfo-------------------------------------------------------------------
sessionInfo()

