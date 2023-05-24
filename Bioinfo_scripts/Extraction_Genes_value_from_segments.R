library(tidyverse)
library(GenomicRanges)


# ================= import segments ================


segments<-data.table::fread("./CopyNumberCalls/adj_fitted_and_raw_segments_TP53_HD1.tsv")


#################### MULTIPLE GENES ###########################

# import table of gene locations
genesLocations <- data.table::fread("./../25_genes_loci.txt")


# trasform in Granges
segmGR <- makeGRangesFromDataFrame(segments, keep.extra.columns = T)


# LOOP to exract gene values from segments

results <- data.frame()

for (i in 1:nrow(genesLocations)){
  
  gene <- genesLocations$gene[i]
  chr <- as.numeric(genesLocations$chromosome[i])
  start <- as.numeric(genesLocations$start[i])
  end <- as.numeric(genesLocations$end[i])
 
  print(paste(gene,chr, start,end))
   
  geneGR <- GRanges(chr, IRanges(start,end))
  gene_dimension <- width(geneGR) # compute the gene dimension
  
  overlap <- pintersect( segmGR, geneGR ) # comupte overlaps between the segments and the gene
  
  res.overlap <- overlap %>% as.data.frame() %>% filter(hit==TRUE) # generate a dataframe with positive overlaps results
  
  res.overlap$percentage_overlap <- res.overlap$width / gene_dimension # compute the overlap PERCENTAGE 
  
  res.overlap_major <- filter(res.overlap, percentage_overlap >= 0.10 ) # exlude overlaps < 10% of focal dimensions
  
  res.overlap_major <- res.overlap_major %>% arrange(sample, desc(abs(logR))) # IMPORTANT ORDERING! order per sample and then per descending abs logR -> the FIRST entry per sample will be the most changed in logR!
  
  res.overlap_unique <- dplyr::distinct(res.overlap_major, sample, .keep_all = TRUE ) # KEEP only the first entry for each sample (this should end up always with one result per sample) 
  
  # # sanity check
  # if(nrow(res.overlap_unique) != length(SAMPLES)) {print("ERROR")} else {print("length ok")}
  
  res.values<- res.overlap_unique %>% select( sample, logR, percentage_overlap ) # extract the logR calls and the percentage of overlap
  
  res.values$gene <- gene
  
  #save results 
  results <- rbind(results, res.values)
}

  
