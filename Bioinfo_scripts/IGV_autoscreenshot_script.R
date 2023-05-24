
library(data.table)
library(tidyverse)
library(GenomicRanges)
library(liftOver)
library(biomaRt)

# regions <- fread("C:/Users/andre/Alma Mater Studiorum Università di Bologna/PROJECT UMA_MM_panel - Documenti/Design_phase/Agilent_panel_design/After_shift/all_regions_targets_hg19_DEF.bed") %>% as.data.frame()
regions <- fread("C:/Users/andre/Alma Mater Studiorum Università di Bologna/PROJECT UMA_MM_panel - Documenti/Design_phase/Agilent_panel_design/After_shift/AIO_MM_IGH_1/AIO_MM_IGH_1_Report.txt") %>% as.data.frame()



mart<-useMart(biomart="ENSEMBL_MART_ENSEMBL",
              dataset="hsapiens_gene_ensembl", 
              host="grch37.ensembl.org")

res=getBM(attributes=c("chromosome_name", "start_position","end_position","hgnc_symbol"),
                  filters="hgnc_symbol",
                  values=regions$TargetID,
                  mart=mart)

regions <- res %>% filter(!grepl("HSCHR6|HG",res$chromosome_name)) %>% rename(chr=chromosome_name, start=start_position, end=end_position, gene=hgnc_symbol)


i = 1
dir <- "C:/Users/andre/Desktop/IGVsnapshots_AIO/"


sink("C:/Users/andre/Desktop/IGVscript.txt")

cat("snapshotDirectory", dir, "\n")

for (i in 1:nrow(regions)){
  cat("goto chr",regions[i,1],":",regions[i,2] -200 ,"-",regions[i,3]+ 200,"\n",sep = "")
  cat("snapshot ", regions[i,4],".png\n", sep = "")
}

sink()


############################


igh_reg <- fread("C:/Users/andre/Alma Mater Studiorum Università di Bologna/PROJECT UMA_MM_panel - Documenti/Design_phase/translocation_target_regions.bed") %>% as.data.frame()

igh_reg

dir <- "C:/Users/andre/Desktop/IGVsnapshots_AIO/IGH_REGIONS/"


sink("C:/Users/andre/Desktop/IGVscript_IgH.txt")

cat("snapshotDirectory", dir, "\n")
i=1
for (i in 1:nrow(igh_reg)){
  cat("goto chr",igh_reg[i,1],":",igh_reg[i,2] -100 ,"-",igh_reg[i,3]+ 100,"\n",sep = "")
  cat("snapshot IgH_region_",i,"_Nevents_", igh_reg[i,4],".png\n", sep = "")
}

sink()
