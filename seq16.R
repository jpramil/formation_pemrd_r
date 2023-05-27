library(arrow)

chemin <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"
path <- file.path(chemin, "nais2017.parquet")

toto <- arrow::read_parquet(path)
toto
