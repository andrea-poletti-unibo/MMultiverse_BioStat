# check your package library path 
.libPaths()

# grab old packages names
old_packages <- installed.packages(lib.loc = "C:/Users/ajsik/AppData/Local/R/win-library/4.2")
old_packages <- as.data.frame(old_packages)
list.of.packages <- unlist(old_packages$Package)

readr::write_tsv(old_packages, "workfiles/package_list_old_ajsi.txt")

# remove old packages 
# remove.packages( installed.packages( priority = "NA" )[,1] )

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

