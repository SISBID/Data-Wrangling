### Installing packages lab for SISBID

1. Easy one, install the devtools package (http://cran.r-project.org/web/packages/devtools/index.html) from CRAN: `install.packages("devtools")`
2. Install the sva package (http://www.bioconductor.org/packages/release/bioc/html/sva.html) from Bioconductor:
  - If you've never installed Bioconductor
  - `source("http://bioconductor.org/biocLite.R")`
  - `biocLite()`
  - `biocLite("sva")`
4. Look at the sva vignette to see how the package works 
  - List possible vignettes with `vignette(package="sva")`
  - Name is in first column (creatively titled sva :-)) so view vignette with `vignette("sva")`
5. Install the broom package (https://github.com/dgrtwo/broom, also available from CRAN) from Github:
  - `devtools::install_github("dgrtwo/broom")`
6. Look at the help for the `tidy` function:
  - `?tidy`