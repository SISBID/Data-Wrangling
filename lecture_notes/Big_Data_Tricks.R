## ---- echo = FALSE----------------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")


## ---------------------------------------------------------------------------------
suppressPackageStartupMessages(library(ff))
mon_ff= read.csv.ffdf(file="../data/Monuments.csv")
class(mon_ff)


## ---------------------------------------------------------------------------------
mon_ff$newCol = ff(1:nrow(mon_ff))
mon_ff[1:4,1:7]


## ---- rleExample------------------------------------------------------------------
x= rep(c(0,1,0,1,0), times=c(10000,4,10000,6,10000))
length(x)
rle(x) # base r


## ---- rleExample2-----------------------------------------------------------------
suppressPackageStartupMessages(library(IRanges))
df= data.frame(x=x)
DF = DataFrame(df)
Rle(x) # from IRanges, s4-methods
DF$x = Rle(DF$x) # note the capital R
head(DF)


## ---- sparseSize------------------------------------------------------------------
s1=object.size(df)
s1
s2=object.size(DF)
s2
as.numeric(round(s1/s2))


## ---------------------------------------------------------------------------------
set.seed(34)
x = rnorm(10000)
datList = replicate(10000, sample(1:10000),simplify = FALSE)
class(datList)
lapply(datList[1:5], head)
head(x)


## ---------------------------------------------------------------------------------
system.time(lapply(datList,cor,x))
system.time(mclapply(datList, cor, x))


## ---------------------------------------------------------------------------------
suppressPackageStartupMessages(library(doParallel))
system.time(foreach(i=1:10000) %do% cor(datList[[i]],x))
system.time(foreach(i=1:10000) %dopar% cor(datList[[i]],x))


## ---------------------------------------------------------------------------------
registerDoParallel(cores=2)
system.time(foreach(i=1:10000) %dopar% cor(datList[[i]], x))


## ---------------------------------------------------------------------------------
datMat = simplify2array(datList)
class(datMat)
dim(datMat)
system.time(cor(x,datMat))


## ---- awkImport,eval=FALSE--------------------------------------------------------
## > awkCall = "awk -F\"\t\" '$2 == \"chr21\" { print $0 }' foo.txt"
## > read.delim(pipe(awkCall),header=FALSE)
##      V1    V2         V3        V4        V5        V6        V7         V8
## 1  row6 chr21 0.06470508 0.2104643 0.2630865 0.6748644 0.5838493 0.59531516
## 2  row7 chr21 0.69930753 0.9533248 0.7929459 0.7084059 0.5305247 0.37651206
## 3  row8 chr21 0.31752770 0.6364067 0.7774075 0.6607039 0.5074746 0.43583281
## 4  row9 chr21 0.18445757 0.1926704 0.5522359 0.4889265 0.2885484 0.36124031
## 5 row10 chr21 0.96333352 0.9455556 0.2251288 0.7133460 0.2673244 0.01864215
##          V9       V10        V11
## 1 0.5832685 0.8670779 0.08756482
## 2 0.9471309 0.6032699 0.37931679
## 3 0.2296118 0.4037352 0.37954743
## 4 0.3595676 0.6895200 0.09194656
## 5 0.1601413 0.4742028 0.07500326


## ---- awkImport2,eval=FALSE-------------------------------------------------------
## > awkCall2 = "awk -F\"\t\" '$2 == \"chr21\" { print $2\"\t\"$3\"\t\"$4 }' foo.txt"
## > read.delim(pipe(awkCall2),header=FALSE)
##      V1         V2        V3
## 1 chr21 0.06470508 0.2104643
## 2 chr21 0.69930753 0.9533248
## 3 chr21 0.31752770 0.6364067
## 4 chr21 0.18445757 0.1926704
## 5 chr21 0.96333352 0.9455556


## ---- cutImport,eval=FALSE--------------------------------------------------------
## > cutCall = "cut -f2,3,4 foo.txt"
## > read.delim(pipe(cutCall),header=FALSE)
##       V1         V2         V3
## 1   chr1 0.55127556 0.06161779
## 2   chr1 0.97378813 0.84200893
## 3   chr1 0.67479999 0.54580091
## 4   chr1 0.90762683 0.62246401
## 5   chr1 0.27251173 0.09567016
## 6  chr21 0.06470508 0.21046433
## 7  chr21 0.69930753 0.95332484
## 8  chr21 0.31752770 0.63640675
## 9  chr21 0.18445757 0.19267041
## 10 chr21 0.96333352 0.94555563


## ---- bothRun, eval=FALSE---------------------------------------------------------
## > bothCall = paste("awk -F\"\t\" '$2 == \"chr21\" { print $0 }' foo.txt | cut -f2,3,4")
## > read.delim(pipe(bothCall),header=FALSE)
##      V1         V2        V3
## 1 chr21 0.06470508 0.2104643
## 2 chr21 0.69930753 0.9533248
## 3 chr21 0.31752770 0.6364067
## 4 chr21 0.18445757 0.1926704
## 5 chr21 0.96333352 0.9455556

