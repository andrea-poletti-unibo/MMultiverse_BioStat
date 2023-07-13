# check your package library path 
.libPaths()

# grab old packages names
old_packages <- installed.packages(lib.loc = "C:/Users/andre/AppData/Local/R/win-library/4.3/")

old_packages <- as.data.frame(old_packages)

list.of.packages <- unlist(old_packages$Package)

save(old_packages, file="workfiles/package_list_andrea_13-07-23.Rda")


# install necessary packages
# install.packages("dplyr")

library(dplyr)

# carica il file
load("workfiles/package_list_old_ajsi.Rda")

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

devtools::install_github("andrea-poletti-unibo/BioNerds")
devtools::install_bitbucket('n0s3n/rawcopy/rawcopyPackage')



# check dei pacchetti mancanti
#############################################

actual_packages <- installed.packages(lib.loc = "C:/Users/vincenza.solli2//AppData/Local/R/win-library/4.2")
actual_packages <- actual_packages %>% as.data.frame()

list.of.packages2 <- actual_packages$Package
list.of.packages[(list.of.packages %in% list.of.packages2)==F]
