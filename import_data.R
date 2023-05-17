install.packages("rio")

bucket <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"

naissances <- rio::import(file.path(bucket,"nais2017.dbf"),as.is=TRUE)
base_cc_comparateur <- rio::import(file.path(bucket,"base_cc_comparateur.xlsx"),as.is=TRUE)
