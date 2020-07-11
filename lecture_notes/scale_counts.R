
scale_counts <- function(rse, by = 'auc', targetSize = 4e7, L = 100,
                         factor_only = FALSE, round = TRUE) {    
  
  ## Check inputs
  stopifnot(is(rse, 'RangedSummarizedExperiment'))
  stopifnot(length(targetSize) == 1)
  stopifnot(is.numeric(targetSize) | is.integer(targetSize))
  stopifnot(length(L) == 1)
  stopifnot(is.numeric(L) | is.integer(L))
  stopifnot(is.character(by))
  stopifnot(by %in% c('auc', 'mapped_reads'))
  stopifnot(is.logical(factor_only))
  stopifnot(length(factor_only) == 1)
  stopifnot(is.logical(round))
  stopifnot(length(round) == 1)
  
  ## Check RSE details
  counts <- SummarizedExperiment::assay(rse, 1)
  stopifnot(ncol(counts) == nrow(SummarizedExperiment::colData(rse)))
  if(by == 'auc'){
    stopifnot('auc' %in% colnames(SummarizedExperiment::colData(rse)))
  } else if (by == 'mapped_reads') {
    stopifnot(all(c('avg_read_length', 'mapped_read_count',
                    'paired_end') %in% colnames(SummarizedExperiment::colData(rse))))
  }
  
  ## Scale counts
  if(by == 'auc') {
    # L cancels out:
    # have to multiply by L to get the desired library size,
    # but then divide by L to take into account the read length since the
    # raw counts are the sum of base-level coverage.
    scaleFactor <- targetSize / SummarizedExperiment::colData(rse)$auc
  } else if (by == 'mapped_reads') {
    scaleFactor <- targetSize * L *
      ifelse(SummarizedExperiment::colData(rse)$paired_end, 2, 1)^2 /
      (SummarizedExperiment::colData(rse)$mapped_read_count *
         SummarizedExperiment::colData(rse)$avg_read_length^2)
  }
  
  if(factor_only) {
    names(scaleFactor) <- rownames(SummarizedExperiment::colData(rse))
    return(scaleFactor)
  } else {
    scaleMat <- matrix(rep(scaleFactor, each = nrow(counts)),
                       ncol = ncol(counts))
    scaledCounts <- counts * scaleMat
    if(round) scaledCounts <- round(scaledCounts, 0)
    SummarizedExperiment::assay(rse, 1) <- scaledCounts
    return(rse)
  }
}