# BiocManager::install("liftOver")

library(liftOver)

path = system.file(package="liftOver", "extdata", "hg38ToHg19.over.chain")

# or select an appropriate chain from the folder in Bionformatic website EVERGREEN folder
path="C:/Users/andre/Alma Mater Studiorum Università di Bologna/Bioinformatics Seràgnoli - Documenti/EVERGREEN_Bioinformatica/LiftOver_chains_ref_genomes/hg38ToHg19.over.chain"

# import chain for conversion
ch = import.chain(path)

# import and format regions (BED file) to convert
baits <- data.table::fread("C:/Users/andre/Alma Mater Studiorum Università di Bologna/PROJECT UMA_MM_panel - Documenti/Design_phase/Agilent_panel_design/After_shift/AIO_MM_IGH_1/AIO_MM_IGH_1_Regions.bed")
names(baits) <- c("chr","start","end","gene")

# trasnform in Grange
baitsGR <- makeGRangesFromDataFrame(baits, keep.extra.columns = T)


# do the liftover from hg38 to hg19
baitsGR_hg19 <- liftOver(baitsGR, ch)

head(baitsGR)

head(baitsGR_hg19)

t <- unlist(baitsGR_hg19)


tdf <- as.data.frame(t)


