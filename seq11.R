# Accéder à une base de données PostgreSQL
install.packages("RPostgres")
library(RPostgres)
driver<- dbDriver("Postgres")

base <- dbConnect(driver,
                  dbname="postgres",
                  hors="localhost",
                  port=5432,
                  user="f5f31q",
                  password=rstudioapi::askForPassword())

dbListTables(base)

dbGetQuery(base, "SELECT schema_name FROM information_schema.schemata")

requete<-"SELECT schema_name FROM information_schema.schemata"

resultat_requete<-dbGetQuery(base, requete)

dbGetQuery(base,
"SELECT table_name
FROM information_schema.tables
WHERE table_schema='formation'"
)

dbGetQuery(base,
"SELECT ordinal_position AS position,
column_name,
data_type,
CASE WHEN character_maximum_length IS NOT NULL
THEN character_maximum_length
ELSE numeric_precision END AS max_length
FROM information_schema.columns
WHERE table_schema='formation' AND table_name='poplegale_6815'"
)

dbGetQuery(base,
"SELECT *
FROM formation.poplegale_6815
WHERE pmun15>300000")

dbDisconnect(base)

