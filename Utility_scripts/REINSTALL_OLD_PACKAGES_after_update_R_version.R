# check your package library path 
.libPaths()

# grab old packages names
old_packages <- installed.packages(lib.loc = "C:/Users/ajsi.kanapari2/AppData/Local/R/win-library/4.2")
old_packages <- as.data.frame(old_packages)
list.of.packages <- unlist(old_packages$Package)

save(old_packages, file="workfiles/package_list_old_ajsi.Rda")


# install necessary packages
# install.packages("data.table")
# install.packages("dplyr")

library(dplyr)
library(data.table)

# carica il file
load("workfiles/package_list_old_ajsi.Rda")

# remove old packages 
# remove.packages( installed.packages( priority = "NA" )[,1] )

list.of.packages <- unlist(old_packages$Package)

# reinstall all packages 
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


# resinstall old pkgs from bioconductor
library(tidyverse)

list.of.packages.biocond <- old_packages %>% filter(grepl("Artistic", old_packages$License)) %>% .$Package
BiocManager::install(list.of.packages.biocond)

installed.bicond <- installed.packages() %>% as.data.frame() %>% filter(grepl("Artistic", .$License)) %>% .$Package

failed.biocond <- list.of.packages.biocond[!(list.of.packages.biocond %in% installed.bicond)]

BiocManager::install(failed.biocond)


# final check
library(tidyverse)
final.packages <- installed.packages() %>% as.data.frame() %>% .$Package

still.missing <- list.of.packages[!(list.of.packages %in% final.packages)]

BiocManager::install(still.missing)
install.packages(still.missing)

# github packages
devtools::install_github('VanLoo-lab/ascat/ASCAT')
devtools::install_github("Wedge-Oxford/dpclust")
devtools::install_github("andrea-poletti-unibo/BioNerds")



# check dei pacchetti mancanti
#############################################
new.list<-as.data.frame(list.of.packages) 



list.of.packages

actual_packages <- installed.packages(lib.loc = "C:/Users/ajsi.kanapari2/AppData/Local/R/win-library/4.2")
actual_packages <- actual_packages %>% as.data.frame()

list.of.packages2 <- actual_packages$Package
list.of.packages[(list.of.packages %in% list.of.packages2)==FALSE]
