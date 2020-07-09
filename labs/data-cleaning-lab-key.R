## ---------------------------------------------------------------------------------
library(readr)
library(stringr)
suppressPackageStartupMessages(library(dplyr))
tax = read_csv("http://sisbid.github.io/Module1/data/Real_Property_Taxes.csv.gz")
tax = as.data.frame(tax)


## ---------------------------------------------------------------------------------
nrow(tax)
dim(tax)


## ---------------------------------------------------------------------------------
options(digits=12) # so no rounding
head(tax$CityTax)
tax$CityTax = parse_number(tax$CityTax)
tax$StateTax = parse_number(tax$StateTax)

sum(tax$CityTax, na.rm = TRUE)
sum(tax$CityTax, na.rm = TRUE)/1e6

sum(tax$StateTax, na.rm = TRUE)
sum(tax$StateTax, na.rm = TRUE)/1e6


## ---------------------------------------------------------------------------------
taxRes = tax %>% filter(ResCode == "PRINCIPAL RESIDENCE")


## ---------------------------------------------------------------------------------
taxRes %>% nrow()


## ---------------------------------------------------------------------------------
quantile(taxRes$StateTax,na.rm=TRUE)
quantile(taxRes$CityTax,na.rm=TRUE)


## ---------------------------------------------------------------------------------
tax$LotSize = str_trim(tax$LotSize) # trim to be safe
lot = tax$LotSize # for checking later


## ---------------------------------------------------------------------------------
aIndex= which(str_detect(tax$LotSize, "AC.*") | 
            str_detect(tax$LotSize, fixed(" %")))
head(aIndex)
head(lot[aIndex])

acre = tax$LotSize[aIndex] # temporary variable
## find and replace character strings
acre = str_replace_all(acre, " AC.*","")
acre = str_replace_all(acre, " %","")
table(!is.na(as.numeric(acre)))

head(acre[is.na(as.numeric(acre))],50)

## lets clean the rest
acre = str_replace_all(acre, "-",".") # hyphen instead of decimal
head(acre[is.na(as.numeric(acre))])
table(!is.na(as.numeric(acre)))

acre = str_replace_all(acre, "ACRES","")
head(acre[is.na(as.numeric(acre))])

# take care of individual mistakes
acre = str_replace_all(acre, "O","0") # 0 vs O
acre = str_replace_all(acre, "Q","") # Q, oops
acre = str_replace_all(acre, ",.",".") # extra ,
acre = str_replace_all(acre, ",","") # extra ,
acre = str_replace_all(acre, "L","0") # leading L
acre[is.na(as.numeric(acre))]

acre2 = as.numeric(acre)*43560 
sum(is.na(acre2)) # all but 3


## ---------------------------------------------------------------------------------
library(purrr)
fIndex = which(str_detect(tax$LotSize, "X"))

ft = tax$LotSize[fIndex]

ft = str_replace_all(ft, fixed("&"), "-")
ft = str_replace_all(ft, "IMP ONLY ", "")
ft = str_replace_all(ft, "`","1")

ft= map_chr(str_split(ft, " "), first)

## now get the widths and lengths
width = map_chr(str_split(ft,"X"), first)
length = map_chr(str_split(ft,"X"), nth, 2) 

## width
widthFeet = as.numeric(map_chr(str_split(width, "-"), first))
widthInch = as.numeric(map_chr(str_split(width, "-"),nth,2))/12
widthInch[is.na(widthInch)] = 0 # when no inches present
totalWidth = widthFeet + widthInch # add together

# length
lengthFeet = as.numeric(map_chr(str_split(length, "-"),first))
lengthInch = as.numeric(map_chr(str_split(length, "-",2),nth,2))/12
lengthInch[is.na(lengthInch)] = 0 # when no inches present
totalLength = lengthFeet + lengthInch

# combine together for square feet
sqrtFt = totalWidth*totalLength 
ft[is.na(sqrtFt)] # what is left?


## ---------------------------------------------------------------------------------
tax$sqft = rep(NA)
tax$sqft[aIndex] = acre2
tax$sqft[fIndex] = sqrtFt
mean(!is.na(tax$sqft))

# already in square feet, easy!!
sIndex=which(str_detect(tax$LotSize, "FT") | str_detect(tax$LotSize, "S.*F."))
sf = tax$LotSize[sIndex] # subset temporary variable

sqft2 = map_chr(str_split(sf,"( |SQ|SF)"),first)
sqft2 = as.numeric(str_replace_all(sqft2, ",", "")) # remove , and convert
tax$sqft[sIndex] = sqft2
table(is.na(tax$sqft)) 
## progress!

#what remains?
lot[is.na(tax$sqft)]

