install.packages("rio")
library(rio)
# Sous AUS
# .libPaths("V:PALETTES/IGoR/R-4.1.0/library")

chemin <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"

# Import naissances
chemin_naissance <- file.path(chemin,"nais2017.dbf")
naissances <- rio::import(chemin_naissance,as.is=TRUE)

p1 <- rio::import(file.path(chemin,"poplegale_6815d.RDS"))

prenoms2017 <- rio::import(file.path(chemin,"prenoms2017.dbf"),as.is = T)
# Regarder la mémoire : 
prenoms2017b <- prenoms2017

lire <- rio::import
prenoms2017 <- lire(file.path(chemin,"prenoms2017.dbf"),as.is = T)

file.choose()
