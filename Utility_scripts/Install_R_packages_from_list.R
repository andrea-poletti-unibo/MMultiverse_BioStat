# install necessary packages to run script
install.packages("dplyr")
library(dplyr)

# carica il file
load("workfiles/package_list_andrea_13-07-23.Rda")

list.of.packages <- unlist(old_packages$Package)

# Reinstallzione dei pacchetti da CRAN
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


# Reinstallzione pacchetti da BIOCONDUCTOR
list.of.packages.biocond <- old_packages %>% filter(grepl("Artistic", old_packages$License)) %>% .$Package

BiocManager::install(list.of.packages.biocond)

installed.bicond <- installed.packages() %>% as.data.frame() %>% filter(grepl("Artistic", .$License)) %>% .$Package
failed.biocond <- list.of.packages.biocond[!(list.of.packages.biocond %in% installed.bicond)]

BiocManager::install(failed.biocond)

# final check
final.packages <- installed.packages() %>% as.data.frame() %>% .$Package
still.missing <- list.of.packages[!(list.of.packages %in% final.packages)]

BiocManager::install(still.missing)
install.packages(still.missing)

# pacchetti da altre fonti
devtools::install_github('VanLoo-lab/ascat/ASCAT')
devtools::install_github("Wedge-Oxford/dpclust")

# pacchetti da file (BioNerds)unibo

file_path <- "C:/Users/andre/Alma Mater Studiorum Università di Bologna/Bioinformatics Seràgnoli - Documenti/EVERGREEN_Bioinformatica/BioNerds-0.2.tar.gz"
install.packages(file_path, repos = NULL, type="source")
